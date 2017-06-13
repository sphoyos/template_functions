
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
local varname= subinstr("`varname'","º","_",.)
local varname= subinstr("`varname'","ª","_",.)
local varname= subinstr("`varname'","á","a",.)
local varname= subinstr("`varname'","Á","a",.)
local varname= subinstr("`varname'","à","a",.)
local varname= subinstr("`varname'","À","a",.)
local varname= subinstr("`varname'","é","e",.)
local varname= subinstr("`varname'","É","e",.)
local varname= subinstr("`varname'","è","e",.)
local varname= subinstr("`varname'","È","e",.)
local varname= subinstr("`varname'","í","i",.)
local varname= subinstr("`varname'","Í","i",.)
  local varname= subinstr(`"`varname'"',"ò","o",.)
    local varname= subinstr(`"`varname'"',"Ò","o",.)
 local varname= subinstr("`varname'","ó","o",.)
  local varname= subinstr("`varname'","Ó","o",.)
 local varname= subinstr("`varname'","ú","u",.)
  local varname= subinstr("`varname'","Ú","u",.)
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

