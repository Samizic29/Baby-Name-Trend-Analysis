-- Names data
SELECT *
FROM names
limit 10;

-- Regions data
SELECT *
FROM regions
limit 10;

/* Exploratory Data Analysis */
-- Total distinct baby names
SELECT COUNT(DISTINCT Name) as total_unique_names
FROM names;

 /* Objective 1 - Track changes in name popularity */
-- 1. Most popular boy and girl names over the years
-- Most Popular Boy Name
SELECT 
	Name,
	SUM(Births) AS num_babies
FROM names
WHERE Gender = 'M'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;  -- Michael is the most popular boy name.

-- Most Popular Girl Name
SELECT 
	Name,
	SUM(Births) AS num_babies
FROM names
WHERE Gender = 'F'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1; -- Jessica is the most popular girl name.

-- Most Popular Boy Names over the years
SELECT *
FROM (
	WITH boy_names AS(
	SELECT Year, Name AS boy_name, SUM(Births) AS num_babies
	FROM names
	WHERE Gender = 'M'
	GROUP BY 1,2
	)

	SELECT Year, boy_name,
		   ROW_NUMBER() OVER (PARTITION BY Year ORDER BY num_babies DESC) AS popularity
	FROM boy_names) AS yearly_popular_boy_names
WHERE popularity = 1;
-- Insight: Michael dominated from 1980–1999, while Jacob led 2000–2009.

-- Most Popular Girl Names over the years
SELECT *
FROM (
	WITH girl_names AS(
	SELECT Year, Name AS girl_name, SUM(Births) AS num_babies
	FROM names
	WHERE Gender = 'F'
	GROUP BY 1,2
	)

	SELECT Year, girl_name,
		   ROW_NUMBER() OVER (PARTITION BY Year ORDER BY num_babies DESC) AS popularity
	FROM girl_names) AS yearly_popular_girl_names
WHERE popularity = 1;
-- Insight: Emily held the longest female name popularity streak (1996–2007)

-- 2. Baby names with the biggest jumps in popularity
-- CTE's
WITH names_1980 AS (
	WITH all_names AS(
		SELECT Year, Name, SUM(Births) AS num_babies
		FROM names
		GROUP BY 1,2
		)
        
	SELECT Year, Name,
		ROW_NUMBER() OVER (PARTITION BY Year ORDER BY num_babies DESC) AS popularity
	FROM all_names
	WHERE Year = 1980
),

names_2009 AS (
	WITH all_names AS(
		SELECT Year, Name, SUM(Births) AS num_babies
		FROM names
		GROUP BY 1,2
		)

	SELECT Year, Name,
		ROW_NUMBER() OVER (PARTITION BY Year ORDER BY num_babies DESC) AS popularity
	FROM all_names
	WHERE Year = 2009
)

SELECT t1.Year, t1.Name, t1.popularity, t2.Year, t2.Name, t2.popularity,
	   CAST(t2.popularity AS SIGNED) -  CAST(t1.popularity AS SIGNED) AS popularity_diff
FROM names_1980 AS t1
INNER JOIN names_2009 AS t2
ON t1.name = t2.name
ORDER BY popularity_diff;
-- Insight: The Colton baby name has the biggest jump in the popularity.

/* Objective 2 - Compare popularity across decades */
-- 1. Top 3 most popular boy and girl names over the years
SELECT *
FROM (
	WITH top_names AS(
			SELECT Year, Name, Gender, SUM(Births) AS num_babies
			FROM names
			GROUP BY 1,2,3
			)

	SELECT Year, Name, Gender,
			ROW_NUMBER() OVER (PARTITION BY YEAR, Gender ORDER BY num_babies DESC) AS popularity
	FROM top_names) AS top_3_year
WHERE popularity <=3;

-- 2. Top 3 most popular boy and girl names over the decades
SELECT *
FROM (
	WITH top_names AS(
			SELECT (CASE
						WHEN Year BETWEEN 1980 AND 1989 THEN 'Eighties'
                        WHEN Year BETWEEN 1990 AND 1999 THEN 'Nineties'
                        WHEN Year BETWEEN 2000 AND 2009 THEN 'Two_Thousands'
                        ELSE 'None' END) AS decade,
            Name, Gender, SUM(Births) AS num_babies
			FROM names
			GROUP BY 1,2,3
			)

	SELECT decade, Name, Gender,
			ROW_NUMBER() OVER (PARTITION BY decade, Gender ORDER BY num_babies DESC) AS popularity
	FROM top_names) AS top_3_decades
WHERE popularity <=3;

/* Objective 3 - Compare popularity across regions */

SELECT DISTINCT Region FROM regions;

-- clean up the region: Replace 'New_England' with 'New England' and add new state 'MI' to 'Midwest' region
WITH clean_regions AS (
	SELECT State,
		   CASE WHEN Region = 'New_England' THEN 'New England' ELSE Region END AS clean_region
	FROM regions
    UNION
    SELECT 'MI' AS State, 'Midwest' AS Region)

-- 1. Total number of babies born in each region
SELECT clean_region, SUM(Births) as num_babies
FROM names n
LEFT JOIN clean_regions cr
ON n.state = cr.State
GROUP BY 1;
-- Insights: The South and Midwest had the highest birth counts.

-- 2. Top 3 most popular boy and girl names in each region
SELECT *
FROM (
-- CTE
	WITH babies_region AS (
		-- clean region
		WITH clean_regions AS (
			SELECT State,
				   CASE WHEN Region = 'New_England' THEN 'New England' ELSE Region END AS clean_region
			FROM regions
			UNION
			SELECT 'MI' AS State, 'Midwest' AS Region)

		SELECT cr.clean_region, n.Gender, n.Name, SUM(n.Births) as num_babies
		FROM names n
		LEFT JOIN clean_regions cr
		ON n.state = cr.State
		GROUP BY 1,2,3
	)

	SELECT clean_region, Gender, num_babies,
		ROW_NUMBER() OVER (PARTITION BY clean_region, Gender ORDER BY num_babies DESC) AS popularity
	FROM babies_region) AS region_popularity
    
WHERE popularity < 4;
-- Insight: Jessica and Michael are the most popular female and male name across all regions excluding the south region.

/* Objective 4 - Explore Unique names */
-- 1. Top 10 popular androgynous names (names given to both females and males)
SELECT Name, COUNT(DISTINCT Gender) AS num_genders, SUM(Births) AS num_babies
FROM names
GROUP BY 1
HAVING num_genders = 2
ORDER BY 3 DESC
LIMIT 10;
-- Insight: Michael and Christopher appeared frequently across genders

-- 2. The most popular short and long baby names
-- shortest names
SELECT Name, LENGTH(Name) as name_length
FROM names
ORDER BY 2; -- 2 characters

-- longest names
SELECT Name, LENGTH(Name) as name_length
FROM names
ORDER BY 2 DESC; -- 15 characters

-- The most popular short and long baby names
WITH short_long_names AS (
	SELECT *
	FROM names
	WHERE LENGTH(Name) IN(2,15)
)

SELECT Name, SUM(Births) AS num_births
FROM short_long_names
GROUP BY 1
ORDER BY 2 DESC;
-- Insight: The most popular short name is TY while Francisco Javier is the most popular long name.