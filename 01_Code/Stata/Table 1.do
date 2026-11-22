

svy:proportion depression_cat , level(95)

/****************************************************************************************
     SECTION 2: MATERNAL VARIABLES (stratified by depression_cat)
****************************************************************************************/
svy: proportion women_age, over(depression_cat) level(95)
svy: proportion age_first_birth_cat, over(depression_cat) level(95)
svy: proportion age_first_sex, over(depression_cat) level(95)
svy: proportion age_cohab_cat, over(depression_cat) level(95)
svy: proportion education_woman, over(depression_cat) level(95)
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



