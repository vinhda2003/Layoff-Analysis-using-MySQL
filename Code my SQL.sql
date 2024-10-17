-- Requirement: Using my SQL to data cleaning and Exploratory Data Analysis (EDA) 
-- Dataset Info
SELECT 
    (SELECT COUNT(*) FROM layoffs) AS number_of_rows, 
    (SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = 'layoffs') AS number_of_columns;

-- I. Data Cleaning:
-- 1. Remove duplicates
-- 2. Standardize the Data
-- 3. Fill Null and BLank values
-- 4. Remove Any Columns

SELECT *
FROM layoffs;

-- Create a new table using for data cleaning

CREATE TABLE layoffs_cleaned
LIKE layoffs;

INSERT layoffs_cleaned
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_cleaned;

-- 1. Remove duplicates
WITH dup_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,'date',stage,funds_raised_millions) as row_num
FROM layoffs_cleaned
)
DELETE 
FROM dup_cte
WHERE row_num > 1;

