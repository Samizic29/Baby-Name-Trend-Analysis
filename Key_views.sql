-- Creating Views for Data Visualizations
-- Top Names by Births
CREATE VIEW top_names AS
SELECT 
	Name,
    SUM(Births) AS num_babies
FROM names
GROUP BY 1
ORDER BY 2
LIMIT 5;

-- Birth Counts by Gender
CREATE VIEW gender_births AS
SELECT 
	Gender,
    SUM(Births) AS num_babies
FROM names
GROUP BY 1;

-- Top Male Names
CREATE VIEW top_male_names AS
SELECT 
	Name,
	SUM(Births) AS num_babies
FROM names
WHERE Gender = 'M'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Top Female Names
CREATE VIEW top_female_names AS
SELECT 
	Name,
	SUM(Births) AS num_babies
FROM names
WHERE Gender = 'F'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Births by Region
CREATE VIEW region_births AS
SELECT 
	r.clean_region,
    SUM(Births) AS num_babies
FROM names n
INNER JOIN regions_clean r
ON n.State = r.State
GROUP BY 1;

-- Births by State
CREATE VIEW top_state_births AS
SELECT 
	State,
	SUM(Births) AS num_babies
FROM names
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
