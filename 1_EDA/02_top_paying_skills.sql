/*
Question: What are the highest-paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer postions
- Focus on the remote positions with the specified salaries
- Include skill frequency to identify both salary and demand
- Why? Helps identify which skills command the highest compensation while also showing
how common those skilss are, providing a more complete picture for skill development priorities*/

-- Median is used instead of the average to reduce the impact of outlier salaries

SELECT
    sd.skills AS skills,
    ROUND(MEDIAN (jpf.salary_year_avg), 0) AS median_salary,
    COUNT(sd.skill_id) AS skill_count
FROM
    job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND job_work_from_home = TRUE
    --AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
HAVING 
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 25;

/*
Key Insights:
The High-Performance Premium (Rust Leads the Pack): Rust commands the highest median salary by a significant margin at $210,000,
outperforming all other technologies. This reflects the heavy market premium placed on systems-level programming for high-throughput, 
memory-safe data infrastructure. 

Infrastructure & Orchestration Dominate High-Pay Tiers: Core infrastructure and backend scaling tools
like Terraform ($184,000), Golang ($184,000), and Spring ($175,500) occupy the top compensation tiers,
proving that data engineers who understand cloud infrastructure and microservices command top dollar. 

The Salary vs. Demand Trade-Off: While specialized or niche tools like Rust boast the highest salaries, 
their absolute demand (e.g., 232 job postings) 
is lower compared to ubiquitous orchestrators like Terraform (3,248 postings). Balancing high compensation with
high skill count is the key to strategic career planning.   

┌────────────┬───────────────┬─────────────┐
│   skills   │ median_salary │ skill_count │
│  varchar   │    double     │    int64    │
├────────────┼───────────────┼─────────────┤
│ rust       │      210000.0 │         232 │
│ golang     │      184000.0 │         912 │
│ terraform  │      184000.0 │        3248 │
│ spring     │      175500.0 │         364 │
│ neo4j      │      170000.0 │         277 │
│ gdpr       │      169616.0 │         582 │
│ zoom       │      168438.0 │         127 │
│ graphql    │      167500.0 │         445 │
│ mongo      │      162250.0 │         265 │
│ fastapi    │      157500.0 │         204 │
│ bitbucket  │      155000.0 │         478 │
│ django     │      155000.0 │         265 │
│ crystal    │      154224.0 │         129 │
│ c          │      151500.0 │         444 │
│ atlassian  │      151500.0 │         249 │
│ typescript │      151000.0 │         388 │
│ kubernetes │      150500.0 │        4202 │
│ ruby       │      150000.0 │         736 │
│ airflow    │      150000.0 │        9996 │
│ node       │      150000.0 │         179 │
│ css        │      150000.0 │         262 │
│ redis      │      149000.0 │         605 │
│ vmware     │      148798.0 │         136 │
│ ansible    │      148798.0 │         475 │
│ jupyter    │      147500.0 │         400 │
└────────────┴───────────────┴─────────────┘
*/