*********** This do file is named as 'clean_2006' **************

*\\\///  Project:  Foundational analysis to close the gender profit gap (GPG)      *\\\///
*\\\///  Purpose:  Use WBES for Global Data Analysis                               *\\\///
*\\\///  Data brought in: WBES Angola Raw File 2006                              	*\\\///
*\\\///  Data created:    WBES  Angola Cleaned File 2006                            *\\\///
*\\\///  Unit of observation ; unique identifier(id): Firm level Data ; id: firm   	*\\\///
*\\\///  Date:  Nov 29, 2021                                                      	*\\\///
*\\\///  Author:  DEN                                              					*\\\///

di "$S_DATE" // update do file date
	
use "Data/01_Raw/Angola-2006--full-data-1.dta",clear 

	keep idstd weights_locsec weights_sec reg screensi industry b4c j1 b3b1 j2a j2c ///
		j2b1 j2b2 j3a j3b j3c j4a l1b l1c j3b f1*

//creating a variable list of all the variables in the clean dataset

	local vars reg screensi industry b4c j1 b3b1 j2a j2c j2b1 j2b2 j3a j3b j3c j4a l1b l1c f1*


foreach var of varlist `vars' {
gen _`var' = `var'
replace _`var' = . if inlist(`var', -99, -88, -66, -77, -44, -440)
_crcslbl _`var' `var'
label val _`var' `var'
} 

	sum _*

save "Data/02_Country/angola_wbes_regular_cleaned_2006.dta", replace

