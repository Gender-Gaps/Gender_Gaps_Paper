
*********** This do file is named as 'prepare_2010' **************

*\\\///  Project:  Foundational analysis to close the gender profit gap (GPG)      	*\\\///
*\\\///  Purpose:  Use WBES for Global Data Analysis                               	*\\\///

*\\\///  Data brought in: WBES Angola Cleaned File 2010                             *\\\///
*\\\///  Data created:    WBES Angola Prepared File 2010                            *\\\///
*\\\///  Unit of observation ; unique identifier(id): Firm level Data ; id: firm   	*\\\///
*\\\///  Date: Dec 8, 2021                                                      	*\\\///
*\\\///  Author:  DEN                                                     			*\\\///

use "Data/02_Country/angola_wbes_regular_cleaned_2010.dta",clear 

	gen 		id_firm = idstd
	label var 	id_firm "Firm ID"
	tostring 	id_firm, replace
	
** Check uniqueness 

	count
	codebook 	id_firm

	order 		wstrict wmedian wweak, a(id_firm)

***** Sampling ******
	
	gen 		samp_region= _a2
	label val 	samp_region A2
	label var 	samp_region "sampling region"

***** Firm Size ******

	gen 		size_micro = .
	label var 	size_micro "less than 5 employees" 

	tab 		a6b, m
	gen 		size_small= _a6b == 1 if _a6b != .
	label var 	size_small "5 to 19 employees" 
	tab 		a6b size_small, m

	tab 		a6b, m
	gen 		size_medium= _a6b == 2 if _a6b != .
	label var 	size_medium "20 to 99 employees" 
	tab 		a6b size_medium, m

	tab 		a6b, m
	gen 		size_large= _a6b == 3 if _a6b != .
	label var 	size_large "100 or more employees"
	tab 		a6b size_large, m

************************************

********* Industry Sector ********

	tab 		a4b, m
	gen 		ind_food= _a4b==15 if _a4b !=.
	label var 	ind_food "Food industry"

	tab 		a4b, m
	gen 		ind_tobacco= _a4b==16 if _a4b !=.
	label var 	ind_tobacco "Tobacco industry"

	tab 		a4b, m
	gen 		ind_textiles= _a4b ==17 if _a4b !=.
	label var 	ind_textiles "Textiles industry"

	tab 		a4b, m
	gen 		ind_garments= _a4b == 18 if _a4b !=.
	label var 	ind_garments "Garments industry"

	tab 		a4b, m
	gen 		ind_leather= _a4b == 19 if _a4b !=.
	label var 	ind_leather "Leather industry"

	tab 		a4b, m
	gen 		ind_wood= _a4b == 20 if _a4b !=.
	label var 	ind_wood "Wood industry"

	tab 		a4b, m
	gen 		ind_paper= _a4b == 21 if _a4b !=.
	label var 	ind_paper "Paper industry"

	tab 		a4b, m
	gen 		ind_media= _a4b == 22 if _a4b !=.
	label var 	ind_media "Recorded media industry"

	tab 		a4b, m
	gen 		ind_petroleum= _a4b == 23 if _a4b !=.
	label var 	ind_petroleum "Refined petroleum product industry"

	tab 		a4b, m
	gen 		ind_chemical= _a4b == 24 if _a4b !=.
	label var 	ind_chemical "Chemicals industry"

	tab 		a4b, m
	gen 		ind_plastic_rubber= _a4b == 25 if _a4b !=.
	label var 	ind_plastic_rubber "Plastics & rubber"

	tab 		a4b, m
	gen 		ind_nonmetal_mineral=  _a4b == 26 if _a4b !=.
	label var 	ind_nonmetal_mineral "Non metallic mineral products"

	tab 		a4b, m
	gen 		ind_metal_basic= _a4b == 27 if _a4b !=.
	label var 	ind_metal_basic "Basic metals"

	tab 		a4b, m
	gen 		ind_metal_fabricated= _a4b == 28 if _a4b !=.
	label var 	ind_metal_fabricated "Fabricated metal products"

	tab 		a4b, m
	gen 		ind_machine_appliance = _a4b == 29 if _a4b !=.
	label var	ind_machine_appliance "Manufacture of general and special purppose machinery and domestic appliances"

	tab 		a4b, m
	gen 		ind_machine_computing = .
	label var	ind_machine_computing "Manufacture of office accounting and computing machinery"

	tab 		a4b, m
	gen 		ind_electronics= inrange(_a4b, 31, 32) if _a4b !=.
	label var 	ind_electronics "Electronics (31 & 32)"

	tab 		a4b, m
	gen 		ind_precsn_inst= _a4b == 33 if _a4b !=.
	label var 	ind_precsn_inst "Precision instruments"

	tab 		a4b, m
	gen 		ind_transport_machine= inrange(_a4b, 34, 35) if _a4b !=.
	label var 	ind_transport_machine "Transport machines (34&35)"

	tab 		a4b, m
	gen 		ind_other_manufacturing = _a4b == 36 if _a4b !=.
	label var 	ind_other_manufacturing "Manufacture N.E.C"

	tab 		a4b, m
	gen 		ind_recycling= _a4b == 37 if _a4b !=.
	label var 	ind_recycling "Recycling industry"

	tab 		a4b, m
	gen 		ind_retail = _a4b == 52 if _a4b !=. 
	label var 	ind_retail "Retail industry"
	
	gen			ind_utility = .
	label var	ind_utility "Electricity, gas and water supply"

	tab 		a4b, m
	gen 		ind_wholesale= _a4b == 51 if _a4b !=.
	label var 	ind_wholesale "Wholesale industry"

	tab 		a4b, m
	gen 		ind_hotel_restaurant= _a4b == 55 if _a4b !=.
	label var 	ind_hotel_restaurant "Hotel and restaurants industry section H"

	tab 		a4b, m
	gen 		ind_motor_vehicle= _a4b == 50 if _a4b !=.
	label var 	ind_motor_vehicle "Services of motor vehicles industry"

	tab 		a4b, m
	gen 		ind_construction= _a4b == 45 if _a4b !=. 
	label var 	ind_construction "Construction industry Section F"

	tab 		a4b, m
	gen 		ind_transport_communication = inrange(_a4b, 60, 64) if _a4b !=.
	label var 	ind_transport_communication "Transport and communication industry Section I: (60-64)"

	gen 		ind_financial = .
	label var 	ind_financial "Financial intermediation (65-67)"
	
	gen			ind_realestate	=	.	
	label var	ind_realestate	"Real estate, renting and business activities"
	
	gen			ind_renting	=	.	
	label var	ind_renting	"Renting of machinery and equipment "

	tab 		a4b, m
	gen			ind_computer_service =	_a4b == 72 if _a4b !=. 
	label var	ind_computer_service	"Computer and related activities "
	
	gen			ind_research_dev	=	.	
	label var	ind_research_dev	"Research and development"
	
	gen			ind_business_service	=	.	
	label var	ind_business_service	"Other business activities (74)	"
	
	gen			ind_edu	=	.	
	label var	ind_edu	"Education Industry"
	
	gen			ind_health	=	.	
	label var	ind_health	"Health and social work"
	
	gen			ind_other_service	=	.	
	label var	ind_other_service	"Other community, social and personal service activities (90-93, 99)"
	
	gen			ind_pub_admin	=	.	
	label var	ind_pub_admin	"Public administration and defence; compulsory social security"
	gen 		startup_year = _b5
	label var 	startup_year	"Year establishment began operations" 

	gen 		startup_employee= _b6
	label var 	startup_employee "Establishment year full-time employees"


******************************
** Firm Ownership **
	
	gen 		female_ownership_1 = .
	label var 	female_ownership_1 "Firm has at least one female owner"

	gen 		female_ownership_2 = . 
	label var 	female_ownership_2 "Percentage of female ownership"

	tab 		AFb3b
	gen 		female_ownership_3= _AFb3b == 1 if !missing(_AFb3b)
	label var 	female_ownership_3 "The/at least one of the largest/ principal owner/s is female"
	tab 		AFb3b female_ownership_3, m 
	
	tab 		b7a, m
	gen 		female_ownership_4= _b7a == 1 if !missing(_b7a)
	label var 	female_ownership_4 "Top manager is female"
	tab 		b7a female_ownership_4, m

	tab 		AFb3a, m 	
	gen 		owner_composition = _AFb3a
	label var 	owner_composition	"Gender composition of the owners"
	tab 		AFb3a owner_composition, m 

******************************

*********** Employee **********

	gen 		emp_full_perm= _l1
	label var 	emp_full_perm "Permanent full-time workers last fiscal year"

	gen 		emp_full_perm_3y= _l2
	label var 	emp_full_perm "Permanent full-time workers three years ago"

	gen 		emp_full_perm_5y= .
	label var 	emp_full_perm_5y "Permanent full-time workers five fiscal years ago"

	gen 		emp_full_perm_7y= .
	label var 	emp_full_perm_7y "Permanent full-time workers seven fiscal years ago"

	egen 		emp_full_perm_female= rowtotal(_l5a _l5b)
	label var 	emp_full_perm_female "Permanent female full-time workers"

	gen 		emp_full_perm_prod_female = _l5a
	label var 	emp_full_perm_prod_female	"Permanent female full-time production workers" 

	gen 		emp_full_perm_nonprod_female = _l5b
	label var 	emp_full_perm_nonprod_female	"Permanent female full-time non-production workers"

	gen 		emp_full_temp= _l6
	label var 	emp_full_temp "Permanent full-time temporary/seasonal workers last fiscal year"

	gen 		emp_full_temp_female= .
	label var 	emp_full_temp_female "Permanent full-time female temporary/ seasonal workers last fiscal year"

	gen 		length_full_temp= _l8
	label var 	length_full_temp "Full time temporary employment length (average)"

	gen 		emp_part_time= _AFl8a
	label var 	emp_part_time "Part-time workers last fiscal year"

	gen 		sales_total= _d2
	label var 	sales_total "Total annual sales"

	gen 		sales_total_3y= _n3
	label var 	sales_total_3y "Total annual sales three years ago"
	
***********************************

*********** Registration **********

	gen 		startup_registered = _b6a
	label var 	startup_registered	"	Establishment year registration status (1 if yes)	"
	
	gen 		register_year = _b6b
	label var 	register_year	"	Year establishment formally registered 	"

**********************************

*********** Constraints **********

*********** Constraints Based on Categorical Variables **********

	gen 		obstacle_electricity = _c30a
	label def 	obstacles 0 "No obstacle" 1 "Minor obstacles" 2 "Moderate obstacles" 3 "Major obstacles" 4 "Very sever obstacles"
	label val 	obstacle_electricity obstacles
	label var 	obstacle_electricity	"	Degree at which electricity an obstacle to the current operations 	"
	
	gen 		obstacle_telecom = _c30b
	label val 	obstacle_telecom obstacles
	label var 	obstacle_telecom	"	Degree at which telecommunications an obstacle to the current operations	"
	
	gen 		obstacle_transport = _d30a
	label val 	obstacle_transport obstacles
	label var 	obstacle_transport	"	Degree at which transport an obstacle to the current operations 	"
	
	gen 		obstacle_custom_regulation = _d30b
	label val 	obstacle_custom_regulation obstacles
	label var 	obstacle_custom_regulation	"	Degree at which customs and trade regulations are obstacle to the current operations 	"
	
	gen 		obstacle_informal_firm_practice = _e30
	label val 	obstacle_informal_firm_practice obstacles
	label var 	obstacle_informal_firm_practice	"	Degree at which Practices of Competitors in the Informal Sector an obstacle to the current operations	"
	
	gen 		obstacle_access_land = _g30a
	label val 	obstacle_access_land obstacles
	label var 	obstacle_access_land	"	Degree at which access to land an obstacle to the current operations	"
	
	gen 		obstacle_crime = _i30
	label val 	obstacle_crime obstacles
	label var 	obstacle_crime	"	Degree at which Crime, Theft and Disorder an obstacle to the current operations	"
	
	gen 		obstacle_access_finance = _k30
	label val 	obstacle_access_finance obstacles
	label var 	obstacle_access_finance	"	Degree at which access to finance an obstacle to the current operations	"
	
	gen 		obstacle_tax_rate = _j30a
	label val 	obstacle_tax_rate obstacles
	label var 	obstacle_tax_rate	"	Degree at which tax rates an obstacle to the current operations	"
	
	gen 		obstacle_tax_admin = _j30b
	label val 	obstacle_tax_admin obstacles
	label var 	obstacle_tax_admin	"	Degree at which tax administration an obstacle to the current operations	"
	
	gen 		obstacle_license_permit = _j30c
	label val 	obstacle_license_permit obstacles
	label var 	obstacle_license_permit	"	Degree at which business licensing and permits an obstacle to the current operations"
	
	gen 		obstacle_political = _j30e
	label val 	obstacle_political obstacles
	label var 	obstacle_political	"	Degree at which political instability  an obstacle to the current operations	"
	
	gen 		obstacle_corruption = _j30f
	label val 	obstacle_corruption obstacles
	label var 	obstacle_corruption	"	Degree at which corruption  an obstacle to the current operations	"
	
	gen 		obstacle_courts = _h30
	label val 	obstacle_courts obstacles
	label var 	obstacle_courts	"	Degree at which courts an obstacle to the current operations	"
	
	gen 		obstacle_labor_regulation = _l30a
	label val 	obstacle_labor_regulation obstacles
	label var 	obstacle_labor_regulation	"	Degree at which labor regulations an obstacle to the current operations	"
	
	gen 		obstacle_labor_edu_inadqt = _l30b
	label val 	obstacle_labor_edu_inadqt obstacles
	label var 	obstacle_labor_edu_inadqt	"	Degree at which inadequately educated workforce an obstacle to the current operations	"
					
*********** Constraints Based on Biggest Obstacles **********

	gen 		obstacle_first = _m1a
	label var 	obstacle_first "First most serioius obstacle faced by this establishment"

	gen 		obstacle_second = . 
	label var 	obstacle_second "Second most serioius obstacle faced by this establishment"
	
	gen 		obstacle_third = . 
	label var 	obstacle_third "Third most serioius obstacle faced by this establishment"
	
	label def 	obs_business_environment 1 "Access to finance" 2 "Access to land" ///
				3 "Business licensing and permits" 4 "Corruption" 5 "Courts" 	  ///
				6 "Crime, theft and disorder" 7 "Customs and trade regulations"   ///
				8 "Electricity" 9 "Inadequately educated workforce" 			  ///
				10 "Labor regulations" 11 "Political instability"  				  ///
				12 "Practices of competitors in the informal sector" 			  ///
				13 "Tax administration" 14 "Tax rates" 15 "Transport" 			///
				16 "Telecommunication" 17 "Macroeconomic environment" 			///
				18 "Zoning restrictions" 19 "Regulation on hours of operation"  ///
				20 "Regulation on pricing and mark-ups" 21 "Cost of finance" 	///
				22 "Policy uncertainity" 23 "Shortage of water supply" 			///
				24 "Shortage of capital" 										///
				25 "Practices of competitors in the Formal sector" 				///
				26 "Lack of market"  27 "Shortage of input" 					///
				28 "Massive in flood of aid food" 								///
				29 "Excessive flooding of illegally imported goods" 			///
				30 "Competition from imported goods" 							///
				31 "Implementation of government regulation" 					///
				32 "Availability of raw materials" 33 "Rising of input prices" 	///
				34 "Shortage and lack of critical spare parts and specialized technologies" /// 
				35 "Bureaucratic burden" 36 "Control and regulation" 99 "Other" 
	label val 	obstacle_first obs_business_environment
	label val 	obstacle_second obs_business_environment
	label val 	obstacle_third obs_business_environment			
	
	
*** Creating Binaries for Obstacle First **
	
	gen 		ob1_electricity = _m1a == 8 if !missing(_m1a)
	gen 		ob1_transportation = _m1a == 15 if !missing(_m1a)
	gen 		ob1_access_land = _m1a == 2 if !missing(_m1a)
	gen 		ob1_tax_rates = _m1a == 14 if !missing(_m1a)	
	gen 		ob1_tax_admin = _m1a == 13 if !missing(_m1a)	
	gen 		ob1_customs = _m1a == 7 if !missing(_m1a)
	gen 		ob1_courts = _m1a == 5 if !missing(_m1a)	
	gen 		ob1_labor_reg = _m1a == 10 if !missing(_m1a)	
	gen 		ob1_labor_edu_inadqt = _m1a == 9 if !missing(_m1a)
	gen 		ob1_license_permit = _m1a == 3 if !missing(_m1a)
	gen 		ob1_access_finance = _m1a == 1 if !missing(_m1a)	
	gen 		ob1_political_instability = _m1a == 11 if !missing(_m1a)		
	gen 		ob1_corruption = _m1a == 4 if !missing(_m1a)	
	gen 		ob1_crime = _m1a == 6 if !missing(_m1a)
	gen 		ob1_informal_firm_practice = _m1a == 12 if !missing(_m1a)

	
	label var 	ob1_electricity  "electricity (obstacle first)"
	label var 	ob1_transportation "transportation (obstacle first)"
	label var 	ob1_access_land "access to land (obstacle first)"
	label var 	ob1_tax_rates  "tax rates (obstacle first)"
	label var 	ob1_tax_admin  "tax administration (obstacle first)"
	label var 	ob1_customs  "customs and Trade Regulations (obstacle first)"
	label var 	ob1_courts  "Functioning of the courts (obstacle first)"
	label var 	ob1_labor_reg  "labor regulations (obstacle first)"	
	label var 	ob1_labor_edu_inadqt  "	 inadequately educated workforce (obstacle first)"
	label var 	ob1_license_permit "business licensing and Permits (obstacle first)"
	label var 	ob1_access_finance  " access to finance (availability and cost) (obstacle first)"
	label var 	ob1_political_instability  " political instability (obstacle first)"
	label var 	ob1_corruption  "corruption (obstacle first)"
	label var 	ob1_crime  " crime, theft and disorder (obstacle first)"
	label var 	ob1_informal_firm_practice  "practices of competitors in the informal sector (obstacle first)"

	
	
** Ordering variables **

order id_firm-obstacle_third

sum id_firm-obstacle_third


save "Data/02_Country/angola_wbes_regular_prepared_2010.dta",replace
