# Results — composition notes (§3)

**How to use these.** Same system as the Discussion notes: **bold line** = your topic-sentence seed; dashes = supporting facts in writing order; `→` = the closing observation. Write from memory, look back only to check the numbers. Results stay **descriptive** here — *what* was found; the *why/what-it-means* lives in §4 (cross-referenced as "→ see §4.x"), so don't re-argue mechanism in the Results. Markers: `[cite]` = reference; `[confirm: …]` = verify before submission. Variant format throughout: `coordinate_REF>ALT (FNP, RSM, Δsensitivity)`; an annotated (plotted) variant is one with Δsensitivity ≥ 5%; "green / inf OR" = perfect-sensitivity marker (variant exclusive to resistant samples).

*(Plot conventions — axes, thresholds, quadrant colours, black-border = filtered, green = infinite OR — are already defined in the section 3 introduction, so don't redefine them per drug.)*

---

## 3.1 First-line drugs

**¶ The first-line drugs produced the most densely populated plots, and three of four yielded ablation candidates.**
- RIF, INH, EMB → ablation-threshold candidates; PZA → large filtered pool, none crossing
- canonical target genes recovered throughout (*rpoB*, *katG*, *embB*) + recurrent pe/ppe loci
- two recurring confounders (*rpoB* 761155_C>T, *katG* 2155168_C>G) surface in off-target drugs → interpreted in §4.2
- → first-line panel = the clearest internal validation of the pipeline

**¶ Rifampicin — every annotated candidate fell in *rpoB*.**
- plot: Sig (OR>0) n=1380, Sig (OR<0) n=16, filtered n=484; dense upper-right quadrant; green (inf-OR) markers near *PPE54*
- *rpoB*: 761155_C>T (97%, 1%, 14.99%), 761110_A>T (89%, 2%, 3.37%), 761139_C>G (100%, 2%, 1.22%), 761139_C>T (100%, 2%, 1.26%) — only 761155_C>T crosses the 5% annotation threshold
- *PPE60*: 3894503_GGCC>G (89%, 2%, –), 3895400_A>C (71%, 2%, –)
- *PPE54*: 3733405_G>A (73%, 2%, –)
- → all four ablation candidates in the target gene, within/flanking the RRDR; no off-target annotated candidates (→ §4.2)

**¶ Isoniazid — a target candidate, a promoter candidate, and a confounder.**
- plot: Sig (OR>0) n=1460, Sig (OR<0) n=448, filtered n=378; note larger susceptibility-side (blue) cloud than RIF; green markers at *rpoB*/*katG*/*inhA* labels
- *katG* (11 variants): leading 2155168_C>G (100%, 3%, 6.26%) crosses threshold; remaining ten at RSM 4%, none with Δsens (2155546_T>C, 2155417_G>C, 2155418_G>C, 2155631_A>G, 2154661_C>T, 2155168_C>T, 2155687_T>C, 2155819_T>C, 2155300_G>A, 2154016_C>T)
- **intergenic region: 1673425_C>T (–, –, 4.56%)** — FNP/RSM not reported; this is the resolved label (was previously unannotated)
- *rpoB*: 761155_C>T (50%, 3%, 0.73%) — **confounder** (the RIF mutation; flag, → §4.2)
- *PPE54*: 3733476_A>AG (37%, 4%, –), 3733405_G>A (73%, 4%, –); *PPE60*: 3894503_GGCC>G (89%, 4%, –); *inhA*: 1674782_T>C (100%, 4%, –)
- → two ablation crossers (*katG* 6.26%, intergenic 4.56%); the intergenic 1673425_C>T recurs for ethionamide (§3.2 Group C)

**¶ Ethambutol — the most diverse candidate set, across the most genes.**
- plot: Sig (OR>0) n=2963, Sig (OR<0) n=1127, filtered n=1812 — largest bilateral spread of the first-line drugs; green markers near *PE_PGRS19*
- *embB* (7 variants, 5 ablation-contributing): 4247429_A>G (95%, 2%, 2.56%), 4248003_A>G (92%, 2%, 0.66%), 4247431_G>C (80%, 2%, 0.97%), 4247431_G>A (38%, 2%, 1.05%), 4247574_A>C (100%, 2%, 1.77%); + 4247847_A>G (90%, 2%, –), 4247730_G>C (80%, 2%, –)
- **confounders**: *rpoB* 761155_C>T (17%, 1%, 2.33%), *katG* 2155168_C>G (11%, 1%, 0.97%) — flag (→ §4.2)
- other filtered loci: *embC* 4241022_C>T (100%); *ubiA* 4269271_A>G (100%); *PPE55* (4: 3752124_G>A 40%, 3744603_T>G 39%, 3747326_C>T 39%, 3745906_A>G 65%); *PPE60* (3894503_GGCC>G 89%, 3894484_C>T 62%); *PPE54* 3733405_G>A (75%); *PE_PGRS6* 624157_T>G (88%); *PE_PGRS7* (672683_G>A 80%, 673482_C>T 100%); *PE_PGRS4* 336616_C>T (38%); *PE_PGRS19* 1188873_C>G (100%)
- → no single *embB* variant crosses 5%; spread of substitution types/positions = spectrum rather than one dominant mutation (→ §4.2)

**¶ Pyrazinamide — a large, dense plot but no ablation crossers.**
- plot: Sig (OR>0) n=3161 (largest positive count of the first-line drugs), Sig (OR<0) n=752, filtered n=448; green marker at *PE_PGRS9*
- no canonical target-gene (*pncA*) candidate in the filtered set; entirely pe/ppe + PE_PGRS
- *PPE54* (3729592_G>A 100%, 3734621_C>T 56%); *PE_PGRS4* (338688_C>T 71%, 336635_CCCGCCGTTG>C 50%); *PE_PGRS9* 836018_G>A (80%); *PPE55* (3752419_C>G 62%, 3752065_A>C 100%); *PPE60* 3894914_C>G (100%)
- → only first-line drug with no ablation-annotated candidate (interpretation, incl. unreliable PZA phenotyping, → §4.2)

---

## 3.2 Second-line drugs

### Group A

**¶ Fluoroquinolones (levofloxacin + moxifloxacin) — treated together; all annotated candidates in *gyrA*.** *(combine per ll. 171; they differ mainly in number of phenotypes)*
- LFX plot: Sig (OR>0) n=234, Sig (OR<0) n=1, filtered n=16; green (inf-OR) *gyrA* markers
- MFX plot: Sig (OR>0) n=83, Sig (OR<0) n=1, filtered n=50; green marker at *PPE54*
- *gyrA* — shared lead variant 7582_ACAG>GCAC: LFX (100%, 2%, 21.09%), MFX (44%, 1%, 32.55%); and 7570_C>T: LFX (70%, 2%, 9.98%), MFX (40%, 1%, 11.51%) — both cross 5% in both drugs
- LFX-only *gyrA*: 7572_T>C (100%, 2%, 2.73%), 7582_ACAG>CCAC (100%, 2%, 3.7%)
- non-target: LFX *PE_PGRS33* 2062066_TCCGCCGGCGCCGCCGGCC>T (20%, 2%, –); MFX *PPE54* 3733185_G>C (100%, 1%, –)
- → the same *gyrA* variants recover for both drugs (shared-mechanism observation, → §4.3); note 7582_ACAG>GCAC is two linked SNPs, not a true MNP (→ §4.3, per ll. 158)

**¶ Bedaquiline — sparse; no annotated candidates.**
- plot: Sig (OR>0) n=5, Sig (OR<0) n=0, filtered n=2; among the sparsest in the study
- no candidates in recognised resistance/pe-ppe genes; no Δsens
- → data-limited (→ §4.3)

**¶ Linezolid — signal present but no ablation crossers.**
- plot: Sig (OR>0) n=164, Sig (OR<0) n=5, filtered n=164 (all positive significant variants passed filtering); strongest signals actually on the susceptibility side (−log₁₀(p) ≈ 11)
- no candidate in a recognised resistance/pe-ppe gene; no Δsens
- → distributed signal, no single crosser; watch rRNA loci (*rrl*, *rplC*) in future (→ §4.3)

### Group B

> *(Cycloserine + Terizidone dropped per ll. 248/266 — Group B = clofazimine only.)*

**¶ Clofazimine — a confounder, an uncharacterised candidate, and pe/ppe loci.**
- plot: Sig (OR>0) n=837, Sig (OR<0) n=23, filtered n=582; diffuse spread, −log₁₀(p) ceiling ~18 (lowest of the large-filtered drugs); labels: *ethA*, *Rv3254*, *PPE54*, *PE_PGRS9*
- *ethA*: 4326333_C>G (22%, 1%, 11.08%) — **confounder** (ETO activator, no CFZ role; flag, → §4.4)
- *Rv3254*: 3634487_G>A (57%, 1%, 3.67%) — conserved hypothetical protein [cite]
- *PPE54*: 3734189_A>T (14%, 1%, –); *PE_PGRS9*: 836694_ACCGGCGGGTTCGGCGATACCGACGGGGGAGCCGGCGGTG>A (20%, 1%, –)
- → two ablation crossers, both problematic for catalogue use (one confounder, one uncharacterised); canonical *Rv0678* absent (→ §4.4)

### Group C

**¶ Delamanid — moderately populated, no ablation crossers.**
- plot: Sig (OR>0) n=320, Sig (OR<0) n=11, filtered n=318; label *PPE54*
- *PPE54*: 3733795_C>T (14%, 1%, –) — only annotated locus; no Δsens
- → distributed-resistance pattern; serves as a pretomanid proxy (→ §4.5)

**¶ Ethionamide — the most densely populated second-line plot; standout intergenic candidate.**
- plot: Sig (OR>0) n=2524, Sig (OR<0) n=251, filtered n=706; green marker at *PPE51*; labels: intergenic region, *PPE55*, *inhA*, *PE_PGRS33*, *PE_PGRS19*, *PPE51*
- **intergenic region: 1673425_C>T (–, –, 25.69%)** — largest Δsens in Group C; *same coordinate as the isoniazid intergenic candidate* (§3.1)
- *inhA*: 1674481_T>G (100%, 5%, 0.65%), 1674262_A>G (77%, 5%, –)
- *PPE55* (3): 3748936_G>A (77%), 3752124_G>A (85%), 3748412_G>A (100%); *PE_PGRS33* 2061315_C>A (77%); *PPE51* 3502814_G>A (100%, green/inf OR); *PE_PGRS19* 1188514_A>G (86%)
- → two ablation crossers (intergenic 25.69%, *inhA* 0.65%); shared 1673425_C>T with INH is the key cross-resistance observation (→ §4.5)

**¶ Amikacin — a single, high-quality candidate.**
- plot: Sig (OR>0) n=214, Sig (OR<0) n=11, filtered n=190; green (inf-OR) marker at *rrs*
- *rrs*: 1473246_A>G (100%, 1%, 25.5%) — the only annotated candidate, large Δsens
- → identical *rrs* variant recurs for capreomycin and kanamycin (injectable cross-resistance, → §4.5)

**¶ Capreomycin — same *rrs* variant as amikacin.**
- plot: Sig (OR>0) n=102, Sig (OR<0) n=9, filtered n=4; *rrs* labelled (filtered, not green here — FNP 90%)
- *rrs*: 1473246_A>G (90%, 2%, 30.25%) — largest Δsens in Group C; same coordinate as AMK/KAN
- → strengthens the injectable cross-resistance observation (→ §4.5)

> *(PAS dropped per ll. 357. Pretomanid + prothionamide absent from the dataset — pretomanid covered by the delamanid proxy.)*

---

## 3.3 Other drugs

**¶ The unclassified agents largely recapitulate the target-gene and cross-resistance patterns of the WHO groups.**
- fluoroquinolone *gyrA* signal extends to ciprofloxacin and ofloxacin; injectable *rrs* to kanamycin; streptomycin shows its canonical *rpsL* plus the *katG* confounder
- note: these drugs' filtered variants surfaced largely at relaxed RSM (≈8–14%) and few produced Δsens — descriptive only, interpretation deferred (→ §4.8)

**¶ Ciprofloxacin — *gyrA* signal plus pe/ppe, none crossing threshold.**
- plot: Sig (OR>0) n=217, Sig (OR<0) n=1, filtered n=168; green marker at *PPE50*
- *PPE50* 3501668_G>C (100%, 13%, –); *gyrA* 7570_C>T (91%, 14%, –), 7582_ACAG>GCAC (97%, 10%, –) — same *gyrA* positions as LFX/MFX but no Δsens here; *PE_PGRS4* (4: 338648_T>G 73%, 338682_TCCC>GGCG 74%, 338690_ATT>GTC 64%, 338669_T>C 59%); *PE_PGRS19* 1189137_C>CGCCGCCGGCCCCGCCGTT (74%); *PPE54* 3735033_G>A (80%)
- → no ablation crossers; gyrA recurrence is the cross-resistance observation

**¶ Kanamycin — the injectable *rrs* variant again.**
- plot: Sig (OR>0) n=562, Sig (OR<0) n=2, filtered n=230; green (inf-OR) marker at *rrs*
- *rrs*: 1473246_A>G (100%, 2%, 14.32%) — crosses threshold; same coordinate as AMK/CAP; *PPE68* 4351991_C>A (60%, 2%, –)
- → third injectable carrying the identical *rrs* determinant (→ §4.5)

**¶ Ofloxacin — the largest *gyrA* set in the study.**
- plot: Sig (OR>0) n=3026, Sig (OR<0) n=1618, filtered n=1386 — largest bilateral spread outside first-line; green markers at *PE_PGRS7*
- *gyrA* (9 variants): 7581_GACAG>TACAC (100%), 7572_T>C (91%), 7581_GACAG>CACAC (88%), 7570_C>T (88%), 7582_ACAG>GCAC (94%), 7582_ACAG>CCAC (87%), 8639_G>A (78%), 7581_GACAG>AACAC (94%), 8955_G>C (100%) — all RSM 8–11%, none with Δsens
- also *gyrB* 6608_G>C (69%) — only FQ here to implicate the second gyrase subunit; *PE_PGRS7* (675069_C>A 78%, 672738_G>CCGA 100%); *PPE55* 3747888_T>C (69%); *PPE68* 4351991_C>A (100%); *PPE54* 3734189_A>T (59%)
- → broadest *gyrA* coverage; shares QRDR positions with the other three fluoroquinolones (→ §4.3)

**¶ Streptomycin — canonical *rpsL* plus the *katG* confounder.**
- *(plot not available in this set — report from table)*
- *rpsL*: 781687_A>G (95%, 8%, 2.57%) — canonical streptomycin determinant, the leading ablation contributor
- *katG*: 2155168_C>G (36%, 5%, 2.39%) — **confounder** (the INH mutation; flag, → §4.2)
- *rrs* 1473246_A>G (49%, 7%, –) — same injectable coordinate but markedly lower FNP than for AMK/CAP/KAN; pe/ppe: *PE_PGRS33* 2061424_G>A (62%), *PPE55* 3745863_G>A (68%), *PPE51* 3502457_G>A (58%), *PPE42* 2935915_C>A (60%), *PE_PGRS4* 337482_C>T (62%)
- → two ablation crossers (*rpsL* 2.57%, *katG* confounder 2.39%); the *katG* confounder extends the first-line confounder pattern to streptomycin (→ §4.2)
