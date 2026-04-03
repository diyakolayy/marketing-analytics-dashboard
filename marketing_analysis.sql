--1. View all data
SELECT * FROM marketing_analysis LIMIT 5;

--2. Select specific columns
SELECT "Campaign_ID", "Budget", "Clicks", "Conversions"
FROM marketing_analysis;

--3. Filter campaigns with high budget
SELECT * FROM marketing_analysis
WHERE "Budget" > 30000;

--4. Get campaigns with ROI greater than 2
SELECT "Campaign_ID", "ROI"
FROM marketing_analysis
WHERE "ROI" > 2;

-- 5. Sort campaigns by Revenue (highest first)
SELECT "Campaign_ID", "Revenue_Generated"
FROM marketing_analysis
ORDER BY "Revenue_Generated" DESC;


-- 6. Count total records
SELECT COUNT(*) AS total_campaigns
FROM marketing_analysis;

-- 7. Average ROI
SELECT AVG("ROI") AS avg_roi
FROM marketing_analysis;

-- 8. Total revenue generated
SELECT SUM("Revenue_Generated") AS total_revenue
FROM marketing_analysis;

-- 9. Group by subscription tier
SELECT "Subscription_Tier", COUNT(*) AS total_users
FROM marketing_analysis
GROUP BY "Subscription_Tier";

-- 10. Average conversions per subscription tier
SELECT "Subscription_Tier", AVG("Conversions") AS avg_conversions
FROM marketing_analysis
GROUP BY "Subscription_Tier";

-- 11. Top 5 campaigns by clicks
SELECT "Campaign_ID", "Clicks"
FROM marketing_analysis
ORDER BY "Clicks" DESC
LIMIT 5;

-- 12. Campaigns with high conversions but low clicks
SELECT "Campaign_ID", "Clicks", "Conversions"
FROM marketing_analysis
WHERE "Conversions" > 500 AND "Clicks" < 1000;

-- 13. Revenue by subscription tier
SELECT "Subscription_Tier", SUM("Revenue_Generated") AS total_revenue
FROM marketing_analysis
GROUP BY "Subscription_Tier"
ORDER BY "total_revenue" DESC;

-- 14. Count campaigns per flash sale
SELECT "Flash_Sale_ID", COUNT(*) AS campaign_count
FROM marketing_analysis
GROUP BY "Flash_Sale_ID";

-- 15. ROI per campaign efficiency (Revenue vs Budget ratio)
SELECT 
    "Campaign_ID",
    "Revenue_Generated",
    "Budget",
    ("Revenue_Generated"::NUMERIC / NULLIF("Budget", 0)) AS revenue_to_budget_ratio
FROM "marketing_analysis"
ORDER BY revenue_to_budget_ratio DESC;


-- 16. Rank campaigns based on revenue
SELECT 
    "Campaign_ID",
    "Revenue_Generated",
    RANK() OVER (ORDER BY "Revenue_Generated" DESC) AS revenue_rank
FROM "marketing_analysis";


-- 17. Top 3 campaigns per subscription tier
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY "Subscription_Tier" 
               ORDER BY "Revenue_Generated" DESC
           ) AS rn
    FROM "marketing_analysis"
) t
WHERE rn <= 3;


-- 18. Running total of revenue
SELECT 
    "Campaign_ID",
    "Revenue_Generated",
    SUM("Revenue_Generated") OVER (
        ORDER BY "Campaign_ID"
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM "marketing_analysis";


-- 19. Compare each campaign with average ROI
SELECT 
    "Campaign_ID",
    "ROI",
    AVG("ROI") OVER () AS avg_roi,
    "ROI" - AVG("ROI") OVER () AS roi_difference
FROM "marketing_analysis";


-- 20. Identify high-performing campaigns (above average ROI)
SELECT *
FROM "marketing_analysis"
WHERE "ROI" > (
    SELECT AVG("ROI") 
    FROM "marketing_analysis"
);


-- 21. Product-wise total revenue
SELECT 
    "Product_ID",
    SUM("Revenue_Generated") AS total_revenue
FROM "marketing_analysis"
GROUP BY "Product_ID"
ORDER BY total_revenue DESC;


-- 22. Discount impact on units sold
SELECT 
    "Discount_Level",
    AVG("Units_Sold") AS avg_units_sold
FROM "marketing_analysis"
GROUP BY "Discount_Level"
ORDER BY avg_units_sold DESC;


-- 23. Correlation-style insight (Clicks vs Conversions)
SELECT 
    "Campaign_ID",
    "Clicks",
    "Conversions",
    ("Conversions"::NUMERIC / NULLIF("Clicks", 0)) AS conversion_rate
FROM "marketing_analysis"
WHERE "Clicks" > 0
ORDER BY conversion_rate DESC;








