-- ============================================================
-- MERCEDES-BENZ SALES ANALYTICS
-- PHASE 3: SQL ANALYSIS
-- ============================================================


-- ============================================================
-- SECTION 1: DATABASE EXPLORATION
-- ============================================================

-- Q1. Display the first 10 records from the Sales table.
SELECT *
FROM SALES 
LIMIT 10 ;


-- Q2. Display all records from the Models table.
-- Check how each Model_ID maps to a Model name.
SELECT *
FROM MODELS;


-- Q3. Display all records from the Regions table.
-- Check how each Region_ID maps to a Region name.
SELECT *
FROM REGIONS;


-- Q4. Count the total number of records in the Sales table.
SELECT COUNT(*) TOTAL_RECORDS_SALES
FROM SALES ;


-- Q5. Check the total number of unique models in the Models table.
SELECT COUNT(DISTINCT(MODEL)) TOTAL_UNIQUE_MODELS
FROM MODELS;


-- Q6. Check the total number of unique regions in the Regions table.
SELECT COUNT(DISTINCT(REGION)) TOTAL_UNIQUE_REGIONS
FROM REGIONS;


-- ============================================================
-- SECTION 2: JOIN VALIDATION
-- ============================================================

-- Q7. Join Sales with Models.
-- Display the Record_ID, Model_ID, and corresponding Model name.
-- Limit the result to 10 rows.
SELECT RECORD_ID, S.MODEL_ID, MODEL 
FROM SALES S, MODELS M
WHERE S.MODEL_ID =  M.MODEL_ID
LIMIT 10;


-- Q8. Join Sales with Regions.
-- Display the Record_ID, Region_ID, and corresponding Region name.
-- Limit the result to 10 rows.
SELECT RECORD_ID, S.REGION_ID, REGION
FROM SALES S, REGIONS R
WHERE S.REGION_ID = R.REGION_ID 
LIMIT 10;


-- Q9. Join Sales, Models, and Regions together.
-- Display the Record_ID, Model name, Region name, Revenue,
-- and Profit for the first 10 records.
SELECT RECORD_ID, MODEL, REGION, REVENUE, PROFIT 
FROM SALES S, MODELS M , REGIONS R
WHERE S.MODEL_ID = M.MODEL_ID 
AND S.REGION_ID = R.REGION_ID
LIMIT 10;


-- ============================================================
-- SECTION 3: OVERALL SALES PERFORMANCE
-- ============================================================

-- Q10. Calculate the total revenue generated across all sales.
SELECT SUM(REVENUE) AS TOTAL_REVENUE
FROM SALES;


-- Q11. Calculate the total profit generated across all sales.
SELECT SUM(PROFIT) AS TOTAL_PROFIT
FROM SALES;


-- Q12. Calculate the total number of units sold.
SELECT SUM(UNITS_SOLD) AS TOTAL_UNITS_SOLD
FROM SALES;


-- Q13. Calculate the average profit margin across all sales.
SELECT AVG(PROFIT_MARGIN_PCT) AVG_PROFIT_MARGIN
FROM SALES; 


-- Q14. Find the average selling price across all sales records.
SELECT AVG(PRICE) AVG_SELLING_PRICE
FROM SALES;


-- ============================================================
-- SECTION 4: MODEL PERFORMANCE ANALYSIS
-- ============================================================

-- Q15. Calculate total revenue for each Mercedes model.
-- Sort the models from highest to lowest revenue.
SELECT MODEL, SUM(REVENUE) TOTAL_REVENUE_PER_MODEL
FROM SALES S, MODELS M
WHERE S.MODEL_ID = M.MODEL_ID 
GROUP BY MODEL
ORDER BY TOTAL_REVENUE_PER_MODEL DESC; 


-- Q16. Calculate total profit for each Mercedes model.
-- Identify the most profitable model.
SELECT MODEL, SUM(PROFIT) TOTAL_PROFIT
FROM SALES S, MODELS M
WHERE S.MODEL_ID = M.MODEL_ID 
GROUP BY MODEL
ORDER BY TOTAL_PROFIT DESC
LIMIT 1;


-- Q17. Calculate total units sold for each model.
-- Sort from highest to lowest.
SELECT MODEL, SUM(UNITS_SOLD) TOTAL_UNITS_SOLD_PER_MODEL
FROM SALES S, MODELS M
WHERE S.MODEL_ID = M.MODEL_ID 
GROUP BY MODEL
ORDER BY TOTAL_UNITS_SOLD_PER_MODEL DESC;


-- Q18. Calculate the average profit margin for each model.
SELECT MODEL, AVG(PROFIT_MARGIN_PCT) AVG_PROFIT_MARGIN_PER_MODEL
FROM SALES S, MODELS M
WHERE S.MODEL_ID = M.MODEL_ID
GROUP BY MODEL;


-- Q19. Find the top 5 Mercedes models by total revenue.
SELECT MODEL, SUM(REVENUE) TOTAL_REVENUE_PER_MODEL
FROM SALES S, MODELS M
WHERE S.MODEL_ID = M.MODEL_ID
GROUP BY MODEL 
ORDER BY TOTAL_REVENUE_PER_MODEL DESC
LIMIT 5;


-- ============================================================
-- SECTION 5: REGIONAL PERFORMANCE ANALYSIS
-- ============================================================

-- Q20. Calculate total revenue for each region.
SELECT REGION, SUM(REVENUE) TOTAL_REVENUE_PER_REGION
FROM SALES S, REGIONS R 
WHERE S.REGION_ID = R.REGION_ID 
GROUP BY REGION
ORDER BY TOTAL_REVENUE_PER_REGION DESC;


-- Q21. Calculate total profit for each region.
SELECT REGION, SUM(PROFIT) TOTAL_PROFIT_PER_REGION
FROM SALES S, REGIONS R 
WHERE S.REGION_ID = R.REGION_ID 
GROUP BY REGION
ORDER BY TOTAL_PROFIT_PER_REGION DESC;


-- Q22. Calculate total units sold for each region.
SELECT REGION, SUM(UNITS_SOLD) TOTAL_UNITS_SOLD_PER_REGION
FROM SALES S, REGIONS R 
WHERE S.REGION_ID = R.REGION_ID 
GROUP BY REGION
ORDER BY TOTAL_UNITS_SOLD_PER_REGION DESC;


-- Q23. Identify the region generating the highest revenue.
SELECT REGION, SUM(REVENUE) TOTAL_REVENUE
FROM SALES S, REGIONS R
WHERE S.REGION_ID = R.REGION_ID 
GROUP BY REGION 
ORDER BY TOTAL_REVENUE DESC
LIMIT 1;


-- Q24. Identify the lowest-performing region based on total profit.
SELECT REGION, SUM(PROFIT) TOTAL_PROFIT
FROM SALES S, REGIONS R 
WHERE S.REGION_ID = R.REGION_ID 
GROUP BY REGION 
ORDER BY TOTAL_PROFIT
LIMIT 1;


-- ============================================================
-- SECTION 6: MODEL AND REGION ANALYSIS
-- ============================================================

-- Q25. Calculate revenue and profit for every Model-Region combination.
SELECT MODEL, REGION, SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) TOTAL_PROFIT
FROM SALES S, MODELS M, REGIONS R
WHERE S.MODEL_ID = M.MODEL_ID 
AND S.REGION_ID = R.REGION_ID 
GROUP BY MODEL, REGION;


-- Q26. Find the most profitable model in each region.
SELECT MODEL, REGION, TOTAL_PROFIT
FROM (SELECT MODEL, REGION, SUM(PROFIT) TOTAL_PROFIT, DENSE_RANK()
OVER (PARTITION BY REGION ORDER BY SUM(PROFIT) DESC) RN
FROM SALES S, MODELS M, REGIONS R 
WHERE S.MODEL_ID = M.MODEL_ID 
AND S.REGION_ID = R.REGION_ID 
GROUP BY MODEL, REGION) 
WHERE RN = 1
ORDER BY TOTAL_PROFIT DESC;


-- Q27. Find the top 2 models in each region based on total profit.
-- Try solving this using a window function.
SELECT *
FROM (SELECT MODEL, REGION, SUM(PROFIT) TOTAL_PROFIT, DENSE_RANK()
OVER (PARTITION BY REGION ORDER BY SUM(PROFIT) DESC) RN 
FROM SALES S, MODELS M, REGIONS R
WHERE S.MODEL_ID = M.MODEL_ID 
AND S.REGION_ID = R.REGION_ID 
GROUP BY MODEL, REGION)
WHERE RN <= 2;


-- Q28. Identify the least profitable model in each region.
SELECT MODEL, REGION , TOTAL_PROFIT
FROM (SELECT MODEL, REGION , SUM(PROFIT) TOTAL_PROFIT, DENSE_RANK()
OVER (PARTITION BY REGION ORDER BY SUM(PROFIT)) RN 
FROM SALES S, MODELS M, REGIONS R
WHERE S.MODEL_ID = M.MODEL_ID 
AND S.REGION_ID = R.REGION_ID 
GROUP BY MODEL, REGION)
WHERE RN = 1;


-- ============================================================
-- SECTION 7: TIME-BASED SALES ANALYSIS
-- ============================================================

-- Q29. Calculate total revenue by year.
SELECT STRFTIME('%Y',DATE) YEAR , SUM(REVENUE) TOTAL_REVENUE_PER_YEAR
FROM SALES
GROUP BY STRFTIME('%Y',DATE)
ORDER BY YEAR;


-- Q30. Calculate total revenue by month.
SELECT STRFTIME('%Y-%m',DATE) MONTH , SUM(REVENUE) TOTAL_REVENUE_PER_MONTH
FROM SALES
GROUP BY STRFTIME('%Y-%m',DATE)
ORDER BY MONTH;


-- Q31. Calculate the month-over-month change in revenue.
-- Try using the LAG() window function.
SELECT T.* , (CURRENT_MONTH_REVENUE - PREVIOUS_MONTH_REVENUE) MOM_REVENUE_CHANGE
FROM (SELECT STRFTIME('%Y-%m',DATE) MONTH , SUM(REVENUE) CURRENT_MONTH_REVENUE,
LAG(SUM(REVENUE)) OVER(ORDER BY STRFTIME('%Y-%m',DATE)) PREVIOUS_MONTH_REVENUE
FROM SALES 
GROUP BY STRFTIME('%Y-%m',DATE)) T
ORDER BY MONTH;


-- Q32. Identify the month with the highest total revenue.
SELECT STRFTIME('%Y-%m',DATE) MONTH , SUM(REVENUE) TOTAL_REVENUE
FROM SALES
GROUP BY STRFTIME('%Y-%m',Date)
ORDER BY TOTAL_REVENUE DESC
LIMIT 1;


-- Q33. Analyze the monthly trend in total units sold.
SELECT STRFTIME('%Y-%m',DATE) MONTH , SUM(UNITS_SOLD) TOTAL_UNITS_SOLD_PER_MONTH
FROM SALES
GROUP BY STRFTIME('%Y-%m',DATE)
ORDER BY MONTH;

-- ============================================================
-- SECTION 8: PRICE AND UNIT TIER ANALYSIS
-- ============================================================

-- Q34. Calculate total revenue, profit, and units sold
-- for each Price_Tier.
SELECT PRICE_TIER, SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) TOTAL_PROFIT, SUM(UNITS_SOLD) TOTAL_UNITS_SOLD
FROM SALES 
GROUP BY PRICE_TIER 
ORDER BY PRICE_TIER;


-- Q35. Identify which Price_Tier generates the highest profit.
SELECT PRICE_TIER, SUM(PROFIT) TOTAL_PROFIT
FROM SALES
GROUP BY PRICE_TIER 
ORDER BY TOTAL_PROFIT DESC
LIMIT 1;


-- Q36. Calculate total revenue and profit for each Unit_Tier.
SELECT UNIT_TIER, SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) TOTAL_PROFIT
FROM SALES
GROUP BY UNIT_TIER 
ORDER BY UNIT_TIER;


-- Q37. Compare the average profit margin across Price_Tiers.
SELECT PRICE_TIER, AVG(PROFIT_MARGIN_PCT) AVG_PROFIT_MARGIN
FROM SALES 
GROUP BY PRICE_TIER 
ORDER BY AVG_PROFIT_MARGIN DESC;


-- ============================================================
-- SECTION 9: DATA QUALITY AND FLAG ANALYSIS
-- ============================================================

-- Q38. Count the total number of price outliers.
SELECT COUNT(IS_OUTLIER) COUNT_PRICE_OUTLIER
FROM SALES
WHERE IS_OUTLIER <> 0 ;


-- Q39. Compare total revenue and profit between
-- outlier and non-outlier records.
SELECT 'NON-OUTLIER' CATEGORY, SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) TOTAL_PROFIT
FROM SALES 
WHERE IS_OUTLIER = 0 

UNION ALL

SELECT 'OUTLIER' CATEGORY, SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) TOTAL_PROFIT
FROM SALES 
WHERE IS_OUTLIER <> 0 ;


-- Q40. Count the total number of loss-making sales records.
SELECT COUNT(RECORD_ID) COUNT_LOSS_MAKING_SALES_RECORD
FROM SALES 
WHERE IS_LOSS <> 0;


-- Q41. Calculate the total financial impact of loss-making records.
SELECT SUM(PROFIT) TOTAL_PROFIT
FROM SALES 
WHERE IS_LOSS <> 0;


-- Q42. Compare overall revenue and profit:
--      a. Including all records
--      b. Excluding price outliers
SELECT 'A' OPTION, 'INCLUDING ALL RECORDS' CATEGORY, SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) TOTAL_PROFIT
FROM SALES 

UNION ALL

SELECT 'B' OPTION, 'EXCLUDING PRICE OUTLIER' CATEGORY, SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) TOTAL_PROFIT
FROM SALES 
WHERE IS_OUTLIER = 0;


-- Q43. Compare overall results with and without loss-making records.
SELECT 'WITH LOSS-MAKING RECORDS' CATEGORY, SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) TOTAL_PROFIT
FROM SALES

UNION ALL

SELECT 'WITHOUT LOSS-MAKING RECORDS' CATEGORY, SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) TOTAL_PROFIT
FROM SALES 
WHERE IS_LOSS = 0;

-- ============================================================
-- SECTION 10: ADVANCED BUSINESS QUESTIONS
-- ============================================================

-- Q44. Rank all Mercedes models by total revenue.
SELECT MODEL, SUM(REVENUE) TOTAL_REVENUE, DENSE_RANK()
OVER(ORDER BY SUM(REVENUE) DESC) MODEL_RANK
FROM SALES S, MODELS M
WHERE S.MODEL_ID = M.MODEL_ID
GROUP BY MODEL;


-- Q45. Rank all Mercedes models by total profit.
SELECT MODEL, SUM(PROFIT) TOTAL_PROFIT, DENSE_RANK()
OVER(ORDER BY SUM(PROFIT) DESC) MODEL_RANK
FROM SALES S, MODELS M 
WHERE S.MODEL_ID = M.MODEL_ID 
GROUP BY MODEL;


-- Q46. Rank models within each region based on total profit.
SELECT REGION, MODEL, SUM(PROFIT) TOTAL_PROFIT, DENSE_RANK()
OVER(PARTITION BY REGION ORDER BY SUM(PROFIT) DESC) MODEL_RANK
FROM SALES S, MODELS M, REGIONS R 
WHERE S.MODEL_ID = M.MODEL_ID 
AND S.REGION_ID = R.REGION_ID 
GROUP BY MODEL, REGION;


-- Q47. Calculate each model's percentage contribution
-- to overall company revenue.
SELECT MODEL, ((TOTAL_MODEL_REVENUE * 100) / TOTAL_REVENUE) OVERALL_REVENUE_PERCENTAGE_CONTRIBUTION_BY_MODEL
FROM (SELECT MODEL, SUM(REVENUE) TOTAL_MODEL_REVENUE, (SELECT SUM(REVENUE) FROM SALES) TOTAL_REVENUE
FROM SALES S , MODELS M 
WHERE S.MODEL_ID = M.MODEL_ID 
GROUP BY MODEL) T
ORDER BY OVERALL_REVENUE_PERCENTAGE_CONTRIBUTION_BY_MODEL DESC;


-- Q48. Calculate each region's percentage contribution
-- to overall company revenue.
SELECT REGION, ((TOTAL_REGION_REVENUE * 100) / TOTAL_REVENUE) OVERALL_REVENUE_PERCENTAGE_CONTRIBUTION_BY_REGION
FROM (SELECT REGION, SUM(REVENUE) TOTAL_REGION_REVENUE, (SELECT SUM(REVENUE) FROM SALES) TOTAL_REVENUE
FROM SALES S, REGIONS R 
WHERE S.REGION_ID = R.REGION_ID 
GROUP BY REGION) T
ORDER BY OVERALL_REVENUE_PERCENTAGE_CONTRIBUTION_BY_REGION DESC;


-- Q49. Find models whose profit margin is above
-- the overall average profit margin.
SELECT MODEL
FROM (SELECT MODEL, AVG(PROFIT_MARGIN_PCT) PROFIT_MARGIN_PER_MODEL, (SELECT AVG(PROFIT_MARGIN_PCT) FROM SALES) AVG_PROFIT_MARGIN
FROM SALES S, MODELS M 
WHERE S.MODEL_ID = M.MODEL_ID 
GROUP BY MODEL) T
WHERE PROFIT_MARGIN_PER_MODEL > AVG_PROFIT_MARGIN;


-- Q50. Identify high-revenue but relatively low-profit models.
SELECT MODEL
FROM SALES S, MODELS M 
WHERE S.MODEL_ID = M.MODEL_ID 
GROUP BY MODEL
HAVING SUM(REVENUE) > (SELECT AVG(TOTAL_REVENUE) FROM (SELECT SUM(REVENUE) TOTAL_REVENUE FROM SALES GROUP BY MODEL_ID) T) 
AND SUM(PROFIT) < (SELECT AVG(TOTAL_PROFIT) FROM (SELECT SUM(PROFIT) TOTAL_PROFIT FROM SALES GROUP BY MODEL_ID) U); 


-- ============================================================
-- SECTION 11: SQL VIEW
-- ============================================================

-- Q51. Create a reusable view that summarizes performance by model.
-- Include:
-- Model name
-- Total Revenue
-- Total Profit
-- Total Units Sold
-- Average Profit Margin
DROP VIEW IF EXISTS MODEL_PERFORMANCE;

CREATE VIEW MODEL_PERFORMANCE AS
SELECT MODEL, SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) TOTAL_PROFIT, SUM(UNITS_SOLD) TOTAL_UNITS_SOLD, AVG(PROFIT_MARGIN_PCT) AVG_PROFIT_MARGIN
FROM SALES S , MODELS M 
WHERE S.MODEL_ID = M.MODEL_ID 
GROUP BY MODEL;


-- Q52. Query the newly created view and rank models
-- by total profit.
SELECT MODEL_PERFORMANCE.*, DENSE_RANK()
OVER(ORDER BY TOTAL_PROFIT DESC) MODEL_RANK
FROM MODEL_PERFORMANCE;


-- ============================================================
-- SECTION 12: FINAL VALIDATION
-- ============================================================

-- Q53. Calculate final total Revenue, Profit, and Units Sold.
-- Compare these values with your Python/Power BI results.
SELECT SUM(REVENUE) TOTAL_REVENUE, SUM(PROFIT) SUM_PROFIT, SUM(UNITS_SOLD) TOTAL_UNITS_SOLD
FROM SALES;


-- Q54. Verify that every Model_ID in Sales has a matching
-- record in the Models table.
SELECT DISTINCT(MODEL_ID)
FROM SALES 
WHERE MODEL_ID NOT IN (SELECT MODEL_ID FROM MODELS);


-- Q55. Verify that every Region_ID in Sales has a matching
-- record in the Regions table.
SELECT REGION_ID 
FROM SALES 
WHERE REGION_ID NOT IN (SELECT REGION_ID FROM REGIONS);


-- ============================================================
-- END OF SQL ANALYSIS
-- ============================================================