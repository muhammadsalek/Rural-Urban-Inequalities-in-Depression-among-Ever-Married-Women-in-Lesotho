
clear all 
set maxvar 30000
use "D:\Research\BDHS Research\Mental Health\Lestho\data\LSIR81DT\LSIR81FL.DTA", clear













***-------------------------------------------------------------
// Sampling weight
*Since DHS follws stratified sampling we need to apply survey weigth, primary sampling unit (V021), and sampling strata (V022).
*In DHS we need to create Weight variable first, following this formula:
***-------------------------------------------------------------
gen WGT=(v005/1000000)

*Now we will label this variable 

label variable WGT "Survey Weight"
svyset [pw=WGT],psu(v021) strata(v022)

** Note: We'll use survey weight in our final regression model (at the end). 
** In the variable selection process, we'll go without sampling weight for simplicity

**************************************************************
* Ever-Married Indicator based on v020
* v020 = 0 → all-woman sample
* v020 = 1 → ever-married sample
**************************************************************

gen ever_married = .
replace ever_married = 1 if v020 == 1
replace ever_married = 0 if v020 == 0

label define yesno 0 "No" 1 "Yes"
label values ever_married yesno
label variable ever_married "Ever Married (1=Yes, 0=No)"

tab ever_married



**************************************************************
* Outcome Variables: Depression and Anxiety
**************************************************************

gen depression_cat = .
replace depression_cat = 1 if mth22 >= 10 & mth22 <= 27
replace depression_cat = 0 if mth22 < 10 & !missing(mth22)

label values depression_cat yesno
label variable depression_cat "Depression (PHQ-9 ≥10 = Yes)"

tab depression_cat, missing


svy: tab depression_cat




tab depression_cat





* Drop observations where depression is missing
drop if missing(depression_cat)









*** 1. INDIVIDUAL-LEVEL SOCIODEMOGRAPHIC VARIABLES ***
* Age Group recoding and labeling with missing handling

gen women_age = .
replace women_age = 1 if inrange(v012, 15, 19)
replace women_age = 2 if inrange(v012, 20, 24)
replace women_age = 3 if inrange(v012, 25, 29)
replace women_age = 4 if inrange(v012, 30, 34)
replace women_age = 5 if inrange(v012, 35, 39)
replace women_age = 6 if inrange(v012, 40, 44)
replace women_age = 7 if inrange(v012, 45, 49)

label define agegroup 1 "15–19" 2 "20–24" 3 "25–29" 4 "30–34" 5 "35–39" 6 "40–44" 7 "45–49", replace
label values women_age agegroup

tab women_age





* Create categories for age at first birth
gen age_first_birth_cat = .

* Define categories
replace age_first_birth_cat = 1 if inrange(v212, 10, 17)   // Early first birth
replace age_first_birth_cat = 2 if inrange(v212, 18, 24)   // Normal first birth
replace age_first_birth_cat = 3 if v212 >= 25              // Late first birth

* Assign value labels
label define age_first_birth_lbl 1 "10-17 (Early)" 2 "18-24 (Normal)" 3 "≥25 (Late)", replace
label values age_first_birth_cat age_first_birth_lbl

* Label variable
label variable age_first_birth_cat "Age at First Birth"

* Check distribution
tab age_first_birth_cat

/*
Conde-Agudelo A, Belizán JM. Maternal age and risk of adverse pregnancy outcomes: a systematic review. Lancet. 2000; 356: 3–8.

Yaya S et al., BMC Pregnancy and Childbirth, 2018;18:1–12.
*/








* Create new binary variable for age at first sex
gen age_first_sex= . 

* 0 = <18 years
replace age_first_sex = 0 if v525 < 18

* 1 = >=18 years
replace age_first_sex = 1 if v525 >= 18

* Add labels
label define sexage_lbl 0 "<18 years" 1 "≥18 years"
label values age_first_sex sexage_lbl

* Check the variable
tab age_first_sex, missing












tab v511 // Age at cohabitation
describe v511
codebook v511


* Create new categorical variable for age at first cohabitation
generate age_cohab_cat = .

* Recode into categories
replace age_cohab_cat = 0 if v511 < 18          // young
replace age_cohab_cat = 1 if v511 >= 18 & v511 <= 20   // mild
replace age_cohab_cat = 2 if v511 >= 21         // older

* Add value labels
label define agecohab_label 0 "Young (<18)" 1 "Mild (18-20)" 2 "Older (21+)"
label values age_cohab_cat agecohab_label

* Check the distribution
tab age_cohab_cat







* Woman's Education
gen education_woman = .
replace education_woman = 0 if v106 <= 1
replace education_woman = 1 if v106 == 2
replace education_woman = 2 if v106 >= 3
label define edu_lbl 0 "No/Primary" 1 "Secondary Incomplete" 2 "Secondary+"
label values education_woman edu_lbl

tab education_woman








tab v714 // Employment status of woman
describe v714
codebook v714


* Create a new variable with clear name
generate maternal_employment = .

* Recode the original variable
replace maternal_employment = 0 if v714 == 0   // Not working
replace maternal_employment = 1 if v714 == 1   // Currently working

* Add value labels
label define maternal_employment_label 0 "Not working" 1 "Currently working"
label values maternal_employment maternal_employment_label

* Check the distribution
tab maternal_employment










*------------------------------------------------------------
* Create binary variable for antenatal care visits (ANC_visits)
*------------------------------------------------------------

* Clean special or missing codes if any
replace m14_1 = . if m14_1 >= 97   // DHS missing codes (97, 98, 99)

* Generate new variable
gen ANC_visit = .
label variable ANC_visit "Adequate ANC visits (4 or more)"

* Categorize:
* 0 = less than 4 ANC visits (including don't know and missing)
* 1 = 4 or more ANC visits
replace ANC_visit = 0 if m14_1 < 4 | m14_1 == 98 | m14_1 == . 
replace ANC_visit = 1 if m14_1 >= 4 & m14_1 < .

* Add labels
label define ANC_lbl 0 "<4" ///
                    1 ">=4"
label values ANC_visit ANC_lbl

* Check
tab ANC_visit, missing









* Number of Living Children with missing handling
tab v128
gen num_children = .
replace num_children = 0 if v218 == 0
replace num_children = 1 if inrange(v218, 1, 2)
replace num_children = 2 if v218 >= 3 & v218 != .

label define child_lbl 0 "None" 1 "1–2" 2 "3+", replace
label values num_children child_lbl

tab num_children






*------------------------------------------------------------
* Create binary variable for birth size
*------------------------------------------------------------
gen birth_size = .

* 0 = Smaller than average / very small / don't know / missing
replace birth_size = 0 if inlist(m18_1, 4,5,8) | missing(m18_1)

* 1 = Average or larger
replace birth_size = 1 if inlist(m18_1, 1,2,3)

* Add labels
label define bsize_lbl 0 "Small / Unknown" 1 "Average or Large"
label values birth_size bsize_lbl

* Check
tab birth_size, missing















* Create binary variable
gen preterm_birth = 0

* Define preterm births (<9 months)
replace preterm_birth = 1 if b20_01 < 9

* Label variable
label variable preterm_birth "Preterm birth (0=Term, 1=Preterm)"

* Label values
label define preterm_birth_lbl 0 "Term (>=9 months)" 1 "Preterm (<9 months)", replace
label values preterm_birth preterm_birth_lbl

* Check distribution
tab preterm_birth



* Recode v213 to a new variable called currently_pregnant
tab v213

gen currently_pregnant = .
replace currently_pregnant = 0 if v213 == 0    // no or unsure
replace currently_pregnant = 1 if v213 == 1    // yes

* Label the new variable
label define preg_lbl 0 "No or unsure" 1 "Yes"
label values currently_pregnant preg_lbl

* Add a variable label
label variable currently_pregnant "Currently pregnant status"


tab currently_pregnant








* Create binary variable
gen pregnancy = 0

* Define multiple pregnancies
replace pregnancy = 1 if p0_01 >= 2

* Label variable
label variable pregnancy "Multiple pregnancy (0=Single, 1=Multiple)"

* Label values
label define pregnancy_lbl 0 "Single pregnancy" 1 "Multiple pregnancy", replace
label values pregnancy pregnancy_lbl

* Check distribution
tab pregnancy






* pregnent
rename v636 pressure_to_pregnant

tab pressure_to_pregnant





*To categorize v245 (pregnancy losses)
gen preg_loss_cat = .
replace preg_loss_cat = 0 if v245 == 0
replace preg_loss_cat = 1 if v245 == 1
replace preg_loss_cat = 2 if v245 >= 2

label define preg_loss_lbl 0 "None" 1 "One loss" 2 "Two or more losses"
label values preg_loss_cat preg_loss_lbl
tab preg_loss_cat

 
 





* Recode v504 to a new variable called residing_with

tab v504
gen residing_status = .
replace residing_status = 1 if v504 == 1
replace residing_status = 0 if inlist(v504, 2, 3)

label define residing_status_lbl 0 "Not residing with husband/partner" 1 "Residing with husband/partner"
label values residing_status residing_status_lbl
label variable residing_status "Current residence status with husband/partner"

tab residing_status


 tab v406 // abstainng
 

 
* Create binary variable: 1 = Yes, 0 = No
gen currently_abstaining = .
replace currently_abstaining = 1 if v406 == 1
replace currently_abstaining = 0 if v406 == 0

* Define and assign value labels
label define abstain_lbl 0 "No" 1 "Yes"
label values currently_abstaining abstain_lbl

* Label the variable for publication
label variable currently_abstaining "Currently abstaining from sexual intercourse (Yes=1, No=0)"

* Check the result
tab currently_abstaining
 
 tab v503 // কয়বার বিবাহ/দাম্পত্য সম্পর্ক

* Create a binary variable: 0 = once, 1 = more than once
gen number_of_unions = .
replace number_of_unions = 0 if v503 == 1
replace number_of_unions = 1 if v503 > 1

* Define value labels
label define union_lbl 0 "Once" 1 "More than once"

* Assign value labels
label values number_of_unions union_lbl

* Label the variable for publication
label variable number_of_unions "Number of marital unions (Once = 0, More than once = 1)"

* Tabulate to confirm
tab number_of_unions

 
 
 
 
 
 
 

* Generate a new variable menstruated_last6wks
gen menstruated_last6wks = .
replace menstruated_last6wks = 1 if v216 == 1   // yes
replace menstruated_last6wks = 0 if v216 == 0   // no

* Label the new variable values
label define menses_lbl 0 "No" 1 "Yes"
label values menstruated_last6wks menses_lbl

* Label the variable
label variable menstruated_last6wks "Menstruated in last six weeks"

* Check the recoded variable with a tabulation
tab menstruated_last6wks



*Empowerment Index
gen emp_health = inlist(v743a, 1, 2)   // respondent alone or joint
gen emp_purchase = inlist(v743b, 1, 2)
gen emp_money = inlist(v743f, 1, 2)
gen emp_visit = inlist(v743d, 1, 2)
gen emp_fp = inlist(v632, 1, 3)        // respondent or joint decision

* Composite empowerment score
gen emp_score = emp_health + emp_purchase + emp_money + emp_visit + emp_fp



gen emp_level = .
replace emp_level = 0 if emp_score <= 2   // No
replace emp_level = 1 if emp_score >= 3   // Yes
label define emp_lbl 0 "No" 1 "Yes"
label values emp_level emp_lbl

tab emp_level // Yes" (empowered) ,"No" (not empowered)



















/*

* IPV
 tab v744a
 tab v744b
 tab v744c
 tab v744d
 tab v744e
 
 * Recode "don't know" (usually coded as 2) to missing for each IPV justification question
foreach var in v744a v744b v744c v744d v744e {
    replace `var' = . if `var' == 2
}

* Generate IPV justification binary variable:
* 1 = Justifies beating in at least one condition
* 0 = Does NOT justify beating in any condition
gen ipv_justified = 0
replace ipv_justified = 1 if v744a == 1 | v744b == 1 | v744c == 1 | v744d == 1 | v744e == 1

* Label the variable for publication
label define ipv_lbl 0 "Does not justify IPV" 1 "Justifies IPV"
label values ipv_justified ipv_lbl
label variable ipv_justified "Justification of intimate partner violence (any condition)"

* Tabulate the new variable
tab ipv_justified, missing

 

*/
 
 
 
*------------------------
* Environmental / Household
*------------------------

tab v116 // toilet
tab v113 // water_source


tab v116
describe v116
codebook v116







* Create binary variable
gen toilet = .

* Recode improved facilities
replace toilet = 1 if inlist(v116, 11,12,13,14,21,22)  

* Recode all other facilities as unimproved (include previously uncoded categories)
replace toilet = 0 if !missing(v116) & toilet==.

* Label variable
label variable toilet"Type of toilet facility (Improved/Unimproved)"

* Label values
label define toilet_lbl 0 "Unimproved" 1 "Improved", replace
label values toilet toiletlbl

* Check distribution
tab toilet



tab v113
describe v113
codebook v113




* Create binary variable
gen water = .

* Recode improved water sources
replace water = 1 if inlist(v113, 11,12,13,14,21,31,41,51)  

* Recode all other sources as unimproved (except missing)
replace water = 0 if !missing(v113) & water==.

* Label variable
label variable water "Source of drinking water (Improved/Unimproved)"

* Label values
label define waterlbl 0 "Unimproved" 1 "Improved", replace
label values water water_lbl

* Check distribution
tab water

 
 
*******Another confounder****

* Place of residence/area (v025)
rename v025 area
tab area, mis

label define area_label 1 "Urban" 2 "Rural"
label values area area_label
tabulate area

* Division (v024)
rename v024 hh_division
tab hh_division, mis


* Religion (v130)
* Step 1: Generate binary religion variable
* Drop existing variable if it exists






**************************************************************
* Collapse religion (v130) into 5 categories → religion_bin
**************************************************************



tab v130
describe v130
codebook v130




* Step 1: Create binary variable called religion_bin
generate religion_bin = 0

* Step 2: Assign 1 for Roman Catholic
replace religion_bin = 1 if v130 == 1

* Step 3: Add value labels (optional, for clarity)
label define religion_lbl 0 "Other" 1 "Roman Catholic"
label values religion_bin religion_lbl

* Step 4: Check
tab religion_bin



* currently working
rename  v714 currently_working
tab currently_working














* Household wealth index v190 

* Drop existing categorized wealth variable if it exists
capture drop wealth_cat

* Create a new variable for wealth category
gen wealth_cat = .

* Categorize: Poor (poorest + poorer)
replace wealth_cat = 0 if inlist(v190, 1, 2)   // 1 = poorest, 2 = poorer

* Categorize: Middle class (middle)
replace wealth_cat = 1 if v190 == 3

* Categorize: Rich (richer + richest)
replace wealth_cat = 2 if inlist(v190, 4, 5)

* Label the variable categories
label define wealth_lbl 0 "Poor" 1 "Middle Class" 2 "Rich"
label values wealth_cat wealth_lbl

* Check the frequencies
tab wealth_cat


* Household size (v136)
tab v136, mis

* Drop existing categorized variable if exists
capture drop hh_size_cat

* Generate new categorical variable
gen hh_size_cat = .

* Assign 0 if household size is 1, 2, or 3
replace hh_size_cat = 0 if inlist(v136, 1, 2, 3)

* Assign 1 if household size is 4 or more
replace hh_size_cat = 1 if v136 >= 4

* Label the categories
label define hh_lbl 0 "1-3 members" 1 "4 or more members"
label values hh_size_cat hh_lbl

* Tabulate to check
tab hh_size_cat


* sex of the household head (V151)
tab v151, mis
rename v151 hh_head_sex
tab hh_head_sex






*****************************
*****************************
*Household Assest
*****************************
*****************************
  

  tab v122
  describe v122
  codebook v122
  
  
  tab v123
  describe v123
  codebook v123
   
   
   
   
  tab v124
  describe v124
  codebook v124
  
  
  
  tab v125
  describe v125
  codebook v125
   
   
   

   
 * Create a single household asset variable (binary)
gen hh_assets = 0

* Mark as 1 if household owns any asset (recode not a dejure resident as no)
replace hh_assets = 1 if inlist(v122,1) | inlist(v123,1) | inlist(v124,1) | inlist(v125,1)

* Label the variable
label define hh_assets_lbl 0 "No" 1 "Yes"
label values hh_assets hh_assets_lbl
label variable hh_assets "Household owns any major asset (refrigerator, bicycle, motorcycle/scooter, car/truck)"

* Check
tab hh_assets
  
   
   
   




* --------------------------------------
* Step 1: Recode individual media variables as binary
* --------------------------------------
gen radio_exp = 0
replace radio_exp = 1 if v158 >= 1

gen tv_exp = 0
replace tv_exp = 1 if v159 >= 1

gen tv_house = 0
replace tv_house = 1 if v121 == 1

gen mobile = v169a

* --------------------------------------
* Step 2: Create a single composite media variable
* 0 = no exposure to any media
* 1 = exposed to at least one media type
* --------------------------------------
gen media = 0
replace media = 1 if radio_exp==1 | tv_exp==1 | tv_house==1 | mobile==1

* Add labels
label define media_lbl 0 "No media exposure" 1 "Any media exposure"
label values media media_lbl

* Check
tab media







******************************************
tab v171a

***************************************************************************
* Media - Internet use binary coding
gen internet_use = .
replace internet_use = 0 if inlist(v171a, 0, 2)  // never or yes, before last 12 months = No
replace internet_use = 1 if v171a == 1            // yes  last 12 months = Yes

label define internet_lbl 0 "No internet use" 1 "Internet use  last 12 months"
label values internet_use internet_lbl
label variable internet_use "Internet use (binary: only  last 12 months = Yes)"

tab internet_use





*****************************
***************************
* Household materials
 
*****************************
*******************************
   
tab v128     //  wall material

describe v128
codebook v128
   
tab v127 
describe v127
 codebook v127
   
   
tab v129 
describe v129
codebook v129
   
   
   
   
   *-------------------------------
* Create household materials variable
*-------------------------------

gen hh_materials = 0   // default = unimproved

* Wall material: assign 1 if improved (cement, bricks, cement blocks, tin, stone with lime/cement)
replace hh_materials = 1 if inlist(v128, 31, 34, 35, 37, 36, 38, 39)  

* Floor material: assign 1 if improved (cement, ceramic tiles, vinyl, parquet, carpet)
replace hh_materials = 1 if inlist(v127, 34, 30, 31, 32, 33)  

* Roof material: assign 1 if improved (cement, tin/metal, ceramic tiles, calamine/cement fiber, roofing shingles)
replace hh_materials = 1 if inlist(v129, 31, 35, 36, 37, 38, 39)  

* Treat "not dejure resident" as unimproved
replace hh_materials = 0 if inlist(v128,97) | inlist(v127,97) | inlist(v129,97)

* Label the variable
label define hh_materials_lbl 0 "Unimproved" 1 "Improved"
label values hh_materials hh_materials_lbl
label variable hh_materials "Household materials quality (Improved vs Unimproved)"

* Check
tab hh_materials















**************************************************************
* DHS Analysis Tabulations Do-File
* Organized by Variable Groups
**************************************************************

**************************************************
* 1. Outcome Variables
**************************************************

* Depression & Anxiety
tab depression_cat, missing
tab anxiety_cat, missing

**************************************************
* 2. Maternal Variables
**************************************************

* Age of woman
tab women_age

* Age at first birth
tab age_first_birth_cat

* Age at first sex
tab age_first_sex, missing

* Age at cohabitation
tab age_cohab_cat

* Education
tab education_woman
tab husband_education

* Maternal employment
tab maternal_employment

* Antenatal care
tab ANC_visit, missing

* Number of children
tab num_children

* Birth size
tab birth_size, missing

* Preterm birth
tab preterm_birth

* Currently pregnant
tab currently_pregnant

* Pregnancy history
tab pregnancy
tab pressure_to_pregnant
tab preg_loss_cat

**************************************************
* 3. Demographic Variables
**************************************************

* Residing status
tab residing_status

* Currently abstaining
tab currently_abstaining

* Number of unions
tab number_of_unions

* Menstruated in last 6 weeks
tab menstruated_last6wks

* Empowerment level
tab emp_level

* Husband's preference for more/same children
tab husb_pref_more_same

* IPV justification
tab ipv_justified, missing

**************************************************
* 4. Household Variables
**************************************************

* Toilet facilities
tab toilet

* Water source
tab water

* Area (urban/rural)
tabulate area

* Division
tab hh_division, missing

* Religion (5 categories)
tab religion_bin, missing

* Currently working
tab currently_working

* Wealth index
tab wealth_cat

* Household size
tab hh_size_cat

* Household head sex
tab hh_head_sex

* Household assets
tab hh_assets

* Media access
tab media

* Internet use
tab internet_use

* Household materials
tab hh_materials






**************************************************************
* Keep only these variables
**************************************************************

keep depression_cat  women_age age_first_birth_cat age_first_sex age_cohab_cat education_woman  maternal_employment ANC_visit num_children birth_size preterm_birth currently_pregnant pregnancy pressure_to_pregnant preg_loss_cat residing_status currently_abstaining number_of_unions menstruated_last6wks emp_level toilet water area hh_division religion_bin currently_working wealth_cat hh_size_cat hh_head_sex hh_assets media internet_use hh_materials v005 v022 v021 v023 WGT







save "D:\Research\BDHS Research\Mental Health\Lestho\Women empowerment\Data\clean_data_emp",replace






/*
Outcome Variables

depression_cat – Depression severity (None, Moderate, Severe)

anxiety_cat – Anxiety severity (None, Moderate, Severe)

2. Maternal Variables

women_age – Age of the woman

age_first_birth_cat – Age at first birth (categorical)

age_first_sex – Age at first sexual intercourse

age_cohab_cat – Age at cohabitation (categorical)

education_woman – Woman's education level

husband_education – Husband's education level

maternal_employment – Maternal employment status

ANC_visit – Number of antenatal care visits

num_children – Number of children

birth_size – Size of the child at birth

preterm_birth – Preterm birth indicator

currently_pregnant – Whether currently pregnant

pregnancy – Pregnancy history

pressure_to_pregnant – Pressure to become pregnant

preg_loss_cat – Pregnancy loss category

3. Demographic Variables

residing_status – Residence status (urban/rural)

currently_abstaining – Currently abstaining from sex

number_of_unions – Number of marital/sexual unions

menstruated_last6wks – Menstruation in last 6 weeks

emp_level – Empowerment level

husb_pref_more_same – Husband preference for more/same children

ipv_justified – Justification of IPV

4. Household / Geographic Variables

toilet – Toilet facilities

water – Water source

area – Urban/rural area

hh_division – Administrative division

religion_bin – Religion (collapsed into 5 categories)

currently_working – Household member currently working

wealth_cat – Wealth index

hh_size_cat – Household size category

hh_head_sex – Sex of household head

hh_assets – Household assets

media – Access to media

internet_use – Access to internet

hh_materials – Household construction materials

*/










/****************************************************************************************
     TABLE 1: Prevalence
****************************************************************************************/





**************************************************
* 1. Outcome Variables
**************************************************

* Depression & Anxiety
svy: tab depression_cat, missing
svy: tab anxiety_cat, missing

**************************************************
* 2. Maternal Variables
**************************************************

* Age of woman
svy: tab women_age

* Age at first birth
svy: tab age_first_birth_cat

* Age at first sex
svy: tab age_first_sex, missing

* Age at cohabitation
svy: tab age_cohab_cat

* Education
svy: tab education_woman
svy: tab husband_education

* Maternal employment
svy: tab maternal_employment

* Antenatal care
svy: tab ANC_visit, missing

* Number of children
svy: tab num_children

* Birth size
svy: tab birth_size, missing

* Preterm birth
svy: tab preterm_birth

* Currently pregnant
svy: tab currently_pregnant

* Pregnancy history
svy: tab pregnancy
svy: tab pressure_to_pregnant
svy: tab preg_loss_cat

**************************************************
* 3. Demographic Variables
**************************************************

* Residing status
svy: tab residing_status

* Currently abstaining
svy: tab currently_abstaining

* Number of unions
svy: tab number_of_unions

* Menstruated in last 6 weeks
svy: tab menstruated_last6wks

* Empowerment level
svy: tab emp_level

* Husband's preference for more/same children
svy: tab husb_pref_more_same

* IPV justification
svy: tab ipv_justified, missing

**************************************************
* 4. Household Variables
**************************************************

* Toilet facilities
svy: tab toilet

* Water source
svy: tab water

* Area (urban/rural)
svy: tab area

* Division
svy: tab hh_division, missing

* Religion (5 categories)
svy: tab religion_bin, missing

* Currently working
svy: tab currently_working

* Wealth index
svy: tab wealth_cat

* Household size
svy: tab hh_size_cat

* Household head sex
svy: tab hh_head_sex

* Household assets
svy: tab hh_assets

* Media access
svy: tab media

* Internet use
svy: tab internet_use

* Household materials
svy: tab hh_materials

















/****************************************************************************************
     TABLE 2: Prevalence
****************************************************************************************/





/****************************************************************************************
     SECTION 1: OUTCOME VARIABLES
****************************************************************************************/
proportion depression_cat, over(women_age) level(95)















*Table 1





/****************************************************************************************
     BEGIN WORD DOCUMENT
****************************************************************************************/
putdocx begin
putdocx paragraph, style(Title)
putdocx text ("Descriptive Statistics of Study Variables among Zambia Reproductive-aged Women (n=13,183)")

putdocx paragraph
putdocx text ("Variable | Category | Weighted N | Percent (%)")
putdocx paragraph

/****************************************************************************************
     DEFINE VARIABLES
****************************************************************************************/
* Maternal variables
local maternal_vars women_age age_first_birth_cat age_first_sex age_cohab_cat ///
    education_woman  maternal_employment ANC_visit num_children ///
    birth_size preterm_birth currently_pregnant pregnancy pressure_to_pregnant preg_loss_cat

* Demographic variables
local demographic_vars residing_status currently_abstaining number_of_unions ///
    menstruated_last6wks emp_level ipv_justified

* Household & socioeconomic variables
local household_vars toilet water area hh_division religion_bin currently_working ///
    wealth_cat hh_size_cat hh_head_sex hh_assets media internet_use hh_materials

* Combine all
local all_vars `maternal_vars' `demographic_vars' `household_vars'

/****************************************************************************************
     LOOP OVER VARIABLES AND WRITE TO WORD
****************************************************************************************/
local total_n = 13183  // survey population size

foreach var of local all_vars {
    
    * Get weighted proportions
    svy: proportion `var'
    
    * Get number of categories
    local ncat = colsof(r(table))
    
    * Loop over categories
    forvalues i = 1/`ncat' {
        local prop = r(table)[1,`i']         // proportion
        local wN = round(`prop' * `total_n') // weighted N
        local pct = round(`prop' * 100, 0.1) // percent with 1 decimal
        
        * Get category label if variable has value labels
        capture local cat_label : label (`var') `i'
        if "`cat_label'" == "" local cat_label = "`i'"
        
        * Write line to Word
        putdocx paragraph
        putdocx text ("`var' | `cat_label' | `wN' | `pct'")
    }
}

putdocx save "D:\Research\BDHS Research\Mental Health\Lestho\men\Table", replace





svy:tab anxiety_cat

/****************************************************************************************
     TABLE 1: Significant(Supplymentary table)
****************************************************************************************/

/****************************************************************************************
     SECTION 2: MATERNAL VARIABLES
****************************************************************************************/
tabulate anxiety_cat women_age, row col cell chi2
tabulate anxiety_cat age_first_birth_cat, row col cell chi2
tabulate anxiety_cat age_first_sex, row col cell chi2
tabulate anxiety_cat age_cohab_cat, row col cell chi2
tabulate anxiety_cat education_woman, row col cell chi2
tabulate anxiety_cat husband_education, row col cell chi2
tabulate anxiety_cat maternal_employment, row col cell chi2
tabulate anxiety_cat ANC_visit, row col cell chi2
tabulate anxiety_cat num_children, row col cell chi2
tabulate anxiety_cat birth_size, row col cell chi2
tabulate anxiety_cat preterm_birth, row col cell chi2
tabulate anxiety_cat currently_pregnant, row col cell chi2
tabulate anxiety_cat pregnancy, row col cell chi2
tabulate anxiety_cat pressure_to_pregnant, row col cell chi2
tabulate anxiety_cat preg_loss_cat, row col cell chi2

/****************************************************************************************
     SECTION 3: DEMOGRAPHIC VARIABLES
****************************************************************************************/
tabulate anxiety_cat residing_status, row col cell chi2
tabulate anxiety_cat currently_abstaining, row col cell chi2
tabulate anxiety_cat number_of_unions, row col cell chi2
tabulate anxiety_cat menstruated_last6wks, row col cell chi2
tabulate anxiety_cat emp_level, row col cell chi2
tabulate anxiety_cat ipv_justified, row col cell chi2

/****************************************************************************************
     SECTION 4: HOUSEHOLD & SOCIOECONOMIC VARIABLES
****************************************************************************************/
tabulate anxiety_cat toilet, row col cell chi2
tabulate anxiety_cat water, row col cell chi2
tabulate anxiety_cat area, row col cell chi2
tabulate anxiety_cat hh_division, row col cell chi2
tabulate anxiety_cat religion_bin, row col cell chi2
tabulate anxiety_cat currently_working, row col cell chi2
tabulate anxiety_cat wealth_cat, row col cell chi2
tabulate anxiety_cat hh_size_cat, row col cell chi2
tabulate anxiety_cat hh_head_sex, row col cell chi2
tabulate anxiety_cat hh_assets, row col cell chi2
tabulate anxiety_cat media, row col cell chi2
tabulate anxiety_cat internet_use, row col cell chi2
tabulate anxiety_cat hh_materials, row col cell chi2










svy:proportion depression_cat , level(95)
svy: proportion anxiety_cat , level(95)




/****************************************************************************************
     SECTION 2: MATERNAL VARIABLES (stratified by anxiety_cat)
****************************************************************************************/
svy: proportion women_age, over(anxiety_cat) level(95)
svy: proportion age_first_birth_cat, over(anxiety_cat) level(95)
svy: proportion age_first_sex, over(anxiety_cat) level(95)
svy: proportion age_cohab_cat, over(anxiety_cat) level(95)
svy: proportion education_woman, over(anxiety_cat) level(95)
svy: proportion husband_education, over(anxiety_cat) level(95)
svy: proportion maternal_employment, over(anxiety_cat) level(95)
svy: proportion ANC_visit, over(anxiety_cat) level(95)
svy: proportion num_children, over(anxiety_cat) level(95)
svy: proportion birth_size, over(anxiety_cat) level(95)
svy: proportion preterm_birth, over(anxiety_cat) level(95)
svy: proportion currently_pregnant, over(anxiety_cat) level(95)
svy: proportion pregnancy, over(anxiety_cat) level(95)
svy: proportion pressure_to_pregnant, over(anxiety_cat) level(95)
svy: proportion preg_loss_cat, over(anxiety_cat) level(95)

/****************************************************************************************
     SECTION 3: DEMOGRAPHIC VARIABLES (stratified by anxiety_cat)
****************************************************************************************/
svy: proportion residing_status, over(anxiety_cat) level(95)
svy: proportion currently_abstaining, over(anxiety_cat) level(95)
svy: proportion number_of_unions, over(anxiety_cat) level(95)
svy: proportion menstruated_last6wks, over(anxiety_cat) level(95)
svy: proportion emp_level, over(anxiety_cat) level(95)
svy: proportion ipv_justified, over(anxiety_cat) level(95)

/****************************************************************************************
     SECTION 4: HOUSEHOLD & SOCIOECONOMIC VARIABLES (stratified by anxiety_cat)
****************************************************************************************/
svy: proportion toilet, over(anxiety_cat) level(95)
svy: proportion water, over(anxiety_cat) level(95)
svy: proportion area, over(anxiety_cat) level(95)
svy: proportion hh_division, over(anxiety_cat) level(95)
svy: proportion religion_bin, over(anxiety_cat) level(95)
svy: proportion currently_working, over(anxiety_cat) level(95)
svy: proportion wealth_cat, over(anxiety_cat) level(95)
svy: proportion hh_size_cat, over(anxiety_cat) level(95)
svy: proportion hh_head_sex, over(anxiety_cat) level(95)
svy: proportion hh_assets, over(anxiety_cat) level(95)
svy: proportion media, over(anxiety_cat) level(95)
svy: proportion internet_use, over(anxiety_cat) level(95)
svy: proportion hh_materials, over(anxiety_cat) level(95)








/****************************************************************************************
     SECTION 2: MATERNAL VARIABLES (stratified by depression_cat)
****************************************************************************************/
svy: proportion women_age, over(depression_cat) level(95)
svy: proportion age_first_birth_cat, over(depression_cat) level(95)
svy: proportion age_first_sex, over(depression_cat) level(95)
svy: proportion age_cohab_cat, over(depression_cat) level(95)
svy: proportion education_woman, over(depression_cat) level(95)
svy: proportion husband_education, over(depression_cat) level(95)
svy: proportion maternal_employment, over(depression_cat) level(95)
svy: proportion ANC_visit, over(depression_cat) level(95)
svy: proportion num_children, over(depression_cat) level(95)
svy: proportion birth_size, over(depression_cat) level(95)
svy: proportion preterm_birth, over(depression_cat) level(95)
svy: proportion currently_pregnant, over(depression_cat) level(95)
svy: proportion pregnancy, over(depression_cat) level(95)
svy: proportion pressure_to_pregnant, over(depression_cat) level(95)
svy: proportion preg_loss_cat, over(depression_cat) level(95)

/****************************************************************************************
     SECTION 3: DEMOGRAPHIC VARIABLES (stratified by depression_cat)
****************************************************************************************/
svy: proportion residing_status, over(depression_cat) level(95)
svy: proportion currently_abstaining, over(depression_cat) level(95)
svy: proportion number_of_unions, over(depression_cat) level(95)
svy: proportion menstruated_last6wks, over(depression_cat) level(95)
svy: proportion emp_level, over(depression_cat) level(95)
svy: proportion ipv_justified, over(depression_cat) level(95)

/****************************************************************************************
     SECTION 4: HOUSEHOLD & SOCIOECONOMIC VARIABLES (stratified by depression_cat)
****************************************************************************************/
svy: proportion toilet, over(depression_cat) level(95)
svy: proportion water, over(depression_cat) level(95)
svy: proportion area, over(depression_cat) level(95)
svy: proportion hh_division, over(depression_cat) level(95)
svy: proportion religion_bin, over(depression_cat) level(95)
svy: proportion currently_working, over(depression_cat) level(95)
svy: proportion wealth_cat, over(depression_cat) level(95)
svy: proportion hh_size_cat, over(depression_cat) level(95)
svy: proportion hh_head_sex, over(depression_cat) level(95)
svy: proportion hh_assets, over(depression_cat) level(95)
svy: proportion media, over(depression_cat) level(95)
svy: proportion internet_use, over(depression_cat) level(95)
svy: proportion hh_materials, over(depression_cat) level(95)







* Stepwoise variable selection for adjusted models
*******************************************************************************
* Depression and anxiety
*******************************************************************************
* Bivariate association between each variable and depression
* Bivariate association between each variable and depression














*******************************************************
* Bivariate chi-square tables: depression_cat vs predictors
*******************************************************

tabulate depression_cat women_age, row col cell chi2
tabulate depression_cat age_first_birth_cat, row col cell chi2
tabulate depression_cat age_first_sex, row col cell chi2
tabulate depression_cat age_cohab_cat, row col cell chi2
tabulate depression_cat education_woman, row col cell chi2
tabulate depression_cat husband_education, row col cell chi2
tabulate depression_cat maternal_employment, row col cell chi2
tabulate depression_cat ANC_visit, row col cell chi2
tabulate depression_cat num_children, row col cell chi2
tabulate depression_cat birth_size, row col cell chi2
tabulate depression_cat preterm_birth, row col cell chi2
tabulate depression_cat currently_pregnant, row col cell chi2
tabulate depression_cat pregnancy, row col cell chi2
tabulate depression_cat pressure_to_pregnant, row col cell chi2
tabulate depression_cat preg_loss_cat, row col cell chi2
tabulate depression_cat residing_status, row col cell chi2
tabulate depression_cat currently_abstaining, row col cell chi2
tabulate depression_cat number_of_unions, row col cell chi2
tabulate depression_cat menstruated_last6wks, row col cell chi2
tabulate depression_cat emp_level, row col cell chi2
tabulate depression_cat ipv_justified, row col cell chi2
tabulate depression_cat toilet, row col cell chi2
tabulate depression_cat water, row col cell chi2
tabulate depression_cat area, row col cell chi2
tabulate depression_cat hh_division, row col cell chi2
tabulate depression_cat religion_bin, row col cell chi2
tabulate depression_cat currently_working, row col cell chi2
tabulate depression_cat wealth_cat, row col cell chi2
tabulate depression_cat hh_size_cat, row col cell chi2
tabulate depression_cat hh_head_sex, row col cell chi2
tabulate depression_cat hh_assets, row col cell chi2
tabulate depression_cat media, row col cell chi2
tabulate depression_cat internet_use, row col cell chi2
tabulate depression_cat hh_materials, row col cell chi2




/*
Variables with p-value < 0.25 for Depression:
Variable	Chi-square p-value	Significance
women_age	0.007	***
age_first_sex	0.003	***
age_cohab_cat	0.005	***
education_woman	0.000	***
husband_education	0.000	***
maternal_employment	0.000	***
ANC_visit	0.131	*
num_children	0.244	*
birth_size	0.886	❌
currently_pregnant	0.000	***
pregnancy	0.015	**
pressure_to_pregnant	0.142	*
preg_loss_cat	0.062	*
residing_status	0.031	**
currently_abstaining	0.581	❌
number_of_unions	0.105	*
menstruated_last6wks	0.336	❌
emp_level	0.000	***
husb_pref_more_same	0.815	❌
ipv_justified	0.000	***
toilet	0.007	***
water	0.000	***
area	0.411	❌
hh_division	0.000	***
religion_bin	0.000	***
currently_working	0.000	***
wealth_cat	0.000	***
hh_size_cat	0.320	❌
hh_head_sex	0.664	❌
hh_assets	0.000	***
media	0.000	***
internet_use	0.000	***
hh_materials	0.000	***
*/
















































