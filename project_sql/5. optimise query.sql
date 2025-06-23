/* Question: What are the most optimal skills to learn loka it's in high demand and a high-paying skill)?"
- Identify skills in high demand and assoliated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified Malacies
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in data analysis */

WITH demanded_skills AS (
SELECT
    skills_job_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL

GROUP BY 
    skills_job_dim.skill_id,
    skills_dim.skills


),
top_paying_skills AS(
SELECT
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE AND
    salary_year_avg IS NOT NULL

GROUP BY 
   skills_job_dim.skill_id

)

SELECT
    demanded_skills.skill_id,
    demanded_skills.skills,
    demanded_skills.demand_count,
    top_paying_skills.avg_salary
FROM demanded_skills
INNER JOIN top_paying_skills ON demanded_skills.skill_id = top_paying_skills.skill_id
ORDER BY
    demand_count DESC,
    avg_salary DESC