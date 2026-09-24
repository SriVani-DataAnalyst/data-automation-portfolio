-- =========================================================================
-- SYSTEM: CUSTOMER RISK & PORTFOLIO ANALYTICS DATA MART
-- TARGET: ANALYTICAL REPOSITORY FOR EXL & LATENTVIEW CONSULTING FRAMEWORKS
-- FOCUS: FACT/DIMENSION MODELING, DATA CLEANSING, AND COMPLEX TRANSFORMS
-- =========================================================================

-- STEP 1: Clean and Aggregate Transactional Pipeline (Data Cleansing & CTE Transformation)
WITH cleaned_transactions AS (
    SELECT 
        customer_id,
        account_id,
        transaction_id,
        transaction_amount,
        transaction_date,
        COALESCE(transaction_status, 'UNKNOWN') AS verified_status,
        -- Handle missing flags safely without breaking system logic
        CASE 
            WHEN delinquency_days IS NULL THEN 0 
            ELSE delinquency_days 
        END AS derived_delinquency_days
    FROM 
        source_banking.fct_raw_transactions
    WHERE 
        transaction_date >= DATEADD(month, -12, GETDATE())
        AND account_id IS NOT NULL
),

-- STEP 2: Aggregate Performance Metrics per Account Structure
account_aggregates AS (
    SELECT 
        account_id,
        customer_id,
        COUNT(transaction_id) AS total_tx_count,
        SUM(transaction_amount) AS total_spend_volume,
        MAX(derived_delinquency_days) AS peak_delinquency_streak,
        -- Compute running distribution profiles via window functions
        AVG(transaction_amount) OVER(PARTITION BY customer_id) AS avg_customer_monthly_spend
    FROM 
        cleaned_transactions
    WHERE 
        verified_status = 'COMPLETED'
    GROUP BY 
        account_id, customer_id, transaction_amount
)

-- STEP 3: Load into Analytical Data Mart Layer with Risk Categorization
SELECT 
    agg.account_id,
    agg.customer_id,
    agg.total_tx_count,
    agg.total_spend_volume,
    agg.peak_delinquency_streak,
    -- Apply strict business-rule segmentations for portfolio risk analysis
    CASE 
        WHEN agg.peak_delinquency_streak = 0 THEN 'Tier-1 Elite'
        WHEN agg.peak_delinquency_streak BETWEEN 1 AND 30 THEN 'Tier-2 Watchlist'
        WHEN agg.peak_delinquency_streak BETWEEN 31 AND 90 THEN 'Tier-3 Substandard'
        ELSE 'Tier-4 Non-Performing'
    END AS risk_segmentation_tier,
    -- Prevent potential divide-by-zero calculation breakdowns across massive datasets
    ROUND((agg.total_spend_volume / NULLIF(agg.total_tx_count, 0)), 2) AS ticket_size_velocity,
    DENSE_RANK() OVER(PARTITION BY agg.risk_segmentation_tier ORDER BY agg.total_spend_volume DESC) AS risk_tier_spend_rank
INTO 
    analytics_mart.dm_portfolio_risk_profile
FROM 
    account_aggregates agg
ORDER BY 
    risk_segmentation_tier ASC, 
    total_spend_volume DESC;
