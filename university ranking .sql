-- SELECT *
-- INTO latest_ranking
-- FROM rankings
-- WHERE YEAR = 2025

-- Unequal Distribution of Top-Ranked Universities in 2025
-- Some countries have more universities ranked in the top tier, while others are underrepresented.
-- in this segment we'd show the countries that are ranked in the top tier 

-- 2,092 univeristy recorded--

SELECT * 
FROM latest_ranking

/* we had 115 countries represented and ranked among themeselves*/


SELECT 
    Country,
    Count(Country) as Represented,
    RANK() OVER(ORDER BY Count(Country) DESC) as Rankings
FROM latest_ranking
GROUP BY Country
ORDER BY Country 

/* United State, Japan, United Kingdom, Indian, China,Turkey, Iran, Russian, Brazil, Italy and spain where the top 10 countries represented*/

SELECT Top 10 Country,Count(Country) as Represented
FROM latest_ranking
GROUP BY Country
ORDER BY Represented DESC

-- in this section we found the top 30% of university Ranked by thier countries

with table1 AS
(
    SELECT * 
    FROM latest_ranking
    Where Rank < (select count(Rank) *.30 from latest_ranking)
)
SELECT 
    Country,
    COUNT(Country) AS represented
from table1
GROUP By Country
ORDER BY represented DESC

-- in this section we compare countries to see how many percent made it to the top 30% countries 

WITH table1 AS (
    SELECT * 
    FROM latest_ranking
    WHERE Rank < (SELECT COUNT(Rank) * 0.30 FROM latest_ranking)
),
table2 AS (
    SELECT 
        Country,
        COUNT(Country) AS Represented
    FROM latest_ranking
    GROUP BY Country
)
SELECT 
    t1.Country,
    t2.Represented AS intial_representation,
    COUNT(t1.Country) AS Top30_Percent_Country,
    ROUND((COUNT(t1.Country) * 100.0 / CAST(Represented AS FLOAT)), 2) AS Percent_represented
FROM 
    table1 AS t1
LEFT JOIN 
    table2 AS t2 
ON t1.Country = t2.Country
GROUP BY 
    t1.Country,t2.Represented
ORDER BY 
   Percent_represented DESC;


-- Research and Innovation Disparities in 2025
-- Research quality and output significantly influence countries' global academic reputations.


-- this section list the countries with the highest score of research quality and a total of 83 out of 115 countries where represented 

SELECT Country,COUNT(Country) as repersented
From latest_ranking
Where Research_quality > 49
GROUP BY Country
ORDER BY repersented DESC


-- Trends in International Student Attraction in 2025
-- Some countries attract a higher percentage of international students, reflecting their global education appeal.


SELECT 
    Country, 
    CONCAT(ROUND(AVG(CAST(REPLACE(international_Students, '%', '') AS FLOAT)), 2), '%') AS Avg_Percent
FROM latest_ranking
GROUP BY Country
ORDER BY AVG(CAST(REPLACE(international_Students, '%', '') AS FLOAT)) DESC;



