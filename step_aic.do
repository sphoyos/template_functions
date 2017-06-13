


 
* ******* Variable Resposta **********
local var_resp=""


 local nomvar_resp: var label `var_resp' 
 if   `"`nomvar_resp'"' == "" local nomvar_resp = "`var_resp'"

* ********* Variables explicatives  i. identifica les variables cualitatives **********

local varreg1= ""
local varreg2= ""
local varreg3= " " 
local varreg4=" "
							
* *** Selecciona els casos que tenen dades per totes les variables ******
preserve							
gen seleccion=1

foreach vargrup in   `varreg1' `varreg2' `varreg3'  `varreg4' {
if strpos("`vargrup'","i.")!=0 {
local vargrup=subinstr("`vargrup'","i.","",1) 
}
										  replace seleccion=0 if `vargrup'==.
											  }
	  
						
keep if seleccion==1						

* *** Ajusta els models ajust=1 indica que  pot continuar ajustat a mes del nombre del model ***********
 
htput <H3> Análisis Multivariat per a variable resposta  `nomvar_resp'  </H3>
htput <BR/>

local ajust=1
local varadd_mod="i.RECO_BMI_CAT"
 htput <b> <FONT COLOR="#8000FF"> model inicial: constante  `varadd_mod' </b>  </font>
* ** Bucle que s'atura quan no es pot afegir més variables *******

while `ajust'!=0 {

* ** Ajusta el model sense afegir variables i guarda les estimacions i el AIC del model *** ****

cap xi:  logit  `var_resp' `varadd_mod'
estimates store mod`ajust' 	 
local varadd=" "
estimates stats
matrix ZZ=r(S)
local aic1=ZZ[1, 5]

 
 htput  <b> model   `ajust'  </b> <br>
 
* ** Afegeix al model variable a variable  *** ****

foreach vargrup in `varreg1' `varreg2' `varreg3'  `varreg4'  {


cap xi:  logit  `var_resp'   `varadd_mod'  `vargrup'
 
di in yellow  "`vargrup'"
** Compara la versemblança del model senes la variable

cap  lrtest mod`ajust'

  local pval=r(p)
  * **   Selecciona si la variable millora la versemblança p<0.05
  if r(p)<0.1 & _rc==0{
 * *** Calcula el AIC  
 estimates stats
   matrix ZZ=r(S)
  local aic= ZZ[1, 5]
   local saic: di %7.3f `aic'
   local spval: di %7.3f `pval'
   
  htput  Variable `vargrup': AIC=`saic' : valor p `spval' <br> 
  
  * **  Compara si l'AIC es menor que  el que ja estava gravat
  
   if `aic'<`aic1' {
   
   local varadd="`vargrup'"

   local aic1= `aic'
   }
   }
 }  
 
 * ** Si hi ha una milloria  indica la variable . En cas contrari s'atura
 
  if "`varadd'"!=""  {
      local ajust=  `ajust'+1
	    
 disp in yellow   "Variable candidata a entrar `varadd' "
	 
	htput <BR>
 htput <b> <FONT COLOR="#8000FF"> Variable candidata a entrar `varadd' </b>  </font>
 	htput <BR>
	local varadd_mod= "`varadd_mod'"+" "+"`varadd'"	 
  if "`varadd_mod'"!="" {
    htputvarcox , reg("logit" ) dep("`var_resp'") indep ("`varadd_mod'  ") color  rr("OR") trans(exp)    multi
	htput <BR>
  } 


local varreg1=  subinstr("`varreg1'","`varadd'","",.) 	 
local varreg2=  subinstr("`varreg2'","`varadd'","",.) 	 
local varreg3=  subinstr("`varreg3'","`varadd'","",.) 	 
local varreg4=  subinstr("`varreg4'","`varadd'","",.) 	   
	  
	  }
	  else {
	  local ajust=0
	   htput  <b> No entran màs variables  </b> <br>
	  }
	  
	   

	  
	

 htput <BR>
 
 }
restore
 
  * ** S'escriu el model  finalment ajustat
 
    
  * ** S'escriu el model  finalment ajustat
 
 if "`varadd_mod'"!="" {
 
     htput <H3> Model Multivariat  ajustat per a variable resposta  `nomvar_resp'  despres de stepwise  </H3>
     htput <BR/>
     
     htput <BR>
	 
     htputvarcox , reg("logit" ) dep("`var_resp'") indep ("`varadd_mod'  ") color  rr("OR") trans(exp)    multi
	 
	 }
	 else {
	 
	      htput <H2> Cap variable explica la  variable resposta  `nomvar_resp'  i no hi ha model multivariat  </H2>
     htput <BR/>
	 
	 }
	 