import pandas as pd
import json
import numpy as np
from cyvcf2 import VCF
from tqdm import tqdm
from pathlib import Path
import scipy.sparse as sp

df = pd.read_csv(
    '/data/scratch/projects/punim1703/false_negative/old_tbprof/resources/data/NEW_classifications.csv')

with open("/data/scratch/projects/punim1703/false_negative/old_tbprof/results/essentials/NEW_updated_runs.json") as f:
    run_dict = json.load(f)

snp_path = Path(
    "/data/scratch/projects/punim1703/false_negative/old_tbprof/results/essentials/NEW_snps.txt")
with open(snp_path) as f:
    snp_list = f.read().splitlines()

snp_lu = {snp: i for i, snp in enumerate(snp_list)}

drugs = df['drug'].unique()

for drug in drugs:
    # Create drug dir
    dir_path = Path(
        f'/data/scratch/projects/punim1703/false_negative/old_tbprof/results/matrices/{drug}')
    dir_path.mkdir(parents=True, exist_ok=True)

    for classif in ['FN', 'FP', 'TN', 'TP']:

        if run_dict[classif].get(drug):
            runs = run_dict[classif][drug]
        else:
            continue

        rows = []
        cols = []

        for i, run in tqdm(enumerate(runs), desc='going through samples', total=len(runs)):
            vcf = VCF(
                f'/data/scratch/projects/punim1703/tbvcf/results/variants/{run}/{run}.masked.vcf.gz')

            for variant in vcf:
                pos = variant.start + 1
                ref = variant.REF
                for alt in variant.ALT:
                    snp = f'{pos}_{ref}_{alt}'
                    if snp in snp_lu.keys():
                        rows.append(i)
                        cols.append(snp_lu[snp])

        rows = np.array(rows, dtype=np.int32)
        cols = np.array(cols, dtype=np.int32)
        data = np.ones(len(rows), dtype=np.int8)

        matrix = sp.coo_matrix(
            (data, (rows, cols)),
            shape=(len(runs), len(snp_lu.keys()))
        )

        file_path = Path(dir_path/f'{classif}_{drug}_snps.npz')
        sp.save_npz(file_path, matrix)
