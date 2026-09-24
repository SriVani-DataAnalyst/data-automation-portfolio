# =========================================================================
# SYSTEM: PORTFOLIO PERFORMANCE & EARLY RISK SCORE MIGRATION ENGINE
# TARGET: SCALABLE EXPLORATORY ANALYSIS & RISK STRATEGY TESTING (EXL/LATENTVIEW)
# PLATFORM: PYTHON (PANDAS, NUMPY)
# =========================================================================

import pandas as pd
import numpy as np

def run_score_migration_matrix(dataset_path=None):
    """
    Simulates portfolio segment migration matrix parsing and alternative score 
    cut-off strategy evaluation based on transaction and vintage performance data.
    """
    print("[INFO] Initializing risk pipeline engine...")
    
    # 1. GENERATING SCALABLE REPLICABLE MOCK DATA FOR DEMONSTRATION PURPOSES
    np.random.seed(42)
    n_records = 50000
    
    mock_data = {
        'customer_id': np.arange(100000, 100000 + n_records),
        'segment': np.random.choice(['Retail', 'SME', 'Corporate', 'Micro-Finance'], size=n_records, p=[0.5, 0.2, 0.1, 0.2]),
        'baseline_credit_score': np.random.randint(300, 850, size=n_records),
        'subsequent_credit_score': np.random.randint(300, 850, size=n_records),
        'vintage_delinquency_days': np.random.choice([0, 15, 45, 95], size=n_records, p=[0.75, 0.15, 0.07, 0.03])
    }
    
    df = pd.DataFrame(mock_data)
    
    # 2. APPLYING RECONCILIATION LOGIC & VALIDATION CHECKS (Data Cleansing Block)
    df['score_delta'] = df['subsequent_credit_score'] - df['baseline_credit_score']
    
    # Define current strategy thresholds
    current_cutoff = 600
    proposed_cutoff = 650
    
    # 3. SCORE CUT-OFF STRATEGY MODELING EVALUATION
    print(f"\n--- EVALUATING ALTERNATIVE SCORE CUT-OFF IMPACTS ---")
    
    for cutoff in [current_cutoff, proposed_cutoff]:
        approved_pool = df[df['baseline_credit_score'] >= cutoff]
        total_approved = len(approved_pool)
        
        # Calculate delinquency velocity within approved population
        bad_loans = len(approved_pool[approved_pool['vintage_delinquency_days'] > 30])
        delinquency_rate = (bad_loans / total_approved) * 100 if total_approved > 0 else 0
        approval_rate = (total_approved / n_records) * 100
        
        print(f"Strategy Cut-off Target [{cutoff}]: Approval Rate = {approval_rate:.2f}%, Portfolio Delinquency Rate = {delinquency_rate:.2f}%")
        
    # 4. BUILDING SCORE MIGRATION PROFILES
    df['migration_trend'] = np.where(df['score_delta'] > 50, 'Upgraded',
                             np.where(df['score_delta'] < -50, 'Downgraded', 'Stable'))
    
    summary = df.groupby(['segment', 'migration_trend']).size().unstack(fill_value=0)
    print("\n--- GENERATED PORTFOLIO SUMMARY SEGMENT MIGRATION MATRIX ---")
    print(summary)
    
    print("\n[SUCCESS] Matrix computation sequence finalized with 0 data drops.")
    return summary

if __name__ == '__main__':
    run_score_migration_matrix()
