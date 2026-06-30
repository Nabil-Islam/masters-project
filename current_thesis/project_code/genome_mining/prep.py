import pandas as pd
import json
from cyvcf2 import VCF
from tqdm import tqdm
from collections import Counter

df = pd.read_csv(
    '/data/scratch/projects/punim1703/false_negative/old_tbprof/resources/data/NEW_classifications.csv')

run_dict = {}

for classif in ['TN', 'TP', 'FN', 'FP']:
    mask = df['classification'] == classif
    # group by drug, collect all 'run' values into a list
    run_dict[classif] = (
        df.loc[mask, ['drug', 'run']]
          .groupby('drug')['run']
          .apply(list)
          .to_dict()
    )

'''TN_runs = {run for drug in run_dict['TN'] for run in run_dict['TN'][drug]}

runs_to_rem = []
# Remove runs common between FN and TN 
for drug in list(set(run_dict['FN'].keys()) & set(run_dict['TN'].keys())):
    for run in run_dict['FN'][drug]:
        if run in TN_runs:
            runs_to_rem.append(run)

for drug in list(set(run_dict['FN'].keys()) & set(run_dict['TN'].keys())):
    for run in run_dict['FN'][drug]:
        if run in runs_to_rem:
            run_dict['FN'][drug].remove(run)

    assert run_dict['TN'][drug] != run_dict['FN'][drug]'''

with open("/data/scratch/projects/punim1703/false_negative/old_tbprof/results/essentials/NEW_updated_runs.json", 'w') as f:
    json.dump(run_dict, f, indent=4)

# Collect all the snps

drugs = df['drug'].unique()

runs = []
with open('/data/scratch/projects/punim1703/nn_tb/REVISION/results/vcf_list.txt') as f:
    for vcf in f:
        runs.append(vcf.strip('\n'))


snp_list = []

for run in tqdm(runs, desc='harvesting snps', total=len(runs)):
    vcf = VCF(run)

    for variant in vcf:
        pos = variant.start + 1
        ref = variant.REF

        for alt in variant.ALT:
            snp = f'{pos}_{ref}_{alt}'
            snp_list.append(snp)

snp_count = Counter(snp_list)

final_snps = []

for snp, count in snp_count.items():
    if count >= 2:
        final_snps.append(snp)


with open("/data/scratch/projects/punim1703/false_negative/old_tbprof/results/essentials/NEW_snps.txt", 'w') as f:
    for snp in final_snps:
        f.write(snp+'\n')
