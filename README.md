# Rural–Urban Inequalities in Depression among Ever-Married Women in Lesotho

<div align="center">

[![License](https://img.shields.io/badge/License-MIT-e11d48?style=for-the-badge&labelColor=0f0f0f&logo=opensourceinitiative&logoColor=e11d48)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Under%20Review-f59e0b?style=for-the-badge&labelColor=0f0f0f)](https://github.com)
[![Journal](https://img.shields.io/badge/Output-Q1%20Journal%20Ready-6366f1?style=for-the-badge&labelColor=0f0f0f)](https://github.com)
[![N](https://img.shields.io/badge/Sample-3%2C297%20Women-10b981?style=for-the-badge&labelColor=0f0f0f)](https://github.com)
[![Country](https://img.shields.io/badge/Country-Lesotho-0ea5e9?style=for-the-badge&labelColor=0f0f0f)](https://github.com)

</div>

<div align="center">

![Stata](https://img.shields.io/badge/Stata-1A478B?style=flat-square&logo=stata&logoColor=white)
![DHS](https://img.shields.io/badge/DHS_2023--24-USAID%20Funded-00d4ff?style=flat-square&logoColor=white)
![PHQ-9](https://img.shields.io/badge/Tool-PHQ--9%20Scale-e11d48?style=flat-square&logoColor=white)
![Design](https://img.shields.io/badge/Design-Cross--Sectional-f59e0b?style=flat-square&logoColor=white)
![Analysis](https://img.shields.io/badge/Analysis-Multivariable%20Logistic-10b981?style=flat-square&logoColor=white)
![Spatial](https://img.shields.io/badge/Mapping-District--Level%20Spatial-6366f1?style=flat-square&logoColor=white)

</div>

---

<div align="center">

```
╔══════════════════════════════════════════════════════════════════════════╗
║  🧠  3,297 Ever-Married Women  ·  Lesotho  ·  2023–24 DHS  ·  USAID   ║
║  📍  Rural–Urban Stratified Analysis  ·  10 Districts  ·  PHQ-9        ║
║  📊  Prevalence: 7.0%  ·  AUC: 0.676  ·  H-L p = 0.732               ║
╚══════════════════════════════════════════════════════════════════════════╝
```

</div>

---

## 📄 Publication Details

> **Rural–Urban Inequalities in Depression among Ever-Married Women in Lesotho: Evidence from the 2023–24 Demographic and Health Survey**

**Authors:** Md Salek Miah<sup>a*</sup> · Maria Bintey Kabir<sup>b,c</sup>

<sup>a</sup> Department of Statistics, Shahjalal University of Science & Technology (SUST), Sylhet-3114, Bangladesh
<sup>b</sup> Shaheed Suhrawardy Medical College, Dhaka-1207, Bangladesh
<sup>c</sup> Study Physician, Projahnmo Research Foundation, Dhaka-1213, Bangladesh

---

## Overview

This study investigates **rural–urban inequalities in depression** among ever-married women in Lesotho using data from the nationally representative **Lesotho Demographic and Health Survey (LDHS) 2023–24**, funded by USAID. Depression was assessed using the **Patient Health Questionnaire-9 (PHQ-9)**, and **survey-weighted stepwise multivariable logistic regression** was used to identify determinants, with stratified analyses for rural and urban women.

**Analysis Pipeline:**

```
LDHS 2023–24  (Cross-Sectional · Nationally Representative · USAID-Funded)
          │
          │  3,297 ever-married women aged 15–49 years
          │  10 districts · Rural & Urban strata
          ▼
   Data Management      cleaning · recoding · survey weighting · PHQ-9 scoring
   (Stata)              married women · complete depression & covariate data
          │
          ▼
   Descriptive Stats    prevalence estimation · district-level breakdown
                        rural vs urban stratification
          │
          ▼
   Spatial Mapping      district-level depression prevalence maps
   (R / ggplot2)        decision autonomy spatial figures
          │
          ▼
   Regression Analysis  survey-weighted stepwise multivariable logistic regression
                        national · rural-stratified · urban-stratified models
          │
          ▼
   Model Assessment     AUC · Hosmer–Lemeshow goodness-of-fit
          │
          ▼
   Outputs              TIFF spatial figures · adjusted ORs · policy brief
```

---

## Abstract

### Objective
To assess the key influencing risk factors of depression with rural–urban inequalities among ever-married women in Lesotho.

### Methods
This study analyzed cross-sectional data from **3,297 ever-married women** from the Lesotho Demographic and Health Survey (LDHS) 2023–24. Depression was evaluated using the **Patient Health Questionnaire-9 (PHQ-9)**. Survey-weighted stepwise multivariable logistic regression was conducted to identify factors associated with depression, with stratified analyses for rural and urban areas.

### Results

**Nationally:**
- Older age (45–49 years) was associated with **lower odds** of depression (aOR = 0.28; 95% CI: 0.10–0.76)
- High parity (≥3 children) was associated with **higher odds** (aOR = 2.49; 95% CI: 1.04–5.93)
- Lower odds observed in Mohale's Hoek (OR = 0.42; 95% CI: 0.19–0.94) and Mokhotlong (OR = 0.33; 95% CI: 0.15–0.74) vs. Maseru

**Among Rural Women**, protective factors included:
- Older age
- Late cohabitation (18–20 years: OR = 0.34; 95% CI: 0.16–0.72; ≥21 years: OR = 0.36; 95% CI: 0.17–0.75)
- Maternal employment (OR = 0.48; 95% CI: 0.27–0.83)
- Residence in Mafeteng, Mokhotlong, or Thaba-Tseka

**Among Urban Women**, significant factors included:
- Early sexual debut → increased depression risk
- Late sexual debut ≥18 years (OR = 0.51; 95% CI: 0.29–0.91) → protective
- High parity → increased risk
- Justification of IPV (OR = 0.45; 95% CI: 0.22–0.94)
- Access to improved water (OR = 5.59; 95% CI: 1.42–21.99)
- Improved household materials (OR = 0.15; 95% CI: 0.04–0.50) → protective

### Conclusions
Depression affects approximately **one in fourteen ever-married women** in Lesotho, with significant variation by age, parity, residence, and geography. Targeted mental health interventions are needed for high-risk groups — particularly women with high parity, early sexual debut, and those residing in urban or central-northern districts.

**Keywords:** Maternal Mental Health · Depression · Rural-Urban Health Disparities · Socioeconomic Inequalities · Lesotho

---

## ✨ Key Highlights

> 🔵 **7%** of ever-married women showed depression nationally

> 🔴 Highest depression prevalence in **Berea, Maseru, Leribe, and Butha-Buthe** districts

> 📈 Final model: **AUC = 0.676** (moderate discriminative ability) · **Hosmer–Lemeshow p = 0.732** (good fit)

> 🌍 Significant **rural–urban stratification** in determinants — risk factors differ meaningfully by residence type

> 👶 **High parity (≥3 children)** strongly associated with increased depression odds nationally

---

## Authors

### Corresponding Author

**Md Salek Miah**
Research Assistant, Department of Statistics
Shahjalal University of Science and Technology (SUST), Sylhet-3114, Bangladesh
📍 Sylhet, Bangladesh
📞 +8801687831074
📧 [saleksta@gmail.com](mailto:saleksta@gmail.com) · [2021134066@student.sust.edu](mailto:2021134066@student.sust.edu)
[![ORCID](https://img.shields.io/badge/ORCID-0009--0005--5973--461X-A6CE39?style=flat-square&logo=orcid&logoColor=white)](https://orcid.org/0009-0005-5973-461X)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Md_Salek_Miah-0077B5?style=flat-square&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/md-salek-miah-b34309329/)

### Co-Author

**Maria Bintey Kabir**
Shaheed Suhrawardy Medical College, Dhaka-1207, Bangladesh
Study Physician, Projahnmo Research Foundation, Dhaka-1213, Bangladesh

---

## Study Design & Data Source

### Survey Overview

This study used secondary data from the **Lesotho Demographic and Health Survey (LDHS) 2023–24** — a **cross-sectional, nationally representative** survey funded by **USAID** via the DHS Program. The survey was conducted in partnership with the Lesotho Ministry of Health, using standardized structured questionnaires administered by trained interviewers across all 10 districts.

| Field | Details |
|:------|:--------|
| 📅 **Survey Year** | 2023–24 |
| 🌍 **Country** | Lesotho |
| 🔗 **Source** | [DHS Program — USAID Funded](https://dhsprogram.com) |
| 📄 **Survey Report** | FR391.pdf (included in repository) |
| 👩 **Sample (n)** | **3,297** ever-married women |
| 🏥 **Depression Tool** | Patient Health Questionnaire-9 (PHQ-9) |
| 📐 **Design** | Cross-sectional · multi-stage cluster sampling |
| 🗺️ **Coverage** | 10 districts · National |

> **Note:** Raw DHS microdata requires free registration at [dhsprogram.com](https://dhsprogram.com). The cleaned Stata dataset (`clean_data_emp.dta`) used in this analysis is freely available in this repository.

### Study Population & Eligibility

```
Target Population
      │
      ├─ Ever-married women of reproductive age: 15–49 years
      ├─ Resident in Lesotho at the time of the 2023–24 DHS
      └─ Inclusion: Complete data on depression (PHQ-9) & key covariates

                         ↓  After data management & survey weighting

              ┌──────────────────────────────────────────┐
              │   Final Sample: n = 3,297 Women          │
              ├──────────────────┬───────────────────────┤
              │  🌾 Rural        │   Stratified analysis  │
              │  🏙️ Urban        │   Stratified analysis  │
              │  📍 10 Districts │   Spatial mapping      │
              └──────────────────┴───────────────────────┘
```

---

## Repository Structure

```
Rural-Urban-Inequalities-in-Depression-among-Ever-Married-Women-in-Lesotho/
│
├── README.md
│
├── Data management.do          ← Data cleaning · recoding · PHQ-9 scoring · labeling
├── Analysis.do                 ← Survey-weighted logistic regression · stratified models
├── Spatials.do                 ← District-level spatial mapping code
│
├── clean_data_emp.dta          ← Cleaned Stata dataset (analysis-ready)
│
├── Rplot01.tiff                ← Depression prevalence spatial figure (300 DPI)
├── Rplot02.tiff                ← Decision autonomy prevalence spatial figure (300 DPI)
│
├── FR391.pdf                   ← LDHS 2023–24 official survey report
│
├── .gitignore
└── LICENSE                     ← MIT License
```

---

## Key Variables & Measurement

| Variable | Type | Measurement |
|:---------|:-----|:------------|
| **Depression** | Binary outcome | PHQ-9 ≥ 10 = depressed |
| **Residence** | Stratifier | Rural / Urban |
| **Maternal age** | Categorical | 15–19, 20–24, ..., 45–49 years |
| **Parity** | Categorical | 0, 1–2, ≥3 children |
| **Age at cohabitation** | Categorical | <18, 18–20, ≥21 years |
| **Sexual debut age** | Categorical | Early (<18) vs. late (≥18) |
| **Employment status** | Binary | Employed / Not employed |
| **IPV justification** | Binary | Yes / No |
| **Water source** | Binary | Improved / Unimproved |
| **Household materials** | Binary | Improved / Unimproved |
| **District** | Categorical | 10 districts (ref: Maseru) |

---

## Statistical Methods

| Step | Method |
|:-----|:-------|
| **Prevalence estimation** | Survey-weighted proportions with 95% CI |
| **Spatial analysis** | District-level choropleth mapping (R) |
| **Regression** | Survey-weighted stepwise multivariable logistic regression |
| **Stratification** | Rural vs. Urban separate models |
| **Model fit** | Hosmer–Lemeshow goodness-of-fit test |
| **Discrimination** | Area Under the ROC Curve (AUC) |
| **Effect measure** | Adjusted odds ratios (aOR) with 95% CI |
| **Software** | Stata · R (ggplot2 / spatial packages) |

---

## Key Results Summary

### National-Level Model

| Factor | Direction | aOR (95% CI) |
|:-------|:---------:|:------------:|
| Age 45–49 years | ↓ Protective | 0.28 (0.10–0.76) |
| Parity ≥3 children | ↑ Risk | 2.49 (1.04–5.93) |
| Mohale's Hoek district | ↓ Protective | 0.42 (0.19–0.94) |
| Mokhotlong district | ↓ Protective | 0.33 (0.15–0.74) |

### Rural-Stratified Model

| Factor | Direction | OR (95% CI) |
|:-------|:---------:|:-----------:|
| Older age | ↓ Protective | — |
| Cohabitation 18–20 yrs | ↓ Protective | 0.34 (0.16–0.72) |
| Cohabitation ≥21 yrs | ↓ Protective | 0.36 (0.17–0.75) |
| Maternal employment | ↓ Protective | 0.48 (0.27–0.83) |

### Urban-Stratified Model

| Factor | Direction | OR (95% CI) |
|:-------|:---------:|:-----------:|
| Late sexual debut ≥18 yrs | ↓ Protective | 0.51 (0.29–0.91) |
| IPV justification | ↓ Protective | 0.45 (0.22–0.94) |
| Improved water access | ↑ Risk | 5.59 (1.42–21.99) |
| Improved household materials | ↓ Protective | 0.15 (0.04–0.50) |

### Model Performance

| Metric | Value | Interpretation |
|:-------|:-----:|:--------------|
| AUC | **0.676** | Moderate discriminative ability |
| Hosmer–Lemeshow p | **0.732** | Good model fit |
| Overall depression prevalence | **~7%** | ≈ 1 in 14 ever-married women |

---

## Spatial Figures

| Figure | Description | File |
|:-------|:------------|:-----|
| 🗺️ Depression Prevalence Map | District-level choropleth: highest in Berea, Maseru, Leribe, Butha-Buthe | `Rplot01.tiff` |
| 🗺️ Decision Autonomy Map | District-level spatial distribution of decision autonomy | `Rplot02.tiff` |

---

## Research Impact

| Domain | Contribution |
|:-------|:-------------|
| **Mental Health** | First rural–urban stratified analysis of depression in Lesotho using DHS |
| **Public Health** | Evidence for SDG 3 — Good Health and Well-Being |
| **Women's Health** | Targets ever-married women, a priority but under-researched group |
| **Health Policy** | Actionable insights for district-targeted mental health programs |
| **Methodology** | Survey-weighted regression with spatial mapping for LMIC context |
| **Equity** | Exposes geographic and socioeconomic inequalities in mental health |

---

## Policy Implications

1. **Targeted interventions** for women with high parity (≥3 children) — the strongest modifiable risk factor nationally
2. **Urban-specific programs** addressing early sexual debut and IPV as depression drivers
3. **Rural employment support** for women — maternal employment significantly protective in rural areas
4. **District prioritization**: Berea, Maseru, Leribe, and Butha-Buthe require urgent mental health resources
5. **Water & housing** quality improvements in urban areas may have mental health co-benefits

---

## Citation

```bibtex
@article{miah_kabir_depression_lesotho_2025,
  title   = {Rural--Urban Inequalities in Depression among Ever-Married Women in
             Lesotho: Evidence from the 2023--24 Demographic and Health Survey},
  author  = {Miah, Md Salek and Kabir, Maria Bintey},
  journal = {[Journal Name]},
  year    = {2025},
  note    = {Q1 Journal Submission},
  url     = {https://github.com/muhammadsalek/Rural-Urban-Inequalities-in-Depression-among-Ever-Married-Women-in-Lesotho}
}
```

---

## License

MIT License — Copyright (c) 2025 Md Salek Miah & Maria Bintey Kabir
Open for academic research. Citation required for publication use.

---

<div align="center">

**Department of Statistics · Shahjalal University of Science and Technology (SUST)**
Sylhet-3114, Bangladesh

[![Made with Stata](https://img.shields.io/badge/Made%20with-Stata-1A478B?style=flat-square&logoColor=white)](https://www.stata.com)
[![PHQ-9](https://img.shields.io/badge/Depression%20Tool-PHQ--9-e11d48?style=flat-square)](https://www.phqscreeners.com)
[![DHS Program](https://img.shields.io/badge/Data-DHS%20Program%20%7C%20USAID-00d4ff?style=flat-square)](https://dhsprogram.com)
[![Spatial](https://img.shields.io/badge/Spatial%20Analysis-R%20%2F%20ggplot2-276DC3?style=flat-square&logo=r&logoColor=white)](https://www.r-project.org)
[![SUST](https://img.shields.io/badge/University-SUST%20Bangladesh-f59e0b?style=flat-square)](https://www.sust.edu)

*⭐ Star this repository if it supported your research!*

</div>
