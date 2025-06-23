SELECT
    skills,
    COUNT(skills) AS skills_number
FROM job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_work_from_home = TRUE AND
    job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY skills_number DESC
LIMIT 5