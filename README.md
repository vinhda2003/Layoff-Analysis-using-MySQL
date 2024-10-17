# **My-SQL_Project**
*This project using MySQL to Data Proceesing and Exploratory Data Analysis a data set about number of laid off employees of major corporations in the world*

<img width="700" alt="heading img layoff" src="https://github.com/user-attachments/assets/d602328c-61ab-4464-a3f3-523b35c8be61">


# **SQL statements using in project**
- Basic statements
- Create/Alter/Update/Delete table
- Join/Window functions
- Subqueries/CTEs/Temp table

# **Phase 1: Data Proceesing**
## **Remove duplicate**
```sql
-- Check duplicates (row_num > 1)
WITH dup_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',stage,funds_raised_millions) as row_num
FROM layoffs_cleaned
)
SELECT *
FROM dup_cte
WHERE row_num > 1;

--Create a new table before delete duplicate
CREATE TABLE `layoffs_cleaned_ver2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--Add value into table was deleted duplicate (row_num = 1)
INSERT layoffs_cleaned_ver2
WITH dup_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',stage,funds_raised_millions) as row_num
FROM layoffs_cleaned
)
SELECT *
FROM dup_cte
WHERE row_num = 1;

```
<img width="700" alt="duplicate_table" src="https://github.com/user-attachments/assets/b9139eed-f603-4632-99cb-c6c8c35b9bd9">

## **Standardize Data**

```
--industry column

SELECT DISTINCT industry
FROM layoffs_cleaned_ver2
ORDER BY 1;

SELECT DISTINCT industry
FROM layoffs_cleaned_ver2
WHERE industry LIKE 'Crypto%'
ORDER BY 1;

UPDATE layoffs_cleaned_ver2
SET industry ='Crypto'
WHERE industry LIKE 'Crypto%';
```
<img width="700" alt="image" src="https://github.com/user-attachments/assets/02759931-32b1-4bb8-9b58-df3cdd918679">

```
--country column
SELECT DISTINCT country
FROM layoffs_cleaned_ver2
ORDER BY 1;

SELECT DISTINCT country
FROM layoffs_cleaned_ver2
WHERE country LIKE 'United States%';

UPDATE layoffs_cleaned_ver2
SET country = TRIM(TRAILING '.' FROM country);
```

<img width="700" alt="image" src="https://github.com/user-attachments/assets/96ff3e33-6f9b-44bb-aaad-9dbbde29d62f">

```
--date column
SELECT date, STR_TO_DATE(date, '%m/%d/%Y') as date_trans
FROM layoffs_cleaned_ver2;

UPDATE layoffs_cleaned_ver2
SET date = STR_TO_DATE(date, '%m/%d/%Y');
```

<img width="700" alt="image" src="https://github.com/user-attachments/assets/66901976-a1ad-43e1-9c99-1677ad248246">

## **Fill Null and BLank values**

```
-- Industry column

-- Check industry is Null 
SELECT *
FROM layoffs_cleaned_ver2
WHERE industry IS NULL OR industry LIKE '';

UPDATE layoffs_cleaned_ver2
SET industry = NULL
WHERE industry = '';

-- Check all company missing value in industry column
SELECT *
FROM layoffs_cleaned_ver2 lo1 	
JOIN layoffs_cleaned_ver2 lo2
ON lo1.company = lo2.company 
WHERE (lo1.industry IS NULL OR lo1.industry ='') 
AND lo2.industry IS NOT NULL;

-- Update missing industry value for all company
UPDATE layoffs_cleaned_ver2 lo1
JOIN layoffs_cleaned_ver2 lo2
ON lo1.company = lo2.company 
SET lo1.industry=lo2.industry
WHERE lo1.industry IS NULL AND lo2.industry IS NOT NULL;
```
<img width="626" alt="image" src="https://github.com/user-attachments/assets/416771bb-d214-433c-8937-32a7d0f759db">

```
-- total_laid_off Column and percentage_laid_off Column

SELECT *
FROM layoffs_cleaned_ver2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

-- Delete rows have null in total_laid_off and percentage_laid_off
DELETE FROM layoffs_cleaned_ver2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;
```

<img width="623" alt="image" src="https://github.com/user-attachments/assets/d86a15b7-e72b-4f05-a0fa-0cbc985f7148">


