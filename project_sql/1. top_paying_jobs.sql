/*
Question: What are the top paying data analyst jobs ?
- Identify the top 10 paying data analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove NULL)
-Why? Highlight the top paying oppotunities for Data analysts offering insights
*/

SELECT 
    job_id,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name

FROM job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE
    job_location = 'Anywhere' AND
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10