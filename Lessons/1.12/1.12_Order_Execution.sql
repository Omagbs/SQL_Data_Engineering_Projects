/*
Find the top 10 companies for posting jobs
They must have >3000 postings
Limit this to only US jobs
*/

SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS number_of_postings
FROM
    job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    jpf.job_country = 'United States'
GROUP BY
    company_name
HAVING
    COUNT(jpf.job_id) >= 3000
ORDER BY number_of_postings DESC
LIMIT 10;

EXPLAIN
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS number_of_postings
FROM
    job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    jpf.job_country = 'United States'
GROUP BY
    company_name
HAVING
    COUNT(jpf.job_id) >= 3000
ORDER BY number_of_postings DESC
LIMIT 10;

EXPLAIN ANALYZE
SELECT
    cd.name AS company_name,
    COUNT(jpf.job_id) AS number_of_postings
FROM
    job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
WHERE
    jpf.job_country = 'United States'
GROUP BY
    company_name
HAVING
    COUNT(jpf.job_id) >= 3000
ORDER BY number_of_postings DESC
LIMIT 10;

/*
Find the top 5 most in-demands skills specificaaly to Data Engineer
job posting located in the United States*/

SELECT
    sd.skills,
    COUNT(jpf.job_id) AS in_demand_skills
FROM
    job_postings_fact AS jpf
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_country = 'United States'
GROUP BY
    sd.skills
ORDER BY in_demand_skills DESC
LIMIT 5;


/*Write a single SQL query that finds the top 3
companies that have the highest number
of open job postings requiring the skill python,
located in the United States*/

SELECT
    cd.name as company_name,
    COUNT(jpf.job_id) AS number_of_postings
FROM
    job_postings_fact AS jpf
LEFT JOIN company_dim AS cd
    ON jpf.company_id = cd.company_id
LEFT JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
LEFT JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE 
    jpf.job_country = 'United States'
    AND sd.skills = 'python'
GROUP BY
    company_name
ORDER BY number_of_postings DESC
LIMIT 3;