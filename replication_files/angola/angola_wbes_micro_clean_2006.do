*********** This do file is named as 'cleaned_2006_micro' **************

*\\\///  Project:  Foundational analysis to close the gender profit gap (GPG)      *\\\///
*\\\///  Purpose:  Use WBES for Global Data Analysis                               *\\\///
*\\\///  Data brought in: WBES Angola Raw File 2006                              *\\\///
*\\\///  Data created:    WBES Angola Cleaned File 2006                             *\\\///
*\\\///  Unit of observation ; unique identifier(id): Firm level Data ; id: firm  	*\\\///
*\\\///  Date:  Dec 6, 2021                                                      	*\\\///
*\\\///  Author:  DEN                                                   			*\\\///

use "Data/01_Raw/Angola-2006-Micro-full-data-1.dta",clear 


	keep idstd reg industry b4c j1  b3b1 j2a j2b j2c j4a j4b j4c i5a i5b i5c i5d l1a l1b f1*


	local vars reg industry b4c j1  b3b1 j2a j2b j2c j4a j4b j4c i5a i5b i5c i5d l1a l1b f1*

	//creating a variable list of all the variables in the clean dataset

foreach var of varlist `vars' {
gen _`var' = `var'
replace _`var' = . if inlist(`var', -99, -88, -66, -77, -44)
_crcslbl _`var' `var'
}

save "Data/02_Country/angola_wbes_micro_cleaned_2006.dta", replace







