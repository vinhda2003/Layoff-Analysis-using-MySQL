# **My-SQL_Project**
*This project using MySQL to Data Proceesing and Exploratory Data Analysis a data set about number of laid off employees of major corporations in the world*

<img width="558" alt="heading img layoff" src="https://github.com/user-attachments/assets/d602328c-61ab-4464-a3f3-523b35c8be61">


# **SQL statements using in project**
- Basic statements
- Create/Alter/Update/Delete table
- Join/Window functions
- Subqueries/CTEs/Temp table

# **Phase 1: Data Proceesing**

```sql
WITH dup_cte AS
(
    SELECT *,
    ROW_NUMBER() OVER(
    PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, 'date', stage, funds_raised_millions) AS row_num
    FROM layoffs_cleaned
)
SELECT *
FROM dup_cte
WHERE row_num > 1;

| company          | location    | industry       | total_laid_off | percentage_laid_off | date       | stage     | country      | funds_raised_millions |
|------------------|-------------|----------------|----------------|---------------------|------------|-----------|--------------|-----------------------|
| E Inc.           | Toronto     | Transportation |                |                     | 12/16/2022 | Post-IPO  | Canada       |                       |
| E Inc.           | Toronto     | Transportation |                |                     | 12/16/2022 | Post-IPO  | Canada       |                       |
| Included Health  | SF Bay Area | Healthcare     |                | 0.06                | 7/25/2022  | Series E  | United States| 272                   |
| Included Health  | SF Bay Area | Healthcare     |                | 0.06                | 7/25/2022  | Series E  | United States| 272                   |


