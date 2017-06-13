
************************** GIRAR VARIABLES A OBSERVACIONS ***********************

sxpose, clear firstnames destring

*********************************************************************************

unab listavar:*

foreach var of varlist `listavar' {
 cap ren `var' `=lower("`var'")'
}


************** LISTADO DE VARIABLES

unab listavar:*

foreach var of varlist `listavar' {

****** Prepara para poner etiquetas a las variables

 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"
 disp "label var `var' "  char(34) "`nomvar'"   char(34)

*  Pone listado de variables

*disp "`var'"


**** Prepara para renombrar variables

*disp "rename  `var'   `var'"
 }
 
 
 **** Pone en minusculas y elmina acentos
 
 unab listavar:*
foreach var in  `listavar' {
version 11.2

local varname="`var'"
local varname= subinstr("`varname'","�","_",.)
local varname= subinstr("`varname'","�","_",.)
local varname= subinstr("`varname'","�","a",.)
local varname= subinstr("`varname'","�","a",.)
local varname= subinstr("`varname'","�","a",.)
local varname= subinstr("`varname'","�","a",.)
local varname= subinstr("`varname'","�","e",.)
local varname= subinstr("`varname'","�","e",.)
local varname= subinstr("`varname'","�","e",.)
local varname= subinstr("`varname'","�","e",.)
local varname= subinstr("`varname'","�","i",.)
local varname= subinstr("`varname'","�","i",.)
  local varname= subinstr(`"`varname'"',"�","o",.)
    local varname= subinstr(`"`varname'"',"�","o",.)
 local varname= subinstr("`varname'","�","o",.)
  local varname= subinstr("`varname'","�","o",.)
 local varname= subinstr("`varname'","�","u",.)
  local varname= subinstr("`varname'","�","u",.)
 disp in yellow "`varname'"
 cap ren `var' `=lower("`varname'")'
}



//Combining many graphs on a page 
sysuse auto, clear 
graph drop _all
 foreach i of varlist _all { 
 capture confirm numeric variable `i'
 if _rc==0 {
histogram `i', name(`i') nodraw
 local z "`z' `i'" 
 }
 } 
graph combine `z'






unab listavar:*

foreach var of varlist `listavar' {

****** Prepara para poner etiquetas a las variables
disp "rename `var'  `var'"

***  Pone listado de variables

*disp "`var'"


**** Prepara para renombrar variables

*disp "rename  `var'    "

}

unab listavar:*

foreach var of varlist `listavar' {

 local nomvar: var label `var' 
local nomvar= upper(substr("`nomvar'",1,1)) +lower(substr("`nomvar'",2,.))
label var `var'  "`nomvar'"
}
 local lab : value label `var'
 if "`lab'"!="" {
    qui levelsof `var', local(lev)
	    foreach val of local lev {
            local vallab `:label `lab' `val''
			local vallab= substr("`vallab'",1,1) +lower(substr("`vallab'",2,.))
			label define `lab' `val' "`vallab'", modify
		}	
   }	
   
   cap ren `var' `=lower("`var'")' 
}

