*********** This do file is named as 'cleaned_2010' **************

*\\\///  Project:  Foundational analysis to close the gender profit gap (GPG)      *\\\///
*\\\///  Purpose:  Use WBES for Global Data Analysis                               *\\\///
*\\\///  Data brought in: WBES Angola Raw File 2010                              *\\\///
*\\\///  Data created:    WBES Angola Cleaned File 2010                             *\\\///
*\\\///  Unit of observation ; unique identifier(id): Firm level Data ; id: firm  	*\\\///
*\\\///  Date:  Dec 16, 2021                                                      	*\\\///
*\\\///  Author:  DEN                                                  				*\\\///

use "Data/01_Raw/Angola-2010-full-data-.dta",clear 

	keep idstd wstrict wweak wmedian a2 a6b a4b b5 b6 AFb3b b7a AFb3a l1 l2 l5a l5b 	///
	l6 l8 AFl8a d2 n3 c30a c30b d30a d30b e30 g30a i30 k30 j30a-h30 l30a-m1a b6a b6b

	local vars a2 a6b a4b b5 b6 AFb3b b7a AFb3a l1 l2 l5a l5b l6 l8 AFl8a d2 n3 ///
	 c30a c30b d30a d30b e30 g30a i30 k30 j30a-h30 l30a-m1a b6a b6b

foreach var of varlist `vars' {
gen _`var' = `var'
replace _`var' = . if inlist(`var', -9, -8, -6, -7)
_crcslbl _`var' `var'
}

save "Data/02_Country/angola_wbes_regular_cleaned_2010.dta", replace










