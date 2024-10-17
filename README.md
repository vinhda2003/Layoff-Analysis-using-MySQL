# **My-SQL_Project**
*This project using MySQL to Data Proceesing and Exploratory Data Analysis a data set about number of laid off employees of major corporations in the world*

<img width="558" alt="heading img layoff" src="https://github.com/user-attachments/assets/d602328c-61ab-4464-a3f3-523b35c8be61">


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
<img width="611" alt="duplicate_table" src="https://github.com/user-attachments/assets/b9139eed-f603-4632-99cb-c6c8c35b9bd9">

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
<img width="566" alt="image" src="https://github.com/user-attachments/assets/02759931-32b1-4bb8-9b58-df3cdd918679">




