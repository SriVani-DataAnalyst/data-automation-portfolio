-- Query to identify high-risk seller accounts based on defect rates and SLA breaches
-- Target platform: AWS Redshift / Postgres data warehouse
-- Created by Sri Vani

WITH base_seller_perf AS (
    SELECT 
        seller_id,
        region,
        COUNT(order_id) AS total_orders,
        SUM(CASE WHEN delivery_status = 'Delayed' THEN 1 ELSE 0 END) AS delayed_orders,
        SUM(CASE WHEN defect_flag = 'Y' THEN 1 ELSE 0 END) AS defective_orders,
        DATE_TRUNC('month', creation_date) AS order_month
    FROM 
        marketplace_dw.fct_shipments
    WHERE 
        creation_date >= DATEADD(day, -90, GETDATE()) -- looking at last 90 days of trends
    GROUP BY 
        1, 2, 6
)
SELECT 
    seller_id,
    region,
    order_month,
    total_orders,
    delayed_orders,
    defective_orders,
    -- calculate percentage rates while protecting against divide-by-zero errors
    ROUND((delayed_orders::FLOAT / NULLIF(total_orders, 0)) * 100, 2) AS sla_breach_pct,
    ROUND((defective_orders::FLOAT / NULLIF(total_orders, 0)) * 100, 2) AS order_defect_rate,
    -- rank high volume sellers to isolate major impacts
    DENSE_RANK() OVER (PARTITION BY region ORDER BY total_orders DESC) AS regional_volume_rank
FROM 
    base_seller_perf
WHERE 
    total_orders >= 100 -- filtering out low volume testing/new accounts
ORDER BY 
    order_defect_rate DESC, 
    sla_breach_pct DESC;
