--Renaming Columns For Convenience
EXEC sp_rename '[dbo].[Global_Cybersecurity_Threats_20$].[Financial loss(in Million $)]', 'Financial Loss', 'COLUMN';
EXEC sp_rename '[dbo].[Global_Cybersecurity_Threats_20$].[incident resolution time (in hours)]', 'IRT', 'COLUMN';

--Yearly Trend of Cybersecurity Attacks
WITH YearlyAttacks AS (
    SELECT 
        Year,
        COUNT(*) AS AttackCount
    FROM [dbo].[Global_Cybersecurity_Threats_20$]
    GROUP BY Year
)
SELECT 
    Year,
    AttackCount,
    LAG(AttackCount, 1, 0) OVER (ORDER BY Year) AS PreviousYearCount,
    AttackCount - LAG(AttackCount, 1, 0) OVER (ORDER BY Year) AS YearlyIncrease
FROM YearlyAttacks
ORDER BY Year

--Determining The Most Common And Costly Vulnerability Types
WITH VulnerabilityImpact AS (
    SELECT 
        [Security Vulnerability Type],
        COUNT(*) AS AttackCount,
        SUM([Financial Loss]) AS TotalLossMillion
    FROM [dbo].[Global_Cybersecurity_Threats_20$]
    GROUP BY [Security Vulnerability Type]
)
SELECT 
    [Security Vulnerability Type],
    AttackCount,
    TotalLossMillion,
    DENSE_RANK() OVER (ORDER BY TotalLossMillion DESC) AS LossRank
FROM VulnerabilityImpact
ORDER BY LossRank

--Determining The Financial Loss Over Time
WITH YearlyLoss AS (
    SELECT 
        Year,
        SUM([Financial Loss]) AS TotalLossMillion
    FROM [dbo].[Global_Cybersecurity_Threats_20$]
    GROUP BY Year
)
SELECT 
    Year,
    TotalLossMillion,
    ROUND(AVG(TotalLossMillion) OVER (ORDER BY Year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS MovingAvgLoss
FROM YearlyLoss
ORDER BY Year

--Calculating Which Country Resolves Incidents Best
SELECT 
    Country,
    ROUND(AVG(IRT), 2) AS AvgResolutionTime,
    RANK() OVER (ORDER BY AVG(IRT) DESC) AS ResolutionRank
FROM [dbo].[Global_Cybersecurity_Threats_20$]
GROUP BY Country
HAVING COUNT(*) > 10
ORDER BY ResolutionRank

--Determining Most Common Attack Type Per Industry
WITH attack_rank AS (
    SELECT [Target Industry], 
           [Attack Type],
           COUNT(*) AS attack_count,
           RANK() OVER (PARTITION BY [Target Industry] ORDER BY COUNT(*) DESC) AS rank
    FROM [dbo].[Global_Cybersecurity_Threats_20$]
    GROUP BY [Target Industry], [Attack Type]
)
SELECT [Target Industry], 
       [Attack Type], 
       attack_count
FROM attack_rank
WHERE rank = 1

--Which Industry Has Above Average Resolution Times
WITH overall_avg AS (
    SELECT AVG(IRT) AS avg_irt,
           COUNT(*) AS total_incidents
    FROM [dbo].[Global_Cybersecurity_Threats_20$]
)
SELECT [Target Industry], 
       ROUND(AVG(IRT),2) AS avg_industry_irt,
       COUNT(*) AS incident_count,
       MAX(IRT) AS max_irt
FROM [dbo].[Global_Cybersecurity_Threats_20$]
GROUP BY [Target Industry]
HAVING AVG(IRT) > (SELECT avg_irt FROM overall_avg)

--Determining Which Defense Mechanism Is Best
SELECT 
    d.[defense mechanism used],
    COUNT(*) AS AttackCount,
    ROUND(AVG(a.[IRT]),2) AS AvgResolutionTime,
    RANK() OVER (ORDER BY AVG(a.[IRT])) AS EffectivenessRank
FROM [dbo].[Global_Cybersecurity_Threats_20$] a
LEFT JOIN (SELECT DISTINCT [defense mechanism used] FROM [dbo].[Global_Cybersecurity_Threats_20$]) d
    ON a.[defense mechanism used] = d.[defense mechanism used]
GROUP BY d.[defense mechanism used]
ORDER BY EffectivenessRank

--Which Industry Do Attack Sources Frequent
SELECT [Attack source], 
       [Target Industry], 
       COUNT(*) AS attack_count,
       ROUND(AVG([financial loss]),2) AS avg_industry_loss
FROM [dbo].[Global_Cybersecurity_Threats_20$]
WHERE [Target Industry] IN (
    SELECT TOP 3 [Target Industry]
    FROM [dbo].[Global_Cybersecurity_Threats_20$]
    GROUP BY [Target Industry]
    ORDER BY AVG([financial loss]) DESC
)
GROUP BY [Attack source], [Target Industry]
ORDER BY attack_count DESC

--Determining Most Dominant Attack Type Per Country
WITH CountryYearLoss AS (
    SELECT 
        country,
        year,
        SUM([Financial Loss]) AS total_loss
    FROM [dbo].[Global_Cybersecurity_Threats_20$]
    GROUP BY country, year
),
RankedLoss AS (
    SELECT 
        country,
        year,
        total_loss,
        RANK() OVER (PARTITION BY country ORDER BY total_loss DESC) AS rank_in_country
    FROM CountryYearLoss
),
DominantAttackType AS (
    SELECT 
        cy.country,
        cy.year,
        (
            SELECT TOP 1 [Attack Type]
            FROM [dbo].[Global_Cybersecurity_Threats_20$] ca
            WHERE ca.country = cy.country AND ca.year = cy.year
            GROUP BY [Attack Type]
            ORDER BY COUNT(*) DESC
        ) AS dominant_attack_type
    FROM RankedLoss cy
    WHERE cy.rank_in_country = 1
)
SELECT *
FROM DominantAttackType
ORDER BY country