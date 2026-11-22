


****************************************************
****************************************************
* Region-wise Pregnancy Loss & Internet Use
****************************************************
****************************************************

************************************
* 1. Pregnancy Loss (division-wise)
************************************
preserve

* Create indicators from category variable
gen pl_none = (preg_loss_cat==0)
gen pl_one  = (preg_loss_cat==1)
gen pl_two  = (preg_loss_cat==2)

* Collapse by region (sum = number of women)
collapse (sum) pl_none pl_one pl_two (count) total=preg_loss_cat, by(hh_division)

* Compute percentages
gen none_pct = round((pl_none/total)*100,1)
gen one_pct  = round((pl_one/total)*100,1)
gen two_pct  = round((pl_two/total)*100,1)

* Drop raw counts
drop pl_none pl_one pl_two total



* Export depression data to Lesotho folder
export excel using "D:\Research\BDHS Research\Mental Health\Lestho\spatial\region_wise_preg_loss.xlsx", ///
    firstrow(variables) replace




restore




************************************
* 2. Internet Use (division-wise)
************************************
preserve

* Create binary indicators
gen net_no  = (internet_use==0)
gen net_yes = (internet_use==1)

* Collapse by region
collapse (sum) net_no net_yes (count) total=internet_use, by(hh_division)

* Percentages
gen no_pct  = round((net_no/total)*100,1)
gen yes_pct = round((net_yes/total)*100,1)

drop net_no net_yes total



* Export depression data to Lesotho folder
export excel using "D:\Research\BDHS Research\Mental Health\Lestho\spatial\region_wise_internet.xlsx", ///
    firstrow(variables) replace






restore








****************************************************
* Division Share (%) = Each column sums to 100%
****************************************************

preserve

****************************************************
* 1. Pregnancy Loss (None / One / Two+)
****************************************************

* Create indicators
gen pl_none = (preg_loss_cat==0)
gen pl_one  = (preg_loss_cat==1)
gen pl_two  = (preg_loss_cat==2)

* Collapse to get total counts per division
collapse (sum) pl_none pl_one pl_two, by(hh_division)

* Compute national totals
quietly sum pl_none, meanonly
local T_none = r(sum)

quietly sum pl_one, meanonly
local T_one = r(sum)

quietly sum pl_two, meanonly
local T_two = r(sum)

* Division share (sums to 100%)
gen none_pct = round((pl_none/`T_none')*100,1)
gen one_pct  = round((pl_one/`T_one')*100,1)
gen two_pct  = round((pl_two/`T_two')*100,1)

* Keep final variables only
keep hh_division none_pct one_pct two_pct


* Export CSV to Lesotho folder
export delimited using ///
"D:\Research\BDHS Research\Mental Health\Lestho\spatial\division_share_pregloss.csv", replace



restore



****************************************************
* 2. Internet Use (Yes / No)
****************************************************
preserve
* Create indicators
gen net_no  = (internet_use==0)
gen net_yes = (internet_use==1)

collapse (sum) net_no net_yes, by(hh_division)

quietly sum net_no, meanonly
local T_no = r(sum)

quietly sum net_yes, meanonly
local T_yes = r(sum)

gen no_pct  = round((net_no/`T_no')*100,1)
gen yes_pct = round((net_yes/`T_yes')*100,1)

keep hh_division no_pct yes_pct



* Export CSV to Lesotho folder
export delimited using ///
"D:\Research\BDHS Research\Mental Health\Lestho\spatial\division_share_internet.csv", replace


restore






****************************************************
* Division Share (%) for Pregnancy Loss
* (One loss + Two+ loss combined)
****************************************************

preserve

* Create binary indicators
gen pl_none = (preg_loss_cat==0)
gen pl_loss = (preg_loss_cat==1 | preg_loss_cat==2)

* Collapse counts by division
collapse (sum) pl_none pl_loss, by(hh_division)

* National totals
quietly sum pl_none, meanonly
local T_none = r(sum)

quietly sum pl_loss, meanonly
local T_loss = r(sum)

* Division share (sums to 100%)
gen none_pct  = round((pl_none/`T_none')*100,1)
gen loss_pct  = round((pl_loss/`T_loss')*100,1)

* Keep final output only
keep hh_division none_pct loss_pct




* Export CSV to Lesotho folder
export delimited using ///
"D:\Research\BDHS Research\Mental Health\Lestho\spatial\division_share_pregloss.csv", replace


restore







