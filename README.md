# Decision-Making Autonomy and Depressive Symptoms Among Women in Lesotho: Rural–Urban Differences

**Research code, statistical analysis, and publication materials for a peer-reviewed study**

[![Publication](https://img.shields.io/badge/Article-Published-2f6f61)](https://doi.org/10.1016/j.jadr.2026.101080) [![Journal](https://img.shields.io/badge/Journal-Journal%20of%20Affective%20Disorders%20Reports-315375)](https://doi.org/10.1016/j.jadr.2026.101080) [![License](https://img.shields.io/badge/Repository-MIT%20License-6b7280)](LICENSE)

**Study:** Lesotho Demographic and Health Survey (LDHS) 2023–2024  
**Population:** 3,297 ever-married women aged 15–49 years  
**Methods:** Survey-weighted logistic regression; rural–urban stratification; district-level spatial analysis  
**Article:** [DOI: 10.1016/j.jadr.2026.101080](https://doi.org/10.1016/j.jadr.2026.101080)

> This repository provides a structured record of the research workflow. DHS microdata access restrictions and editorial confidentiality must be respected. Reproducibility depends on obtaining the authorized data and installing the required software.

## Contents

- [Publication Details](#publication-details)
- [Overview](#overview)
- [Abstract](#abstract)
- [Key Highlights](#key-highlights)
- [Authors & Contributions](#authors--contributions)
- [Study Design & Data Source](#study-design--data-source)
- [Repository Structure](#repository-structure)
- [Key Variables & Measurement](#key-variables--measurement)
- [Statistical Methods](#statistical-methods)
- [Key Results](#key-results)
- [Figures & Visual Outputs](#figures--visual-outputs)
- [Reproducibility](#reproducibility)
- [Data Availability Statement](#data-availability-statement)
- [Ethical Considerations](#ethical-considerations)
- [Funding & Conflict of Interest](#funding--conflict-of-interest)
- [Strengths & Limitations](#strengths--limitations)
- [Related Work from the Author](#related-work-from-the-author)
- [Research Impact](#research-impact)
- [Policy Implications](#policy-implications)
- [Citation](#citation)
- [Acknowledgments](#acknowledgments)
- [License](#license)


## Publication Details

**Article:** Decision-Making Autonomy and Depressive Symptoms Among Women in Lesotho: Rural–Urban Differences

| Field | Details |
|---|---|
| Journal | *Journal of Affective Disorders Reports* |
| Article number | 101080 |
| Publication status | Published, 2026 |
| Available online | 13 May 2026 |
| DOI | [10.1016/j.jadr.2026.101080](https://doi.org/10.1016/j.jadr.2026.101080) |
| Authors | Md Salek Miah; Maria Bintey Kabir |

### Manuscript and publication workflow

Initial submission → peer review → response and revision → editorial decision → production → published article.

The repository includes a dedicated [`06_Revision_and_Submission/`](06_Revision_and_Submission/) directory for documentation of these stages. Reviewer correspondence, response letters, manuscript drafts, and internal production files should be retained in a **private archive** unless their disclosure is explicitly permitted by applicable editorial policies and rights holders.

For the definitive scholarly record, consult the [published article](https://doi.org/10.1016/j.jadr.2026.101080).


## Overview

This study investigates **decision-making autonomy and depressive symptoms** among ever-married women in Lesotho, with a focus on **rural–urban inequalities** and **district-level spatial disparities**, using data from the nationally representative **Lesotho Demographic and Health Survey (LDHS) 2023–24**, funded by USAID. Depression was assessed using the **Patient Health Questionnaire-9 (PHQ-9 ≥ 10)**, and **survey-weighted multivariable logistic regression** was used to identify associations — with stratified analyses for rural and urban women and spatial choropleth mapping at the district level.

**Analysis Pipeline:**

```
LDHS 2023–24  (Cross-Sectional · Nationally Representative · USAID-Funded)
          │
          │  3,297 ever-married women aged 15–49 years
          │  10 districts · Rural & Urban strata
          ▼
   Data Management      cleaning · recoding · survey weighting · PHQ-9 scoring
   (Stata)              decision-making autonomy composite index · covariate coding
          │
          ▼
   Descriptive Stats    prevalence estimation · district-level breakdown
                        rural vs urban stratification · bivariate chi-square tests
          │
          ▼
   Spatial Mapping      district-level depression prevalence maps
   (R / ggplot2)        decision-making autonomy spatial figures
          │
          ▼
   Regression Analysis  survey-weighted stepwise multivariable logistic regression
                        national · rural-stratified · urban-stratified models
          │
          ▼
   Model Assessment     AUC · Hosmer–Lemeshow · VIF · AIC · BIC
          │
          ▼
   Peer Review          editor & reviewer comments · point-by-point response · revision
          │
          ▼
   Outputs               TIFF spatial figures · graphical abstract · adjusted ORs ·
                         policy brief · published article (DOI 101080)
```

---


## Abstract

### Background
Depression among women in low- and middle-income countries is shaped by structural gender inequality, and women's decision-making autonomy has been proposed as a modifiable determinant of mental health, yet evidence from Southern Africa remains limited, and rural–urban heterogeneity in this relationship is rarely examined.

### Objectives
To assess the association between depressive symptoms and decision-making autonomy with rural–urban inequalities, and to map district-level spatial disparities in depression prevalence among ever-married women in Lesotho.

### Methods
This study used cross-sectional data from **3,297 ever-married women aged 15–49 years** from the **2023–24 Lesotho Demographic and Health Survey (LDHS)**. Depression was measured using the **Patient Health Questionnaire-9 (PHQ-9 ≥ 10)**. Women's decision-making autonomy was measured using a **composite empowerment index** based on participation in five household decision-making domains. Survey-weighted multivariable logistic regression models were fitted at the national level and **stratified by place of residence**. Model discrimination was assessed using the **AUC**, calibration using the **Hosmer–Lemeshow test**, and multicollinearity using **VIF**. Spatial analyses were conducted to examine **district-level variation** in depression prevalence and autonomy.

### Results

- **Overall depression prevalence:** 7.4% (95% CI: 6.3–8.7)
- Women with decision-making autonomy showed **lower odds of depression nationally** (AOR = 0.63; 95% CI: 0.39–0.98; *p* = 0.048)
- The protective effect was **stronger in rural areas** (AOR = 0.44; 95% CI: 0.27–0.74; *p* = 0.002)
- In **urban areas**, the association was not statistically significant (AOR = 0.88; 95% CI: 0.39–1.97; *p* = 0.758)
- Depression prevalence was **highest** in central–northern districts (Maseru, Berea, Leribe, Butha-Buthe)
- **Lowest autonomy** was observed in southern and south-western districts (Quthing, Qacha's Nek, Mohale's Hoek, Mafeteng)
- Final model showed **moderate discrimination** (AUC = 0.68) and **good calibration** (Hosmer–Lemeshow *p* = 0.6642)

### Conclusions
Women's decision-making autonomy is significantly associated with **lower odds of depressive symptoms** in Lesotho, particularly among rural women. The observed rural–urban and spatial inequalities highlight the need for **context-specific mental health and reproductive health interventions** that incorporate women's empowerment as a core component.

**Keywords:** Depression · Decision-making autonomy · Pregnancy loss · Rural–urban disparities · Lesotho · Spatial analysis

---


## Key Highlights

- **7.4%** (95% CI: 6.3–8.7) of ever-married women showed moderate-severe depression nationally

-  Decision-making autonomy was **protective** nationally (AOR = 0.63) and **strongly protective in rural areas** (AOR = 0.44)

-  Depression rates were **slightly higher among urban women** despite greater resource access — reflecting possible urban stressors

- Highest depression burden in **Maseru, Berea, Leribe, and Butha-Buthe** (central–northern districts)

- Lowest autonomy concentrated in **Quthing, Qacha's Nek, Mohale's Hoek, and Mafeteng** (southern/south-western)

- Final model: **AUC = 0.68** (moderate discrimination) · **Hosmer–Lemeshow p = 0.6642** (good fit) · **AIC = 1648.22** · **mean VIF = 2.2** (no significant multicollinearity)

- Significant **rural–urban heterogeneity** — the autonomy–depression association was statistically significant only in rural areas, indicating an effect-modification pattern by place of residence

- Article now **published**, with a structured repository of research code, outputs, and publication documentation

---


## Authors & Contributions

### Corresponding Author

**Md Salek Miah**
Research Assistant, Department of Statistics, Shahjalal University of Science and Technology (SUST), Sylhet-3114, Bangladesh
Statistical Analysis Instructor, Bangladesh Institute of Innovative Health Research (BIIHR)
GBD Collaborator, Institute for Health Metrics and Evaluation (IHME)

 Sylhet, Bangladesh ·  +8801687831074

### Co-Author

**Maria Bintey Kabir**
Shaheed Suhrawardy Medical College, Dhaka-1207, Bangladesh
Study Physician, Projahnmo Research Foundation, Dhaka-1213, Bangladesh

### Author Contributions (CRediT-style)

>  The roles below follow the standard CRediT taxonomy typical of quantitative/clinical author pairings; please align exact wording with the CRediT statement published in the final article.

| Role | Contributor(s) |
|:-----|:----------------|
| Conceptualization, Methodology, Formal Analysis | Md Salek Miah |
| Data Curation, Software, Visualization (spatial mapping) | Md Salek Miah |
| Clinical/Content Expertise, Validation | Maria Bintey Kabir |
| Writing – Original Draft | Md Salek Miah |
| Writing – Review & Editing | Both authors |
| Supervision guidance | Prof. Md Jamal Uddin (SUST / Daffodil International University) |

---


## Study Design & Data Source

### Survey Overview

This study used secondary data from the **Lesotho Demographic and Health Survey (LDHS) 2023–24** — a **cross-sectional, nationally representative** survey funded by **USAID** via the DHS Program. The survey was conducted from **27 November 2023 to 29 February 2024** in partnership with the Lesotho Ministry of Health, using standardized structured questionnaires administered via **tablet-based CAPI** across all 10 districts.

| Field | Details |
|:------|:--------|
|  **Survey Period** | 27 November 2023 – 29 February 2024 |
|  **Country** | Lesotho |
| 🔗 **Source** | [DHS Program — USAID Funded](https://dhsprogram.com) |
|  **Survey Report** | DHS Program report (refer to official source) |
|  **Final Sample (n)** | **3,297** ever-married women |
|  **Depression Tool** | Patient Health Questionnaire-9 (PHQ-9 ≥ 10) |
|  **Exposure** | Decision-making autonomy (composite index, 5 domains) |
|  **Design** | Cross-sectional · two-stage stratified cluster sampling |
|  **Coverage** | 10 districts · National |
|  **Reporting Standard** | STROBE guidelines |

> **Data access:** Individual-level DHS files require authorization. Do not redistribute restricted microdata through this repository.

### Sampling Design

```
2016 Lesotho Population & Housing Census
          │
          ▼
Stage 1: 400 Enumeration Areas (EAs) — probability proportional to size
          │
          ▼
Stage 2: 25 households per EA — systematic random sampling
          │
          ▼
Eligible: Women aged 15–49 · usual residents or overnight guests
Subsampled: PHQ-9 depression module respondents
          │
          ▼
              ┌───────────────────────────────────────────┐
              │   Final Weighted Sample: n = 3,297         │
              ├──────────────────┬──────────────────────────┤
              │   Rural 55.0%  │   n = 2,086               │
              │   Urban 45.0%  │   n = 1,211               │
              │   10 Districts │   Spatial mapping          │
              └──────────────────┴──────────────────────────┘
```

---


## Repository Structure

The repository has been reorganized into research-focused directories, as shown in the updated GitHub repository screenshot:

```text
Rural-Urban-Inequalities-in-Depression-among-Ever-Married-Women-in-Lesotho/
├── README.md
├── LICENSE
├── .gitignore
├── 01_Code/
│   └── Stata/
│       └── [data preparation, analysis, and spatial .do scripts]
├── 02_Data/
│   └── [data-access documentation and any permitted data files]
├── 03_Outputs/
│   └── [figures, tables, and graphical abstract]
├── 04_Publication/
│   └── [publication records and permitted article materials]
└── 06_Revision_and_Submission/
    └── [revision history and editorial/production documentation]
```

**Directory guide**

| Directory | Purpose |
|---|---|
| [`01_Code/Stata/`](01_Code/Stata/) | Stata scripts for data management, survey-weighted models, and spatial analysis |
| [`02_Data/`](02_Data/) | Data source information, access procedures, and restricted-data guidance |
| [`03_Outputs/`](03_Outputs/) | Research figures, tabular outputs, and graphical abstract |
| [`04_Publication/`](04_Publication/) | Published article reference and allowable publication materials |
| [`06_Revision_and_Submission/`](06_Revision_and_Submission/) | Manuscript development and revision workflow documentation |

**Note:** The folder list reflects the structure visible in the supplied screenshot. Exact filenames inside the folders should be checked after moving files. Reproducibility guidance is maintained in this root README.


## Key Variables & Measurement

### Outcome Variable
| Variable | Measurement | Cut-off |
|:---------|:------------|:--------|
| **Depressive symptoms** | PHQ-9 scale (9 items) | ≥ 10 = moderate-severe depression; < 10 = no depression |
| **Internal consistency** | Cronbach's alpha | α = 0.82 (good reliability) |

### Main Exposure — Decision-Making Autonomy (Composite Index)

Women scored 1 point per domain if they reported deciding **alone or jointly** with their partner:

| Domain | Points |
|:-------|:------:|
| Own health care | 1 |
| Large household purchases | 1 |
| Use of household money | 1 |
| Visits to relatives or family | 1 |
| Family planning decisions | 1 |
| **Total composite score** | **0–5** |

> **No autonomy:** composite score ≤ 2 · **Has autonomy:** composite score ≥ 3

### Key Covariates
| Variable | Type | Categories |
|:---------|:-----|:-----------|
| Women's age | Categorical | 15–19, 20–24, 25–29, 30–34, 35–39, 40–44, 45–49 yrs |
| Education | Categorical | Below primary / Secondary incomplete / Secondary or higher |
| Maternal employment | Binary | Currently working / Not working |
| Age at first birth | Categorical | Early (10–17) / Normal (18–24) / Late (≥25) |
| Age at cohabitation | Categorical | Young (<18) / Mild (18–20) / Older (≥21) |
| Pregnancy loss | Categorical | None / One / Two or more |
| Place of residence | Binary | Urban / Rural |
| Administrative district | Categorical | 10 districts (ref: Maseru) |
| Wealth status | Categorical | Poor / Middle / Rich |
| Household head sex | Binary | Male / Female |
| Internet use | Binary | Yes / No (last 12 months) |
| Media access | Binary | Yes / No |
| Water source | Binary | Improved / Unimproved |
| Toilet facility | Binary | Improved / Unimproved |

---


## Statistical Methods

| Step | Method | Detail |
|:-----|:-------|:-------|
| **Descriptive** | Survey-weighted proportions | 95% CI; chi-square bivariate tests |
| **Spatial analysis** | District-level choropleth mapping | R (ggplot2 / spatial packages) |
| **Regression** | Survey-weighted stepwise multivariable logistic | Forward stepwise; Models 0–4 |
| **Stratification** | Rural (n=2,086) vs. Urban (n=1,211) | Separate fully adjusted models |
| **Multicollinearity** | Variance Inflation Factor (VIF) | Mean VIF = 2.2 |
| **Model fit** | Hosmer–Lemeshow test | χ² = 5.85, p = 0.6642 |
| **Discrimination** | Area Under ROC Curve (AUC) | AUC = 0.6781 |
| **Model selection** | AIC / BIC | AIC = 1648.22; BIC = 1886.15 |
| **Effect measure** | Adjusted odds ratios (AOR) | 95% CI; p < 0.05 significance |
| **Software** | Stata · R | STROBE-compliant reporting |

### Model Building Sequence

| Model | Variables Added |
|:------|:----------------|
| **Model 0** | Maternal age + decision-making autonomy |
| **Model 1** | + Sociodemographic factors (education, religion, residence) |
| **Model 2** | + Reproductive factors (age at first birth, cohabitation, parity, pregnancy loss) |
| **Model 3** | + Contextual factors (urban/rural residence) |
| **Model 4 (Final)** | + Household & environmental factors (toilet, water, household size, wealth, media, internet, assets, materials) |

---


## Key Results

### Depression Prevalence

| Group | Prevalence | 95% CI |
|:------|:----------:|:------:|
| **Overall** | **7.4%** | 6.3–8.7 |
| Rural residents | 45.5% of depressed | 37.3–53.9 |
| Urban residents | 54.5% of depressed | 46.1–62.7 |
| Rural share of total sample | 54.98% | 51.47–58.45 |
| Urban share of total sample | 45.02% | 41.55–48.53 |

### Main Result — Decision-Making Autonomy and Depression

| Level | COR (95% CI) | AOR (95% CI) | p-value |
|:------|:------------:|:------------:|:-------:|
| **National** | 0.83 (0.56–1.23) | **0.63 (0.39–0.98)** | 0.048 |
| **Rural** | — | **0.44 (0.27–0.74)** | 0.002 |
| **Urban** | — | 0.88 (0.39–1.97) | 0.758 |

> Reference: No decision-making autonomy. Adjusted for: women's age, education, maternal employment, religion, administrative division, age at first birth, age at cohabitation, number of children, pregnancy status, pregnancy loss, place of residence, toilet facilities, water access, household head sex, household size, wealth status, media access, internet use, household assets, and household materials.

### Spatial Findings

| Region | Depression | Autonomy |
|:-------|:----------:|:--------:|
| **Maseru, Berea, Leribe, Butha-Buthe** (central–north) |  Highest | Relatively higher |
| **Quthing, Qacha's Nek, Mohale's Hoek, Mafeteng** (south/south-west) |  Lower |  Lowest |
| **Thaba-Tseka, Mokhotlong** | Lower burden | Moderate |

### Model Performance

| Metric | Value | Interpretation |
|:-------|:-----:|:--------------|
| AUC | **0.6781** | Moderate discriminative ability |
| Hosmer–Lemeshow χ² | **5.85** | — |
| Hosmer–Lemeshow p | **0.6642** | Good model fit |
| AIC | **1648.22** | Final model selection |
| BIC | **1886.15** | Final model selection |
| Mean VIF | **2.2** | No significant multicollinearity |

---


## Figures & Visual Outputs

Figures associated with the published analysis include the following outputs described in the supplied README. Locate them within [`03_Outputs/`](03_Outputs/) and confirm filenames after reorganization.

| Figure | Description | Original filename |
|---|---|---|
| Depression prevalence map | District-level geographical variation in depressive symptoms | `Rplot01.tiff` |
| Decision-making autonomy map | District-level autonomy patterns | `Rplot02.tiff` |
| Published figure 3 | Journal figure | `Figure 3.tif` |
| Published figure 4 | Journal figure | `Figure 4.tif` |
| Supplementary image | Additional graphical output | `Picture5.tif` |
| Graphical abstract | Visual summary of the study | `Graphical_abstract.pdf` |

Publisher-created images or proofs should only be redistributed when allowed by their applicable licenses.


## Reproducibility

The analysis workflow documented in the supplied README comprises the following stages:

1. **Data preparation (Stata):** clean and recode LDHS variables, construct PHQ-9 and decision-making autonomy measures, and configure survey design settings.
2. **Statistical analysis (Stata):** generate weighted descriptive estimates, bivariate comparisons, national and rural/urban stratified logistic regression models, and model diagnostics.
3. **Spatial analysis:** create district-level geographic summaries and visual outputs using the scripts and supporting resources available in the code directory.
4. **Verification:** compare reproduced tables, figures, and estimates with those reported in the published article.

**Code location:** [`01_Code/Stata/`](01_Code/Stata/)

The original scripts were named `Data management.do`, `Analysis.do`, and `Spatials.do`. Verify their current filenames and paths inside `01_Code/Stata/` before running them. In particular, do not assume that `Spatials.do` is an R script solely because spatial figures were produced with R-related tooling.

**Data:** LDHS 2023–2024 individual-level microdata require authorized access through the [DHS Program](https://dhsprogram.com/data/). Obtain the appropriate files independently and keep them outside public version control. Update local paths in the `.do` scripts as needed.

**Software:** Stata and, where used for spatial graphics, R with the packages referenced in the actual scripts. The precise versions and dependencies should be verified from the code and environment before reproducing the results.

**Reproducibility status:** Research scripts and documentation are presented for inspection; the current README does **not** claim that an automated end-to-end reproduction has been independently verified.


## Data Availability Statement

The study analyzes data from the **Lesotho Demographic and Health Survey (LDHS) 2023–2024**. The survey documentation is available via the [DHS Program](https://dhsprogram.com/), and access to individual-level datasets is controlled by the DHS Program's applicable data-use terms.

**Restricted microdata should not be redistributed through this public repository without explicit authorization.** A Stata file previously identified as `clean_data_emp.dta` appeared in an earlier repository listing. If it contains individual-level DHS records, it should be removed from current public access **and from Git history**, not merely excluded through `.gitignore`. See [`02_Data/`](02_Data/) for data access documentation.

Aggregated, non-disclosive research outputs may be shared when permitted by the relevant source and publication licenses.


## Ethical Considerations

This study is a secondary analysis of de-identified, publicly available survey data. The original LDHS 2023–24 fieldwork received ethical clearance from the relevant Lesotho institutional review authority and the ICF International Institutional Review Board, in line with DHS Program protocols; all respondents provided informed consent prior to interview. No additional ethical approval was required for this secondary analysis. *(Please cross-check this statement against the exact wording in the published article's Ethics section.)*


## Funding & Conflict of Interest

This secondary data analysis was conducted without dedicated external project funding, consistent with typical DHS-based academic secondary analyses. The authors declare no competing interests. *(Confirm against the Funding and Declaration of Competing Interest statements in the final published article.)*

---


## Strengths & Limitations

| Strengths | Limitations |
|:----------|:-------------|
| Nationally representative sample with survey-weighted design | Cross-sectional design precludes causal inference |
| Study examining autonomy, depression, and rural–urban strata in Lesotho | PHQ-9 is a screening tool, not a clinical diagnostic instrument |
| District-level spatial mapping adds geographic granularity absent from most DHS mental health studies | Self-reported measures of autonomy and depressive symptoms may be subject to social desirability bias |
| STROBE-compliant reporting and transparent, reproducible Stata/R pipeline | Residual confounding from unmeasured psychosocial or genetic factors cannot be excluded |
| Reproducible analysis code and organized publication documentation | Moderate model discrimination (AUC = 0.68) indicates room for additional predictors |

---


## Related Work from the Author

Part of a broader multi-country DHS research program on women's empowerment and mental health led by Md Salek Miah:

| Study | Country / Data | Focus |
|:------|:----------------|:------|
| BMC Women's Health (Springer Nature) | Multi-country DHS | Women's health and empowerment indicators |
| Health Science Reports (Wiley) | Nepal DHS | Water, handwashing, and early childhood education |
| Cambridge Prisms: Global Mental Health | Zambia DHS | Intimate partner violence and mental health |
| **This study** — Journal of Affective Disorders Reports (Elsevier) | Lesotho LDHS 2023–24 | Decision-making autonomy and depression, rural–urban strata |

---


## Research Impact

| Domain | Contribution |
|:-------|:-------------|
| **Mental Health** | Study assessing associations between decision-making autonomy to depression with rural–urban stratification in Lesotho using nationally representative DHS data |
| **Public Health** | Evidence for SDG 3 — Good Health and Well-Being; SDG 5 — Gender Equality |
| **Women's Health** | Identifies autonomy as a modifiable protective factor for rural women's mental health |
| **Health Policy** | Actionable district-level evidence for targeted mental health resource allocation |
| **Methodology** | Survey-weighted multivariable regression + spatial mapping; STROBE-compliant |
| **Equity** | Exposes geographic (central–north vs. south) and rural–urban inequalities in mental health burden |
| **Open Science** | Organized documentation of the manuscript and publication workflow; confidential correspondence retained privately |

---


## Policy Implications

1. **Consider supporting rural women** through decision-making autonomy programs — the estimated association is strongest (AOR = 0.44) in rural settings where structural barriers are greatest
2. **Target central–northern districts** (Maseru, Berea, Leribe, Butha-Buthe) with expanded mental health services and community awareness
3. **Address urban stressors** — economic insecurity and social isolation may undermine the protective role of autonomy in urban areas
4. **Integrate empowerment strategies** into maternal and reproductive health programs across both rural and urban contexts
5. **Prioritize southern/south-western districts** (Quthing, Qacha's Nek, Mohale's Hoek, Mafeteng) for women's empowerment interventions, given the lowest autonomy levels observed
6. **Context-sensitive approaches** — associations differ by residence type; one-size-fits-all policies are insufficient

---


## Citation

**Suggested article citation**

Miah, M. S., & Kabir, M. B. (2026). Decision-making autonomy and depressive symptoms among women in Lesotho: Rural–urban differences. *Journal of Affective Disorders Reports*, Article 101080. https://doi.org/10.1016/j.jadr.2026.101080

```bibtex
@article{miah_kabir_lesotho_2026,
  author  = {Miah, Md Salek and Kabir, Maria Bintey},
  title   = {Decision-Making Autonomy and Depressive Symptoms Among Women in Lesotho: Rural--Urban Differences},
  journal = {Journal of Affective Disorders Reports},
  year    = {2026},
  pages   = {101080},
  doi     = {10.1016/j.jadr.2026.101080},
  url     = {https://doi.org/10.1016/j.jadr.2026.101080}
}
```


## Acknowledgments

The authors thank the DHS Program and USAID for public access to the Lesotho DHS 2023–24 data, and the editorial team and anonymous reviewers at the *Journal of Affective Disorders Reports* for their constructive feedback during peer review.

---


## License

The repository contains an [MIT License](LICENSE) for software contributions to which the author(s) hold the relevant rights. This license **does not supersede** DHS data access restrictions, third-party copyright, journal publication terms, or confidential editorial correspondence. Cite the [published article](https://doi.org/10.1016/j.jadr.2026.101080) when drawing on its findings.


---

**Corresponding author:** Md Salek Miah · Department of Statistics, Shahjalal University of Science and Technology (SUST), Bangladesh  
**Research portfolio:** https://salek-prot.vercel.app/  
**Google Scholar:** https://scholar.google.com/citations?user=oV99NYoAAAAJ  
**ORCID:** https://orcid.org/0009-0005-5973-461X  
**Research education:** https://www.youtube.com/@SalekResearch
