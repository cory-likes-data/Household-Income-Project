# US Household Income - Date Cleaning and EDA - 2 parts

# US Household Income - Data Cleaning - Part 1 of 2

SELECT *
FROM us_household_income
; 


SELECT *
FROM us_household_income_statistics
; 


ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`
;


SELECT COUNT(id)
FROM us_household_income
; 


SELECT COUNT(id) 
FROM us_household_income_statistics
; 


SELECT id, COUNT(id)
FROM us_household_income 
GROUP BY id
HAVING COUNT(id) > 1
;


SELECT *
FROM (
SELECT row_id,
	   id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_household_income
) duplicates 
WHERE row_num > 1  
; 


DELETE FROM us_household_income
WHERE row_id IN (
	SELECT row_id
	FROM (
		SELECT row_id,
	    id,
        ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
        FROM us_household_income
        ) duplicates 
	WHERE row_num > 1 )
; 


SELECT id, COUNT(id)
FROM us_household_income_statistics 
GROUP BY id
HAVING COUNT(id) > 1
;


SELECT *
FROM us_household_income
;


SELECT State_Name, COUNT(State_Name)
FROM us_household_income
GROUP BY State_Name
;


SELECT DISTINCT State_Name
FROM us_household_income
GROUP BY State_Name
ORDER BY 1
;


UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia' 
;


UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama' 
;


SELECT *
FROM us_household_income
;


SELECT DISTINCT State_ab
FROM us_household_income
ORDER BY 1
; 


SELECT *
FROM us_household_income
ORDER BY 1
;


SELECT *
FROM us_household_income
WHERE Place = ''
ORDER BY 1
;


SELECT *
FROM us_household_income
WHERE County = 'Autauga County' 
ORDER BY 1
;


UPDATE us_household_income
SET Place = 'Autaugaville' 
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;


SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
;


UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs' 
;


SELECT *
FROM us_household_income
;


SELECT ALand, AWater
FROM us_household_income
WHERE AWater = 0 OR AWater = '' OR AWater IS NULL 
;


SELECT DISTINCT AWater
FROM us_household_income
WHERE AWater = 0 OR AWater = '' OR AWater IS NULL 
;


SELECT ALand, AWater
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL) 
AND (ALand = 0 OR ALand = '' OR ALand IS NULL)
;


SELECT ALand, AWater
FROM us_household_income
WHERE ALand = 0 OR ALand = '' OR ALand IS NULL
;






# US Household Income - Exploratory Data Analysis - Part 2 of 2






SELECT * 
FROM us_household_income
;


SELECT * 
FROM us_household_income_statistics
;


SELECT State_Name, SUM(ALand), SUM(AWater) 
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
;


SELECT State_Name, SUM(ALand), SUM(AWater) 
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10
;


SELECT * 
FROM us_household_income ui 
JOIN us_household_income_statistics uhis
	ON ui.id = uhis.id
;


SELECT * 
FROM us_household_income ui 
RIGHT JOIN us_household_income_statistics uhis
	ON ui.id = uhis.id
WHERE ui.id IS NULL
;


SELECT * 
FROM us_household_income ui 
JOIN us_household_income_statistics uhis
	ON ui.id = uhis.id
;


SELECT * 
FROM us_household_income ui 
JOIN us_household_income_statistics uhis
	ON ui.id = uhis.id
WHERE Mean <> 0
;


SELECT ui.State_Name, County, Type, `Primary`, Mean, Median
FROM us_household_income ui 
JOIN us_household_income_statistics uhis
	ON ui.id = uhis.id
WHERE Mean <> 0
;


SELECT ui.State_Name, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income ui 
JOIN us_household_income_statistics uhis
	ON ui.id = uhis.id
WHERE Mean <> 0
GROUP BY ui.State_Name
ORDER BY 2 DESC
LIMIT 10
;


SELECT Type, COUNT(TYPE), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income ui 
JOIN us_household_income_statistics uhis
	ON ui.id = uhis.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 3 DESC
;


SELECT Type, COUNT(TYPE), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income ui 
JOIN us_household_income_statistics uhis
	ON ui.id = uhis.id
WHERE Mean <> 0
GROUP BY 1
ORDER BY 4 DESC
;


SELECT *
FROM us_household_income
WHERE Type = 'Community'
;


SELECT Type, COUNT(TYPE), ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income ui 
JOIN us_household_income_statistics uhis
	ON ui.id = uhis.id
WHERE Mean <> 0
GROUP BY 1
HAVING COUNT(Type) > 100
ORDER BY 4 DESC
;


SELECT ui.State_Name, City, ROUND(AVG(Mean),1), ROUND(AVG(Median),1)
FROM us_household_income ui 
JOIN us_household_income_statistics uhis
	ON ui.id = uhis.id
GROUP BY State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC 
;










