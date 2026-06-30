# Results

> Draft conventions (same as the Discussion draft):
> - **`[cite]`** — a reference to add. **`[confirm: …]`** — a detail to verify before submission (the remaining ones are codon/amino-acid identities to check against NC_000962.3).
> - The Results report *what was found*; mechanistic interpretation is deferred to the Discussion and signposted as "(see §4.x)". Avoid re-arguing mechanism here.
> - Ethambutol = **EMB**, ethionamide = **ETO**. Cycloserine, terizidone and PAS are omitted per supervisor feedback (ll. 248/266/357). Variant format: `coordinate_REF>ALT (FNP, RSM, Δsensitivity)`; an annotated variant crosses the Δsensitivity ≥ 5% threshold; "green / infinite-OR" markers denote variants exclusive to resistant samples.
> - Plot axes, thresholds and quadrant/colour conventions are defined in the section introduction and are not repeated per drug.

---

## 3.1 First-line drugs

The first-line drugs produced the most densely populated volcano plots in the dataset, and three of the four yielded candidates that crossed the ablation sensitivity threshold. Annotated candidates fell predominantly in the canonical target genes — *rpoB*, *katG* and *embB* — alongside a recurrent set of pe/ppe and PE_PGRS loci. Two variants, the *rpoB* substitution 761155_C>T and the *katG* substitution 2155168_C>G, recurred as candidates for drugs in which the respective gene has no mechanistic role; these are reported below as confounders and interpreted in §4.2.

### Rifampicin

The Rifampicin plot returned 1,380 variants significantly associated with resistance, 16 associated with susceptibility, and 484 passing the filtering protocol, with a densely populated upper-right quadrant and infinite-odds-ratio (green) markers in the region of *PPE54*. Every annotated candidate fell within *rpoB*: 761155_C>T (97%, 1%, 14.99%), 761110_A>T (89%, 2%, 3.37%), 761139_C>G (100%, 2%, 1.22%) and 761139_C>T (100%, 2%, 1.26%), of which only 761155_C>T crossed the 5% annotation threshold. All four lie within or immediately flanking the Rifampicin Resistance Determining Region. The remaining filtered loci were pe/ppe: *PPE60* (3894503_GGCC>G, 89%; 3895400_A>C, 71%) and *PPE54* (3733405_G>A, 73%), neither with a calculable Δsensitivity. The concentration of all annotated candidates in the target gene, with no off-target annotations, is noted as internal validation of the pipeline (see §4.2).

### Isoniazid

The Isoniazid plot returned 1,460 resistance-associated and 448 susceptibility-associated variants — a larger susceptibility-side cloud than Rifampicin — with 378 passing filtering and green markers at the *rpoB*, *katG* and *inhA* labels. Eleven *katG* variants were recovered, of which the leading 2155168_C>G (100%, 3%, 6.26%) crossed the annotation threshold; the remaining ten (2155546_T>C, 2155417_G>C, 2155418_G>C, 2155631_A>G, 2154661_C>T, 2155168_C>T, 2155687_T>C, 2155819_T>C, 2155300_G>A and 2154016_C>T) were recovered at RSM 4% with no calculable Δsensitivity. A second annotated candidate was returned as an intergenic-region variant, 1673425_C>T (4.56%), for which FNP and RSM are not reported. The *rpoB* substitution 761155_C>T (50%, 3%, 0.73%) — the same variant that is the dominant rifampicin candidate above — is flagged here as a confounder (see §4.2). The remaining filtered loci were *PPE54* (3733476_A>AG, 37%; 3733405_G>A, 73%), *PPE60* (3894503_GGCC>G, 89%) and *inhA* (1674782_T>C, 100%), none with a calculable Δsensitivity. The intergenic 1673425_C>T variant recurs as the leading ethionamide candidate (§3.2, Group C).

### Ethambutol

The Ethambutol plot was the most diverse of the first-line drugs, returning 2,963 resistance-associated and 1,127 susceptibility-associated variants — the largest bilateral spread in the class — with 1,812 passing filtering and green markers near *PE_PGRS19*. Seven *embB* candidates were recovered, five of them ablation-contributing: 4247429_A>G (95%, 2%, 2.56%), 4248003_A>G (92%, 2%, 0.66%), 4247431_G>C (80%, 2%, 0.97%), 4247431_G>A (38%, 2%, 1.05%) and 4247574_A>C (100%, 2%, 1.77%), alongside two further filtered *embB* variants (4247847_A>G, 90%; 4247730_G>C, 80%) with no calculable Δsensitivity. No individual *embB* variant crossed the 5% threshold, the candidates spanning multiple positions and substitution types. Two confounders were present — *rpoB* 761155_C>T (17%, 1%, 2.33%) and *katG* 2155168_C>G (11%, 1%, 0.97%), the canonical rifampicin and isoniazid mutations respectively (see §4.2). The remaining filtered set comprised the auxiliary target loci *embC* (4241022_C>T, 100%) and *ubiA* (4269271_A>G, 100%), and the pe/ppe loci *PPE55* (four variants, 39–65%), *PPE60* (3894503_GGCC>G, 89%; 3894484_C>T, 62%), *PPE54* (3733405_G>A, 75%), *PE_PGRS6* (624157_T>G, 88%), *PE_PGRS7* (672683_G>A, 80%; 673482_C>T, 100%), *PE_PGRS4* (336616_C>T, 38%) and *PE_PGRS19* (1188873_C>G, 100%), none with a calculable Δsensitivity.

### Pyrazinamide

The Pyrazinamide plot returned the largest resistance-associated count of the first-line drugs (n=3,161), alongside 752 susceptibility-associated variants and 448 passing filtering, with a green marker at *PE_PGRS9*. No canonical target-gene (*pncA*) candidate appeared in the filtered set; the annotated genes were exclusively pe/ppe and PE_PGRS: *PPE54* (3729592_G>A, 100%; 3734621_C>T, 56%), *PE_PGRS4* (338688_C>T, 71%; 336635_CCCGCCGTTG>C, 50%), *PE_PGRS9* (836018_G>A, 80%), *PPE55* (3752419_C>G, 62%; 3752065_A>C, 100%) and *PPE60* (3894914_C>G, 100%). None produced a calculable Δsensitivity, making Pyrazinamide the only first-line drug without an ablation-annotated candidate (see §4.2).

---

## 3.2 Second-line drugs

### Group A

#### Fluoroquinolones (levofloxacin and moxifloxacin)

Levofloxacin and moxifloxacin are reported together, as they share a resistance mechanism and differ in this dataset mainly in the number of phenotypes available. The Levofloxacin plot returned 234 resistance-associated and 1 susceptibility-associated variant, with 16 passing filtering and infinite-odds-ratio (green) markers at *gyrA*; the Moxifloxacin plot returned 83 and 1 respectively, with 50 passing filtering and a green marker at *PPE54*. For both drugs, every annotated candidate fell within *gyrA*. The shared lead variant 7582_ACAG>GCAC was recovered for levofloxacin (100%, 2%, 21.09%) and moxifloxacin (44%, 1%, 32.55%), and the shared variant 7570_C>T for levofloxacin (70%, 2%, 9.98%) and moxifloxacin (40%, 1%, 11.51%); all four of these crossed the 5% threshold. Two further levofloxacin-only *gyrA* variants were below threshold: 7572_T>C (100%, 2%, 2.73%) and 7582_ACAG>CCAC (100%, 2%, 3.7%). The only non-target annotations were levofloxacin *PE_PGRS33* (2062066_TCCGCCGGCGCCGCCGGCC>T, 20%) and moxifloxacin *PPE54* (3733185_G>C, 100%), neither with a calculable Δsensitivity. The recovery of the same *gyrA* variants for both drugs, and the composition of the leading variant (7582_ACAG>GCAC), are addressed in §4.3 (the latter being two linked substitutions rather than a true multinucleotide polymorphism).

#### Bedaquiline

The Bedaquiline plot was among the sparsest in the study, returning only 5 resistance-associated variants, no susceptibility-associated variants, and 2 passing filtering. No candidate fell in a recognised resistance or pe/ppe gene, and no Δsensitivity could be calculated (see §4.3).

#### Linezolid

The Linezolid plot returned 164 resistance-associated and 5 susceptibility-associated variants, with all 164 resistance-associated variants passing filtering — the only drug for which the filtered set equalled the significant resistance-associated set in size. The most prominent signals lay on the susceptibility side, reaching −log₁₀(p) values approaching 11. No candidate fell in a recognised resistance or pe/ppe gene, and none produced a calculable Δsensitivity (see §4.3).

### Group B

*(Cycloserine and terizidone are omitted per supervisor feedback (ll. 248/266); Group B reduces to clofazimine.)*

#### Clofazimine

The Clofazimine plot returned 837 resistance-associated and 23 susceptibility-associated variants, with 582 passing filtering, a diffuse spread, and a −log₁₀(p) ceiling of approximately 18 — the lowest among the large-filtered drugs. Four loci were annotated. The leading candidate, *ethA* 4326333_C>G (22%, 1%, 11.08%), crossed the threshold but is flagged as a confounder, *ethA* being the ethionamide activator with no role in clofazimine action (see §4.4). The second candidate resolved to *Rv3254* (3634487_G>A, 57%, 1%, 3.67%), a conserved hypothetical protein of unknown function [cite]. The remaining two loci were pe/ppe — *PPE54* (3734189_A>T, 14%) and *PE_PGRS9* (836694_ACCGGCGGGTTCGGCGATACCGACGGGGGAGCCGGCGGTG>A, 20%) — neither with a calculable Δsensitivity. The canonical clofazimine determinant *Rv0678* did not appear among the annotated candidates (see §4.4).

### Group C

#### Delamanid

The Delamanid plot returned 320 resistance-associated and 11 susceptibility-associated variants, with 318 passing filtering. The single annotated locus was *PPE54* (3733795_C>T, 14%), with no calculable Δsensitivity, and no canonical target-gene candidate appeared (see §4.5).

#### Ethionamide

The Ethionamide plot was the most densely populated of the second-line drugs, returning 2,524 resistance-associated and 251 susceptibility-associated variants, with 706 passing filtering and a green marker at *PPE51*. The standout candidate was an intergenic-region variant, 1673425_C>T (25.69%), the largest Δsensitivity in Group C and the same coordinate as the isoniazid intergenic candidate (§3.1); FNP and RSM are not reported for it. The target-gene candidate *inhA* 1674481_T>G (100%, 5%, 0.65%) also crossed into the annotated set, with a second *inhA* variant 1674262_A>G (77%, 5%) below threshold. The remaining filtered loci were pe/ppe and PE_PGRS — *PPE55* (3748936_G>A, 77%; 3752124_G>A, 85%; 3748412_G>A, 100%), *PE_PGRS33* (2061315_C>A, 77%), *PPE51* (3502814_G>A, 100%; infinite-OR green marker) and *PE_PGRS19* (1188514_A>G, 86%) — none with a calculable Δsensitivity. The recurrence of 1673425_C>T across both ethionamide and isoniazid is addressed in §4.5.

#### Amikacin

The Amikacin plot returned 214 resistance-associated and 11 susceptibility-associated variants, with 190 passing filtering and an infinite-odds-ratio (green) marker at *rrs*. A single locus was annotated: *rrs* 1473246_A>G (100%, 1%, 25.5%), corresponding to the A1401G mutation **[confirm: A1401G assignment]**. The same coordinate recurs as the leading candidate for capreomycin and kanamycin (see §4.5).

#### Capreomycin

The Capreomycin plot returned 102 resistance-associated and 9 susceptibility-associated variants, with 4 passing filtering. The single annotated locus was *rrs* 1473246_A>G (90%, 2%, 30.25%) — the largest Δsensitivity in Group C and the identical coordinate recovered for amikacin and kanamycin (see §4.5).

*(Pretomanid and prothionamide were absent from the dataset; pretomanid is addressed via the delamanid cross-resistance proxy in §4.5.)*

---

## 3.3 Other drugs

The agents outside the primary WHO first- and second-line classification largely recapitulate the target-gene and cross-resistance patterns seen above: the fluoroquinolone *gyrA* signal extends to ciprofloxacin and ofloxacin, the injectable *rrs* variant to kanamycin, and streptomycin returns its canonical *rpsL* determinant alongside the *katG* confounder. Across these drugs the filtered variants were recovered largely at relaxed RSM values (approximately 8–14%) and few produced a calculable Δsensitivity; interpretation is deferred to §4.8.

### Ciprofloxacin

The Ciprofloxacin plot returned 217 resistance-associated and 1 susceptibility-associated variant, with 168 passing filtering and a green marker at *PPE50*. No candidate crossed the annotation threshold. The annotated loci were *PPE50* (3501668_G>C, 100%, 13%), *gyrA* (7570_C>T, 91%, 14%; 7582_ACAG>GCAC, 97%, 10% — the same QRDR positions as levofloxacin and moxifloxacin), *PE_PGRS4* (338648_T>G, 73%; 338682_TCCC>GGCG, 74%; 338690_ATT>GTC, 64%; 338669_T>C, 59%), *PE_PGRS19* (1189137_C>CGCCGCCGGCCCCGCCGTT, 74%) and *PPE54* (3735033_G>A, 80%), none with a calculable Δsensitivity.

### Kanamycin

The Kanamycin plot returned 562 resistance-associated and 2 susceptibility-associated variants, with 230 passing filtering and an infinite-odds-ratio (green) marker at *rrs*. The annotated *rrs* variant 1473246_A>G (100%, 2%, 14.32%) crossed the threshold — the identical coordinate recovered for amikacin and capreomycin — alongside *PPE68* (4351991_C>A, 60%) with no calculable Δsensitivity (see §4.5).

### Ofloxacin

The Ofloxacin plot returned the largest bilateral spread outside the first-line drugs — 3,026 resistance-associated and 1,618 susceptibility-associated variants — with 1,386 passing filtering and green markers at *PE_PGRS7*. Nine *gyrA* variants were recovered, the largest single-gene fluoroquinolone set in the study: 7581_GACAG>TACAC (100%), 7572_T>C (91%), 7581_GACAG>CACAC (88%), 7570_C>T (88%), 7582_ACAG>GCAC (94%), 7582_ACAG>CCAC (87%), 8639_G>A (78%), 7581_GACAG>AACAC (94%) and 8955_G>C (100%), all at RSM 8–11% with no calculable Δsensitivity. Ofloxacin was the only fluoroquinolone to implicate the second gyrase subunit, *gyrB* (6608_G>C, 69%). The remaining annotated loci were *PE_PGRS7* (675069_C>A, 78%; 672738_G>CCGA, 100%), *PPE55* (3747888_T>C, 69%), *PPE68* (4351991_C>A, 100%) and *PPE54* (3734189_A>T, 59%). The shared QRDR positions across all four fluoroquinolones are addressed in §4.3.

### Streptomycin

The Streptomycin filtered set is reported from the table **[confirm: figure reference, if a plot exists]**. The canonical determinant *rpsL* 781687_A>G (95%, 8%, 2.57%) was the leading ablation contributor. The *katG* substitution 2155168_C>G (36%, 5%, 2.39%) — the canonical isoniazid mutation — also crossed the threshold and is flagged as a confounder, extending the first-line confounder pattern to streptomycin (see §4.2). The same injectable *rrs* variant 1473246_A>G appeared (49%, 7%) but at markedly lower FNP than for amikacin, capreomycin or kanamycin and with no calculable Δsensitivity. The remaining filtered loci were pe/ppe and PE_PGRS: *PE_PGRS33* (2061424_G>A, 62%), *PPE55* (3745863_G>A, 68%), *PPE51* (3502457_G>A, 58%), *PPE42* (2935915_C>A, 60%) and *PE_PGRS4* (337482_C>T, 62%), none with a calculable Δsensitivity.
