/*
Question: What are the most in-demand skills for data analyst jobs?
- Identify the top 5 in-demand skills for a data analyst role.
- Focus on all job postings.
- Why? Retrieve the top 5 skills with the highest demand in the data analyst job market, providing insights for job seekers.
*/

SELECT
    skills,
    COUNT(skills_job.job_id) AS skill_counts
FROM job_postings_fact
INNER JOIN skills_job_dim AS skills_job ON job_postings_fact.job_id = skills_job.job_id
INNER JOIN skills_dim AS skills ON skills_job.skill_id = skills.skill_id
WHERE
    job_title_short = 'Data Analyst'
--  AND job_work_from_home = True
GROUP BY
    skills.skills
ORDER BY
    skill_counts DESC
LIMIT 5;