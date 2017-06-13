



  *************** TIPUS DE REGRESSIO ************
 *local tiporeg ="logit"
 *local tiporeg ="stcox"
   local tiporeg ="regress"
 *local tiporeg ="stcox"
if "`tiporeg'" =="stcox"  local RR="rr("+char(34)+"HR"+char(34)+") trans(exp)"
 if "`tiporeg'" =="logit"  local RR="rr("+char(34)+"OR"+char(34)+") trans(exp)"
 if "`tiporeg'" =="regress"  local RR="rr("+char(34)+"Coef."+char(34)+")"

 local opcion=""
  if   "`opcion'"!="" {
  local h_opcion="options("+char(34)+" `opcion'"+char(34)+")"
  disp `"`h_opcion'"'

  }
* ******* Variable Resposta **********
local var_resp=""

* ********* Variables explicatives  i. identifica les variables cualitatives **********

local varreg1= ""
local varreg2= ""
local varreg3= "" 
local varreg4=""

* ****** Variables iniciales fijas i. identifica las variables cualitativas *******************
local varadd_mod=""




************************** INICIA EL AJUSTE ***********************************
local nomvar_resp=""
tempvar constant 
*gen `constant'=1
local constant=""
if "`var_resp'"!="" {
 local nomvar_resp: var label `var_resp' 
 if   `"`nomvar_resp'"' == "" local nomvar_resp = "`var_resp'"
}
************************** AJUSTE MODELOS UNIVARIANTES  ***********************************



htput <font color="#993366">
htput Para la construcción del modelo multivariante se ha utilizado un método de selección basado en la mejora de la verosimilitud 
htput y el criterio de información de Akaike (AIC). Se consideraron todas las variables que la literatura o anàlisis previos indicaban
htput  que ser realacionan con la variable resultado. <BR> A partir de un modelo con la constante se han ido introduciendo paulatinamente
htput  las variables que mejoraban la verosimilitud desde un modelo con la constante hasta que la inclusión no mejoraba el modelo anterior. <br>
htput   El criterio para incluir una variable fue un valor de p<0.10
htput </font color>. 

if "`tiporeg'"!="stcox" | "`tiporeg'" !="streg" {
   htput <H3> Análisis Univariat per a variable resposta  `nomvar_resp'  </H3>
}
else {
   htput <H3> Análisis Univariat   </H3> 
}   
   htput <BR>






version 13.1: htputvarcox , reg("`tiporeg'" ) dep("`var_resp'") indep (" `varadd_mod' `varreg1' `varreg2' `varreg3'  `varreg4'  ") color  `RR'  `h_opcion'
htput <BR>

							
* " *** Selecciona els casos que tenen dades per totes les variables i preserva la base de dades ******
preserve							
gen seleccion=1

foreach vargrup in  `varadd_mod'  `varreg1' `varreg2' `varreg3'  `varreg4' {
if strpos("`vargrup'","i.")!=0 {
local vargrup=subinstr("`vargrup'","i.","",1) 
}
										  replace seleccion=0 if `vargrup'==.
											  }
	  
* " Executa la selecció
 						
keep if seleccion==1						

* *** Ajusta els models ajust=1 indica que  pot continuar ajustat a mes del nombre del model ***********
 

if "`tiporeg'"  !="stcox" | "`tiporeg'"  !="streg" {
   htput <H3> Análisis Multivariat per a variable resposta  `nomvar_resp'  </H3>
}
else {
   htput <H3> Análisis Multivariat  </H3> 
}   
   htput <BR>

local ajust=1
disp in yellow 
if "`var_resp'"=="" & "`varadd_mod'"==""  local varadd_mod="`constant'"
 htput <b> <FONT COLOR="#8000FF"> model inicial: constante  `varadd_mod'   </font></b>
* ** Bucle que s'atura quan no es pot afegir més variables *******
htput <BR>
disp "`varadd_mod'"
while `ajust'!=0 {

* ** Ajusta el model sense afegir variables i guarda les estimacions i el AIC del model *** ****

cap xi:  `tiporeg'  `var_resp' `varadd_mod' 
estimates store mod`ajust' 	 
local varadd=""
estimates stats
matrix ZZ=r(S)
local aic1=ZZ[1, 5]

   local varadd_mod= subinstr("`varadd_mod'","`constant'","",.) 
 htput  <b>Model   `ajust'  </b> <br>
 
* ** Afegeix al model variable a variable  *** ****
htput <br>
htput <TABLE>
htput <TR>
htput <TH> Variable </TH>
htput <TH> AIC </TH>
htput <TH> pvalor </TH>
htput </TR>





foreach vargrup in `varreg1' `varreg2' `varreg3'  `varreg4'  {

 local nom_vargrups= subinstr("`vargrup'","i.","",.)
	    local nom_vargrup: var label `nom_vargrups'
		if   `"`nom_vargrup'"' == "" local nom_vargrup = "`nom_vargrups'"


cap xi:  `tiporeg'  `var_resp'   `varadd_mod'  `vargrup' 
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
   htput <TR>
htput <TD> `nom_vargrup' </TD>
htput <TD> `saic' </TD>
htput <TD> `spval' </TD>
htput </TR>

   	 
di in green  " Variable `vargrup': AIC=`saic' : valor p `spval'  "
  
  * **  Compara si l'AIC es menor que  el que ja estava gravat
  
   if `aic'<`aic1' {
   
   local varadd=trim("`vargrup'")
   

   local aic1= `aic'
   }
   }
 }  
 
htput </TABLE>

 * ** Si hi ha una milloria  indica la variable . En cas contrari s'atura
 
  if "`varadd'"!=""  {
      local ajust=  `ajust'+1
	     
	   local nom_varad= subinstr("`varadd'","i.","",.)
	    local nom_varadd: var label `nom_varad'
		if   `"`nom_varadd'"' == "" local nom_varadd = "`nom_varad'"
 disp in yellow   "Variable candidata a entrar `varadd' "
	 
	htput <BR>
 htput <b> <FONT COLOR="#8000FF"> Variable candidata a entrar `nom_varadd' </b>  </font>
 	htput <BR>
local varadd_mod= "`varadd_mod'"+" "+"`varadd'"	 
local varadd_mod= subinstr("`varadd_mod'","`constant'","",.)   
   if "`varadd_mod'"!=""  {
   version 13.1: htputvarcox , reg("`tiporeg'" ) dep("`var_resp'") indep ("`varadd_mod'  ") color  `RR'    multi `h_opcion'
	htput <BR>
  }
  
  
	 



local varreg1=  subinstr("`varreg1'","`varadd'","",1) 	 
local varreg2=  subinstr("`varreg2'","`varadd'","",1) 	 
local varreg3=  subinstr("`varreg3'","`varadd'","",1) 	 
local varreg4=  subinstr("`varreg4'","`varadd'","",1) 	   
	  
	  }
	  else {
	  local ajust=0
	   htput  <b> No entran màs variables  </b> <br>
	  }
	  
	   

	  
	

 htput <BR>
 
 }
restore
 
 
 
    
  * ** S'escriu el model  finalment ajustat amb totes les dades possibles de la base de dades
 
 if "`varadd_mod'"!="" {
 
     htput <H3> Model Multivariat  ajustat per a variable resposta  `nomvar_resp'  despres de stepwise  </H3>
     htput <BR/>
     
     htput <BR>
	 
    version 13.1: htputvarcox , reg("`tiporeg'" ) dep("`var_resp'") indep ("`varadd_mod'  ") color   `RR'   multi `h_opcion'
	
	 }
	 else {
	 
	      htput <H2> Cap variable explica la  variable resposta  `nomvar_resp'  i no hi ha model multivariat  </H2>
     htput <BR/>
	 
	 }
	 
	 htput <BR>
	
if "`tiporeg'"=="stcox" {

	htput <font color="#993366">
    htput 	Si el valor del test no es significativo podemos asumir la proporcionalidad de los riesgos
	htput que exige el modelo de Cox. Se usa la prueba de Therneau_Grambsch que proporciona p valores para el global y para cada una de las covariables
	htput </font color>
     quietly xi: `tiporeg' `varadd_mod',  nolog noshow schoenfeld(res_sch*)  scaledsch(res_sca*) 	  `opcion'
	 htput <BR
	 ht_stphtest, log detail 

	 drop   res_sch*  
	 drop   res_sca*

	 }
	


	 