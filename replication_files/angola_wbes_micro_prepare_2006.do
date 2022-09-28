

*\\\///  Project:  Foundational analysis to close the gender profit gap (GPG)      
*\\\///  Purpose:  Use WBES for Global Data Analysis (Angola)                              
*\\\///  Data brought in: Cleaned Data File 2006 Micro (cleaned_2006_micro)                          
*\\\///  Data created: Prepared File 2006 Micro (prepared_2006_micro)                          
*\\\///  Unit of observation : Firm level Data 
*\\\///  Unique identifier(id): firm  
*\\\///  Date:  Dec 16, 2021                                                    
*\\\///  Author:  Nusrat Jimi                                                     
							   
use "Data/02_Country/angola_wbes_micro_cleaned_2006.dta",clear 

	gen 		id_firm = idstd
	label var 	id_firm "Firm ID"
	tostring 	id_firm, replace

** check uniqueness

	count
	codebook 	id_firm
		
	***** Sampling ******
	
	gen 		samp_region= _reg
	label val 	samp_region reg
	label var 	samp_region "sampling region"


    ********* Industry Sector ********
    
	tab 		industry,m
	tab 		_industry,m

	gen 		ind_food= _industry == 1 if !missing(_industry)
	label var 	ind_food "Manufacturing Food  "

	gen 		ind_garments= _industry == 2 if !missing(_industry)
	label var 	ind_garments "Manufacturing Garments "

	gen 		ind_textiles= .
	label var 	ind_textiles "Textiles Industry"


	gen 		ind_machine_equipment= .
	label var 	ind_machine_equipment "Manufacturing Machinery and Equipment "

	gen 		ind_chemical = _industry == 5 if !missing(_industry)
	label var 	ind_chemical "Manufacturing Chemicals"

	gen 		ind_electronics= .
	label var 	ind_electronics "Manufacturing Electronics "

	gen 		ind_nonmetal_mineral= .
	label var 	ind_nonmetal_mineral "Manufacturing Non-metallic Mineral products "

	gen 		ind_wood= .
	label var 	ind_wood "Manufacturing Wood, Wood products and Furniture"

	gen 		ind_metal=.
	label var 	ind_metal "Manufacturing Metal and Metal products"

	gen 		ind_other_manufacturing = _industry == 10 if !missing(_industry)
	label var 	ind_other_manufacturing "Other Manufacturing"

	gen 		ind_retail = _industry == 11 if !missing(_industry)
	label var 	ind_retail "Retail industry"
	
	gen			ind_IT = _industry == 12 if !missing(_industry)
	label var	ind_IT "Information and Technology ROU"

	gen 		ind_construction_transport= .
	label var 	ind_construction_transport "Construction and transport industry ROU"

	gen 		ind_hotel_restaurant= _industry == 14 if !missing(_industry)
	label var 	ind_hotel_restaurant "Hotel and restaurants industry ROU"

	gen 		ind_others_ROU= _industry == 15 if !missing(_industry)
	label var 	ind_others_ROU "Others in the Rest of the Universe (ROU)"

	gen 		startup_year = _b4c
	label var 	startup_year	"Year establishment began operations" 

	gen 		startup_employee= _j1
	label var 	startup_employee "Establishment year full-time employees"

	tab 		i5a, m
	gen 		registration_name= (_i5a==1)  if !missing(_i5a)
	label var 	registration_name "Registered buiness name"
    tab 		registration_name i5a,m
	
	tab 		i5b, m
	gen 		registration_commercial= (_i5b==1)  if !missing(_i5b)
	label var 	registration_commercial "Registered as commercial business"
    tab 		registration_commercial i5b,m
	
	tab 		i5c, m
	gen 		registration_license= (_i5c==1)  if !missing(_i5c)
	label var 	registration_license "Registered for genral business license"
	tab 		registration_license i5c,m
	
	tab 		i5d, m
	gen 		registration_taxid= (_i5d==1)  if !missing(_i5d)
	label var 	registration_taxid "Registered for tax identification"
    tab 		registration_taxid i5d,m

 ************************
 ** Firm Ownership **
	
	gen 		female_ownership_1= .
	label var 	female_ownership_1 "Firm has at least one female owner"

	gen 		female_ownership_2= .
	label var 	female_ownership_2 "Percentage of female ownership"

	tab 		b3b1, m 
	gen 		female_ownership_3= _b3b1 == 1 if _b3b1 != .
	label var 	female_ownership_3 "The/at least one of the largest/ principal owner/s is female"
	tab 		b3b1 female_ownership_3 , m 
	
	gen 		female_ownership_4= .
	label var 	female_ownership_4 "Top manager is female"

******************************

*********** Employee **********

	gen 		emp_paid= _j2a
	label var 	emp_paid "Full-time paid workers in the last fiscal year"

	gen 		emp_paid_female= _j2b
	label var 	emp_paid_female "Full-time paid female workers in the last fiscal year"

	gen 		emp_part_time= _j4a
	label var 	emp_part_time "Part-time workers last fiscal year"

	gen 		emp_unpaid_fulltime= _j4b
	label var 	emp_unpaid_fulltime "Unpaid workers in the last fiscal year"

	gen 		emp_hh_members= _j4c
	label var 	emp_hh_members "Household employees in the last fiscal year"

	gen 		emp_paid_3y = _j2c
	label var 	emp_paid_3y	"Full-time paid workers three fiscal years ago" 


*********** Sales and Profits **********

 
	gen 		sales_total_m= _l1a
	label var 	sales_total_m "Total sales from last month"

	gen 		sales_total= _l1b
	label var 	sales_total "Total annual sales"


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
				obstacle_labor_regulation obstacle_labor_edu_inadqt, a(sales_total)

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
	label var 	obstacle_economic_instability "Degree at which macroeconomic instability an obstacle to the current operations"
	
*********** Constraints Based on Biggest Obstacles ***********

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




*** Creating Binaries for Obstacle Third **

	gen 		ob3_telecommunication = _f1b3 == 1 if !missing(_f1b3)
	gen 		ob3_electricity = _f1b3 == 2 if !missing(_f1b3)
	gen 		ob3_transportation = _f1b3 == 3 if !missing(_f1b3)
	gen 		ob3_access_land = _f1b3 == 4 if !missing(_f1b3)
	gen 		ob3_tax_rates = _f1b3 == 5 if !missing(_f1b3)	
	gen 		ob3_tax_admin = _f1b3 == 6 if !missing(_f1b3)	
	gen 		ob3_customs = _f1b3 == 7 if !missing(_f1b3)
	gen 		ob3_courts = _f1b3 == 8 if !missing(_f1b3)	
	gen 		ob3_labor_reg = _f1b3 == 9 if !missing(_f1b3)	
	gen 		ob3_labor_edu_inadqt = _f1b3 == 10 if !missing(_f1b3)
	gen 		ob3_license_permit = _f1b3 == 11 if !missing(_f1b3)
	gen 		ob3_access_finance = _f1b3 == 12 if !missing(_f1b3)	
	gen 		ob3_political_instability = _f1b3 == 13 if !missing(_f1b3)	
	gen 		ob3_macroecon_instability = _f1b3 == 14 if !missing(_f1b3)	
	gen 		ob3_corruption = _f1b3 == 15 if !missing(_f1b3)	
	gen 		ob3_crime = _f1b3 == 16 if !missing(_f1b3)
	gen 		ob3_informal_firm_practice = _f1b3 == 17 if !missing(_f1b3)

	
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




** Ordering variables **

order id_firm-obstacle_third obstacle_economic_instability

sum id_firm-obstacle_third obstacle_economic_instability


save "Data/02_Country/angola_wbes_micro_prepared_2006.dta",replace

