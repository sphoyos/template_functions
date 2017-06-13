



	
***************************************************************************************************************
******************************************** VALIDACIO DEL MODEL **********************************************
***************************************************************************************************************	
	  htput <H3> Validación del modelo finalmente ajustado (Shrinkage) </H3>
	  
	 	  htput <BR>
	  htput <font color="#993366"> Uno de los problemas al ajustar modelos es la poca estabilidad de los coeficientes debido al escaso número de eventos
	  htput o de sujetos. Una forma de validar estos modelos es calcular un coeficiente de constricción(Shrinkage) que permita corregir la existencia de 
      htput	  sobreajuste. Normalmente este coeficiente es menor que 1 y multiplica a los coeficientes del modelo proporcionando unos coeficientes corregidos.
	  htput Si el coeficiente es cercano a 1 el modelo queda inalterado <br>.
	local tiporeg ="logit"
 *local tiporeg ="stcox"
if "`tiporeg'" =="stcox"  local RR="HR"
 if "`tiporeg'" =="logit"  local RR="OR"
if "`tiporeg'" =="stcox"  local extravar=" _t _d _st  _t0"
local var_resp="implantado"
local var_reg= "`varadd_mod'"
local var_regv=subinstr("`var_reg'","i.","",.)

disp in yellow "`var_regv'"


tempname b bs sd

*********** Indicar el model ajustado  *********************************
qui xi:`tiporeg'  `var_resp' `var_reg'
// get names of included variables
	
	matrix `b' = e(b)
	matrix `sd' = e(V)
	local names : colnames `b'
qui predict pi_tot, xb
qui predict p_totor

tempfile orig
tempfile results

cap postclose  shrinkage


keep  `var_resp' `var_regv'  pi_tot p_totor  `extravar'
save `orig', replace

cap postclose  shrinkage
postfile  shrinkage nk  coef using `results'

set seed 1265478
forvalues k=1/1000 {
   use `orig' , clear
    bsample
    gen bmostra=1
    qui append using `orig'
    qui  xi:`tiporeg'  `var_resp' `var_reg'    if bmostra==1
    qui   predict pi_b if e(sample), xb
    qui  predict pi_b1 , xb
     qui cor pi_b1 pi_tot if bmostra!=1
	 if r(rho)!=. {
     qui `tiporeg'  `var_resp'  pi_b1 if bmostra!=1
    local coef=_b[pi_b1]
    disp in yellow . _continue
    post  shrinkage  (`k') (`coef')
    }
}

postclose shrinkage

use `orig', clear

local i=0
foreach var in  `var_reg'   {
	if strpos("`var'","i.")!=0 {
	    local var=subinstr("`var'", "i.", "",.) 
		local nomvar: var label `var' 
		if   `"`nomvar'"' == "" local nomvar = "`var'"
 
		local c=substr("`var'",1,9)
			
		local val_grup_lab: value label `var'

		qui levelsof `var', local(gruplevels)
		tokenize `gruplevels'
		local gruplevels=subinstr("`gruplevels'","`1'","",.)
		foreach  g  in `gruplevels'  {
		
			local i=`i'+1
				if "`val_grup_lab'"!="" { 
					local  varlab`i':  label `val_grup_lab' `g'
									}
				else {
					local varlab`i' ="`g'"
				}			
			local varlab`i': disp  "`nomvar' =  `varlab`i'' "
			disp in yellow  "`varlab`i''   ; `i'"
		}	
		
	}
	else{
		local nomvar: var label `var' 
		if   `"`nomvar'"' == "" local nomvar = "`var'"	
		local i=`i'+1
		local varlab`i'= "`nomvar'"
		disp in yellow  "`varlab`i''   ; `i'"	
	}

}



htput <b> Modelo finalmente ajustado :`tiporeg'  `var_resp' `var_regv' </b> <p>

 use `results', clear
summarize  coef 

local shrik_coef= r(mean)


 matrix `bs' = `b'*`shrik_coef'
 matrix list `b'
 matrix list `bs'
 disp "`names'"
 local sc: disp %5.3f  `shrik_coef' 
  	htput  <Font color="993489" size=5><b> Coeficiente de "Shrinkage"   `sc'   </Font color size></b>
      htput <br>
	htput <TABLE BORDER="2" CELLSPACING="0" CELLPADDING="0" WIDTH="85%">

	htput <TR>
	htput <B>
    htput <TH > Variable </TH>
    htput <TH>  Coeficiente original </TH>
    htput <TH> Coeficiente Corregido </TH>
	htput <TH>  `RR' original<br> [95%CI]  </TH>
	htput <TH>  `RR' Corregido <br> [95%CI]</TH>
	htput </B>
	htput </TR>
		

	local i=0
foreach var  in `names' {

   local i=`i'+1
   local varlab="`varlab`i''"
   if "tiporeg" != "stcox" & `i'== colsof(`b')  local varlab "Intercepto"

    local coef: disp %5.2f `b'[1,`i']
    local coefs: disp %5.2f `bs'[1,`i']
	local ee=sqrt(`sd'[`i',`i'])
	local ees=sqrt(`sd'[`i',`i'])*`shrik_coef'
	local ecoef: disp %5.2f exp(`b'[1,`i'])
    local ecoefs: disp %5.2f exp(`bs'[1,`i'])
	local liecoef: disp %5.2f exp(`coef'-1.96*`ee')
	local lsecoef: disp %5.2f exp(`coef'+1.96*`ee')
	local liecoefs: disp %5.2f exp(`coef'-1.96*`ee'*`shrik_coef')
	local lsecoefs: disp %5.2f exp(`coef'+1.96*`ee'*`shrik_coef')
	
	local eci="["+ "`liecoef'"+"-"+"`lsecoef'"+"]"
    local ecis="["+ "`liecoefs'"+"-"+"`lsecoefs'"+"]"
	
  	htput <TR>
    htput <TD > `varlab' </TD>
    htput <TD align=center>  `coef' </TD>
    htput <TD align=center> `coefs' </TD>
	htput <TD align=center>  `ecoef' <br> `eci' </TD>
    htput <TD align=center> `ecoefs' <br> `ecis'</TD>
	htput </TR align=center>
	
}	
 

 htput </TABLE >
htput <BR>
	
*/
