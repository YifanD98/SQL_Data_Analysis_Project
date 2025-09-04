/*
Question: What skills are required for the top-paying remote data analyst jobs?
- Use the top 10 highest-paying Data Analyst roles identified in the previous query.
- Add the specific skills required for these roles.
- Why? Provide insights into the skills that can help secure high-paying remote data analyst positions.
*/

-- Making the first query into a CTE to use it here.
WITH top10_paying_jobs AS(
    SELECT
    job_id,
    job_title,
    salary_year_avg,
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
LIMIT 10
)

SELECT
--    top10_paying_jobs.*,
    skills.skills,
    COUNT(top10_paying_jobs.job_id) AS num_skills
FROM top10_paying_jobs
INNER JOIN skills_job_dim AS skills_job ON top10_paying_jobs.job_id = skills_job.job_id
INNER JOIN skills_dim AS skills ON skills_job.skill_id = skills.skill_id
GROUP BY
    skills.skills
ORDER BY
    num_skills DESC;

/*
Results of the above query:
[
  {
    "skills": "sql",
    "num_skills": "8"
  },
  {
    "skills": "python",
    "num_skills": "7"
  },
  {
    "skills": "tableau",
    "num_skills": "6"
  },
  {
    "skills": "r",
    "num_skills": "4"
  },
  {
    "skills": "snowflake",
    "num_skills": "3"
  },
  {
    "skills": "pandas",
    "num_skills": "3"
  },
  {
    "skills": "excel",
    "num_skills": "3"
  },
  {
    "skills": "atlassian",
    "num_skills": "2"
  },
  {
    "skills": "jira",
    "num_skills": "2"
  },
  {
    "skills": "aws",
    "num_skills": "2"
  },
  {
    "skills": "azure",
    "num_skills": "2"
  },
  {
    "skills": "bitbucket",
    "num_skills": "2"
  },
  {
    "skills": "confluence",
    "num_skills": "2"
  },
  {
    "skills": "gitlab",
    "num_skills": "2"
  },
  {
    "skills": "go",
    "num_skills": "2"
  },
  {
    "skills": "numpy",
    "num_skills": "2"
  },
  {
    "skills": "oracle",
    "num_skills": "2"
  },
  {
    "skills": "power bi",
    "num_skills": "2"
  },
  {
    "skills": "jenkins",
    "num_skills": "1"
  },
  {
    "skills": "crystal",
    "num_skills": "1"
  },
  {
    "skills": "powerpoint",
    "num_skills": "1"
  },
  {
    "skills": "pyspark",
    "num_skills": "1"
  },
  {
    "skills": "hadoop",
    "num_skills": "1"
  },
  {
    "skills": "git",
    "num_skills": "1"
  },
  {
    "skills": "sap",
    "num_skills": "1"
  },
  {
    "skills": "jupyter",
    "num_skills": "1"
  },
  {
    "skills": "flow",
    "num_skills": "1"
  },
  {
    "skills": "databricks",
    "num_skills": "1"
  }
]
*/