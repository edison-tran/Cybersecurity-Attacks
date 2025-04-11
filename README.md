# Global Analysis of Cybersecurity Attacks
**Tools Used: Excel, MS SQL Server, Tableau**

[Dataset Used](https://www.kaggle.com/datasets/atharvasoundankar/global-cybersecurity-threats-2015-2024/data)

[Tableau Visualization](https://public.tableau.com/app/profile/edison.tran/viz/Cybersecurity_Attack1/Dashboard1)

[Tableau Visualization](https://public.tableau.com/app/profile/edison.tran/viz/Cybersecurity_Attack2/Dashboard2)

[Tableau Visualization](https://public.tableau.com/app/profile/edison.tran/viz/Cybersecurity_Attack3/Dashboard3)

## Introduction
Cybersecurity attacks have emerged as a pervasive and escalating threat, impacting organizations, governments,
and individuals across the globe. This project aims to explore a comprehensive dataset of cybersecurity incidents
worldwide, capturing details such as the country of the attack, year, attack type, targeted industry and many more.
By analyzing these elements, it illustrates the growing scale of cyber threats, reveals which regions are most at 
risk of these attacks, and uncover the weaknesses that attackers consistently exploit. These insights offer 
a glimpse into the evolving cybersecurity landscape, ultimately providing opportunities and valuable lessons 
for strengthening defenses and taking necessary precautions in an increasingly digital world.


## Motivation and Objective
The rise in cybersecurity attacks, both in frequency and complexity poses a critical challenge to global security
and economic stability. Organizations struggle to keep up with evolving threats, while the scale of incidents
highlight the need for deeper understanding and proactive solutions. This project is driven by the urgency to 
resolve this problem and answer questions about the nature of cybersecurity attacks:


Analysis of Trends: How have cybersecurity attacks escalated over time in terms of frequency, sophistication, and impact?  

Location Impact: Which countries or regions are hit hardest by cybersecurity attacks, and what patterns of vulnerability emerge?  

Faulty Existing Techniques: What are the most common security vulnerabilities exploited by attackers, and why have existing defenses failed to stop them?



## Approach
### Data Extraction & Transformation (SQL)
Data Querying: 
Grouped attacks by year, country, industry, and vulnerability type to uncover trends and distributions.  

Arithmetic Functions: 
Computed key metrics such as total financial losses, average number of affected users, and median incident resolution times across various segments.  

Aggregation of Data: 
Ensured all relevant dimensions, such as attack sources and defense mechanisms were integrated for holistic analysis.  

Advanced SQL Functions: 
Applied window functions to track the progression of attack frequency and severity over time, and ranked regions and vulnerabilities by impact.

### Visualization (Tableau)

Time Series Charts: 
Used line and area charts to depict the rising trajectory of attacks over the years.  

Geographical Maps: 
Illustrated the global distribution of cybersecurity incidents, highlighting hotspots with color-coded intensity.  

Dual Axis Bar Charts: 
Compared the prevalence of specific vulnerabilities and the success rates of defense mechanisms across industries.  

Interactive Dashboards: 
Combined visualizations with filters for year, country, and attack type, enabling users to explore the data dynamically and drill into specific stories.




## Results
Rising Threat: 
The data revealed a flucuating trend in cybersecurity attacks over the past decade, with a direct relationship between attack
count and total financial loss. There were an equal number of positive and negative attack counts in terms of attack count 
differential. Futhermore, the complexity of attacks, determined by attack types also fluctuated across the decade, with no attack
type standing out in terms of an increase or decrease in volume.

Global Hotspots: 
South America and Western Europe emerged as the most heavily targeted regions, accounting for the top 3 highest financial losses incurred.
This aligns with their concentration of high-value targets, such as tech giants and financial institutions. Meanwhile, Asia
showed the opposite, having 2 countries be amongst the lowest financial losses of all countries, all while having near-average counts of 
attacks. Hotspots displayed distinct vulnerability patterns, namely, SQL Injection in Asia, with an attack average of 17.2%, compared to
the global rate of 16.75%. Whereas in Europe, Ransomware accounted for 17.02% of attacks, greater than the global average of 16.46%.

Common Vulnerabilities:
The most exploited weaknesses involved network based attacks(responsible for 33% of breaches), software based attacks (49.4%),
and social engineering (17.6%). Through analysing industry targets and attack counts, an inverse relationship was discovered in
terms of attack count and average resolution time. With IT, banking, and healthcare as the top victims of attacks, they had an 
average resolution time of 35.9 hours. Conversely, government, telecommunications, and education had an average resolution time 
of 36.9 hours.




## Conclusion
By utilizing SQL and Tableau to analyze this global dataset, this project has punctuated the escalating threat of cybersecurity
attacks, identified the regions most at risk, and exposed the vulnerabilities that attackers exploit with great success.
These insights allow organizations, businesses, and stakeholders with the knowledge to prioritize resources, target
high-risk areas, and address preventable weaknesses like outdated software and poor password practices. As cyber threats continue
to grow, data-driven analyses will remain essential for staying ahead of attackers and building a more resilient digital future.

