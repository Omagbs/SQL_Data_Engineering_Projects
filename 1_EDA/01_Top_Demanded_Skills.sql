/* Question: What are the most in-demand skills for data engineers
a. identify the top 10 in-demand skilss for data engineers
b. focus on remote job postings
Why?
Retrieves the top skills with the highest demand in the remote 
job market, providing insights into the most valuable skilss 
for data engineers seeking remote work*/

--using LEFT JOIN
SELECT
    sd.skills AS in_demand_skills,
    COUNT(jpf.job_id) AS skill_count

FROM
    job_postings_fact AS jpf
    LEFT JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    LEFT JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id

WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND (jpf.job_work_from_home = TRUE
    OR jpf.job_location LIKE '%remote%')

GROUP BY
    in_demand_skills

ORDER BY 
    skill_count DESC
LIMIT 10;

/*
┌──────────────────┬─────────────┐
│ in_demand_skills │ skill_count │
│     varchar      │    int64    │
├──────────────────┼─────────────┤
│ sql              │       29221 │
│ python           │       28776 │
│ aws              │       17823 │
│ azure            │       14143 │
│ spark            │       12799 │
│ airflow          │        9996 │
│ snowflake        │        8639 │
│ databricks       │        8183 │
│ java             │        7267 │
│ gcp              │        6446 │
└──────────────────┴─────────────┘
  10 rows              2 columns
  */

--using INNER JOIN
SELECT
    sd.skills AS in_demand_skills,
    COUNT(jpf.job_id) AS skill_count

FROM
    job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id

WHERE 
    jpf.job_title_short = 'Data Engineer'
    AND (jpf.job_work_from_home = TRUE
    OR jpf.job_location LIKE '%remote%')

GROUP BY
    in_demand_skills

ORDER BY 
    skill_count DESC
LIMIT 10;

/*
┌──────────────────┬─────────────┐
│ in_demand_skills │ skill_count │
│     varchar      │    int64    │
├──────────────────┼─────────────┤
│ sql              │       29221 │
│ python           │       28776 │
│ aws              │       17823 │
│ azure            │       14143 │
│ spark            │       12799 │
│ airflow          │        9996 │
│ snowflake        │        8639 │
│ databricks       │        8183 │
│ java             │        7267 │
│ gcp              │        6446 │
└──────────────────┴─────────────┘
  10 rows              2 columns
  */

  /*
  Here's the breakdown of the most demanded skills for data engineers:
  SQL and python are by far the most in-demands skills, with around 29,000 jobs postins each, nearly double the next skills
  Cloud platforms, such as aws and azure, emerged the next in demand skillsm with aws amounting to to ~17,000, followed by Azure with about 14,000.
  Apache spark makes the top 5 with nearly 13,000 postings, highlighting the importance of big data processing skills

  Key Takeaways:
  - SQL and Python remain the foundational skills for data engineers
  - Cloud platforms (AWS, Azure) are important for modern data engineering
  - Big data tools like Spark continue to be highly valued
  - Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
  - Java and GCP round out the top 10 most requested skills

  ┌──────────────────┬─────────────┐
│ in_demand_skills │ skill_count │
│     varchar      │    int64    │
├──────────────────┼─────────────┤
│ sql              │       29221 │
│ python           │       28776 │
│ aws              │       17823 │
│ azure            │       14143 │
│ spark            │       12799 │
│ airflow          │        9996 │
│ snowflake        │        8639 │
│ databricks       │        8183 │
│ java             │        7267 │
│ gcp              │        6446 │
└──────────────────┴─────────────┘
  10 rows              2 columns
  */

  