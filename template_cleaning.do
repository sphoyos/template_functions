*! docver: 2.0
*!  title: Cleaning
*!   html: yes
*!    log: yes
*!comment: 
version 9.2

htput <H1> $HTtitle </H1>

local fecha:di  c(current_date)

htput <H1> `fecha' </H1>
  


version 9.0
set more off


local my_workbook "cleaning"

local source "Excel Files;DBQ=$orig\\`my_workbook'"
odbc query "`source'" 

odbc load, dsn("`source'") table("cleaning$") clear  lower datestring


*insheet using  "$orig\cleaning.csv", clear delimiter(";") names
local N: di _N

forvalues i=1(1)`N'{

di in red condition[`i']

        tempfile filetemp
		local cond : di condition[`i']
		local mess : di message[`i']
	    local varexp: di showvar[`i']
		local nquery: di n_query[`i']
        di in red `"`cond'"'
		
		
		preserve
		

		
/*Testa si ja existeixen les errades i estan corregides	*/


   	use   "$orig\dades_orig", clear

  rename iniciales  SubjID	
lab var  SubjID "Identificador "
	
			ht_cleaning `cond' , mess(`"`mess'"') vars(`"`varexp'"') quest("Estudi trasplants medul·la") query(`"`nquery'"') saving("`filetemp'")  
		
		
	
		
	*	if  `i' ==1 {
		
	*	use `filetemp',clear 
	*	save $dta/sec/queries,replace
	*	}
	*			else {
	*		
	*	use $dta/sec/queries ,replace
	*	append using `filetemp'
	*	compress
	*	save $dta/sec/queries,replace
		
		
	*	}
		restore
		
	}	
		
*			use  $dta/sec/queries,clear

*		local nomfile= "queries"+subinstr("`fecha'"," ","_",.)+".dta"
*		save $dta/sec/`nomfile',replace
		

			
		
set more on