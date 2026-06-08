# Thesis Writing Resource — Nabil Islam
## M.tb Novel Mutation Discovery: Results & Discussion Points
### Purpose: Your ideas, AI-organised. Write from these bullets in your own voice.

---

# RESULTS SECTION

---

## 3.3 Candidate Mutations — Overview paragraph (opens the whole section)

- Candidates identified from false negative (FN) samples across all drugs with phenotypic data available
- Filtering pipeline steps to mention:
  - Fisher's exact test: -log10(p) ≥ 5 AND log10(OR) > 1
  - Excluded if already in WHO or expert rules catalogue
  - Excluded if known lineage marker
  - Remaining candidates added to augmented weight matrix
- ΔSensitivity = drop in model sensitivity when a candidate SNP's index is zeroed in input tensor
  - Measured against unablated baseline
  - Threshold for flagging: ΔSensitivity ≥ 0.05%
  - This is a functional measure of each variant's independent predictive contribution
- Network weights were initialised from and regularised toward the WHO catalogue baseline (anchor regulariser)
  - Means augmented candidates had to demonstrate value against a biologically anchored starting point
  - Strengthens interpretation of positive ΔSensitivity results
- How to read the volcano plots:
  - x-axis: log10 odds ratio
  - y-axis: -log10 p-value from Fisher's exact test
  - Blue dots: statistically significant, negatively associated with R (log10 OR < 0)
  - Red dots: statistically significant, positively associated with R (log10 OR > 0) — primary candidate pool
  - Red dots with black outline: passed full filtering protocol (lineage exclusion, not in catalogue, passed ablation)
  - Green markers: infinite OR or p-value — variant found exclusively in resistant or susceptible samples, no cases in denominator
  - Annotated variants: filtered set that produced largest sensitivity drops on ablation — highest priority for validation

---

## 3.3.1 Candidate Mutations — First-Line Drugs

### Gene-not-found clarification (put this early, before individual drugs, as it recurs)
- "Gene not found" does NOT mean intergenic
- Means the variant's position falls within an annotated GFF feature BUT that feature lacks a human-readable `gene=` attribute
- Common for:
  - Hypothetical proteins with no assigned gene symbol
  - PE/PPE family genes (frequently use locus tags not gene names)
  - Non-coding RNA features using alternative attribute conventions
- Fix: cross-reference locus tag against TubercuList or PATRIC database
- Important because: some gene-not-found variants may themselves be PE/PPE loci
  - Script bug: `continue` statement was silently dropping these from output JSON
  - Fix: replace with locus tag as placeholder so nothing is lost
- Where ΔSensitivity is large for gene-not-found variants (e.g. ETH C>T at 25.69%), resolving annotation is high priority

### General pattern — first-line drugs
- Most densely populated volcano plots of all drug classes
- INH, RIF, ETH: large numbers of significant positively-associated variants
- Reason: first-line drugs have been in clinical use since 1950s–60s
  - ~60–70 years of selective pressure on M.tb populations
  - Rich and diverse mutational landscape has accumulated
  - Includes: direct target gene mutations, compensatory mutations, distant loci via epistasis
- PZA: large number of significant associations, lower max OR than others
  - Complex and less well-characterised resistance mechanisms
  - Variants distributed across pncA and other regions

### Isoniazid (INH)
- Annotated candidates (passed filtering AND ΔSensitivity ≥ 0.05%):
  1. katG C>G — ΔSensitivity = 6.26%
     - katG encodes catalase-peroxidase that activates INH as a prodrug
     - Without functional KatG, INH cannot convert to active isonicotinoyl-NAD adduct
     - 6% sensitivity improvement = clinically meaningful catalogue gap
     - Green box (infinite OR) — present exclusively in resistant FN samples, no susceptible carriers
     - Infinite OR is artefact of contingency table construction under these conditions
     - Expanded data should resolve to finite estimate
     - Highest priority INH candidate for wet-lab validation and catalogue submission
  2. gene-not-found C>T — ΔSensitivity = 4.56%
     - Cannot assign biological significance without resolving annotation
     - Genomic coordinates should be looked up against locus tag databases
     - Second priority pending annotation resolution
  3. rpoB C>T — ΔSensitivity = 0.73%
     - CONFOUNDER — flag explicitly
     - rpoB encodes RNA polymerase beta subunit — rifampicin target, nothing to do with INH mechanism
     - Appears because MDR strains carry both rpoB and INH resistance mutations simultaneously
     - Including in INH weight matrix risks false positives for INH in susceptible samples carrying rpoB mutations for RIF reasons only
     - Recurs across multiple drugs — discussed separately below

### Rifampicin (RIF)
- All annotated candidates in rpoB — direct drug target gene
  - Strong internal pipeline validation: correct gene, correct location
- Candidates:
  1. rpoB C>T — ΔSensitivity = 14.99%
     - -log10(p) ≈ 120, log10(OR) > 3 (>1000-fold enrichment in resistant samples)
     - Largest single-variant sensitivity contribution among first-line drugs
     - Major catalogue gap for RIF resistance detection in FN subset
  2. rpoB A>T — ΔSensitivity = 3.37%
  3. rpoB C>G — ΔSensitivity = 1.22% (green box — infinite OR)
  4. rpoB C>T (different position) — ΔSensitivity = 1.26% (green box)
- All candidates within or flanking RRDR (Rifampicin Resistance Determining Region, codons 426–452)
- Concentration in drug target gene + absence from unrelated loci = strong pipeline validation
- Filtered candidate set as whole = strong shortlist for validation and catalogue submission

### Ethambutol (ETH)
- Most diverse annotated candidate set among first-line drugs
- embB candidates (drug target gene — encodes arabinosyltransferase, essential for cell wall arabinogalactan biosynthesis):
  1. embB A>G — ΔSensitivity = 2.56%
  2. embB A>G (different position) — ΔSensitivity = 0.66%
  3. embB G>C — ΔSensitivity = 0.97%
  4. embB G>A — ΔSensitivity = 1.05%
  5. embB A>C — ΔSensitivity = 1.77% (green box)
  6. embB (additional) — ΔSensitivity = 0.66%
- Multiple substitution types at distinct positions = diverse resistance variants, not single dominant mutation
- Consistent with published literature: wide spectrum of embB mutations in clinical ETH-resistant isolates
- Suggests current catalogue coverage of embB variants is incomplete
- Auxiliary loci: embC, ubiA also appeared (mention in table context)
- CONFOUNDERS present:
  - rpoB C>T — ΔSensitivity = 2.33% — same MDR co-occurrence argument as INH
  - katG C>G — ΔSensitivity = 0.97% — katG is INH activator, nothing to do with ETH
  - Both have unusually high -log10(p) values for a drug they have no mechanistic connection to
  - High p-values in drug-unrelated context = signal of systematic issue in contingency table construction
  - Likely artefact: variant enriched in MDR strains appears enriched for every drug MDR strains resist simultaneously
  - Flag as probable confounders, not ETH-specific resistance determinants

### Pyrazinamide (PZA)
- No annotated candidates from ablation experiment
- BUT: large, densely populated volcano plot with many significant positive associations
- pncA identified as resistance gene (activator — encodes pyrazinamidase for prodrug activation)
- Cross-resistance to pyrazinoic acid only (note in table)
- Reason for no annotations: distributed resistance architecture
  - Resistance spans many variants across pncA and beyond
  - No single variant contributes enough to cross ablation threshold individually
- Filtered black-bordered candidate set = pool for wet-lab validation
- Single-variant ablation not the right tool for PZA — pathway-level or multi-variant approaches better suited
- Do not frame as negative result — frame as methodological observation about distributed resistance

### The rpoB C>T confounder — standalone discussion point
- Appears across multiple drugs including those where rpoB has no resistance role
- -log10(p) values reaching ~140 in some drug-specific analyses
- This level of significance in a gene unrelated to a drug's mechanism = systematic confounding
- Most likely explanation: rpoB C>T is highly enriched in MDR strains
  - Fisher's exact test conducted per drug independently, no MDR background control
  - Variant's association with any drug MDR strains resist simultaneously will reach significance
- Extreme p-values in unrelated drugs may also indicate anomaly in contingency table construction
  - Worth investigating computationally in future pipeline iterations
- Conclusion: rpoB C>T = confounding marker of MDR strain background for all drugs except RIF
- Pipeline improvement: systematic identification and exclusion of MDR background confounders should be built into filtering

---

## 3.3.2 Candidate Mutations — Second-Line Group A

### General pattern — Group A
- Fluoroquinolones (LFX, MFX): well-populated plots, clear upper-right clustering, meaningful filtered sets
- Novel oral agents (BDQ, LZD): sparse plots, limited candidates
- Contrast driven by: duration of clinical use + number of resistant samples available

### Levofloxacin (LFX)
- Well-populated volcano, ~10 red with black borders
- All annotated candidates in gyrA — gene encoding DNA gyrase subunit A, primary FQ drug target
  - Biological specificity of this: no off-target gene annotations = pipeline validation
- Annotated candidates:
  1. gyrA ACAG>GCAC (MNP) — ΔSensitivity = 21.09% (green box)
     - Multinucleotide polymorphism replacing 4 consecutive nucleotides
     - Scale of change likely produces substantial conformational alteration in DNA gyrase subunit A
     - Could prevent LFX engaging target through steric mechanisms
     - Highest impact LFX candidate
  2. gyrA C>T — ΔSensitivity = 9.98%
     - ~10% sensitivity boost, in drug target gene, statistically significant, passed filters
     - Very solid candidate for validation
  3. gyrA T>C — ΔSensitivity = 2.73% (green box)
  4. gyrA ACAG>CCAC (MNP) — ΔSensitivity = 3.7% (green box)
- Three of four carry infinite OR — exclusive presence in resistant FN samples
- Strong results overall for generating validation candidates

### Moxifloxacin (MFX)
- Smaller number of significant vars than LFX but ~11 red with black borders
- All annotated candidates in gyrA — same drug target, same biological specificity argument
- Annotated candidates:
  1. gyrA ACAG>GCAC (same MNP as LFX) — ΔSensitivity = 32.55%
     - Largest single-variant sensitivity contribution across all Group A drugs
     - Same variant appearing for both FQs = consistent with shared gyrA-mediated resistance
     - Confirms cross-resistance pharmacology
     - OR = 10^1.5 ≈ 32-fold enrichment in resistant samples, statistically significant
     - Star candidate for wet-lab validation — large effect, biologically coherent, reproducible across two drugs
  2. gyrA C>T — ΔSensitivity = 11.51%
     - Also shared with LFX
     - ~10% boost, in target gene, passed all filters
     - Second priority validation candidate

- Recovery of identical high-impact MNP for both FQs:
  - Substantially strengthens case for genuine resistance determinant vs statistical artefact
  - Helps understand FQ cross-resistance mechanistically
  - gyrA ACAG>GCAC = highest priority candidate for validation across entire second-line analysis

### Bedaquiline (BDQ)
- Only 4 statistically significant positive vars, 1 passed full filtering, no ablation annotations
- Do NOT frame as failure — frame as data limitation:
  - BDQ approved 2012, widespread use is recent
  - M.tb populations have had limited exposure under BDQ selection pressure
  - Global genomic surveillance datasets reflect this — resistant isolates are rare
  - Limits both Fisher's exact test statistical power and training signal for weight refinement
- One filtered variant = starting point, not ceiling
- WHO endorsement of BPaLM regimen will generate substantially more resistance data
  - BPaLM: Bedaquiline + Pretomanid + Linezolid + Moxifloxacin
  - Future iterations of pipeline well-positioned to exploit this

### Linezolid (LZD)
- 164 statistically significant positive associations
- ~7 passed full filtering, no ablation annotations
- Key distinction from BDQ: statistical signal IS present, but distributed
  - No single variant contributes enough to cross ablation threshold individually
  - Resistance spread across many small-effect variants
- LZD repurposed from gram-positive infections, entered routine MDR-TB use 2019
- Also part of BPaLM — expanding data expected
- Methodological implication: single-variant ablation not sufficient for LZD
  - Pathway-level or multi-variant aggregation approaches needed
  - This is a future direction to flag

### Why step-down in population from first to second-line?
- First-line drugs in use since 1950s — ~70 years of selective pressure
- Resistance mutations accumulated in: direct target genes, compensatory loci, distant epistatic genes
- Second-line drugs: more recent, less evolutionary time for resistance diversification
- Sparser plots = compressed evolutionary timeline, not analytical failure
- Important framing: black-bordered variants in second-line plots, though fewer, may represent higher proportion of true resistance variants because total landscape is less saturated
- The annotated candidates particularly compelling:
  - TB-Profiler (sophisticated tool with catalogue + lineage + heuristics) failed to classify these samples
  - From those missed samples: uncatalogued variants in established drug target genes
  - Passed statistical filtering, lineage exclusion, absent from existing catalogues, improve sensitivity
  - Convergence of statistical + functional + biological evidence = compelling case for prioritised validation

---

## 3.3.3 Candidate Mutations — Second-Line Group B

### Clofazimine (CFZ)
- Moderately dense volcano, substantial filtered candidate set (thick streak of black-bordered reds)
- Two annotated candidates:
  1. ethA C>G — ΔSensitivity = 11.08%
     - ethA encodes flavin-containing monooxygenase for ethionamide activation
     - Has NO established role in clofazimine mechanism or resistance pathway
     - CFZ works through: reactive oxygen species generation + potassium ion transport disruption
     - CFZ resistance primarily through Rv0678 mutations — transcriptional repressor that upregulates MmpL5 efflux pump
     - Most plausible explanation: co-resistance confounding in MDR strains selected under ETO pressure
     - Flag for cautious interpretation, do not advance for catalogue submission without functional validation
  2. gene-not-found G>A — ΔSensitivity = 3.67%
     - Cannot resolve genomic context without annotation fix
     - Plausible candidate locus: Rv0678 — encodes transcriptional repressor directly governing MmpL5 efflux
     - If coordinates fall within or near Rv0678, biological plausibility substantially elevated
     - Resolving annotation = priority fix for pipeline
     - Lower priority than FQ annotations given ΔSensitivity of 3.67%

### Cycloserine (CS)
- Empty volcano plot — no variants passed statistical association filters in either direction
- Two complementary explanations:
  1. Dataset composition:
     - CS being progressively deprioritised in contemporary MDR-TB guidelines
     - Declining clinical use → underrepresentation of CS-resistant isolates in global genomic databases
     - Limits statistical power to detect resistance-associated variants
  2. Mechanistic — arguably more fundamental:
     - CS simultaneously targets two distinct enzymes:
       - Alanine racemase (Alr) — converts L-alanine to D-alanine
       - D-alanine:D-alanine ligase (DdlA) — incorporates D-alanine into peptidoglycan precursor
     - For M.tb to resist CS: mutations needed to escape BOTH targets simultaneously
     - Probability of two independent resistance-conferring mutations co-selected in same strain = much lower than single-target drugs
     - Dual-target mechanism intrinsically limits accumulation of resistance mutations in circulating populations
     - Consistent with historically low rates of clinically significant CS resistance in literature
- Conclusion: empty plot may reflect genuine biology as much as data limitation
- Distinguish from LZD pattern: CS has no signal at all vs LZD has signal but distributed

### Terizidone (TZD)
- Absent from dataset entirely — but this is NOT a gap in coverage, for mechanistic reasons:
- TZD = two cycloserine molecules joined by terephthalaldehyde molecular bridge
- Following oral administration: TZD hydrolysed in bloodstream → yields two molar equivalents of CS
- Entire antimycobacterial activity mediated by functional CS
- TZD has NO independent mechanism of action distinct from CS
- TZD is pharmacological repackaging of CS — modified pharmacokinetics, reduced neurological/psychiatric side effects, same drug-target interaction
- Complete cross-resistance can be assumed:
  - Any M.tb resistant to CS will be resistant to TZD and vice versa
  - CS dataset = direct proxy for TZD resistance
- Many national TB programmes and clinical guidelines treat CS and TZD as therapeutically interchangeable for exactly this reason
- Conclusions from CS analysis apply equally to TZD without separate analysis needed
- Given dual-target CS mechanism: unlikely significant resistance-conferring mutations would appear for TZD either

---

## 3.3.4 Candidate Mutations — Second-Line Group C

### Gene-not-found clarification reminder
- Refer back to clarification in 3.3.1
- Relevant again here: ETO and AMK both have gene-not-found annotations

### Delamanid (DLM)
- 320 significant positive associations
- ~20 passed significance threshold
- ~18 passed full filtering protocol — substantial candidate set
- BUT: no variants met ablation threshold
- Same pattern as LZD and PZA — distributed resistance, not data limitation
- DLM biology relevant here:
  - New generation anti-TB drug
  - Considerable evidence in paediatric use
  - Alternative to pretomanid in BPaLM for adults who cannot tolerate PA
  - Nitroimidazole prodrug — activated through F420 coenzyme pathway
  - Following activation: unstable intermediates generate ROS
  - ROS simultaneously: inhibits cell wall synthesis + disrupts bacterial respiration
  - Resistance = loss-of-function mutations in F420 activation pathway
  - Multiple loci implicated: ddn, fbiA, fbiB, fbiC, fgd1, Rv2983
  - This distributed, pathway-level resistance architecture explains no single ablation threshold crosser
- DLM-PA cross-resistance:
  - Both drugs rely on same F420 activation pathway
  - Resistance through loss-of-function at same genomic loci
  - Pretomanid absent from dataset
  - DLM filtered candidate set = proxy for PA resistance as well
  - 18 filtered variants have implications for both drugs simultaneously
  - Important given PA's central role in BPaLM

### Ethionamide (ETO)
- Most densely populated upper-right quadrant of all second-line drugs
- Large filtered candidate set
- Two annotated variants:
  1. inhA T>G — ΔSensitivity = 0.65% (green box — infinite OR)
     - inhA encodes enoyl-ACP reductase — shared molecular target of both INH and ETO
     - INH-ETO cross-resistance mechanism:
       - inhA promoter mutations → overexpression of InhA protein
       - Increases target concentration beyond threshold either drug can saturate at therapeutic doses
       - Single mutational event confers resistance to both agents
     - Recovery of inhA variant for ETO = mechanistically coherent
     - Consistent with cross-resistance relationship formalised in expert rule 8
     - Modest ΔSensitivity but location in established cross-resistance pathway = biologically meaningful
     - Green box: infinite OR, exclusive to resistant FN samples, expanded data needed
  2. gene-not-found C>T — ΔSensitivity = 25.69%
     - Largest sensitivity contribution among all Group C candidates
     - One of largest in entire experiment
     - Genomic coordinates suggest possible intergenic region OR unannotated feature
     - Resolving annotation gap = HIGH PRIORITY given magnitude of ablation signal
     - Could be regulatory mechanism (promoter/transcriptional regulation of resistance-relevant gene)
     - Highest priority ETO candidate for genomic characterisation and wet-lab follow-up

### Amikacin (AMK)
- Healthy volcano for a second-line drug
- ~17 variants met full filtering criteria
- Single annotated variant:
  - rrs A>G — ΔSensitivity = 25.5% (green box — infinite OR)
  - rrs encodes 16S ribosomal RNA — structural and functional core of bacterial 30S ribosomal subunit
  - Primary genomic target of aminoglycoside antibiotics
  - Specific substitution A1401G within rrs:
    - Well-characterised high-level resistance mutation
    - Distorts aminoglycoside binding site on ribosome
    - Prevents drug binding
    - Confers clinical resistance to AMK
  - Complete cross-resistance to kanamycin:
    - Both drugs share same ribosomal binding site
    - A1401G structural distortion abolishes binding of both agents simultaneously
  - Cross-resistance implications for KM should be evaluated in KM candidate analysis
  - Infinite OR: exclusively in resistant FN samples, dataset size limitation
  - Despite green box: convergence of evidence makes this one of most compelling individual findings
    - Established drug target gene ✓
    - 25.5% sensitivity improvement ✓
    - Documented cross-resistance implications ✓
  - Among highest priorities for wet-lab validation across entire study

### Para-aminosalicylic acid (PAS)
- Sparse volcano — single statistically significant positive variant passed full filtering
- [INSERT GENE NAME when available]
- No ablation annotation — single filtered variant did not meet sensitivity drop threshold
- Extreme data sparsity = severely constrained statistical power
- Confirms some uncatalogued resistance signal detectable even under constrained sample sizes
- Starting point for investigation, not interpretable further at current sample sizes

### Pretomanid (PA) and Prothionamide (PTO)
- Both absent from dataset — cannot be evaluated directly
- PA: covered by DLM cross-resistance proxy argument (shared F420 pathway)
- PTO: note absence, flag for future dataset expansion

---

## 3.4 Filtered Candidate Variant Gene Annotation (Table 3.1)

### What the table shows
- Each filtered candidate variant mapped to gene via positional lookup against NC_000962.3 reference GFF
- Three categories per drug:
  1. Resistance-relevant genes — established role in drug-specific resistance
  2. Cross-resistance genes — implicated in resistance relationships across drugs
  3. PE/PPE family loci — PE, PPE, PE_PGRS, PE-PGRS subfamilies
- Full gene list per drug in Appendix D
- Table = curated summary, retains only three category annotations

### Validation from resistance-relevant genes
- First-line drugs: all four have resistance-relevant genes recovered
  - RIF: rpoB (RNA polymerase beta subunit — direct drug target)
  - INH: katG (prodrug activator) + inhA (target)
  - ETH: embB (primary target), aux: embC, ubiA
  - PZA: pncA (prodrug activator), cross-R to pyrazinoic acid only
- Fluoroquinolones: gyrA for CIP, LFX, MFX, OFLX — shared DNA gyrase target
  - OFLX additionally: aux gyrB
  - All four: class-wide cross-resistance annotation
- Injectable aminoglycosides: rrs for AMK and KM (shared ribosomal A-site)
  - AMK: cross-resistance to KM and capreomycin
- STR: rpsL primary, aux rrs 530 loop and 912 region
- ETO: inhA (INH-ETO cross-resistance via shared InhA target)
- CFZ: no directly resistance-relevant genes, but cross-resistance to BDQ through efflux loci
- BDQ, LZD, PAS: no resistance-relevant or cross-resistance gene annotations
  - Reflects data limitations discussed per drug
- Recovery of established resistance genes across drug classes = pipeline validation

### The PE/PPE finding — state the observation in results, save interpretation for discussion
- PE/PPE family variants present across 12 of 16 drugs evaluated
- PE_PGRS variants: both first-line and second-line classes, some drugs (ETH, OFLX, STR) with variants in many distinct PE_PGRS loci simultaneously
- PPE family variants: widespread — RIF, INH, ETH, FQs, aminoglycosides, STR, ETO
- PE family variants: smaller number of drugs but present across both first and second-line
- Breadth and consistency across pharmacologically distinct drug classes = not incidental noise
- State: implies systematic biological phenomenon, interpretation in Section 4.6

---

# DISCUSSION SECTION

---

## 4.1 Model Performance

### Convergence and representational capacity
- Rapid convergence within first 20 epochs across all weight schemes
- Attributable to catalogue-initialised weights — not random initialisation
  - Biologically grounded starting point
  - Reduces parameter search space, accelerates convergence
- Double-edged: same initialisation means model quickly saturates representational capacity
- Single-layer architecture = functionally equivalent to weighted logical OR over catalogue variants
  - Cannot encode: interaction terms, epistatic relationships, shared resistance mechanisms between drugs
  - This is a ceiling, not a failure — implications in limitations section

### Sensitivity performance
- Matched or exceeded TB-Profiler for 13/15 drugs
- Contextualise TB-Profiler:
  - Well-established, actively maintained rule-based tool
  - Uses WHO catalogue + lineage marker data + curated heuristics developed over years [CITE]
  - No fancy extra layers, no explicit lineage info, no epistatic encoding in our model
- Meaningful demonstration that probabilistic gradient-trained catalogue representations carry genuine predictive value beyond static look-up mechanics
- Gains modest in absolute terms for well-characterised drugs — but framework scales with architectural complexity

### Cross-resistance discussion
- FQs (LFX, MFX):
  - TB-Profiler sensitivity closely matched by WHO+ER weight scheme
  - Expert rule 7 already encodes FQ cross-resistance → network had relevant variant associations [CITE]
- INH-ETO:
  - Both affected by inhA mutations through shared enoyl-ACP reductase target
  - Expert rule 8 encodes this relationship [CITE]
  - Filtered weight schemes performed well for both
  - Augmented variants contributed additional sensitivity gains for ETO
- BDQ-CFZ:
  - Linked through Rv0678 and mmpL5 via expert rule 9
  - Notable divergence: BDQ sensitivity improved substantially, CFZ remained poor
  - Likely reflects relative availability of resistant training samples, not failure of cross-resistance encoding
- DLM:
  - TB-Profiler sensitivity particularly low
  - Meaningful improvement under all three weight schemes
  - Minimal accompanying specificity cost
  - Encouraging given limited resistance data for newer agent [CITE]
- PA:
  - Absent from dataset
  - BPaLM implementation in high-burden settings (e.g. PNG) generating resistance data
  - Future iterations well-positioned [CITE]
- Biggest opportunity for improvement: explicitly modelling cross-resistance through architecture
  - Hidden layer shared across drugs with linked resistance mechanisms
  - FQs, INH-ETO, BDQ-CFZ, DLM-PA all candidates for this
  - Much of expert rules = formalised cross-resistance heuristics
  - Multi-layer architecture incorporating these could realistically approach WHO-recommended 98% sensitivity threshold [CITE]

### Specificity and clinical trade-offs
- Specificity reduction was deliberate — sensitivity-prioritised threshold strategy
- Asymmetric clinical consequences:

**False Negative (predicting susceptible when actually resistant):**
- Patient receives ineffective drug regimen
- First-line treatment: 6 months; second-line: considerably longer [CITE]
- During this period: M.tb continues replicating, degrading pulmonary tissue, forming granulomas
- In heteroresistant samples: ineffective drug = selection pressure driving further resistance acquisition within patient [CITE]
- Beyond individual: if resistant strain leaves clinical/household setting → transmission
- Each missed case = potential community transmission event
- Compounds global burden of drug-resistant TB — already hundreds of thousands of new MDR/XDR cases annually [CITE]

**False Positive (predicting resistant when actually susceptible):**
- Patient receives more intensive regimen
- Real consequences: side effects, cost, duration, healthcare system burden
  - FQs: nephrotoxicity, tendinopathy [CITE]
  - LZD: peripheral neuropathy, myelosuppression [CITE]
  - CFZ: originally developed for leprosy, significant tolerability burden [CITE]
- However: clinical trajectory more recoverable than FN
- Patient receives effective (if over-intensive) treatment

**The numbers:**
- Our worst specificity ~0.80 vs TB-Profiler ~0.95
- Across 10 susceptible patients: ~1 additional false positive vs TB-Profiler
- But: sensitivity substantially higher → recovering resistant cases TB-Profiler misses entirely
- TB-Profiler sensitivity falls below 0.5 for several drugs → every other resistant patient missed
- Tradeoff: 1 extra FP per 10 susceptible patients vs halving the FP burden on the resistant side

**On the specificity floor:**
- 0.80 was pragmatic constraint for first iteration, not clinically derived
- WHO-recommended: minimum 98% sensitivity AND minimum 95% specificity [CITE]
- Current model does not meet WHO standards — explicitly acknowledged
- Target for subsequent development
- First iteration = proof of concept for sensitivity-boosting methodology

### F1 score
- Reported for completeness as standard classification metric
- NOT the primary interpretive lens for this clinical context
- F1 = harmonic mean of precision and recall — does NOT incorporate specificity
- Incomplete summary of sensitivity-specificity trade-off that defines clinical utility [CITE]
- Optimising for F1 would obscure deliberate asymmetry of threshold strategy
- What F1 does confirm:
  - Specificity cost does not uniformly degrade classification quality
  - For drugs with strong catalogue coverage + sufficient resistant training data: F1 matched or exceeded TB-Profiler
  - Sensitivity gains achieved without disproportionate precision losses
- Where F1 declined (AMK, BDQ, CAP, KAN, LZD, PZA): reflects class imbalance and data limitations, not fundamental modelling failure

---

## 4.2 Candidate Mutations — First-Line Drugs

### Overview
- Sensitivity-contributing variants found in 3/4 first-line drugs
- INH, RIF, ETH: annotated candidates
- PZA: no annotations but large filtered pool
- Biological coherence of annotated candidates (except confounders) = strong pipeline validation

### Isoniazid
- katG C>G: 6.26% ΔSens
  - katG = catalase-peroxidase = prodrug activator [CITE]
  - Without functional KatG: INH cannot convert to active isonicotinoyl-NAD adduct
  - Uncatalogued variant in prodrug activation gene = clinically meaningful coverage gap
  - Highest INH priority for validation and catalogue submission
  - Green box = infinite OR = exclusively in resistant FNs = data size artefact not biological anomaly
- gene-not-found C>T: 4.56% ΔSens
  - Annotation gap — not intergenic, just unannotated feature
  - Second priority pending resolution
- rpoB C>T: 0.73% ΔSens = CONFOUNDER
  - rpoB = RNA polymerase beta = RIF target, no INH mechanistic role [CITE]
  - Appears due to MDR co-occurrence
  - Inclusion would risk FP for INH in susceptible samples with rpoB mutations for RIF reasons

### Rifampicin
- All candidates in rpoB — drug target gene
- Validates pipeline: correct gene, correct location, absence of off-target candidates
- rpoB C>T: 14.99% ΔSens, -log10(p) ~120, log10(OR) >3 (>1000-fold enrichment)
  - Largest single-variant contribution among first-line drugs
  - Major catalogue gap
- rpoB A>T: 3.37% ΔSens
- rpoB C>G: 1.22% ΔSens (green box)
- rpoB C>T (different position): 1.26% ΔSens (green box)
- All within/flanking RRDR — consistent with molecular epidemiology of RIF resistance [CITE]
- Filtered set as whole = strong shortlist for validation and catalogue submission

### Ethambutol
- Most diverse annotated set
- Multiple embB substitution types (A>G, G>C, G>A, A>C) at distinct positions
  - embB = arabinosyltransferase = essential for cell wall arabinogalactan synthesis = ETH target [CITE]
  - Diversity of substitution types = diverse resistance variants, not single dominant mutation
  - Consistent with published literature: wide spectrum of embB mutations in clinical isolates [CITE]
  - Current catalogue coverage of embB variants is incomplete
- Confounders: rpoB C>T and katG C>G
  - Neither has mechanistic role in ETH resistance
  - Unusually high -log10(p) for unrelated genes = possible systematic contingency table construction issue
  - MDR strains carry resistance to multiple first-line drugs simultaneously → spurious cross-drug associations
  - Flag as probable confounders, cautious interpretation pending functional characterisation

### Pyrazinamide
- No ablation annotations despite large volcano plot
- Distributed resistance architecture explanation (not failure):
  - Resistance spans many variants across pncA and beyond
  - No individual variant dominant enough to cross ablation threshold
  - pncA = pyrazinamidase = prodrug activator [CITE]
- Filtered candidate set = pool for wet-lab validation
- Pathway-level approaches better suited than single-variant ablation
- Frame as methodological observation, not negative result

### rpoB C>T — systematic confounder discussion
- Appears across multiple drugs with no mechanistic connection to rpoB
- -log10(p) reaching ~140 in unrelated drug contexts
- Biological implausibility + extreme statistics = systematic confounding not genuine multi-drug signal
- Mechanism: rpoB C>T highly enriched in MDR strains
  - Per-drug Fisher's test without MDR background control
  - Enrichment in any drug MDR strains resist → statistical significance for that drug
- Extreme p-values may also reflect anomaly in contingency table construction
- Action: systematic identification and exclusion should be built into filtering
- rpoB C>T = confounding marker of MDR strain background for all drugs except RIF

---

## 4.3 Candidate Mutations — Second-Line Group A

### Fluoroquinolones — strong findings
- Both LFX and MFX: all annotated candidates exclusively in gyrA
  - Biological specificity = strong pipeline validation
  - No off-target gene contamination
- gyrA ACAG>GCAC MNP:
  - LFX: ΔSens 21.09%; MFX: ΔSens 32.55%
  - MNP replacing 4 consecutive nucleotides
  - Scale of change → substantial conformational alteration in DNA gyrase subunit A [CITE]
  - Could prevent FQ engaging target through steric mechanisms
  - Same variant appearing for both FQs = genuine resistance determinant not statistical artefact [CITE]
  - Consistent with shared gyrA-mediated resistance and cross-resistance pharmacology
  - Helps understand FQ cross-resistance mechanistically
  - Highest priority candidate for wet-lab validation across entire second-line analysis
- gyrA C>T:
  - LFX: ΔSens 9.98%; MFX: ΔSens 11.51%
  - Consistent performance across both FQs
  - In drug target gene, passed all filters, statistically strong
  - Second priority validation candidate

### BDQ and LZD — data limitation framing
- BDQ:
  - Approved 2012, limited widespread use duration [CITE]
  - M.tb had limited generational exposure under BDQ selection
  - Resistant isolates rare in surveillance databases → limits statistical power and training signal
  - Single filtered variant = starting point
  - BPaLM WHO endorsement → substantially expanded clinical resistance data incoming [CITE]
- LZD:
  - 164 significant positive associations — signal IS present
  - Distributed across many small-effect variants → no single ablation threshold crosser
  - Mechanistically distinct from BDQ sparsity
  - MDR-TB use from 2019 [CITE], also part of BPaLM
  - Single-variant ablation insufficient → pathway-level approaches needed (future direction)

### Why first vs second-line density contrast exists
- First-line: 60–70 years selective pressure since 1950s-60s [CITE]
- Resistance accumulated: direct target mutations + compensatory mutations + epistatic loci
- Complex epistatic processes — downstream validators need to consider this
- Second-line: shorter evolutionary timeline → sparser plots
- Black-bordered second-line variants may represent higher proportion of true resistance variants because landscape is less saturated
- The annotated candidates: TB-Profiler missed these, our pipeline found uncatalogued variants in drug target genes with statistical + functional + biological evidence convergence

---

## 4.4 Candidate Mutations — Second-Line Group B

### Clofazimine
- ethA C>G: ΔSens 11.08% — CONFOUNDER WARNING
  - ethA = flavin monooxygenase for ETO activation — nothing to do with CFZ [CITE]
  - CFZ mechanism: ROS generation + potassium ion transport disruption
  - CFZ resistance: primarily Rv0678 mutations → upregulates MmpL5 efflux pump [CITE]
  - Association most plausible as co-resistance confounding in MDR strains selected under ETO pressure
  - Do not advance for catalogue submission without functional validation of direct CFZ mechanism
- gene-not-found G>A: ΔSens 3.67%
  - Plausible candidate locus: Rv0678 (transcriptional repressor governing MmpL5 efflux) [CITE]
  - If coordinates fall within/near Rv0678 → biological plausibility elevated substantially
  - Annotation resolution = priority pipeline fix
  - Lower priority given ΔSens value

### Cycloserine
- Empty volcano — no variants passed filters in either direction
- Two explanations:
  1. Dataset composition: CS deprioritised in guidelines → resistant isolates underrepresented [CITE]
  2. Mechanistic (more fundamental):
     - CS targets two enzymes simultaneously: Alr + DdlA [CITE]
     - Resistance requires escape from BOTH targets
     - Probability of two independent co-selected mutations much lower than single-target
     - Dual-target mechanism intrinsically limits resistance accumulation [CITE]
     - Consistent with historically low CS resistance rates in literature
- Empty plot = genuine biology + data limitation, not just analytical failure
- Key distinction: CS has NO signal vs LZD has signal but distributed

### Terizidone
- Absent from dataset but NOT a coverage gap — pharmacological argument:
  - TZD = two CS molecules + terephthalaldehyde bridge [CITE]
  - Hydrolysed in bloodstream → 2 molar equivalents of CS
  - Entire activity mediated by functional CS
  - No independent mechanism of action
  - TZD = pharmacological repackaging of CS (better tolerability, same drug-target interaction) [CITE]
  - Complete cross-resistance assumption:
    - CS resistant = TZD resistant, and vice versa
    - CS dataset = direct proxy for TZD
  - Many national guidelines treat CS and TZD as therapeutically interchangeable [CITE]
  - CS conclusions + dual-target mechanistic argument apply equally to TZD

---

## 4.5 Candidate Mutations — Second-Line Group C

### Gene-not-found clarification (reference back to 3.3.1 note or earlier in 4.5)
- Not intergenic — falls within annotated GFF feature lacking gene= attribute
- Common for: hypothetical proteins, PE/PPE genes, non-coding RNA features
- Fix: locus tag cross-reference against TubercuList [CITE]
- Script bug: continue statement was silently dropping these from output JSON
  - Some gene-not-found variants may themselves be PE/PPE loci
  - Pipeline fix: replace with locus_tag placeholder
- High ΔSensitivity gene-not-found variants (ETO C>T at 25.69%) = high priority for annotation resolution

### Delamanid
- 320 significant, ~20 passed threshold, ~18 passed full filtering, no ablation annotations
- Distributed resistance architecture — F420 pathway:
  - DLM = nitroimidazole prodrug [CITE]
  - New generation drug, paediatric use evidence, alternative to PA in BPaLM [CITE]
  - Activated by F420 coenzyme pathway
  - Post-activation: unstable intermediates → ROS
  - ROS: inhibits cell wall synthesis + disrupts bacterial respiration
  - Resistance = LoF mutations in F420 biosynthesis/utilisation genes: ddn, fbiA, fbiB, fbiC, fgd1, Rv2983 [CITE]
  - No single target gene → no individual variant crosses ablation threshold
- DLM-PA cross-resistance:
  - Both drugs: F420 activation pathway, LoF mutations at same loci [CITE]
  - PA absent from dataset
  - DLM filtered set = proxy for PA resistance
  - 18 filtered variants have implications for both drugs
  - Critical given PA's role in BPaLM

### Ethionamide
- Most densely populated second-line upper-right quadrant
- inhA T>G: ΔSens 0.65% (green box — infinite OR)
  - inhA = enoyl-ACP reductase = shared target of INH and ETO
  - INH-ETO cross-resistance: inhA promoter mutations → InhA overexpression → both drugs cannot saturate target [CITE]
  - Single mutational event confers resistance to both agents
  - Mechanistically coherent ETO candidate
  - Consistent with expert rule 8
  - Modest ΔSens but established cross-resistance pathway location = biologically meaningful
  - Green box: infinite OR, exclusive to resistant FN samples, expanded data needed
- gene-not-found C>T: ΔSens 25.69%
  - Largest sensitivity contribution among all Group C candidates
  - One of largest in entire experiment
  - Annotation gap: possible intergenic OR unannotated feature
  - Possible regulatory mechanism: promoter/transcriptional regulation of resistance-relevant gene
  - HIGHEST PRIORITY: immediate prioritisation for genomic characterisation and wet-lab follow-up

### Amikacin
- ~17 variants met full filtering
- rrs A>G: ΔSens 25.5% (green box — infinite OR)
  - rrs = 16S ribosomal RNA = structural/functional core of 30S ribosomal subunit = aminoglycoside target [CITE]
  - Specific A1401G substitution:
    - Well-characterised high-level resistance mutation [CITE]
    - Distorts aminoglycoside binding site
    - Prevents drug binding
    - Clinical AMK resistance
  - Complete cross-resistance to kanamycin:
    - Both drugs share same ribosomal binding site
    - A1401G abolishes binding of both simultaneously [CITE]
  - Infinite OR: exclusively in resistant FN samples — data size limitation not biological anomaly
  - Despite green box: convergence of evidence = most compelling individual finding in Group C
    - Established drug target gene ✓, 25.5% ΔSens ✓, documented cross-resistance implications ✓
  - Among highest priorities for wet-lab validation across entire study

### PAS
- Single variant passed full filtering
- [INSERT GENE NAME]
- No ablation annotation — didn't meet sensitivity threshold
- Extreme data sparsity → severely constrained statistical power
- Single filtered variant = starting point, not interpretable further
- Confirms some uncatalogued resistance signal detectable even under constrained sample sizes

---

## 4.6 PE/PPE Family Variants as Candidate Resistance and Compensatory Loci

### Opening — establish the finding
- Gene annotation revealed PE/PPE variants across 12 of 16 drugs
- PE/PPE gene family:
  - ~10% of M.tb coding genome [CITE]
  - Named for conserved Pro-Glu (PE) and Pro-Pro-Glu (PPE) N-terminal motifs
  - Extensively associated with: mycobacterial virulence, host-pathogen interaction, immune evasion
  - Among least functionally characterised regions of M.tb genome [CITE]
- Appearance across pharmacologically distinct drug classes (different targets, mechanisms, resistance pathways):
  - Unlikely to be attributable to chance
  - Systematic biological phenomenon

### Documented epistatic interactions with canonical resistance genes

**katG-PPE54:**
- Well-characterised epistatic pair in literature [CITE]
- katG LoF → high-level INH resistance → cost: reduced oxidative stress defence
- PPE54 = compensatory partner: partially restores fitness lost through katG disruption [CITE]
  - Modulates phagosome maturation arrest
  - Alters intracellular environment
- Data: PPE54 SNP 3733405_G_A
  - Present in 73% of all INH FN samples
  - Only 4% of all resistant samples lack it
  - Near-universal genomic feature of uncatalogued INH-resistant population in cohort
- Second PPE54 variant 3733476_A_AG:
  - Present in 37% of INH FNs
  - Only 4% of resistant samples missing it
- High FN prevalence + near-universal resistant presence = compensatory mutation status not primary resistance determinant

**rpoB-PPE54:**
- Documented epistatic interaction [CITE]
- Associates transcriptional machinery modifications (RIF resistance via rpoB) with outer membrane permeability alterations (PPE54)
- Collectively secures high-level RIF resistance
- Data: same PPE54 SNP 3733405_G_A
  - Present in 73% of RIF FN samples
  - Only 2% of all RIF-resistant samples lack it
- Near-complete presence across resistant population (captured + uncaptured) = not a simple confounder
  - A confounder from MDR strain background would appear at similar frequencies across multiple unrelated drugs
  - BUT prevalence patterns differ meaningfully between drugs → drug-specific enrichment, not uniform MDR co-occurrence

**embB-PPE54:**
- Links arabinosyltransferase cell wall biosynthesis modification with outer membrane permeability alteration [CITE]
- Restructures mycobacterial envelope architecture → amplifies ETH resistance
- Data: same PPE54 SNP 3733405_G_A
  - Present in 75% of ETH FN samples
  - Only 2% of resistant samples lack it
  - Closely mirrors RIF pattern

**embC-PPE68:**
- Different emb operon component + PPE68-mediated transport modification [CITE]
- Predicted ETH co-association
- BUT: no PPE68 variants passed ETH filters
  - Possibly: less prevalent in cohort OR sample size limited detection

### PPE variants as compensatory/resistance-modulating loci

**PPE51:**
- Master regulator of nutrient acquisition AND drug susceptibility [CITE]
- LoF variants: increase resistance across multiple drug classes (INH, RIF, AMK, CAP, STR, MFX)
- Also: triggers transcriptomic upregulation of inner membrane efflux systems
- Data:
  - ETO: SNP 3502814_G_A — present in ALL ETO FN samples, only 5% of resistant samples lack it
  - STR: SNP 3502457_G_A — present in 58% of STR FNs, 92% of all STR-resistant samples carry it
- Multi-drug resistance amplification role + near-universal presence across two distinct drug classes
  = high priority for functional characterisation

**PPE50:**
- Hierarchical clustering and high co-fitness values with PPE51
- Interacting partner in outer membrane transport complexes [CITE]
- Disruption impairs macromolecular porin structures → indirect resistance contribution
- Data: CIP SNP 3501668_G_C
  - Present in ALL CIP FN samples
  - 87% of all CIP-resistant samples carry it
  - Near-fixed resistance-associated variant in CIP-resistant population
  - Not currently captured by catalogue-based tools

**PPE42:**
- Forms functional transport channel [CITE]
- Natural or experimental truncation → increased phenotypic resistance to AMK and other large hydrophilic antibiotics
- Eliminates specific uptake conduits required for intracellular drug delivery
- Data: STR SNP 2935915_C_A
  - Present in 60% of STR FN samples
  - 92% of all STR-resistant samples carry it
  - STR not AMK — but shared aminoglycoside class + established transport channel function = biologically plausible cross-class finding

**PPE54 — extended beyond first-line epistatic interactions:**
- Appears across: CIP, CFZ, DLM, MFX, OFLX, PZA, STR
- Prevalence varies: 14% (DLM) to 100% (MFX, PZA)
- Some associations may reflect MDR strain background
- BUT: those approaching universal FN prevalence → possible genuine resistance-modulating roles
- PPE54 documented function: halts host phagosome maturation [CITE]
  - Intersection of drug resistance and intracellular survival
  - Breadth across drug classes may reflect remodelling intracellular environment broadly reducing drug efficacy
  - Not targeting single resistance mechanism — broader envelope/survival role

**PPE55:**
- Alternative evolutionary pathway for PZA resistance [CITE]
- Mutations in PPE55 seen in PZA-resistant strains with completely wild-type pncA
- Data PZA:
  - 3752419_C_G: present in 62% of PZA FNs, 3% of resistant samples missing it
  - 3752065_A_C: present in 100% of PZA FNs, 3% of resistant samples missing it
  - Near-universal presence = non-canonical PZA resistance determinants in uncatalogued population
- Data ETH (unexpected):
  - Multiple PPE55 variants in 39–65% of ETH FNs
  - Not explained by established PPE55 biology → warrants further investigation
- Also: OFLX, STR FN associations

**PPE60:**
- Associated with KAN resistance as cryptic determinant in strains with wild-type aminoglycoside resistance sequences [CITE]
- Data: primarily first-line drug FNs (ETH, INH, PZA, RIF) — NOT KAN
  - Shared deletion 3894503_GGCC_G: present in ETH, INH, RIF FNs at 89% prevalence, only 2% resistant missing it
  - Unexpected pattern given documented KAN association
  - Could reflect broader envelope-modifying role OR MDR strain enrichment effects
  - Warrants investigation

**PPE68:**
- Epistatic interaction with embA documented: pairs emb operon component with PPE68-mediated transport modification [CITE]
- Predicted ETH association
- Data: KAN and OFLX FNs — not ETH
  - Predicted association not observed
  - Possible: filtering stringency OR sample composition

### PE_PGRS variants and XDR-TB association

**PE_PGRS4:**
- Documented enrichment in XDR-TB isolates resistant to MFX, OFLX, AMK [CITE]
- Data: CIP, ETH, PZA, STR FNs
  - Multiple CIP variants (complex MNPs and indels) at 59–74% prevalence
  - Structural variation at this locus = common feature of uncatalogued CIP-resistant population
  - Consistent with XDR-TB enrichment documented in literature

**PE_PGRS6:**
- Major genomic marker for XDR-TB, high frequency of structural insertions and homoplastic SNPs [CITE]
- Data: STRIKING PATTERN
  - Identical SNP 624157_T_G appears in ETH, INH, AND RIF FNs at 88% prevalence EACH
  - Only 2% of resistant samples lacking it across all three drugs
  - Same variant, same prevalence, across three first-line drugs
  - Most likely: fixed or near-fixed variant in MDR strain background of cohort
  - Genomic marker of uncatalogued MDR population — diagnostic utility even if regulatory/compensatory role
  - NOT drug-specific resistance determinant

**PE_PGRS7:**
- Directly linked to STR resistance through recurrent homoplastic mutations in WGS analyses [CITE]
- Data: ETH and OFLX FNs — NOT STR
  - Two ETH variants with infinite OR (exclusively in resistant FN samples)
  - Large indel variants in OFLX FNs
  - Unexpected: expands potential resistance relevance beyond documented STR association

**PE_PGRS9:**
- Non-canonical PZA resistance mechanism — like PPE55 [CITE]
- Strains with PE_PGRS9 variants exhibit high-level PZA resistance even without pncA mutations
- Data: CFZ (41-nucleotide deletion), ETH, PZA FNs
  - Large structural deletion in CFZ particularly notable

**PE_PGRS19:**
- Potent immunomodulator [CITE]
- Heavily enriched with insertions and nsSNPs in extreme XDR-TB strains
- Altering host cell survival dynamics = critical strategy under multidrug regimens
- Data:
  - CIP: 19-nucleotide insertion at 74% FN prevalence
  - ETH, ETO SNVs
  - Consistent with XDR-TB strain enrichment and immunomodulatory role during chronic infection

**PE_PGRS33:**
- Mediates M.tb entry into macrophages [CITE]
- Vast genetic variability, tolerates massive indels and frameshifts
- Mutations: impair macrophage entry but enhance virulence during chronic necrotic infection phases
  - Complex fitness trade-off aiding survival in drug-treated, chronically infected tissues
- Data:
  - ETO, LFX (large structural deletion), STR FNs
  - PE_PGRS33 variants may influence resistance indirectly through alteration of intracellular infection microenvironment
  - Not direct drug-target interaction — indirect mechanism

### Interpretation and future directions

**Three-tier conclusion structure:**

1. PE/PPE variants are not incidental noise:
   - Pervasive across 12 drug classes
   - Overlap with documented epistatic interactions
   - High FN prevalence patterns
   - Collectively argue for systematic biological relevance

2. Most parsimonious interpretation = compensatory mutations or resistance-amplifying modifiers:
   - Appear alongside canonical resistance genes
   - High prevalence across resistant populations broadly
   - Map to genes with roles in: envelope architecture, efflux regulation, intracellular survival
   - NOT direct drug target modification in most cases

3. Highest priority candidates for immediate functional characterisation:
   - PPE54 3733405_G_A (INH, RIF, ETH — near-universal in FNs, <4% resistant missing it)
   - PPE51 3502814_G_A (ETO — 100% FN prevalence, 5% resistant missing it)
   - PPE55 3752065_A_C (PZA — 100% FN prevalence, 3% resistant missing it)
   - PE_PGRS6 624157_T_G (INH, RIF, ETH — 88% prevalence each, 2% resistant missing it)

**Future directions from PE/PPE findings:**
- Dedicated PE/PPE input channel in neural network
  - Connected through shared hidden layer with canonical resistance gene features
  - Would capture compensatory and epistatic relationships current single-layer cannot encode
- Combine with cross-resistance hidden layer proposed in 4.1
  - These two extensions = primary direction for model development in next iteration
- Wet-lab validation priorities:
  - PPE54 variants given katG/rpoB/embB epistatic interactions
  - PPE51 given multi-drug resistance amplification role
  - PE_PGRS6 given near-universal MDR strain marker status

---

# LIMITATIONS SECTION (key points to cover)

- Training data lacks resistant cases for newer drugs:
  - Class imbalances: BDQ, LZD, DLM, CFZ
  - No data: TD, PA, PTO
  - Consequence: model cannot learn what it hasn't seen

- Model rapidly converges → hits representational capacity quickly:
  - Single-layer architecture = weighted logical OR
  - Cannot learn: cross-resistance, pleiotropic mechanisms, epistatic interactions
  - ETO example: INH-ETO cross-resistance via inhA established biologically, cannot be encoded without shared hidden layers

- SNP filtering needs to be more robust:
  - Flag and remove confounders systematically (rpoB C>T appearing in non-RIF drugs)
  - Comprehensive lineage pattern screening and flagging
  - MDR strain background control in Fisher's exact test

- Significance threshold possibly too stringent for newer drugs:
  - -log10(p) ≥ 5 may exclude genuine variants for drugs with few resistant samples
  - Consider relaxing for drugs where data is sparse

- Gene annotation gaps:
  - gene-not-found variants: silent dropping from output JSON due to continue statement
  - Fix: preserve locus tag as placeholder
  - May be missing PE/PPE candidates in current output

- Fisher's exact test conducted per drug independently:
  - No control for MDR strain background
  - Creates systematic confounding for any variant enriched in MDR strains
  - Solution: include MDR status as covariate or use conditional test

---

# NEXT STEPS / FUTURE WORK (key points to cover)

- Update dataset for newer drugs:
  - Phenotypic R data for TD, PA, PTO
  - More R data for BDQ, LZD, DLM, CFZ
  - BPaLM regimen data = promising source [CITE]

- Validation from external cohort:
  - CRyPTIC consortium [CITE]
  - MIRU-VNTR [CITE]

- Lineage stratification for evaluation:
  - Performance may vary by lineage — not currently assessed
  - Important for generalisability claims

- Wet-lab validation of candidate SNPs:
  - Priority order:
    1. gyrA ACAG>GCAC MNP (LFX + MFX — largest effects, most biologically validated)
    2. rrs A>G in AMK (established target, 25.5% ΔSens)
    3. katG C>G for INH (prodrug activator, 6.26% ΔSens)
    4. PPE54, PPE51, PPE55 variants with high FN prevalence
    5. gene-not-found C>T for ETO (25.69% ΔSens — pending annotation)
  - Potentially included in future catalogues or AMR prediction tools if validated

- Network architecture improvements:
  - Hidden layers for cross-resistance (FQ class, INH-ETO, BDQ-CFZ, DLM-PA)
  - Dedicated PE/PPE feature channel
  - These two extensions = primary architectural development direction

- Resolve gene annotation gaps:
  - Fix continue statement bug in edit_snp.py
  - Replace gene-not-found with locus_tag placeholder
  - Cross-reference all locus tags against TubercuList and PATRIC

- Relax significance threshold for newer drugs:
  - -log10(p) ≥ 5 possibly too stringent for BDQ, LZD, DLM, CFZ
  - Drug-specific thresholds may be more appropriate

- Comprehensive confounder screening:
  - Systematic identification of MDR-background confounders
  - Lineage marker list expansion
  - Conditional Fisher's test controlling for MDR status

- Ciprofloxacin, capreomycin, ofloxacin extended analysis:
  - These are outside primary WHO 1st/2nd line classification
  - Cross-resistance implications with primary drug panel
  - Include as supplementary analysis

---

# CITATION PLACEHOLDERS — things that definitely need references

- TB-Profiler tool citation
- WHO catalogue 2023 (second edition)
- WHO consolidated guidelines on TB treatment
- WHO 98% sensitivity / 95% specificity recommendation for genotypic DST
- BPaLM WHO endorsement
- katG mechanism of INH prodrug activation
- rpoB and RRDR rifampicin resistance
- embB and arabinosyltransferase ethambutol resistance
- pncA and pyrazinamide prodrug activation
- gyrA and fluoroquinolone resistance mechanism
- gyrA ACAG>GCAC MNP — check if any prior literature
- rrs A1401G and aminoglycoside resistance
- rrs A1401G cross-resistance AMK-KM
- inhA and INH-ETO cross-resistance mechanism
- Rv0678 and MmpL5 efflux in CFZ/BDQ resistance
- F420 pathway and DLM/PA activation and resistance
- DLM-PA cross-resistance
- CS dual-target mechanism (Alr + DdlA)
- TZD = prodrug of CS
- PE/PPE gene family general review
- katG-PPE54 epistatic interaction
- rpoB-PPE54 epistatic interaction
- embB-PPE54 epistatic interaction
- embC-PPE68 epistatic interaction
- PPE51 multi-drug resistance role
- PPE50-PPE51 interaction and transport complex
- PPE42 transport channel and AMK resistance
- PPE54 phagosome maturation arrest function
- PPE55 as alternative PZA resistance pathway
- PPE60 cryptic KAN resistance
- PPE68 embA epistatic interaction
- PE_PGRS4 XDR-TB enrichment
- PE_PGRS6 XDR-TB marker
- PE_PGRS7 STR resistance homoplastic mutations
- PE_PGRS9 non-canonical PZA resistance
- PE_PGRS19 XDR-TB immunomodulator
- PE_PGRS33 macrophage entry and virulence
- CRyPTIC consortium
- MIRU-VNTR database
- TubercuList database
- BPaLM PNG implementation
- First-line drug introduction dates (1950s–60s)
- LZD approved for TB use 2019
- BDQ approved 2012
- F1 score and its limitations as clinical metric
- Heteroresistance and selection pressure in TB
- MDR/XDR-TB global burden statistics
- FQ side effects (nephrotoxicity, tendinopathy)
- LZD side effects (peripheral neuropathy, myelosuppression)
- CFZ originally developed for leprosy

---

*End of resource document. All content originated from Nabil Islam's analysis, observations, and biological reasoning. Use this as a structured outline — write each section in your own voice from these bullet points.*
