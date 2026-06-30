# Take snp list -> use a threshold for lpval and lor -> check for lineage markers -> check if in who snps
# if is who snps(+- one bp) -> check what gene it is in -> else put into an enhanced snp list
from pathlib import Path
import pandas as pd
import subprocess
import json

RESULTS = Path.cwd() / "results"
MATRICES = RESULTS / "matrices"
LINEAGE = RESULTS.parent / "fast-lineage-caller/snp_schemes"
with open("/data/scratch/projects/punim1703/nn_tb/REVISION/results/essentials/snp_aug.json", "r") as f:
    er_snps = json.load(f)
lin = subprocess.run(f"ls {LINEAGE}", shell=True,
                     capture_output=True, text=True)
lineages = [line.strip('/') for line in lin.stdout.split()]
results = subprocess.run(
    f"ls {MATRICES}", shell=True, capture_output=True, text=True)
drugs = [line.strip('/') for line in results.stdout.split()]

# Make WHO df
master_file = pd.read_csv(
    "/data/scratch/projects/punim1703/nn_tb/REVISION/data/sheet1.csv", skiprows=2, low_memory=False)
genome_loc = pd.read_csv(
    "/data/scratch/projects/punim1703/nn_tb/REVISION/data/sheet2.csv")

for index, row in genome_loc.iterrows():
    genome_loc.at[index, "snp"] = (
        f"{row['position']}_{row['reference_nucleotide']}_"
        f"{row['alternative_nucleotide']}"
    )

genome_loc = genome_loc.drop(
    columns=["reference_nucleotide", "chromosome",
             "alternative_nucleotide", "position"]
)

for index, row in master_file.iterrows():
    master_file.at[index,
                   "FINAL CONFIDENCE GRADING"] = row["FINAL CONFIDENCE GRADING"][0]

master_file = master_file.loc[
    (master_file["FINAL CONFIDENCE GRADING"] == "1")
    | (master_file["FINAL CONFIDENCE GRADING"] == "2")
]

master_file = master_file[
    [
        "variant",
        "drug",
        "gene",
        "FINAL CONFIDENCE GRADING"
    ]
]

master_file = pd.merge(master_file, genome_loc, on="variant", how='inner')

lineage_data = {}
for file in lineages:
    lineage_data[file] = pd.read_csv(LINEAGE / file, sep='\t')

flag = []

for drug in drugs:
    filtered_snps = []
    snp_path = Path(MATRICES / f"{drug}" / f"{drug}_enriched_snps.csv")
    if not snp_path.exists():
        continue

    snps = pd.read_csv(snp_path)
    snps = snps.sort_values(by="log_pval", ascending=True)

    for _, snp_row in snps.iterrows():
        if snp_row["log_pval"] <= -5 and snp_row["log_or"] > 1:
            snp = snp_row['snp']

            is_flagged = False

            # Check if the snp is a lineage marker
            for file, scheme in lineage_data.items():
                for _, mut in scheme.iterrows():
                    pos = int(mut['position'])
                    ref = mut['allele_change'].split('/')[0]
                    alt = mut['allele_change'].split('/')[1]
                    snp_str = f"{pos}_{ref}_{alt}"
                    snp_str_plus_one = f"{pos+1}_{ref}_{alt}"
                    snp_str_minus_one = f"{pos-1}_{ref}_{alt}"

                    if snp in (snp_str, snp_str_plus_one, snp_str_minus_one):
                        flag.append({'snp': snp, 'flag': 'lineage', 'extra': (
                            file, snp_row['log_pval'], snp_row['log_or'], snp_row['fn_snp_prop'], snp_row['fn_no_snp_prop'])})
                        is_flagged = True
                        break  # Break out of the mut loop

                if is_flagged:
                    break  # Break out of the lineage files loop

            if is_flagged:
                continue  # Skip the rest of the checks and move to the next SNP

            # Check if snp is already in the WHO catalog
            snp_s = snp.split('_')
            pos = int(snp_s[0])
            snp_plus_one = f"{pos+1}_{snp_s[1]}_{snp_s[2]}"
            snp_minus_one = f"{pos-1}_{snp_s[1]}_{snp_s[2]}"

            matches = master_file[master_file['snp'].isin(
                [snp, snp_plus_one, snp_minus_one])]

            if not matches.empty:
                # Just grab the first match to append to the flag list
                first_match = matches.iloc[0]
                flag.append({'snp': snp, 'flag': 'WHO', 'extra': (
                    first_match['gene'], first_match['drug'], first_match['FINAL CONFIDENCE GRADING'], snp_row['log_pval'], snp_row['log_or'], snp_row['fn_snp_prop'], snp_row['fn_no_snp_prop'])})
                is_flagged = True

            if is_flagged:
                continue  # Skip the rest and move to next SNP

            # Check if snps in already ER snps
            check_list = [snp, snp_plus_one, snp_minus_one]

            if any(s in er_snps.get(drug.lower(), []) for s in check_list):
                flag.append({'snp': snp, 'flag': 'ER', 'extra': (
                    None, None, None, snp_row['log_pval'], snp_row['log_or'], snp_row['fn_snp_prop'], snp_row['fn_no_snp_prop'])})
                is_flagged = True

            if is_flagged:
                continue

            # If it passed all three checks (is_flagged is still False), add to new list
            filtered_snps.append(snp_row)

    drug_filtered = pd.DataFrame(filtered_snps)
    drug_filtered.to_csv(
        MATRICES / f"{drug}" / f"filtered_{drug}_snps.csv", index=False)

flagged_snps = pd.DataFrame(flag)
flagged_snps.to_csv(RESULTS / "flagged_snps.csv", index=False)
