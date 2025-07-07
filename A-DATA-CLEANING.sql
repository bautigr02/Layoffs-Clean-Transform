SELECT * FROM layoffs;
SELECT * FROM layoffs WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;
SELECT * FROM layoffs WHERE country LIKE 'United States.';

-- DATA CLEANING
-- 1. Remove Duplicates
-- 2. Standarize the Data
-- 3. Null or Blank Values
-- 4. Remove any Columns or Rows

-- 1. REMOVE DUPLICATES
-- Create a work table like the original
CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT layoffs_staging
SELECT * FROM layoffs;

SELECT * FROM layoffs_staging;

-- row_num to see duplicates
WITH duplicate_cte AS (
SELECT *, ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
as row_num 
FROM layoffs_staging
)
SELECT * FROM duplicate_cte
WHERE row_num > 1;

-- Need to create a new table because we can´t delete rows based on no existing columns. (We need a real row_num column)
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
)
;

INSERT INTO layoffs_staging2
SELECT *, ROW_NUMBER() OVER(
PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
as row_num 
FROM layoffs_staging;

SELECT * FROM layoffs_staging2 
WHERE row_num > 1;

DELETE FROM layoffs_staging2 
WHERE row_num > 1; -- Finally we delete rows based on that column

-- 2. STANDARIZE THE DATA
-- white spaces on column company
SELECT company, trim(company) FROM layoffs_staging2; 

UPDATE layoffs_staging2 
SET company = TRIM(company);

SELECT industry, trim(industry) FROM layoffs_staging2 ORDER BY 1;

-- 3 industries about crypto or similar
SELECT distinct(industry) FROM layoffs_staging2
WHERE industry LIKE 'Crypto%'; 

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry = 'CryptoCurrency' OR industry = 'Crypto Currency';

-- United states & United states.
SELECT distinct country FROM layoffs_staging2
WHERE country LIKE 'United States%';

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- text format date, to date format date
-- convert the text to date format (yyyy-mm-dd)
SELECT `date`, STR_TO_DATE(`date`, '%Y-%m-%d') fecha
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%Y-%m-%d');

SELECT `date` FROM layoffs_staging2;

-- and mofify the data type to date
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 3. NULL OR BLANKS
SELECT * FROM layoffs_staging2;

-- blanks industries to null
UPDATE layoffs_staging2
SET industry = null
WHERE industry = '';

-- join null industries with no null industries of the same company
SELECT t1.company, t1.location, t1.industry, t2.industry 
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL)
	AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- 4. DELETE ANY COLUMNS OR ROWS
-- if total_laid_off and percentage_laid_off is null, it is of no use
SELECT company, total_laid_off, percentage_laid_off FROM layoffs_staging2 
WHERE total_laid_off is null and percentage_laid_off is null;

DELETE FROM layoffs_staging2
WHERE total_laid_off is null and percentage_laid_off is null;

-- drop row_num column (duplicates column)
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Final table
SELECT * FROM layoffs_staging2;