

*\\\///  Project:  Foundational analysis to close the gender profit gap (GPG)      
*\\\///  Purpose:  Use WBES for Global Data Analysis (Angola)                              
*\\\///  Data brought in: Cleaned Data File 2006 (cleaned_2006)                          
*\\\///  Data created: Prepared File 2006 (prepared_2006)                          
*\\\///  Unit of observation : Firm level Data 
*\\\///  Unique identifier(id): firm  
*\\\///  Date:  Nov 26, 2021                                                    
*\\\///  Author:  DEN                                                     
							   
use "Data/02_Country/angola_wbes_regular_cleaned_2006.dta",clear 

	gen 		id_firm = idstd
	label var 	id_firm "Firm ID"
	tostring 	id_firm, replace 

** check uniqueness

	count
	codebook 	id_firm
	
	order 		weights_sec weights_locsec, a(id_firm)
	
***** Sampling ******
	
	gen 		samp_region= _reg
	label val 	samp_region reg
	label var 	samp_region "sampling region"

***** Firm Size ******

	gen 		size_micro = .
	label var 	size_micro "less than 5 employees" 

	tab 		screensi, m 
	gen 		size_small= _screensi == 1 if !missing(_screensi)
	label var 	size_small "5 to 19 employees" 
	tab 		screensi size_small, m 
	
	tab 		screensi, m 
	gen 		size_medium=  _screensi == 2 if !missing(_screensi)
	label var 	size_medium "20 to 99 employees" 
	tab 		screensi size_medium, m 

	tab 		screensi, m 
	gen 		size_large= _screensi == 3 if !missing(_screensi)
	label var 	size_large "100 or more employees"
	tab 		screensi size_large, m 

************************************


********* Industry Sector ********

	gen 		ind_food= _industry == 1 if !missing(_industry)
	label var 	ind_food "Food industry"

	gen 		ind_tobacco= .
	label var 	ind_tobacco "Tobacco industry"

	gen 		ind_textiles= _industry == 3 if !missing(_industry)
	label var 	ind_textiles "Textiles industry"

	gen 		ind_garments= _industry == 2 if !missing(_industry)
	label var 	ind_garments "Garments industry"

	gen 		ind_leather = .
	label var 	ind_leather "Leather industry"

	gen 		ind_wood= _industry == 8 if !missing(_industry)
	label var 	ind_wood "Wood industry"

	gen 		ind_paper= .
	label var 	ind_paper "Paper industry"

	gen 		ind_media= .
	label var 	ind_media "Recorded media industry"

	gen 		ind_petroleum=.
	label var 	ind_petroleum "Refined petroleum product industry"

	gen 		ind_chemical= _industry == 5 if !missing(_industry)
	label var 	ind_chemical "Chemicals industry"

	gen 		ind_plastic_rubber= .
	label var 	ind_plastic_rubber "Plastics & rubber"

	gen 		ind_nonmetal_mineral=  _industry == 7 if !missing(_industry)
	label var 	ind_nonmetal_mineral "Non metallic mineral products"

	gen 		ind_metal_basic= .
	label var 	ind_metal_basic "Basic metals"

	gen 		ind_metal_fabricated= _industry == 9 if !missing(_industry)
	label var 	ind_metal_fabricated "Fabricated metal products"

	gen 		ind_machine_appliance = _industry == 4 if !missing(_industry)
	label var	ind_machine_appliance "Manufacture of general and special purppose machinery and domestic appliances"

	gen 		ind_machine_computing = .
	label var	ind_machine_computing "Manufacture of office accounting and computing machinery"

	gen 		ind_electronics= .
	label var 	ind_electronics "Electronics (31 & 32)"

	gen 		ind_precsn_inst = .
	label var 	ind_precsn_inst "Precision instruments"

	gen 		ind_transport_machine= .
	label var 	ind_transport_machine "Transport machines (34&35)"

	gen 		ind_other_manufacturing = _industry == 10 if !missing(_industry)
	label var 	ind_other_manufacturing "Manufacture N.E.C"

	gen 		ind_recycling= .
	label var 	ind_recycling "Recycling industry"

	gen 		ind_retail = .
	label var 	ind_retail "Retail industry"
	
	gen			ind_utility = .
	label var	ind_utility "Electricity, gas and water supply"

	gen 		ind_wholesale= .
	label var 	ind_wholesale "Wholesale industry"

	gen 		ind_hotel_restaurant= .
	label var 	ind_hotel_restaurant "Hotel and restaurants industry section H"

	gen 		ind_motor_vehicle= .
	label var 	ind_motor_vehicle "Services of motor vehicles industry"

	gen 		ind_construction= .
	label var 	ind_construction "Construction industry Section F"

	gen 		ind_transport_communication =.
	label var 	ind_transport_communication "Transport and communication industry Section I: (60-64)"

	gen 		ind_financial = .
	label var 	ind_financial "Financial intermediation (65-67)"
	
	gen			ind_realestate	=	.	
	label var	ind_realestate	"Real estate, renting and business activities"
	
	gen			ind_renting	=	.	
	label var	ind_renting	"Renting of machinery and equipment "
	
	gen			ind_computer_service =	.
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

	gen 		startup_year = _b4c
	label var 	startup_year	"Year establishment began operations" 

	gen 		startup_employee= _j1
	label var 	startup_employee "Establishment year full-time employees"


******************************
** Firm Ownership **
	
	gen 		female_ownership_1 = .
	label var 	female_ownership_1 "Firm has at least one female owner"

	gen 		female_ownership_2 = .
	label var 	female_ownership_2 "Percentage of female ownership"

	tab 		_b3b1, m 
	gen 		female_ownership_3 = _b3b1 == 1 if !missing(_b3b1)
	label var 	female_ownership_3 "The/at least one of the largest/ principal owner/s is female"
	tab 		b3b1 female_ownership_3, m 

	gen 		female_ownership_4 = .
	label var 	female_ownership_4 "Top manager is female"
	
	gen 		owner_composition = .
	label var 	owner_composition "Gender composition of owner"

******************************

*********** Employee **********

	gen 		emp_full_perm= _j2a
	label var 	emp_full_perm "Permanent full-time workers last fiscal year"

	gen 		emp_full_perm_3y= _j2c
	label var 	emp_full_perm_3y "Permanent full-time workers three years ago"

	gen 		emp_full_perm_5y= .
	label var 	emp_full_perm_5y "Permanent full-time workers five fiscal years ago"

	gen 		emp_full_perm_7y= .
	label var 	emp_full_perm_7y "Permanent full-time workers seven fiscal years ago"

	egen 		emp_full_perm_female= rowtotal (_j2b1 _j2b2)
	label var 	emp_full_perm_female "Permanent female full-time workers"

	gen 		emp_full_perm_prod_female = _j2b1
	label var 	emp_full_perm_prod_female	"Permanent female full-time production workers" 

	gen 		emp_full_perm_nonprod_female = _j2b2
	label var 	emp_full_perm_nonprod_female	"Permanent female full-time non-production workers"

	gen 		emp_full_temp= _j3a
	label var 	emp_full_temp "Permanent full-time temporary/seasonal workers last fiscal year"

	gen 		emp_full_temp_female = (_j3b/100) * emp_full_temp if emp_full_temp != . & _j3b != . 
	label var 	emp_full_temp_female "Permanent full-time female temporary/ seasonal workers last fiscal year"

	gen 		length_full_temp= _j3c
	label var 	length_full_temp "Full time temporary employment length (average)"

	gen 		emp_part_time= _j4a
	label var 	emp_part_time "Part-time workers last fiscal year"

	gen 		sales_total= _l1b
	label var 	sales_total "Total annual sales"

	gen 		sales_total_3y= _l1c
	label var 	sales_total_3y "Total annual sales three years ago"
	
***********************************

*********** Registration **********

	gen 		startup_registered = .
	label var 	startup_registered	"	Establishment year registration status (1 if yes)	"
	
	gen 		register_year = .
	label var 	register_year	"	Year establishment formally registered 	"

**********************************

*********** Constraints **********

*********** Constraints Based on Categorical Variables **********

    recode 		_f1a1-_f1a13 _f1a15-_f1a17 _f1a14 (1 = 0 "No obstacle") 		///
				(2 = 1 "Minor obstacle") (3 = 2 "Moderate obstacle") 			///
				(4 = 3 "Major Obstacles") (5 = 4 "Very Sever Obstacles") 		///
				, gen(obstacle_telecom obstacle_electricity  obstacle_transport ///
				 obstacle_access_land obstacle_tax_rate obstacle_tax_admin 		///
				 obstacle_custom_regulation obstacle_courts 					///
				 obstacle_labor_regulation obstacle_labor_edu_inadqt 			///
				 obstacle_license_permit obstacle_access_finance				///
				 obstacle_political obstacle_corruption obstacle_crime 			///
				 obstacle_informal_firm_practice obstacle_economic_instability ) label(obstacles)
				 
	order 		obstacle_electricity obstacle_telecom obstacle_transport 		///
				obstacle_custom_regulation obstacle_informal_firm_practice 		///
				obstacle_access_land  obstacle_crime obstacle_access_finance 	///
				obstacle_tax_rate obstacle_tax_admin obstacle_license_permit 	///
				obstacle_political obstacle_corruption obstacle_courts 			///
				obstacle_labor_regulation obstacle_labor_edu_inadqt, a(register_year)
	
	label var 	obstacle_electricity	"Degree at which electricity an obstacle to the current operations "
	label var 	obstacle_telecom	"Degree at which telecommunications an obstacle to the current operations"
	label var 	obstacle_transport	"Degree at which transport an obstacle to the current operations"
	label var 	obstacle_custom_regulation	"Degree at which customs and trade regulations are obstacle to the current operations 	"
	label var 	obstacle_informal_firm_practice	"Degree at which Practices of Competitors in the Informal Sector an obstacle to the current operations	"
	label var 	obstacle_access_land	"Degree at which access to land an obstacle to the current operations	"
	label var 	obstacle_crime	"Degree at which Crime, Theft and Disorder an obstacle to the current operations	"
	label var 	obstacle_access_finance	"Degree at which access to finance an obstacle to the current operations	"
	label var 	obstacle_tax_rate	"Degree at which tax rates an obstacle to the current operations	"
	label var 	obstacle_tax_admin	"Degree at which tax administration an obstacle to the current operations	"
	label var 	obstacle_license_permit	"Degree at which business licensing and permits an obstacle to the current operations"
	label var 	obstacle_political	"Degree at which political instability  an obstacle to the current operations	"
	label var 	obstacle_corruption	"Degree at which corruption  an obstacle to the current operations	"
	label var 	obstacle_courts	"Degree at which courts an obstacle to the current operations	"
	label var 	obstacle_labor_regulation	"Degree at which labor regulations an obstacle to the current operations	"
	label var 	obstacle_labor_edu_inadqt	"Degree at which inadequately educated workforce an obstacle to the current operations	"
	label var 	obstacle_economic_instability	"Degree at which macroeconomic condition an obstacle to the current operations	"
	
*********** Constraints Based on Biggest Obstacle **********
	
	recode      _f1b1 (1=16) (2=8) (3=15) (4=2) (5=14) (6=13) (7=7) (8=5) (9=10) (10=9) (11=3) ///
					  (12=1) (13 = 11) (14 = 17) (15 = 4) (16 = 6) (17 = 12), 	 ///
					  gen(obstacle_first)
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
	label var 	obstacle_first "Most serioius obstacle faced by this establishment"

	recode      _f1b2 (1=16) (2=8) (3=15) (4=2) (5=14) (6=13) (7=7) (8=5) (9=10) (10=9) (11=3) ///
					  (12=1) (13 = 11) (14 = 17) (15 = 4) (16 = 6) (17 = 12), 	 ///
						gen(obstacle_second)
	label val 	obstacle_second obs_business_environment						
	label var 	obstacle_second "Second most serioius obstacle faced by this establishment"
	
	recode      _f1b3 (1=16) (2=8) (3=15) (4=2) (5=14) (6=13) (7=7) (8=5) (9=10) (10=9) (11=3) ///
					  (12=1) (13 = 11) (14 = 17) (15 = 4) (16 = 6) (17 = 12), 	 ///
						gen(obstacle_third)
	label val 	obstacle_third obs_business_environment						
	label var 	obstacle_third "Third most serioius obstacle faced by this establishment"

*** Creating Binaries for Obstacle First **
	
	gen 		ob1_telecommunication = _f1b1 == 1 if !missing(_f1b1)
	gen 		ob1_electricity = _f1b1 == 2 if !missing(_f1b1)
	gen 		ob1_transportation = _f1b1 == 3 if !missing(_f1b1)
	gen 		ob1_access_land = _f1b1 == 4 if !missing(_f1b1)
	gen 		ob1_tax_rates = _f1b1 == 5 if !missing(_f1b1)	
	gen 		ob1_tax_admin = _f1b1 == 6 if !missing(_f1b1)	
	gen 		ob1_customs = _f1b1 == 7 if !missing(_f1b1)
	gen 		ob1_courts = _f1b1 == 8 if !missing(_f1b1)	
	gen 		ob1_labor_reg = _f1b1 == 9 if !missing(_f1b1)	
	gen 		ob1_labor_edu_inadqt = _f1b1 == 10 if !missing(_f1b1)
	gen 		ob1_license_permit = _f1b1 == 11 if !missing(_f1b1)
	gen 		ob1_access_finance = _f1b1 == 12 if !missing(_f1b1)	
	gen 		ob1_political_instability = _f1b1 == 13 if !missing(_f1b1)	
	gen 		ob1_macroecon_instability = _f1b1 == 14 if !missing(_f1b1)	
	gen 		ob1_corruption = _f1b1 == 15 if !missing(_f1b1)	
	gen 		ob1_crime = _f1b1 == 16 if !missing(_f1b1)
	gen 		ob1_informal_firm_practice = _f1b1 == 17 if !missing(_f1b1)
	gen 		ob1_zoning_restrictions = _f1b1 == 18 if !missing(_f1b1)
	gen 		ob1_hours_op_reg = _f1b1 == 19 if !missing(_f1b1)
	gen 		ob1_pricing_reg = _f1b1 == 20 if !missing(_f1b1)
	
	label var 	ob1_telecommunication "telecommunication (obstacle first)"
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
	label var 	ob1_macroecon_instability  " macroeconomic instability (obstacle first)"
	label var 	ob1_corruption  "corruption (obstacle first)"
	label var 	ob1_crime  " crime, theft and disorder (obstacle first)"
	label var 	ob1_informal_firm_practice  "practices of competitors in the informal sector (obstacle first)"
	label var 	ob1_zoning_restrictions  " zoning restrictions (obstacle first)"
	label var 	ob1_hours_op_reg  " regulation on hours of operation (obstacle first)"
	label var 	ob1_pricing_reg " regulations on pricing and mark-ups (obstacle first)"
	
	
*** Creating Binaries for Obstacle Second **

	gen 		ob2_telecommunication = _f1b2 == 1 if !missing(_f1b2)
	gen 		ob2_electricity = _f1b2 == 2 if !missing(_f1b2)
	gen 		ob2_transportation = _f1b2 == 3 if !missing(_f1b2)
	gen 		ob2_access_land = _f1b2 == 4 if !missing(_f1b2)
	gen 		ob2_tax_rates = _f1b2 == 5 if !missing(_f1b2)	
	gen 		ob2_tax_admin = _f1b2 == 6 if !missing(_f1b2)	
	gen 		ob2_customs = _f1b2 == 7 if !missing(_f1b2)
	gen 		ob2_courts = _f1b2 == 8 if !missing(_f1b2)	
	gen 		ob2_labor_reg = _f1b2 == 9 if !missing(_f1b2)	
	gen 		ob2_labor_edu_inadqt = _f1b2 == 10 if !missing(_f1b2)
	gen 		ob2_license_permit = _f1b2 == 11 if !missing(_f1b2)
	gen 		ob2_access_finance = _f1b2 == 12 if !missing(_f1b2)	
	gen 		ob2_political_instability = _f1b2 == 13 if !missing(_f1b2)	
	gen 		ob2_macroecon_instability = _f1b2 == 14 if !missing(_f1b2)	
	gen 		ob2_corruption = _f1b2 == 15 if !missing(_f1b2)	
	gen 		ob2_crime = _f1b2 == 16 if !missing(_f1b2)
	gen 		ob2_informal_firm_practice = _f1b2 == 17 if !missing(_f1b2)
	gen 		ob2_zoning_restrictions = _f1b2 == 18 if !missing(_f1b2)
	gen 		ob2_hours_op_reg = _f1b2 == 19 if !missing(_f1b2)
	gen 		ob2_pricing_reg = _f1b2 == 20 if !missing(_f1b2)
	
	label var 	ob2_telecommunication "telecommunication (obstacle second)"
	label var 	ob2_electricity  "electricity (obstacle second)"
	label var 	ob2_transportation "transportation (obstacle second)"
	label var 	ob2_access_land "access to land (obstacle second)"
	label var 	ob2_tax_rates  "tax rates (obstacle second)"
	label var 	ob2_tax_admin  "tax administration (obstacle second)"
	label var 	ob2_customs  "customs and Trade Regulations (obstacle second)"
	label var 	ob2_courts  "Functioning of the courts (obstacle second)"
	label var 	ob2_labor_reg  "labor regulations (obstacle second)"	
	label var 	ob2_labor_edu_inadqt  "	 inadequately educated workforce (obstacle second)"
	label var 	ob2_license_permit "business licensing and Permits (obstacle second)"
	label var 	ob2_access_finance  " access to finance (availability and cost) (obstacle second)"
	label var 	ob2_political_instability  " political instability (obstacle second)"
	label var 	ob2_macroecon_instability  " macroeconomic instability (obstacle second)"
	label var 	ob2_corruption  "corruption (obstacle second)"
	label var 	ob2_crime  " crime, theft and disorder (obstacle second)"
	label var 	ob2_informal_firm_practice  "practices of competitors in the informal sector (obstacle second)"
	label var 	ob2_zoning_restrictions  " zoning restrictions (obstacle second)"
	label var 	ob2_hours_op_reg  " regulation on hours of operation (obstacle second)"
	label var 	ob2_pricing_reg " regulations on pricing and mark-ups (obstacle second)"



*** Creating Binaries for Obstacle Third **

	gen 		ob3_telecommunication = _f1b3 == 1 if !missing(_f1b3)
	gen 		ob3_electricity = _f1b3 == 2 if !missing(_f1b3)
	gen 		ob3_transportation = _f1b3 == 3  if !missing(_f1b3)
	gen 		ob3_access_land = _f1b3 == 4 if !missing(_f1b3)
	gen 		ob3_tax_rates = _f1b3 == 5 	if !missing(_f1b3)
	gen 		ob3_tax_admin = _f1b3 == 6 	if !missing(_f1b3)
	gen 		ob3_customs = _f1b3 == 7 if !missing(_f1b3)
	gen 		ob3_courts = _f1b3 == 8 	if !missing(_f1b3)
	gen 		ob3_labor_reg = _f1b3 == 9 	if !missing(_f1b3)
	gen 		ob3_labor_edu_inadqt = _f1b3 == 10  if !missing(_f1b3)
	gen 		ob3_license_permit = _f1b3 == 11 if !missing(_f1b3)
	gen 		ob3_access_finance = _f1b3 == 12 	if !missing(_f1b3)
	gen 		ob3_political_instability = _f1b3 == 13  if !missing(_f1b3)	
	gen 		ob3_macroecon_instability = _f1b3 == 14 if !missing(_f1b3)	
	gen 		ob3_corruption = _f1b3 == 15 	if !missing(_f1b3)
	gen 		ob3_crime = _f1b3 == 16 if !missing(_f1b3)
	gen 		ob3_informal_firm_practice = _f1b3 == 17  if !missing(_f1b3)
	gen 		ob3_zoning_restrictions = _f1b3 == 18 if !missing(_f1b3)
	gen 		ob3_hours_op_reg = _f1b3 == 19 if !missing(_f1b3)
	gen 		ob3_pricing_reg = _f1b3 == 20 if !missing(_f1b3)
	
	label var 	ob3_telecommunication "telecommunication (obstacle third)"
	label var 	ob3_electricity  "electricity (obstacle third)"
	label var 	ob3_transportation "transportation (obstacle third)"
	label var 	ob3_access_land "access to land (obstacle third)"
	label var 	ob3_tax_rates  "tax rates (obstacle third)"
	label var 	ob3_tax_admin  "tax administration (obstacle third)"
	label var 	ob3_customs  "customs and Trade Regulations (obstacle third)"
	label var 	ob3_courts  "Functioning of the courts (obstacle third)"
	label var 	ob3_labor_reg  "labor regulations (obstacle third)"	
	label var 	ob3_labor_edu_inadqt  "	 inadequately educated workforce (obstacle third)"
	label var 	ob3_license_permit "business licensing and Permits (obstacle third)"
	label var 	ob3_access_finance  " access to finance (availability and cost) (obstacle third)"
	label var 	ob3_political_instability  " political instability (obstacle third)"
	label var 	ob3_macroecon_instability  " macroeconomic instability (obstacle third)"
	label var 	ob3_corruption  "corruption (obstacle third)"
	label var 	ob3_crime  " crime, theft and disorder (obstacle third)"
	label var 	ob3_informal_firm_practice  "practices of competitors in the informal sector (obstacle third)"
	label var 	ob3_zoning_restrictions  " zoning restrictions (obstacle third)"
	label var 	ob3_hours_op_reg  " regulation on hours of operation (obstacle third)"
	label var 	ob3_pricing_reg " regulations on pricing and mark-ups (obstacle third)"


	
***********************************

********** Added Variables ********

	gen 		emp_full_temp_female_p = _j3b
	label var 	emp_full_temp_female_p "Permanent full-time female temporary/ seasonal workers last fiscal year"

	gen 		obstacle_zoning = _f1a18 if _f1a18 !=.
	label var 	obstacle_zoning "Degree at which  Zoning restrictions an obstacle to the current operations"

	gen 		obstacle_hours_regulation = _f1a19 if _f1a19 !=.
	label var 	obstacle_hours_regulation "Degree at which Regulation on hours of operation an obstacle to the current operations"

	gen 		obstacle_pricing_regulation = _f1a20 if _f1a20 !=.
	label var 	obstacle_pricing_regulation "Degree at which Regulation on pricing and mark-ups an obstacle to the current operations"

** Ordering variables **

order id_firm-obstacle_third obstacle_economic_instability emp_full_temp_female_p

sum id_firm-obstacle_third	obstacle_economic_instability emp_full_temp_female_p

save "Data/02_Country/angola_wbes_regular_prepared_2006.dta",replace

