



use "D:\Research\BDHS Research\Mental Health\Lestho\Women empowerment\Data\clean_data_emp.dta",clear


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
logistic depression_cat i.emp_level 
 estimates store m0
 
* Step 1: Add age at first birth
logistic depression_cat i. emp_level i.women_age i.age_first_birth
estimates store m1
estimates stats m0 m1

estimates stats m0 m1 // m1 better model statistically and conceptually
/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m0 |      3,297  -826.4104  -826.3522       2   1656.704   1668.906
          m1 |      3,297  -826.4104  -815.8163      10   1651.633    1712.64
-----------------------------------------------------------------------------


*/

 
* --- Block 1: Maternal & Demographic variables ---
logistic depression_cat i. emp_level i.women_age i.education_woman  ///
    i.religion_bin i.hh_division 
estimates store m2
estimates stats m2 m1 // statistically and conceptually m2


/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m2 |      3,297  -826.4104  -803.5167      20   1647.033   1769.049
          m1 |      3,297  -826.4104  -815.8163      10   1651.633    1712.64


*/

* --- Block 2: Reproductive / Pregnancy-related variables ---
logistic depression_cat i. emp_level i.women_age i.education_woman  ///
    i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy  i.preg_loss_cat
estimates store m3
estimates stats m3 m2 // statistically and conceptually m3

/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m3 |      3,297  -826.4104   -791.278      28   1638.556   1809.377
          m2 |      3,297  -826.4104  -803.5167      20   1647.033   1769.049


*/

* --- Block 3: Contextual / Area variables ---
logistic depression_cat i. emp_level i.women_age i.education_woman  ///
    i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy i.preg_loss_cat i.area 
estimates store m4
estimates stats m4 m3 // statistically and conceptually m4




* --- Block 4: Household & Sanitation variables ---
logistic depression_cat i.women_age i. emp_level i.education_woman ///
    i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy i.preg_loss_cat i.area ///
    i.toilet i.water i.hh_head_sex i.hh_size_cat i.wealth_cat i.media ///
    i.internet_use i.hh_assets i.hh_materials
estimates store m5
estimates stats m5 m4 // statistically and conceptually m5

/*

-----------------------------------------------------------------------------
       Model |          N   ll(null)  ll(model)      df        AIC        BIC
-------------+---------------------------------------------------------------
          m5 |      3,297  -826.4104    -785.11      39    1648.22    1886.15
          m4 |      3,297  -826.4104  -788.9179      29   1635.836   1812.758


*/




*******************************************************
* Final Model Comparison (All Blocks)
estimates stats m0 m1 m2 m3 m4 m5
*******************************************************

 

 *************************************************
 *************************************************
 *n Final Model
 **************************************************
 ***************************************************
 
svy:logistic depression_cat i. emp_level i.women_age  i.education_woman ///
    i.maternal_employment i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy i.preg_loss_cat i.area ///
    i.toilet i.water i.hh_head_sex i.hh_size_cat i.wealth_cat i.media ///
    i.internet_use i.hh_assets i.hh_materials 
	


	

 *************************************************
 *************************************************
 *Model Diagnosis
 **************************************************
 ***************************************************
 logistic depression_cat i. emp_level i.women_age  i.education_woman ///
    i.maternal_employment i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy i.preg_loss_cat i.area ///
    i.toilet i.water i.hh_head_sex i.hh_size_cat i.wealth_cat i.media ///
    i.internet_use i.hh_assets i.hh_materials 
		
	
	
	
estat gof, group(10) // Hosmer–Lemeshow (deciles)	

/*
       


 Number of observations =  3,297
       Number of groups =     10
Hosmer–Lemeshow chi2(8) =   5.85
            Prob > chi2 = 0.6642


*/

	
*  Check multicollinearity with linear regression
	regress depression_cat i. emp_level i.women_age  i.education_woman ///
    i.maternal_employment i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy i.preg_loss_cat i.area ///
    i.toilet i.water i.hh_head_sex i.hh_size_cat i.wealth_cat i.media ///
    i.internet_use i.hh_assets i.hh_materials 
	

vif // (Mean VIF =2.205) 

/*

. vif // (Mean VIF =2.22) 

    Variable |       VIF       1/VIF  
-------------+----------------------
 1.emp_level |      1.67    0.598816
   women_age |
          2  |      1.98    0.505759
          3  |      2.17    0.460474
          4  |      2.43    0.411242
          5  |      2.57    0.389131
          6  |      2.54    0.394311
          7  |      2.21    0.452149
education_~n |
          1  |      1.78    0.561835
          2  |      1.89    0.530077
1.maternal~t |      1.31    0.762040
1.religion~n |      1.07    0.938950
 hh_division |
          2  |      1.93    0.516930
          3  |      1.92    0.519980
          4  |      2.06    0.484951
          5  |      1.74    0.575041
          6  |      1.62    0.615976
          7  |      1.70    0.588774
          8  |      1.66    0.603561
          9  |      1.72    0.581651
         10  |      1.88    0.530504
age_first_~t |
          2  |      3.08    0.324783
          3  |      5.56    0.179946
age_cohab_~t |
          1  |      2.21    0.452989
          2  |      2.77    0.360651
num_children |      4.02    0.248524
 1.pregnancy |      3.77    0.264927
preg_loss_~t |
          1  |      1.08    0.925532
          2  |      1.04    0.957231
      2.area |      1.61    0.621986
    1.toilet |      1.41    0.711043
     1.water |      1.41    0.707554
2.hh_head_~x |      1.23    0.811068
1.hh_size_~t |      1.22    0.823005
  wealth_cat |
          1  |      1.53    0.651802
          2  |      3.59    0.278932
     1.media |      1.27    0.785293
1.internet~e |      1.35    0.742708
 1.hh_assets |      2.24    0.446374
1.hh_mater~s |      1.64    0.609075
-------------+----------------------
    Mean VIF |      2.05

. 
end of do-file



*/

	
	

	
	*-----------------------------------------------
* Run your final survey-weighted logistic model
*-----------------------------------------------
logistic depression_cat i. emp_level i.women_age  i.education_woman ///
    i.maternal_employment i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy i.preg_loss_cat i.area ///
    i.toilet i.water i.hh_head_sex i.hh_size_cat i.wealth_cat i.media ///
    i.internet_use i.hh_assets i.hh_materials 
			
	
* women age, women education, maternal employment, religion, administrative division, age at first birth, age at cohabitation, number of children, pregnancy status, pregnancy loss, place of residence, toilet facilities, water access, household head sex, household size category, household wealth status, media access, internet use, household assets,  and household materials		
	
	
	
	
	
	
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
svy, subpop(rural_subpop): logistic depression_cat i. emp_level i.women_age  i.education_woman ///
    i.maternal_employment i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy i.preg_loss_cat ///
    i.toilet i.water i.hh_head_sex i.hh_size_cat i.wealth_cat i.media ///
    i.internet_use i.hh_assets i.hh_materials 
	
	
	
	

****************************************************
* 2b. URBAN STRATIFIED MODEL
****************************************************
svy, subpop(urban_subpop):  logistic depression_cat i. emp_level i.women_age  i.education_woman ///
    i.maternal_employment i.religion_bin i.hh_division i.age_first_birth i.age_cohab_cat num_children ///
    i.pregnancy i.preg_loss_cat ///
    i.toilet i.water i.hh_head_sex i.hh_size_cat i.wealth_cat i.media ///
    i.internet_use i.hh_assets i.hh_materials 
	

	 
	 
	 
	 
	
********************************************************************************
* END
********************************************************************************




