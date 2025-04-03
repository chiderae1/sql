# University Ranking SQL Project

## Overview
This project analyzes global university rankings using structured SQL queries. The dataset includes key performance indicators such as international student percentages, academic reputation, employer reputation, and country representation among top-tier universities.

## Dataset Description
The dataset contains information related to universities and their rankings, including:
- University Name: The official name of the university.
- Country: The country where the university is located.
- Ranking: The global ranking of the university.
- International Students: Percentage of international students.
- Academic Reputation: Score representing the university's academic prestige.
- Employer Reputation: Score based on employer feedback.

## SQL Scripts
The repository includes various SQL queries for analyzing university rankings:

1. **Number of Universities Represented Per Country
   
   SELECT 
       Country,
       COUNT(Country) AS Represented,
       RANK() OVER (ORDER BY COUNT(Country) DESC) AS Rankings
   FROM latest_ranking
   GROUP BY Country
   ORDER BY Country;
   
   - This query ranks countries based on the number of universities represented in the dataset.

2. Top 10 Countries with Most Universities Ranked**
   sql
   SELECT TOP 10 Country, COUNT(Country) AS Represented
   FROM latest_ranking
   GROUP BY Country
   ORDER BY Represented DESC;
   - This query identifies the top 10 countries with the highest number of ranked universities.

3. Average International Student Percentage by Country
   sql
   SELECT Country,
          CONCAT(ROUND(AVG(CAST(REPLACE(international_Students, '%', '') AS FLOAT)), 2), '%') AS Avg_Percent
   FROM latest_ranking
   GROUP BY Country
   ORDER BY AVG(CAST(REPLACE(international_Students, '%', '') AS FLOAT)) DESC; 
   - This query calculates the average percentage of international students per country.

4. Top 30% Universities by Country Ranking**
   sql
   WITH table1 AS (
       SELECT *, 
              PERCENT_RANK() OVER (ORDER BY Ranking ASC) AS percentile_rank
       FROM latest_ranking
   )
   SELECT *
   FROM table1
   WHERE percentile_rank <= 0.30;
   
   - This query filters the top 30% of universities based on their ranking.

## Setup Instructions
1. Ensure you have a **SQL database** (MySQL, PostgreSQL, or SQL Server) installed.
2. Load the dataset into your database using:
   sql
   CREATE TABLE latest_ranking (
       University_Name VARCHAR(255),
       Country VARCHAR(100),
       Ranking INT,
       International_Students VARCHAR(10),
       Academic_Reputation FLOAT,
       Employer_Reputation FLOAT
   );
   
3. Import the dataset using your preferred SQL client.

## Usage
- Modify the queries to explore different aspects of university rankings.
- Use the provided scripts to gain insights into global education trends.
- Perform advanced analytics using joins, filters, and aggregations.
