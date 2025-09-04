/*
Question: What are the top-pyaing data analyst jobs?
- Identify the top 10 highest-p[aying Data Analyst roles that are avialable remotely.
- Focuses on job postings with specified salaries (remove nulls).
- Why? Highlight the top-pyaing opportunities for data analysts, offering insights into employment opportunities.]
*/

SELECT
    job_id,
    job_title,
    job_location,
    salary_year_avg,
    job_posted_date,
    companies.name AS company_name
FROM
    job_postings_fact
-- Adding company names to see what companies are offering these top-paying jobs.
LEFT JOIN company_dim AS companies ON job_postings_fact.company_id = companies.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'Anywhere' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;