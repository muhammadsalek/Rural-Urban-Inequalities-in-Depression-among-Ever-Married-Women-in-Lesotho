

use "D:\Research\BDHS Research\Mental Health\Lestho\data\clean_data.dta", clear
***-------------------------------------------------------------
// Sampling weight
*Since DHS follws stratified sampling we need to apply survey weigth, primary sampling unit (V021), and sampling strata (V022).
*In DHS we need to create Weight variable first, following this formula:
***-------------------------------------------------------------
*gen WGT=(v005/1000000)

*Now we will label this variable 

label variable WGT "Survey Weight"
svyset [pw=WGT],psu(v021) strata(v022)

** Note: We'll use survey weight in our final regression model (at the end). 
** In the variable selection process, we'll go without sampling weight for simplicity




*******************************************************************
******************************************************************
 * Analysis Start
 *****************************************************************
 *****************************************************************

 
* crude model
logistic depression_cat i.women_age 
 estimates store m0
 
* Step 1: Add age at first birth
logistic depression_cat i.women_age i.age_first_birth
estimates store m1
estimates stats m0 m1

estimates stats m0 m1 // m1 better model


 
 
 *******************************************************
* Stepwise Logistic Regression for Depression (Complete)
*******************************************************

* --- Block 0: Crude model (maternal age only) ---
logistic depression_cat i.women_age
estimates store m0

* --- Block 1: Maternal & Demographic variables ---
logistic depression_cat i.women_age i.education_woman  ///
    i.religion_bin i.hh_division
estimates store m1
estimates stats m0 m1

* --- Block 2: Reproductive / Pregnancy-related variables ---
logistic depression_cat i.women_age i.education_woman  ///
    i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy  i.preg_loss_cat
estimates store m2
estimates stats m1 m2

* --- Block 3: Contextual / Area variables ---
logistic depression_cat i.women_age i.education_woman  ///
    i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy i.preg_loss_cat i.area
estimates store m3
estimates stats m2 m3

* --- Block 4: Household & Sanitation variables ---
logistic depression_cat i.women_age i.education_woman ///
    i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy i.preg_loss_cat i.area ///
    i.toilet i.water i.hh_head_sex i.hh_size_cat i.wealth_cat i.media ///
    i.internet_use i.hh_assets i.hh_materials
estimates store m4
estimates stats m3 m4

*******************************************************
* Final Model Comparison (All Blocks)
estimates stats m0 m1 m2 m3 m4
*******************************************************

 

 *************************************************
 *************************************************
 *n Final Model
 **************************************************
 ***************************************************
 
svy:logistic depression_cat ///
    i.women_age ///
    i.age_first_sex ///
    i.age_cohab_cat ///
    i.education_woman ///
    i.maternal_employment ///
    i.ANC_visit ///
    i.num_children ///
    i.currently_pregnant ///
    i.pregnancy ///
    i.preg_loss_cat ///
    i.number_of_unions ///
    i.emp_level ///
    i.ipv_justified ///
    i.toilet ///
    i.water ///
    i.hh_division ///
	i.are ///
    i.religion_bin ///
    i.wealth_cat ///
    i.hh_assets ///
    i.media ///
    i.internet_use ///
    i.hh_materials

	
	
	
	
	
estat gof, group(10) // Hosmer–Lemeshow (deciles)	

/*
       

Goodness-of-fit test after logistic model
Variable: depression_cat

 Number of observations =  3,297
       Number of groups =     10
Hosmer–Lemeshow chi2(8) =   5.24
            Prob > chi2 = 0.7317


*/

	
*  Check multicollinearity with linear regression
	regress depression_cat ///
    i.women_age ///
    i.age_first_sex ///
    i.age_cohab_cat ///
    i.education_woman ///
    i.maternal_employment ///
    i.ANC_visit ///
    i.num_children ///
    i.currently_pregnant ///
    i.pregnancy ///
    i.preg_loss_cat ///
    i.number_of_unions ///
    i.emp_level ///
    i.ipv_justified ///
    i.toilet ///
    i.water ///
    i.hh_division ///
	i.are ///
    i.religion_bin ///
    i.wealth_cat ///
    i.hh_assets ///
    i.media ///
    i.internet_use ///
    i.hh_materials

	

vif // (Mean VIF =2.22) 
	
* Godness of fit	
	logistic depression_cat ///
    i.women_age ///
    i.age_first_sex ///
    i.age_cohab_cat ///
    i.education_woman ///
    i.maternal_employment ///
    i.ANC_visit ///
    i.num_children ///
    i.currently_pregnant ///
    i.pregnancy ///
    i.preg_loss_cat ///
    i.number_of_unions ///
    i.emp_level ///
    i.ipv_justified ///
    i.toilet ///
    i.water ///
    i.hh_division ///
	i.are ///
    i.religion_bin ///
    i.wealth_cat ///
    i.hh_assets ///
    i.media ///
    i.internet_use ///
    i.hh_materials

	
	

   estat gof 	
	
/*

  estat gof    

Goodness-of-fit test after logistic model
Variable: depression_cat

      Number of observations =   3,297
Number of covariate patterns =   3,169
          Pearson chi2(3127) = 3127.39
                 Prob > chi2 =  0.4947


*/
	
	

	
	
	
	
	
	
	
	*-----------------------------------------------
* Run your final survey-weighted logistic model
*-----------------------------------------------
	
logistic depression_cat ///
    i.women_age ///
    i.age_first_sex ///
    i.age_cohab_cat ///
    i.education_woman ///
    i.maternal_employment ///
    i.ANC_visit ///
    i.num_children ///
    i.currently_pregnant ///
    i.pregnancy ///
    i.preg_loss_cat ///
    i.number_of_unions ///
    i.emp_level ///
    i.ipv_justified ///
    i.toilet ///
    i.water ///
    i.hh_division ///
	i.are ///
    i.religion_bin ///
    i.wealth_cat ///
    i.hh_assets ///
    i.media ///
    i.internet_use ///
    i.hh_materials

	
	
		
	
	
	
	
	
	
*-----------------------------------------------
* 1. Predict adjusted probabilities (p-hat)
*-----------------------------------------------
predict phat, pr

*-----------------------------------------------
* 2. Generate ROC curve + AUC
*-----------------------------------------------
roctab depression_cat phat, graph

	
	
	
	
	
	
	
	
	
	
	
	
	
	
***************************************************************************
* Final output of association  model
***************************************************************************

*******************************************************************************
*-------------------------
* Stratified analysis. Interaction 
*-------------------------

*******************************************************************************
tab area
describe area
codebook area
* binary indicator for Rural:
gen byte rural_subpop = (area == 2)


*For Urban

gen byte urban_subpop = (area == 1)



****************************************************
* Stratified Multivariable Logistic Regression
* Rural vs Urban (subpopulation analysis)
****************************************************





***************************************************************************
* Final output of association model: Stratified analysis (Rural vs Urban)
***************************************************************************

*-------------------------
* 0. Check and describe area variable
*-------------------------
tab area
describe area
codebook area

* Ensure area variable coded as:
* 1 = Urban
* 2 = Rural

*-------------------------
* 1. Create binary subpopulation indicators
*-------------------------
gen byte rural_subpop = (area == 2)
gen byte urban_subpop = (area == 1)

tab rural_subpop
tab urban_subpop

*-------------------------
* 2. Stratified Multivariable Logistic Regression
*-------------------------

****************************************************
* 2a. RURAL STRATIFIED MODEL
****************************************************
svy, subpop(rural_subpop): logistic depression_cat ///
    i.women_age ///
    i.age_first_sex ///
    i.age_cohab_cat ///
    i.education_woman ///
    i.maternal_employment ///
    i.ANC_visit ///
    i.num_children ///
    i.currently_pregnant ///
    i.pregnancy ///
    i.preg_loss_cat ///
    i.number_of_unions ///
    i.emp_level ///
    i.ipv_justified ///
    i.toilet ///
    i.water ///
    i.hh_division ///
    i.religion_bin ///
    i.wealth_cat ///
    i.hh_assets ///
    i.media ///
    i.internet_use ///
    i.hh_materials

****************************************************
* 2b. URBAN STRATIFIED MODEL
****************************************************
svy, subpop(urban_subpop): logistic depression_cat ///
    i.women_age ///
    i.age_first_sex ///
    i.age_cohab_cat ///
    i.education_woman ///
    i.maternal_employment ///
    i.ANC_visit ///
    i.num_children ///
    i.currently_pregnant ///
    i.pregnancy ///
    i.preg_loss_cat ///
    i.number_of_unions ///
    i.emp_level ///
    i.ipv_justified ///
    i.toilet ///
    i.water ///
    i.hh_division ///
    i.religion_bin ///
    i.wealth_cat ///
    i.hh_assets ///
    i.media ///
    i.internet_use ///
    i.hh_materials


	 
	 
	 
	 
	
********************************************************************************
* END
********************************************************************************









