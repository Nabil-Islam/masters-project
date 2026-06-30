# Discussion — composition notes (§4)

**How to use these.** Each paragraph below is one paragraph of prose. The **bold line** is the topic-sentence seed — turn it into your opening sentence. The dashes are the supporting points, already in writing order (claim → evidence → mechanism). The `→` line is the implication to close the paragraph on. Method: read a block, look away, write it from memory in your own words; look back only to check facts after drafting. Markers carried through: `[cite]` = reference to add; `[confirm: …]` = fact for you to verify.

---

## 4.1 Model performance

**¶ Convergence was rapid, and that is a direct consequence of the initialisation.**
- stabilised (loss/AUC/F1) within ~20–30 epochs, all weight schemes
- cause: catalogue-initialised weights + anchor regulariser [cite] → constrains search space, speeds convergence
- double-edged: single linear layer ≈ weighted logical OR over catalogued variants → saturates representational capacity as fast as it converges
- cannot encode interaction terms, epistasis, shared cross-drug mechanisms
- → a ceiling by design, not a training failure — frames the limitations below

**¶ Against that constraint, sensitivity was still competitive.**
- matched/exceeded TB-Profiler for 13/15 drugs; improved after train + threshold for 14/15
- TB-Profiler = demanding comparator: mature, rule-based, WHO catalogue + lineage + curated heuristics [cite]
- our model carries no lineage info, no epistatic encoding, far simpler
- → matching it shows gradient-trained weight representations carry real predictive value beyond static look-up; absolute gains modest for well-characterised drugs, but the framework scales with architecture (a fixed rule set does not)

**¶ Cross-resistance behaved as the expert rules predict.**
- FQs: WHO+ER closely matched TB-Profiler — rule 7 already encodes class cross-R [cite]
- INH–ETO: shared *inhA* target, rule 8 [cite]; augmented scheme added ETO sensitivity
- BDQ–CFZ: rule 9 via *Rv0678*/*mmpL5* [cite]; BDQ improved, CFZ stayed poor → scarce CFZ-resistant training samples, not an encoding failure
- DLM: TB-Profiler poor; improved under all schemes at low specificity cost [cite]
- → clearest opportunity is architectural: a shared hidden layer across linked mechanisms (FQ class, INH–ETO, BDQ–CFZ, DLM–PA) could realistically approach the WHO sensitivity target [cite]

**¶ The specificity reduction was deliberate, justified by asymmetric error costs.** *(FLAG: clinical framing = motivation, not a clinical recommendation; confirm specifics with Rendi or anchor to literature — ll. 468–483)*
- FN (predict susceptible, actually resistant): patient on ineffective regimen
- duration: first-line ~6 months; older second-line longer — BUT newer all-oral regimens (BPaLM) ~6 months, so "considerably longer" is now partly outdated [cite] **[confirm with Rendi, ll. 470]**
- ineffective tx → continued replication; in heteroresistance → within-host selection for further resistance [cite]
- undetected resistant case → onward transmission → adds to DR-TB burden [cite]
- FP (predict resistant, actually susceptible): more intensive regimen — toxicity (FQ / LZD / CFZ profiles [cite]), cost, duration
- → asymmetry: FP = effective-if-over-intensive therapy = more recoverable than a missed resistant case

**¶ The numbers make the trade-off concrete.**
- worst-case specificity ~0.80 vs TB-Profiler ~0.95 → ~1 extra FP per 10 susceptible patients
- offset by higher sensitivity recovering cases TB-Profiler misses outright (its sensitivity <0.5 for several drugs)
- trade = 1 extra FP / 10 susceptible vs substantial reduction in missed resistant cases
- state explicitly: 0.80 floor was pragmatic, not clinically derived; model does NOT yet meet WHO ≥98% sensitivity / ≥95% specificity [cite]
- → meeting that standard is a target for the next iteration; this work = proof of concept for the sensitivity-boosting method

**¶ F1 is reported for completeness but is not the primary lens here.**
- harmonic mean of precision and recall → ignores specificity → incomplete picture of the trade-off that defines clinical utility [cite]
- optimising for F1 would obscure the deliberate threshold asymmetry
- what it confirms: specificity cost did not uniformly degrade quality; F1 matched/exceeded TB-Profiler where catalogue coverage + resistant data were good
- declines (AMK, BDQ, CAP, KAN, LZD, PZA) track class imbalance / data limits
- → not a modelling failure

---

## 4.2 Candidate mutations — first-line drugs

**¶ Candidates were recovered for three of four first-line drugs, and their coherence validates the pipeline.**
- INH, RIF, EMB → annotated candidates; PZA → large filtered pool, no ablation crossers
- biological coherence (excluding confounders) = strong internal validation

**¶ Isoniazid — a target-activator candidate, a promoter candidate, and a confounder.**
- *katG* 2155168_C>G; 100% of INH FN; ΔSens 6.26% **[confirm: canonical codon 315 / Ser315 vs NC_000962.3]**
  - *katG* = catalase-peroxidase prodrug activator [cite]; LoF → no isonicotinoyl-NAD adduct → uncatalogued = meaningful gap → highest INH priority
  - infinite OR (green) = exclusive in resistant FN; contingency-table artefact, resolves with data
- 2nd: C>T at intergenic coordinate **1673425** (*fabG1*/*inhA* / mabA–*inhA* promoter, canonical −15 position); ΔSens 4.56%; FN prevalence not reported
  - −15 region → *inhA* overexpression → low-level INH + ETO resistance [cite]
  - **identical coordinate (1673425_C>T) is the leading ETO candidate (§4.5)** → same variant for both drugs = in-data confirmation of cross-resistance (not just inference)
  - → mechanistically coherent 2nd priority
- 3rd: *rpoB* 761155_C>T; 50% FN; ΔSens 0.73% = **confounder** — *this is the very RIF mutation above*; *rpoB* = RIF target, no INH role; MDR co-occurrence; inclusion risks FP; recurs (see standalone ¶)

**¶ Rifampicin — every candidate in *rpoB*, which validates the pipeline three ways.**
- right gene, right location, no off-target candidates
- 761155_C>T; 97% FN; ΔSens 14.99%; −log₁₀(p) ~120; log₁₀(OR) >3 (>1000× enrichment) → largest first-line contribution, major gap **[confirm: likely canonical Ser450Leu]**
- 761110_A>T (89% FN; 3.37%); 761139_C>G (100%; 1.22%; inf OR); 761139_C>T (100%; 1.26%; inf OR)
- all within/flank RRDR (codons 426–452) [cite]
- → set = strong shortlist for validation / catalogue submission

**¶ Ethambutol — the most diverse candidate set.** *(use EMB throughout — ll. 99)*
- 7× *embB* (5 ablation-contributing): 4247429_A>G (95%; 2.56%), 4248003_A>G (92%; 0.66%), 4247431_G>C (80%; 0.97%), 4247431_G>A (38%; 1.05%), 4247574_A>C (100%; 1.77%); + 2 with no ΔSens (4247847_A>G 90%; 4247730_G>C 80%) **[confirm: codon positions]**
- *embB* = arabinosyltransferase, cell-wall arabinogalactan, EMB target [cite]
- diverse substitution types/positions = spectrum of variants, not one dominant mutation; matches wide clinical *embB* spectrum [cite] → catalogue coverage incomplete
- aux loci: *embC*, *ubiA*
- confounders here too: *rpoB* 761155_C>T (17% FN; 2.33%) + *katG* 2155168_C>G (11% FN; 0.97%) = the canonical RIF + INH mutations; no EMB role; high −log₁₀(p) in unrelated gene = confounding signature (MDR co-resistance)
- → flag as probable confounders, not EMB determinants

**¶ Pyrazinamide — no crossers, but read it as method, not failure.**
- dense plot, *pncA*-centred [cite], but no single variant crosses ablation threshold → distributed architecture
- single-variant ablation is the wrong tool → pathway / multi-variant approaches
- caveat: PZA phenotypic DST is notoriously unreliable [cite] (ll. 120) → some FN signal may be phenotyping error
- → treat filtered set as a hypothesis pool, not a confident candidate list

**¶ The *rpoB* 761155_C>T confounder deserves standalone treatment.**
- appears across drugs incl. those with no *rpoB* role; −log₁₀(p) up to ~140
- it IS the canonical RIF candidate above (likely Ser450Leu) → showing up for INH/EMB = biologically implausible → confounder
- cause: near-universal in MDR background; per-drug Fisher with no MDR control → significant for any drug those strains resist
- FN-prevalence gradient proves it: 97% in RIF (causal) vs 50% INH, 17% EMB (co-selected)
- same logic for *katG* 2155168_C>G: 100% in INH (causal) vs 11% EMB, 36% STR (confounder)
- possible contingency-table anomaly worth a computational check
- → build systematic MDR-background confounder exclusion into filtering (e.g. condition the test on MDR status)
- *(resolves the ll. 132 follow-up: no literature trace needed — the coordinate is the RIF mutation itself)*

---

## 4.3 Candidate mutations — second-line Group A

**¶ Group A splits into well-characterised FQs and sparse newer agents.**
- FQs (LFX, MFX): populated plots, meaningful candidate sets
- BDQ, LZD: sparse
- contrast driven by clinical-use duration + resistant-sample numbers

**¶ Fluoroquinolones — treated together; all candidates in *gyrA*.** *(combine LFX + MFX — ll. 171; they differ here essentially only in number of phenotypes)*
- *gyrA* = DNA gyrase subunit A, primary FQ target; no off-target annotations = specificity
- positions fall in the QRDR (~codons 88–94) [cite]
- **lead variant** 7582–7585 `ACAG>GCAC` — LFX 100% FN, ΔSens 21.09%; MFX 44% FN, ΔSens 32.55% (largest in Group A)
  - CORRECTION (ll. 158): not a true MNP — only positions 1 and 4 are substituted, the two internal bases are unchanged → two linked single-nucleotide substitutions in adjacent codons → two separate amino acids (1st = canonical Asp94 codon; 2nd = neighbouring codon) **[confirm: Asp94Gly + codon 95 vs NC_000962.3]**
  - co-occur consistently → reasonable to treat as one unit *provided* you state they are distinct events
  - scale/location → conformational change impairing FQ binding [cite]; recovery in both FQs → genuine determinant, anchors class cross-resistance → highest validation priority across second-line
- 7570_C>T — LFX 70% FN, 9.98%; MFX 40% FN, 11.51% **[confirm: likely Ala90Val]** → consistent across both, target gene, passed filters → strong 2nd priority
- LFX-only: 7572_T>C (100%; 2.73%; inf OR); 7582_ACAG>CCAC (100%; 3.7%; inf OR) — lower tier, still QRDR
- note: larger MFX ΔSens despite lower FN prevalence = smaller significant pool → each variant carries proportionally more predictive weight

**¶ Bedaquiline — sparse, but that is data limitation, not failure.**
- 4 significant, 1 filtered, no annotations
- approved 2012, recent widespread use [cite] → few resistant isolates → low Fisher power + weak training signal
- single variant = starting point; BPaLM endorsement → more data coming [cite]

**¶ Linezolid — signal present but distributed.**
- 164 significant positives, but spread across small-effect variants → none crosses the threshold
- single-variant ablation insufficient → pathway approaches; repurposed, routine MDR-TB use ~2019 [cite], in BPaLM
- POINTER (ll. 203): in *Enterococcus*/gram-positives, *de novo* LZD-R = 23S rRNA mutations, characteristically ≥3 of 6 gene copies; MTB analogues = *rrl* (23S rRNA) + *rplC* [cite]
- → watch rRNA loci in future iterations; multi-copy nature may also explain the absence of a single threshold-crosser

**¶ The first-to-second-line density step-down is evolutionary, not analytical.**
- first-line in use since 1950s–60s [cite] → 60–70 yr selection → target + compensatory + epistatic loci (validators should note epistasis)
- second-line newer → compressed timeline → sparser plots
- corollary: fewer second-line black-bordered variants may be a *higher proportion* of true determinants (less saturated landscape)
- annotated candidates compelling: TB-Profiler missed the source samples, yet pipeline found uncatalogued target-gene variants passing stats + lineage + novelty + sensitivity
- → convergent evidence = strong case for prioritised validation

---

## 4.4 Candidate mutations — second-line Group B

*(NOTE: Cycloserine + Terizidone dropped per ll. 248/266 — reinstate a sentence each if you disagree. Group B = clofazimine only.)*

**¶ Clofazimine — an *ethA* confounder plus an uncharacterised (*Rv3254*) candidate; canonical *Rv0678* absent.**
- lead: *ethA* 4326333_C>G; 22% FN; ΔSens 11.08% = **confounder**
  - *ethA* = FMO for ETO activation, no CFZ role; CFZ mechanism = ROS + K⁺-transport disruption [cite]
  - association = co-resistance confounding under ETO pressure → do not submit without functional validation
- 2nd: *Rv3254* 3634487_G>A; 57% FN; ΔSens 3.67% — conserved hypothetical protein, unknown function [cite]
  - since *ethA* is a confounder, this is the leading *bona fide* CFZ candidate, BUT uncharacterised → no mechanistic read → priority for locus-level literature / functional follow-up, not catalogue submission
- canonical CFZ determinant *Rv0678* did NOT appear among candidates → consistent with scarce CFZ-resistant data + poor CFZ model performance (§4.1)
  - *Rv0678* also = BDQ-resistance locus (rule 9, BDQ–CFZ cross-R) [cite] *(confirms supervisor query, ll. 238)* → its absence = coverage gap expanded data should close

---

## 4.5 Candidate mutations — second-line Group C

**¶ Delamanid — distributed resistance, and a proxy for pretomanid.**
- 320 significant, ~18 filtered, no crossers = distributed (like PZA / LZD), not data limit
- nitroimidazole prodrug; F₄₂₀ pathway → ROS → inhibits cell wall + respiration [cite]
- resistance = LoF across F₄₂₀ genes (*ddn*, *fbiA/B/C*, *fgd1*, *Rv2983*) → no single target → no crosser [cite]
- DLM + PA share F₄₂₀ pathway + same LoF loci [cite]; PA absent from dataset → DLM filtered set = PA proxy
- → ~18 variants carry implications for both; key given PA's role in BPaLM

**¶ Ethionamide — a coherent *inhA* candidate and the study's standout promoter finding.**
- 1st: *inhA* 1674481_T>G; 100% FN; ΔSens 0.65%; inf OR **[confirm: codon]**
  - *inhA* = enoyl-ACP reductase = shared INH + ETO target; rule 8 [cite]; modest ΔSens but established pathway = meaningful
- 2nd: C>T, ΔSens 25.69% = largest in Group C, one of largest overall
  - resolves to intergenic coordinate **1673425** (*fabG1*/*inhA* promoter, canonical −15); FN prevalence not reported
  - confirms supervisor's promoter suggestion (ll. 329); −15 region → *inhA* overexpression → INH + ETO resistance [cite]
  - **same coordinate (1673425_C>T) independently recovered for INH (§4.2)** → in-data confirmation of the shared mechanism (not just inference)
  - doubly informative: *mechanistic* (largest Group C signal sits in the canonical INH–ETO pathway) + *methodological* (promoter mutations were deliberately excluded from the catalogue, yet the pipeline recovered this real determinant from misclassified samples → validates the FN-augmentation approach)
  - → priority for wet-lab validation + a concrete argument to revisit the catalogue's promoter exclusion

**¶ Amikacin — a single, compelling, textbook candidate.**
- *rrs* 1473246_A>G; 100% FN; ΔSens 25.5%; inf OR = A1401G **[confirm]**
- *rrs* = 16S rRNA, 30S core, aminoglycoside target; A1401G distorts the binding site → high-level resistance [cite]
- AMK / KAN / CAP share the site → A1401G abolishes binding of all three (cross-R) [cite]
  - confirmed: identical 1473246_A>G tops all three injectables — AMK 25.5%, CAP 30.25% (90% FN), KAN 14.32% (100% FN) → strong cross-drug corroboration of one determinant
- → convergence (established target + 25.5% + cross-R) = most compelling Group C finding, top validation priority

*(NOTE: PAS dropped per ll. 357. PA/PTO absent — PA covered by the DLM proxy; PTO = future-data item.)*

---

## 4.6 PE/PPE family variants

*(STRUCTURAL NOTE — ll. 758: lead with the DATA, keep supporting literature brief; detailed PE/PPE biology belongs in the Introduction, not here. References below only anchor interpretation.)*

**¶ The finding: PE/PPE variants recur across 12 of 16 drugs — too broad to be noise.**
- spanning pharmacologically distinct classes → systematic, not incidental
- PE/PPE = Pro-Glu / Pro-Pro-Glu motifs, large fraction of coding genome, least functionally characterised region [cite] → why a recurrent resistance association is worth examining

**¶ *PPE54* 3733405_G>A is the most informative single observation.**
- INH 73% FN (4% R lack it), RIF 73% (2% lack), EMB 75% (2% lack)
- documented compensatory partner for *katG* LoF fitness cost + epistatic with *rpoB*, *embB* [cite] → near-universal → compensatory/modifier, not primary determinant
- KEY discriminator: prevalence differs across the three drugs → drug-specific enrichment, NOT a uniform MDR-background confounder (which would appear at equal frequencies)
- 2nd *PPE54* 3733476_A>AG (INH 37%) supports the same reading

**¶ Several other PPE loci show high FN prevalence and map to envelope/efflux/transport functions.**
- *PPE51* (nutrient acquisition + multidrug susceptibility + efflux upregulation [cite]): ETO 3502814_G>A 100% FN (5% lack); STR 3502457_G>A 58%
- *PPE50* (PPE51 partner, OM transport [cite]): CIP 3501668_G>C 100% FN (87% of R carry)
- *PPE55* (alternative PZA pathway, wild-type *pncA* [cite]): PZA 3752065_A>C 100% (3% lack), 3752419_C>G 62%; + ETO 39–65% (unexplained by its PZA biology → investigate)
- *PPE60* deletion 3894503_GGCC>G: 89% across EMB/INH/RIF — documented association is KAN, not first-line [cite] → broad envelope role or MDR enrichment

**¶ A PE_PGRS set connects to the more extensively-resistant backgrounds — read cautiously.**
- *PE_PGRS6* 624157_T>G: INH/RIF/EMB at 88% each (2% lack) → identical variant + prevalence across three first-line drugs = fixed MDR-background marker, not drug-specific; still useful diagnostically
- others — *PE_PGRS4* (CIP 59–74%, XDR enrichment [cite]), *PE_PGRS7*, *PE_PGRS9* (non-canonical PZA, like *PPE55* [cite]), *PE_PGRS19*, *PE_PGRS33* — suggestive but variable → indirect microenvironment modulators, not direct target interactions

**¶ Three conclusions, then the architectural payoff.**
1. not incidental — pervasive across 12 classes + epistatic overlap + high FN prevalence
2. most parsimonious = compensatory / resistance-amplifying modifiers (appear alongside canonical genes; high resistant-population prevalence; envelope/efflux/survival roles; not target modification)
3. top functional-characterisation priorities (near-universal in FN, near-absent in resistant complement): *PPE54* 3733405 (INH/RIF/EMB); *PPE51* 3502814 (ETO); *PPE55* 3752065 (PZA); *PE_PGRS6* 624157 (MDR marker)
- → motivates a dedicated PE/PPE input channel via a shared hidden layer with canonical resistance-gene features → captures compensatory/epistatic relationships the single layer cannot; combines with the cross-resistance hidden layer (§4.1)

---

## 4.7 Limitations

**¶ Scarcity of resistant cases for newer agents is the most consequential limitation.**
- class imbalance: BDQ, LZD, DLM, CFZ; no data at all: TD, PA, PTO
- a model cannot learn what it has not seen → constrains the per-drug findings

**¶ The architecture imposes a representational ceiling.**
- rapid convergence → hits capacity early; single layer ≈ weighted logical OR
- cannot learn cross-resistance / pleiotropy / epistasis — INH–ETO via *inhA* the clearest example needing shared hidden layers

**¶ The filtering procedure needs strengthening.**
- MDR-background confounders (*rpoB* C>T across unrelated drugs) → need systematic identification/removal, not post-hoc
- per-drug Fisher should control for MDR background (covariate or conditional test); more comprehensive lineage screening
- threshold: uniform −log₁₀(p) ≥ 5 may be too stringent for data-poor drugs → drug-specific thresholds

**¶ An earlier annotation gap, now resolved.**
- variants lacking a gene symbol were initially at risk of being dropped → now reported as intergenic regions or by locus tag
- one proved to be the high-impact *fabG1* promoter variant (§4.5) → underscores why preserving them mattered

---

## 4.8 Future directions

**¶ Expand the dataset for the newer agents.**
- phenotypic resistance data for TD, PA, PTO; more for BDQ, LZD, DLM, CFZ; BPaLM rollout = promising source [cite]

**¶ Validate externally and stratify by lineage.**
- independent cohorts: CRyPTIC consortium, MIRU-VNTR [cite]
- lineage-stratified evaluation (not done here; needed for generalisability claims)

**¶ Two architectural extensions are the primary next step.**
- shared hidden layers across linked mechanisms (FQ class, INH–ETO, BDQ–CFZ, DLM–PA) + dedicated PE/PPE channel → represent cross-R/compensatory relationships the current architecture cannot
- harden pipeline in parallel: systematic MDR-background + lineage-confounder screening (conditional Fisher)

**¶ Prioritised wet-lab validation (approx. order).**
1. *gyrA* 7582–7585 (LFX + MFX; largest effects, most corroborated)
2. *rrs* A1401G = 1473246_A>G — tops all three injectables (AMK 25.5%, CAP 30.25%, KAN 14.32%)
3. *katG* 2155168_C>G for INH (activator; 6.26%)
4. high-prevalence *PPE54* / *PPE51* / *PPE55* variants (§4.6)
5. *fabG1*/*inhA* promoter variant 1673425_C>T (25.69% ETO, identical coordinate also INH) — INH–ETO cross-resistance
- supplementary: extend cross-resistance analysis to the unclassified agents already in the dataset — CIP, OFLX, CAP, KAN, STR — which surfaced their own canonical determinants (e.g. *gyrA* for FQs, *rpsL* for STR) with direct cross-R implications
