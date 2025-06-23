WITH job_per_month AS (SELECT
    job_postings_fact.job_id,
    job_postings_fact.job_title_short,
    job_postings_fact.job_location,
    job_postings_fact.job_via,
    job_postings_fact.salary_year_avg
    skills_dim.skills,
    skills_dim.type,
    EXTRACT(MONTH FROM job_postings_fact.job_posted_date) AS job_month
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE job_postings_fact.salary_year_avg > 70000
ORDER BY job_postings_fact.job_id)

(SELECT *
FROM job_per_month
WHERE job_month = 1)

UNION ALL

(SELECT *
FROM job_per_month
WHERE job_month = 2)

UNION ALL

(SELECT *
FROM job_per_month
WHERE job_month = 3)



