import math
import numpy as np
from pathlib import Path
import scipy.sparse as sp
from scipy.stats import fisher_exact
from tqdm import tqdm
import subprocess
import pandas as pd

workflow = Path.cwd()
matrices = workflow/"results/matrices"

# snp names
snp_path = Path(workflow/"results/essentials/NEW_snps.txt")
snps = []
with open(snp_path) as f:
    for snp in f:
        snps.append(snp.strip('\n'))
snps = np.array(snps)

drugs = subprocess.run(['ls', f'{matrices}'], check=True,
                       capture_output=True, text=True).stdout.split('\n')

for drug in tqdm(drugs, total=len(drugs), desc='running through drugs'):
    fn_path = Path(matrices/f'{drug}/FN_{drug}_snps.npz')
    tn_path = Path(matrices/f'{drug}/TN_{drug}_snps.npz')

    if not fn_path.exists() or not tn_path.exists():
        continue

    # Load matrices
    fn_matrix = sp.load_npz(fn_path).tocsc()
    tn_matrix = sp.load_npz(tn_path).tocsc()

    fn_ones_per_col = pd.Series(
        np.array(fn_matrix.sum(axis=0)).flatten(), index=snps)
    fn_zeros_per_col = fn_matrix.shape[0] - fn_ones_per_col

    tn_ones_per_col = pd.Series(
        np.array(tn_matrix.sum(axis=0)).flatten(), index=snps)
    tn_zeros_per_col = tn_matrix.shape[0] - tn_ones_per_col

    total_ones = fn_ones_per_col + tn_ones_per_col
    total_zeros = fn_zeros_per_col + tn_zeros_per_col

    all_fn_snp_props = fn_ones_per_col / total_ones
    all_fn_no_snp_props = fn_zeros_per_col / total_zeros

    results = []
    for i, snp in tqdm(enumerate(snps), total=len(snps), desc=str(f'snps for {drug}')):
        table = [[fn_ones_per_col[snp], fn_zeros_per_col[snp]],
                 [tn_ones_per_col[snp], tn_zeros_per_col[snp]]]
        res = fisher_exact(table)
        p_val = res.pvalue
        odds_r = res.statistic
        if p_val <= 0.05:
            results.append({
                'snp': snp,
                'log_pval': round(math.log10(p_val) if p_val > 0 else -np.inf, 3),
                'log_or': round(math.log10(odds_r) if odds_r > 0 else -np.inf, 3),
                'fn_snp_prop': all_fn_snp_props[snp],
                'fn_no_snp_prop': all_fn_no_snp_props[snp],
                'fn_count': fn_ones_per_col[snp]
            })

    results_df = pd.DataFrame(results)
    if results_df.empty:
        results_df.to_csv(
            f"{matrices}/{drug}/{drug}_enriched_snps.csv", index=False)
        print(f"empty df caused by {drug}")
        continue
    results_df = results_df.sort_values(by='log_pval', ascending=False)
    results_df.to_csv(
        f"{matrices}/{drug}/{drug}_enriched_snps.csv", index=False)
