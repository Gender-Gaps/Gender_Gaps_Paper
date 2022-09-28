

*\\\///  Project:  Foundational analysis to close the gender profit gap (GPG)      
*\\\///  Purpose:  Use WBES for Global Data Analysis (Angola)                              
*\\\///  Data brought in: Cleaned Data File 2010 Informal (cleaned_2010_informal)                          
*\\\///  Data created: Prepared File 2010 Informal (prepared_2010_informal)                          
*\\\///  Unit of observation : Firm level Data 
*\\\///  Unique identifier(id): firm  
*\\\///  Date:  Dec 19, 2021                                                    
*\\\///  Author:  Nusrat Jimi                                                     
							   
use "Data/02_Country/angola_wbes_informal_cleaned_2010.dta",clear 

	gen 		id_firm = idstd
	label var 	id_firm "Firm ID"
	tostring 	id_firm, replace

** check uniqueness

	count
	codebook 	id_firm
		
	***** Sampling ******
	
	gen 		samp_region= _a3a
	label val 	samp_region A3A
	label var 	samp_region "sampling region"


    ********* Industry Sector ********
    
	tab 		Sc2b,m
	tab 		_Sc2b,m

	gen 		ind_cloth_manuf= _Sc2b == 1 if !missing(_Sc2b)
	label var 	ind_cloth_manuf "Manufacturing of clothes or shoes "

	gen 		ind_bakery = _Sc2b == 2 if !missing(_Sc2b)
	label var 	ind_bakery  "Manufacturing of baked food (Baker) "

	gen 		ind_food= _Sc2b == 3 if !missing(_Sc2b)
	label var 	ind_food "Manufacturing of processed foods "

	gen 		ind_handcraft= _Sc2b == 4 if !missing(_Sc2b)
	label var 	ind_handcraft "Manufacturing of handcrafts "

	gen 		ind_furniture = _Sc2b == 5 if !missing(_Sc2b)
	label var 	ind_furniture "Manufacturing of furniture"

	gen 		ind_metal= _Sc2b == 6 if !missing(_Sc2b)
	label var 	ind_metal "Manufacturing of metal products"

	gen 		ind_hh_items= _Sc2b == 7 if !missing(_Sc2b)
	label var 	ind_hh_items "Manufacturing of household items"

	gen 		ind_instrument= .
	label var 	ind_instrument "Manufacturing of tools and instruments "

	gen 		ind_other_manufacturing = _Sc2b == 14 if !missing(_Sc2b)
	label var 	ind_other_manufacturing "Other manufacturing (not included above)"

	gen 		ind_grocery = _Sc2b == 15 if !missing(_Sc2b)
	label var 	ind_grocery "Selling food or Groceries"
	
	gen			ind_cloth_sell = _Sc2b == 16 if !missing(_Sc2b)
	label var	ind_cloth_sell "Selling of clothes or household items "

	gen 		ind_othergoods= _Sc2b == 17 if !missing(_Sc2b)
	label var 	ind_othergoods "Selling of other goods "

	gen 		ind_business_service= _Sc2b == 18 if !missing(_Sc2b)
	label var 	ind_business_service "Selling of business/computer/phone services"

	gen 		ind_transport= _Sc2b == 19 if !missing(_Sc2b)
	label var 	ind_transport "Transport Services"

	gen 	    ind_cleaning = _Sc2b == 20 if !missing(_Sc2b)
	label var 	ind_cleaning "Cleaning and washing services "
	
	gen			ind_hairdresser = _Sc2b == 21 if !missing(_Sc2b)
	label var	ind_hairdresser "Hairdressers and barber shops "

	gen 		ind_professional= _Sc2b == 22 if !missing(_Sc2b)
	label var 	ind_professional "Professional Services "

	gen 		ind_repair= _Sc2b == 23 if !missing(_Sc2b)
	label var 	ind_repair "Repairing services"

	gen 		ind_construction= _Sc2b == 24 if !missing(_Sc2b)
	label var 	ind_construction "Construction"

	gen 		ind_other_services= _Sc2b == 30 if !missing(_Sc2b)
	label var 	ind_other_services "Other services (not included above) "
	
	gen 		startup_year = _b12
	label var 	startup_year	"Year establishment began operations" 

	gen 		startup_employee= _b13
	label var 	startup_employee "Establishment year full-time employees"
	
	tab 		_b14,m
	gen 		startup_registered = _b14
	recode      startup_registered 2=0
	label var 	startup_registered	"Businees was registered at start-up" 
    tab         b14 startup_registered,m
	
	tab 		_a4,m
	gen 		registered= _a4
	recode      registered 2=0
	label var 	registered "Businees is currently registered"
    tab         a4 registered,m

	tab 		e1,m 
	gen 		operate_location = _e1 
	label def 	loc 1 "Within household premises" 2 "Outside household premises"
	label val 	operate_location loc
	label var 	operate_location "Location of Operation"
	tab 		e1 operate_location, m 

 ************************
 ** Firm Ownership **
	
	gen 		female_ownership_1= .
	label var 	female_ownership_1 "Firm has at least one female owner"

	gen 		female_ownership_2= .
	label var 	female_ownership_2 "Percentage of female ownership"

	tab 		b3, m 
	gen 		female_ownership_3= _b3 == 1 if _b3 != .
	label var 	female_ownership_3 "The/at least one of the largest/ principal owner/s is female"
	tab 		b3 female_ownership_3 , m 

	tab 		b10, m 
	gen 		female_ownership_4= _b10==1 if _b10!=.
	label var 	female_ownership_4 "Top manager is female"
	tab 		b10 female_ownership_4 , m 
	
	tab 		b9, m 
	gen 		female_ownership_5 = _b9 == 1 if !missing(_b9)
	label var 	female_ownership_5 "Is the largest owner also the main decision maker?"
	tab 		b9 female_ownership_5, m 

	tab 		b1, m 
	gen 		owner_number= _b1 
	label var 	owner_number "Number of owners in the business"
	tab 		b1 owner_number , m 

	tab 		b2, m 
	gen 		owner_number_male= _b2 
	label var 	owner_number_male "Number of male owners in the business"
	tab 		b2 owner_number_male , m 

	tab         b15,m
	gen         owner_age= _b15
	label var   owner_age "Age of the largest owner" 
	tab 		b15 owner_age, m
		
	tab         b16,m
	gen         owner_marital_status= _b16
	label var   owner_marital_status "Marital status of the largest owner" 
	tab 		b16 owner_marital_status, m

******************************

*********** Employee **********

	gen 		emp_paid= _l3a
	label var 	emp_paid "Number of paid workers in an usual month"

	gen 		emp_unpaid= _l3b
	label var 	emp_unpaid "Number of unpaid workers in an usual month"

	gen 		emp_paid_female= _l6a
	label var 	emp_paid_female "Number of paid female workers last month"

	gen 		emp_unpaid_female= _l6b
	label var 	emp_unpaid_female "Number of unpaid female workers last month"

	gen 		emp_hh_members= _l7
	label var 	emp_hh_members "Number of HH members worked last month"

	gen 		emp_startup = _b6
	label var 	emp_startup	"Full-time employees at start-up" 


*********** Sales and Profits **********

 
	gen 		sales_total_m= _d6
	label var 	sales_total_m "Monthly sales in a regular month of the year"
	

**********************************

*********** Constraints **********

*********** Constraints Based on Categorical Variables **********

	gen 		obstacle_electricity = .
	label var 	obstacle_electricity	"	Degree at which electricity an obstacle to the current operations 	"
	
	gen 		obstacle_telecom = .
	label var 	obstacle_telecom	"	Degree at which telecommunications an obstacle to the current operations	"
	
	gen 		obstacle_transport = .
	label var 	obstacle_transport	"	Degree at which transport an obstacle to the current operations 	"
	
	gen 		obstacle_custom_regulation = .
	label var 	obstacle_custom_regulation	"	Degree at which customs and trade regulations are obstacle to the current operations 	"
	
	gen 		obstacle_informal_firm_practice = .
	label var 	obstacle_informal_firm_practice	"	Degree at which Practices of Competitors in the Informal Sector an obstacle to the current operations	"
	
	gen 		obstacle_access_land = .
	label var 	obstacle_access_land	"	Degree at which access to land an obstacle to the current operations	"
	
	gen 		obstacle_crime = _i30
	label def 	obstacles 0 "No obstacle" 1 "Minor obstacles" 2 "Moderate obstacles" 3 "Major obstacles" 4 "Very sever obstacles"
	label val 	obstacle_crime obstacles
	label var 	obstacle_crime	"	Degree at which Crime, Theft and Disorder an obstacle to the current operations	"
	
	gen 		obstacle_access_finance = .
	label var 	obstacle_access_finance	"	Degree at which access to finance an obstacle to the current operations	"
	
	gen 		obstacle_tax_rate = .
	label var 	obstacle_tax_rate	"	Degree at which tax rates an obstacle to the current operations	"
	
	gen 		obstacle_tax_admin = .
	label var 	obstacle_tax_admin	"	Degree at which tax administration an obstacle to the current operations	"
	
	gen 		obstacle_license_permit = .
	label var 	obstacle_license_permit	"	Degree at which business licensing and permits an obstacle to the current operations"
	
	gen 		obstacle_political = .
	label var 	obstacle_political	"	Degree at which political instability  an obstacle to the current operations	"
	
	gen 		obstacle_corruption = .
	label var 	obstacle_corruption	"	Degree at which corruption  an obstacle to the current operations	"
	
	gen 		obstacle_courts = .
	label var 	obstacle_courts	"	Degree at which courts an obstacle to the current operations	"
	
	gen 		obstacle_labor_regulation = .
	label var 	obstacle_labor_regulation	"	Degree at which labor regulations an obstacle to the current operations	"
	
	gen 		obstacle_labor_edu_inadqt = .
	label var 	obstacle_labor_edu_inadqt	"	Degree at which inadequately educated workforce an obstacle to the current operations	"

*********** Constraints Based on Biggest Obstacle **********
	
	gen 		obstacle_first = _m1a
	label def 	obs_business_environment 1 "Access to finance" 2 "Access to land" ///
				3 "Corruption"  4 "Crime, theft and disorder" 5 "Poor public infrastructure" ///
				6 "Inadequately educated workforce" 7 "Political instability"  	///
				8 "Business licensing and permits" 9 "Workers are unreliable" ///
				10 "Poor health of workforce" 11 "Limited demand for product or services" ///
				12 "Electricity" 13 "Transport" 99 "Other"
	label val 	obstacle_first obs_business_environment
	label var 	obstacle_first "First most serioius obstacle faced by this establishment"

	gen 		obstacle_second = . 
	label var 	obstacle_second "Second most serioius obstacle faced by this establishment"
	
	gen 		obstacle_third = . 
	label var 	obstacle_third "Third most serioius obstacle faced by this establishment"
	
*********** Creating Binaries for Biggest Obstacle Variable **********
	
	gen 		ob1_access_finance = _m1a == 1 if !missing(_m1a)	
	gen 		ob1_access_land = _m1a == 2 if !missing(_m1a)
	gen 		ob1_corruption = _m1a == 3 if !missing(_m1a)	
	gen 		ob1_crime = _m1a == 4 if !missing(_m1a)
	gen 		ob1_infrastructure = _m1a == 5 if !missing(_m1a)
	gen 		ob1_labor_edu_inadqt = _m1a == 6 if !missing(_m1a)
	gen 		ob1_political_instability = _m1a == 7 if !missing(_m1a)	
	gen 		ob1_license_permit = _m1a == 8 if !missing(_m1a)
	gen 		ob1_labor_unreliable = _m1a == 9 if !missing(_m1a)
	gen 		ob1_labor_health = _m1a == 10 if !missing(_m1a)
	gen 		ob1_low_demand = _m1a == 11 if !missing(_m1a)
	
	label var 	ob1_labor_health "poor health of workforce"
	label var  	ob1_labor_unreliable "unreliable workers (obstacle first)"
	label var 	ob1_infrastructure "poor infrastructur (obstacle first)"
	label var 	ob1_access_land "access to land (obstacle first)"
	label var 	ob1_labor_edu_inadqt  "	 inadequately educated workforce (obstacle first)"
	label var 	ob1_license_permit "business licensing and Permits (obstacle first)"
	label var 	ob1_access_finance  " access to finance (availability and cost) (obstacle first)"
	label var 	ob1_political_instability  " political instability (obstacle first)"
	label var 	ob1_corruption  "corruption (obstacle first)"
	label var 	ob1_crime  " crime, theft and disorder (obstacle first)"
	label var 	ob1_low_demand  "Limited demand for products and services (obstacle first)"	
	
	
** Ordering variables **

order id_firm-obstacle_third

sum id_firm-obstacle_third



save "Data/02_Country/angola_wbes_informal_prepared_2010.dta",replace

