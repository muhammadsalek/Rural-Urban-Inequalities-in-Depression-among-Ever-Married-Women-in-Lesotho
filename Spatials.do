

use "D:\Research\BDHS Research\Mental Health\Lestho\Women empowerment\Data\clean_data_emp.dta", clear


****************************************************
****************************************************
* Region-wise Pregnancy Loss & Internet Use
****************************************************
****************************************************
****************************************************
* 2. Employment Level (Yes / No)
****************************************************
preserve

* Create indicators
gen emp_no  = (emp_level == 0)
gen emp_yes = (emp_level == 1)

* Collapse by division
collapse (sum) emp_no emp_yes, by(hh_division)

* Get national totals
quietly sum emp_no, meanonly
local T_no = r(sum)

quietly sum emp_yes, meanonly
local T_yes = r(sum)

* Percentage share by division
gen no_pct  = round((emp_no  / `T_no')  * 100, 1)
gen yes_pct = round((emp_yes / `T_yes') * 100, 1)

* Keep final variables
keep hh_division no_pct yes_pct

* Export CSV for spatial analysis
export delimited using ///
"D:\Research\BDHS Research\Mental Health\Lestho\spatial\division_share_empowerment.csv", replace

restore






