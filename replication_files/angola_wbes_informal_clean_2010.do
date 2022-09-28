*********** This do file is named as 'cleaned_2010_informal' **************

*\\\///  Project:  Foundational analysis to close the gender profit gap (GPG)      *\\\///
*\\\///  Purpose:  Use WBES for Global Data Analysis                               *\\\///
*\\\///  Data brought in: WBES Angola Raw File 2010                              *\\\///
*\\\///  Data created:    WBES Angola Cleaned File 2010                             *\\\///
*\\\///  Unit of observation ; unique identifier(id): Firm level Data ; id: firm   	*\\\///
*\\\///  Date:  Dec 19, 2021                                                      	*\\\///
*\\\///  Author:   NAJ                                                  			*\\\///

use "Data/01_Raw/Angola-2010-Informal-full-data-.dta",clear 

	keep idstd a3a Sc2b b12 b13 b14 a4 b3 b10 b1 b2 l3a l3b l6a l6b l7 b6 b15 b16 d6 m1a i30 e1 b9


	local vars idstd a3a Sc2b b12 b13 b14 a4 b3 b10 b1 b2 l3a l3b l6a l6b l7 b6 b15 b16 d6 m1a i30 e1 b9

//creating a variable list of all the variables in the clean dataset

foreach var of varlist `vars' {
gen _`var' = `var'
replace _`var' = . if inlist(`var', -9, -8, -6, -7, -4)
_crcslbl _`var' `var'
}

save "Data/02_Country/angola_wbes_informal_cleaned_2010.dta", replace







