# Cue cards

## 1. Title
- Name, supervisors (Dr Michael Hall, Prof Lachlan Coin), Doherty Institute
- One line: using whole-genome data to predict TB drug resistance, starting from the WHO catalogue

## 2. Tuberculosis at a glance
- Caused by *Mycobacterium tuberculosis*; mainly a lung disease, spread through the air
- Slow-growing bacterium: this is why culture-based testing takes weeks

## 3. TB incidence
- Burden concentrated in a few high-incidence regions (point to the map)
- Still one of the leading infectious causes of death worldwide

## 4. Drug resistance: cases
- Drug-resistant TB is a substantial and persistent share of cases
- Resistant cases need longer, more toxic regimens, so detecting resistance early matters

## 5. Drug resistance: classification
- Walk the hierarchy: mono-resistance -> MDR (INH + RIF) -> pre-XDR (+ fluoroquinolone) -> XDR (+ BDQ or LZD)
- Each step up removes treatment options

## 6. Current WGS pipeline
- Phenotypic testing is slow (~2 weeks or more)
- Targeted molecular assays only cover a few genes
- WGS: sequence the whole genome, call variants, look them up in a catalogue -> resistance prediction

## 7. The WHO catalogue
- International standard for interpreting mutations for drug susceptibility
- Grades each variant 1-5 by strength of association with resistance
- Weakest for newer drugs (BDQ, CFZ, DLM, LZD): few resistant isolates to learn from

## 8. Aims
- 1: find where the catalogue misses resistance (false negatives)
- 2: find candidate variants that could fill those gaps
- 3: build a neural network that starts from the catalogue and learns where it is wrong

## 9. Converting the catalogue for a neural network
- Grades 1-2 (associated with resistance) -> weight 1; everything else -> 0
- So the untrained network reproduces the catalogue's calls exactly
- Training can then only move away from the catalogue where the data supports it

## 10. Updating with expert rules
- WHO expert rules add variants the grading misses (e.g. loss-of-function in key genes)
- "WHO + ER" = catalogue plus expert-rule variants: the second model throughout

## 11. Augmenting SNP lists from FN samples
- Idea: variants enriched in isolates TB-Profiler misses could be new resistance markers
- Fisher's test, then filters: lineage markers, already catalogued
- Work in progress: first version used test isolates; enrichment also needs lineage correction
- Not used in the results that follow

## 12. Single neuron
- Input: ~26k binary variant vector from each isolate's VCF
- Weights start at catalogue values; sigmoid gives a probability; threshold gives R/S
- One neuron per drug, so every weight belongs to one mutation: interpretable

## 13. All drugs
- 15 outputs, one per drug, sharing the same input
- Each output has its own threshold

## 14. Training schematic
- Train on isolates with phenotypes; loss compares prediction with lab result
- Anchored regularisation keeps weights near catalogue values unless the data says otherwise
- Threshold per drug set to match TB-Profiler's specificity

## 15. Evaluation design
- One fixed split by accession: 80% training (5 CV folds), 20% test, stratified per drug
- Test set held back and used once, for all tools
- Thresholds chosen on a validation fold, never on test
- Converges in ~15 epochs with learning rate 0.01

## 16. Sensitivity figure
- How to read it: blue = TB-Profiler; hollow = untrained catalogue model; filled = trained; stem = change from training
- Same test isolates for everyone; trained models held at TB-Profiler's specificity
- Point to delamanid: trained ER model 0.48 vs TB-Profiler 0.17
- Point to fluoroquinolones: gap already present before training

## 17. Specificity figure
- Trained models sit at or just above TB-Profiler: that's by design
- Untrained hollow dots: where the catalogue alone over-calls resistance
- ETO: 0.53 -> 0.88 after training; DLM: 0.87 -> 0.996
- Read with the sensitivity slide: high untrained sensitivity often came with low specificity

## 18. Candidate mutations: first-line
- Volcano: x = effect (log odds ratio), y = significance
- Busy top-right: decades of selection pressure, possible compensatory mutations
- Exploratory: all isolates, not corrected for related strains

## 19. Candidate mutations: second-line group A
- FQs, BDQ, LZD: sparser; few resistant isolates for the newer drugs

## 20. Candidate mutations: second-line group B
- CFZ, cycloserine; terizidone not in the dataset
- CFZ caution: much of its signal came from one cluster of related isolates

## 21. Candidate mutations: second-line group C
- DLM, ETO, AMK, PAS
- ETO busy: shared mechanisms with INH (*inhA*)

## 22. Group C: drugs not in dataset
- No phenotype data for pretomanid or prothionamide

## 23. Model performance (key slide)
- Fair comparison: same isolates, same specificity as TB-Profiler
- DLM: 0.48 vs 0.17 (11 vs 4 of 23 resistant); CFZ tied
- Close on most drugs: within 0.03 for INH, RIF, EMB, STP; ~0.05-0.07 for AMK, CAP, KAN, ETO, PZA
- Biggest gap: fluoroquinolones (LFX -0.14, MFX -0.17), present before training
- Training mainly bought specificity
- Penalising false positives more in the loss didn't help (negative result)

## 24. Candidate mutations: summary
- First-line busy, second-line sparse
- Class imbalance: rare resistance can't pass the significance filters
- Exploratory until corrected for population structure

## 25. PE/PPE genes
- ~10% of the genome usually masked; we kept it in
- It does contain FN-associated variants (e.g. *PPE54*, *PPE51*, *PPE50*)
- Caveat: a variant enriched across many drugs may mark an MDR lineage, not a mechanism

## 26. Limitations
- Few resistant isolates for BDQ, LZD, DLM, CFZ (23-30 in test): wide uncertainty
- SNP features miss low-frequency (heteroresistant) calls, loss-of-function rules, indels: likely the FQ gap
- Enrichment not yet corrected for related isolates

## 27. Next steps
- Better features: loss-of-function, amino-acid level, minor-allele calls
- Cross-resistance architecture (LFX-MFX, BDQ-CFZ, INH-ETO): built, being evaluated
- Lineage-stratified enrichment, then retrain the filtered model
- Significance tests (McNemar) and confidence intervals
- More resistant isolates for newer drugs; validate candidates after re-analysis

## 28. References
- (Skip unless asked)

## 29. Supplementary: F1
- Backup only; F1 combines precision and sensitivity

## 30. Supplementary: weighted loss
- Backup for "how did you tune the loss?"
- α: extra weight on resistant isolates; λ: false-positive cost; γ: focus that cost on actual false positives
- 27 settings, 5-fold CV, best was the original loss

## Likely questions
- **Why not the filtered SNPs?** Chosen partly using test isolates, and confounded by related isolates (CFZ: 269 variants from ~18 isolates). Pulled until a lineage-stratified version is ready. WHO and ER results don't depend on it.
- **Earlier results showed more wins?** Earlier comparison ran the model at lower specificity than TB-Profiler, on different isolates. Fixing both changed the numbers.
- **Is DLM significant?** Largest difference, but not yet formally tested: McNemar is the next step.
- **Why not a deeper network?** The gap is in the features; a more complex model can't use information that isn't in the input.
