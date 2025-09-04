/*
Question: What are the most optimal skills to learn (i.e., high demand and high paying)?
- Concentrates on remote positions with specified salaries.
- Why? Targets skills that offer job security and financial benefits, 
    offering strategic insights for career development in data analysis.
*/

-- Reuse query 3 and 4 as CTEs

WITH skills_demand AS (
    SELECT
    skills.skill_id,
    skills.skills,
    COUNT(skills_job.job_id) AS skill_counts
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_job ON job_postings_fact.job_id = skills_job.job_id
INNER JOIN skills_dim AS skills ON skills_job.skill_id = skills.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills.skill_id
),
average_salary AS (
    SELECT
    skills.skill_id,
    skills.skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_job ON job_postings_fact.job_id = skills_job.job_id
INNER JOIN skills_dim AS skills ON skills_job.skill_id = skills.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True    --uncomment this to check for remote jobs only
GROUP BY
    skills.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    skill_counts,
    avg_salary
FROM skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    skill_counts > 10
ORDER BY
    skill_counts DESC,
    avg_salary DESC
LIMIT 25;

-- The above query is a bit tedious, we can try to rewrite it in a more concise way.

SELECT
    skills.skill_id,
    skills.skills,
    COUNT(skills_job.job_id) AS skill_counts,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_job ON job_postings_fact.job_id = skills_job.job_id
INNER JOIN skills_dim AS skills ON skills_job.skill_id = skills.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills.skill_id
HAVING
    COUNT(skills_job.job_id) > 10
ORDER BY
    skill_counts DESC,
    avg_salary DESC
LIMIT 25;