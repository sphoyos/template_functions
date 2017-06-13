*! docver: 2.0
*!  title: Genera fitxer long
*!   html: yes
*!    log: yes
*!comment: 
version 9.1


version 9.2
htput <IMG SRC="UEB_IR.png" ALT="UEB-IR" ALIGN=CENTER WIDTH="80%" height="100">
htput <DIV ALIGN="CENTER" class="RED" style="font-size:small"> 
htput  </DIV>
htput <HR>

htput <H1> $HTtitle </H1>
htput <BR>


use "dta\ana_datos_gemox.dta", clear

drop chosp medico fregistro observa1-observa18

foreach v of var*{
        local l`v' : variable label `v'

 }

 /* save the value labels for variables in local list*/
 foreach var of var* {
     local eti`var': value label `var'
   
	 if "`eti`var''"!="" {
	 
 	   qui  levelsof `var', local(`var'_levels)       /* create local list of all values of `var' */
	   foreach val of local `var'_levels {       /* loop over all values in local list `var'_levels */
      	   local `var'vl`val' : label `var' `val'    /* create macro that contains label for each value */
        }
	}   
 }



reshape long fecha ciclos estadio  gsupra ginfra  gmediast nterrit  med higado digest genit snc pulm piel otros finicio rtx gem oxal pred neutro hemo plaq hep renal  alop vom inf tromb otras gcsf rta frta ecog ///
masa ldh alb b2 vs ipi mipi ayuda  profil prot , i(paciente) j(nmesura) string

 foreach var in  fecha ciclos estadio  gsupra ginfra  gmediast nterrit  med higado digest genit snc pulm piel otros finicio rtx gem oxal pred neutro hemo plaq hep renal  alop vom inf tromb otras gcsf rta frta ecog ///
               masa ldh alb b2 vs ipi mipi ayuda  profil prot { 

	local nomvar="l`var'0"
	local varlab="eti`var'1"
	
	label var `var' "``nomvar''"
	*disp `var'  "`varlab'"
	if "``varlab''" !=""  label val `var'  "``varlab''"
	    if "``varlab''"=="" {
		
	        local varlab="eti`var'0"
	        if "``varlab''"!="" label val `var'  "``varlab''"
		}
		if "``nomvar''"=="" {
		
	        local nomvar="l`var'1"
	        if "``nomvar''"!="" { 
		       local nomvar= subinstr( "``nomvar''", "ciclo 1", "",.)
		        label var `var' "`nomvar'"
			}
        }
	}
 
 

 local var="nmesura"
local varlab:  var lab `var'
rename  `var' `var'_txt 
 gen  `var'=.
replace `var' = 0   if `var'_txt=="0"
replace `var' = 2   if `var'_txt=="1"
replace `var' = 3   if `var'_txt=="2"
replace `var' = 4   if `var'_txt=="3"
replace `var' = 5   if `var'_txt=="4"
replace `var' = 7   if `var'_txt=="5"
replace `var' = 8   if `var'_txt=="6"
replace `var' = 9   if `var'_txt=="7"
replace `var' = 10   if `var'_txt=="8"
replace `var' =  11  if `var'_txt=="f"
replace `var' = 1   if `var'_txt=="ini"
replace `var' = 13   if `var'_txt=="r"
replace `var' = 6   if `var'_txt=="tras4"
replace `var' = 12   if `var'_txt=="u"
label var  `var' "`varlab'"
 label define lab_`var'  /// 
0"Diagnóstico" ///
1"Inici" ///
2"Ciclo 1" ///
3"Ciclo 2 " ///
4"Ciclo 3" ///
5"Ciclo 4" ///
6"Tras Ciclo 4" ///
7"Ciclo 5" ///
8"Ciclo 6" ///
9"Ciclo 7" ///
10"Ciclo 8" ///
11"Final" ///
12"Ultimo contacto" ///
13"Recaida" ///
 , modify
 label val `var'   lab_`var'
 version 13: order `var' , before(`var'_txt)
drop `var'_txt 


save  "$dta\ana_datos_long_gemox.dta", replace




