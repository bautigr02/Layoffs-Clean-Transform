-- B. EXPLORATORY-DATA-ANALYSIS

SELECT * FROM layoffs_staging2;

-- layoffs per year
SELECT sum(total_laid_off) as total, year(`date`) as `year` 
FROM layoffs_staging2
GROUP BY `year`
HAVING `year` IS NOT NULL;

-- Bankruptcies by industry per year
SELECT industry, count(percentage_laid_off) quiebres, sum(total_laid_off) despidos, YEAR(`date`) año FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY industry, year(`date`)
HAVING quiebres > 4
ORDER BY quiebres desc;

-- layoffs per year of Twitter
SELECT company, sum(total_laid_off) as total, year(`date`) as `year` 
FROM layoffs_staging2
GROUP BY company, `year`
HAVING company = 'Twitter'
ORDER BY total desc;

-- layoffs per industry
SELECT industry, sum(total_laid_off) despidos 
FROM layoffs_staging2
GROUP BY industry
ORDER BY despidos desc;

-- layoffs per country
SELECT country, sum(total_laid_off) despidos 
FROM layoffs_staging2
GROUP BY country
ORDER BY despidos desc;

-- acum. layoffs 
WITH total AS
(
SELECT substring(`date`,1,7) as Mes, sum(total_laid_off) as Despidos
FROM layoffs_staging2
GROUP BY Mes
HAVING Mes IS NOT NULL
ORDER BY 1 asc
)
SELECT *, sum(Despidos) OVER(ORDER BY Mes) as Acumulados
FROM total;

-- Companies layoffs per year rank
WITH despidos_empresa AS(
SELECT company, sum(total_laid_off) despidos, year(`date`) as `year`
FROM layoffs_staging2
GROUP BY company,`year` 
), 
ranking_despidos AS(
SELECT *, DENSE_RANK() OVER(PARTITION BY `year` ORDER BY despidos desc)  as ranking
FROM despidos_empresa
WHERE  `year` IS NOT NULL
)
SELECT * 
FROM ranking_despidos
WHERE ranking < 6;

-- Industries layoffs per year rank
WITH despidos_industria AS(
SELECT industry, sum(total_laid_off) despidos, year(`date`) as `year`
FROM layoffs_staging2
GROUP BY industry, `year` 
), 
ranking_despidos AS(
SELECT *, DENSE_RANK() OVER(PARTITION BY `year` ORDER BY despidos desc)  as ranking
FROM despidos_industria
WHERE  `year` IS NOT NULL
),
ranking_apariciones AS(
SELECT *, ROW_NUMBER() OVER(PARTITION BY industry) apariciones
FROM ranking_despidos
WHERE ranking < 6
ORDER BY `year` asc, ranking asc
)
SELECT * FROM ranking_apariciones;

SELECT industry, sum(total_laid_off) despidos
FROM layoffs_staging2
GROUP BY industry;

SELECT company, sum(total_laid_off) despidos
FROM layoffs_staging2
GROUP BY company;