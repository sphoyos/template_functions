	 
********* TROBAR PUNT DE TALL PER A 2 VARIABLES CONTINUAS (REGRESSION TREE) *******************

*** Indica les variables  que vols trobar punt de tall

local varlist_tall="                 "

**** Selecciona el tipus de regressio 
local tiporeg="stcox"




*** Selecciona la variable resposta

local var_resp=""
tempvar constant 
gen `constant'=1

**** Segons el tipo de regressió selecciona mesura d'impacte i resultat *******

if "`tiporeg'"=="logit" local RR="OR"
if "`tiporeg'"=="stcox" local RR="HR"
if "`tiporeg'"=="regress" local RR="B"
if "`tiporeg'"=="poisson" local RR="RR"

if "`tiporeg'"=="logit" local tr="exp"
if "`tiporeg'"=="stcox" local tr="exp"
if "`tiporeg'"=="regress" local tr=""
if "`tiporeg'"=="poisson" local tr="exp"



disp in yellow "`RR'"

*** Selecciona les variables del model inicial
foreach vartalli in `varlist_tall'{

local var_mod=""
if "`var_resp'"=="" & "`var_mod'"==""  local var_mod="`constant'"
************************************************ CAL CANVIAR OOOJOOOOOO   **************************************
**** Indiques el nom de les variables que vas a ajustar (i i j)

preserve 
keep if `vartalli'!=.
 local nomvar_i: var label `vartalli' 
 if   `"`nomvar_i'"' == ""  local nomvar_i =  " `vartalli' " 

***  Inicialitzes un fitxer on guardar combinacions de talls i la verosemblança del model ajustat 
 	 
tempfile mincnt
*** generes variables auxiliars on guardaras els punts de canvi a 0
gen  r_`vartalli'=.
replace  r_`vartalli'=0 if `vartalli'!=.
*** Obres un postfile de texte (tall_cnt) on guardaras els valors de tall i la verosimilitut en un fitxer temporal

cap postclose tall_cnt
postfile tall_cnt  talli  veros val_p hr li_hr ls_hr aic using `mincnt'


local nobs=_N-3
*** Comences un bucle que pase per tots els valors de la primera  variable i

 xi: `tiporeg'  `var_resp'  `var_mod'  
estimates store mod0

sort `vartalli'

local var_mod =subinstr("`var_mod'", "`constant'"," ",.)
forvalues i = 3(1)`nobs' {
 
disp  in yellow " `i' ,    `vartalli'[`i']  "
**** Generes la variable indicador de estar per damunt o per sota del ièsim valor de la base de dades
qui replace r_`vartalli'=0  if `vartalli'!=.
local talli= `vartalli'[`i']
**** Si el OR de la variable continua es <1 l'indicador valdra 1 per valors per damunt (>) Si es mes gran cal posar >*******
qui replace r_`vartalli'=1 if `vartalli'> `talli' & `vartalli'!=.


************************************************ CAL CANVIAR OOOJOOOOOO   ****************************************
**** Cal escriure el model de regressió canviant les variables cuantitatives pels indicadors creats r_vari

qui xi: `tiporeg'  `var_resp'  `var_mod'   r_`vartalli'

local veros=e(ll)
  estimates stats
   matrix ZZ=r(S)
  local aic= ZZ[1, 5]
local hr=exp(_b[r_`vartalli'])
local li_hr=exp(_b[r_`vartalli']-invnorm(0.975)*_se[r_`vartalli'])
local ls_hr=exp(_b[r_`vartalli']+invnorm(0.975)*_se[r_`vartalli'])
*** Es guarden al fixter temporal els punts de tall i la versemblança
lrtest mod0
local val_p=   r(p)

post tall_cnt  (`talli') (`veros') (`val_p')  (`hr') (`li_hr') (`ls_hr') (`aic')
}
*}

**** Es tanca el fitxer temporal i es preserven les dades

postclose tall_cnt


** S'obri el fitxer temporal i s'ordena de menor a major la versemblança
use `mincnt',clear
gsort -veros
*** es guarda en un fitxer fixe totes les combinacions
saveold "$dta/sec/tall_`vartalli'.dta", replace

*** Es guarden en dues variables locals els valors del tall del primer registre (menor versemblança)

local val_tall_i: disp %4.2f talli[1]
local val_veros_tall= veros[1]

sort talli
sc veros talli , xline(`val_tall_i') c(l) xtitle("`vartalli'")  ytitle( -2LikeLihood) 
tempname graph1
graph save `graph1'.gph, replace

htput <br>

twoway   rarea li_hr ls_hr talli, sort bcolor(gs14) xline(`val_tall_i')  || sc  hr talli, c(l)  ms("+") || , xtitle("`vartalli'")  ytitle( Hazard Ratio) 

tempname graph2
graph save `graph2'.gph, replace



graph combine  `graph1'.gph `graph2'.gph, xcommon note(valor optimo `val_tall_i')

local grafname="r_`vartalli'"

*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
**************

restore


***** Reemplaza les variables indicador segons els punts de tall finalment seleccionats
gen r_`vartalli'=.
qui replace r_`vartalli'=0 if `vartalli'!=. 
qui replace r_`vartalli'=1 if `vartalli'>`val_tall_i' & `vartalli'!=.

*

************************************************ CAL CANVIAR OOOJOOOOOO   ******************************
**** Cal posar les etiquetes de les primers variables.
label var r_`vartalli' "`nomvar_i' >`val_tall_i'"
label define lab_r_`vartalli' 0"No(<`val_tall_i')" 1"Si(>`val_tall_i')", modify
label val r_`vartalli'  lab_r_`vartalli'



**** Si la variable estÃ  en escala logaritmica, exponencia per posar els punts de tall en escala original *******
local etalli: disp %8.2f  exp( `val_tall_i')


disp in yellow "`etalli'" 
*** Imprimex en html els punts de talll

 htput <b> <FONT COLOR="#8000FF">	  Punts de tall per `nomvar_i' en `val_tall_i'  (`nomvar_i'>`val_tall_i')  </b>  </font>

 htput <BR>
************************************************ CAL CANVIAR OOOJOOOOOO   ******************************
***** Ajusta el model amb les variables en qüestió i ho posa en taula html

disp in yellow "`tiporeg'"
disp in yellow "`var_resp'"
disp in yellow "`var_mod'"
htputvarcox , reg("`tiporeg'" ) dep("`var_resp'") indep ("`var_mod' i.r_`vartalli'") color  rr("`RR'") trans(`tr')    multi
	 
htput <BR>	 

}



************************************************ CAL CANVIAR OOOJOOOOOO   ******************************
***** Ajusta el model amb les variables en qüestió.
if "tiporeg'"=="logit" {

  qui xi:`tiporeg'  `var_resp' `var_mod' r_vari 
  ***** Calcula els valors post estimación per extreure el AIC
  estimates stats	
  matrix ZZ=r(S)
  local aic_final: di %6.2f ZZ[1, 5]	 
******* Calcula l'area sota la corba del model ajustat.  
  lroc ,nograph
  local auc_final: di  %6.3f r(area) 
***** Estima la bondad de l'ajust del model obtenint el valor del test de Hosmer-Lemeshow
  estat gof, group(10)
  htput <BR>
  local hos_lem : di %6.3f chi2tail(r(df),r(chi2))
  disp "`hos_lem'"
	set trace off
**** Imprimeix els resultats en html del AIC, AUC i HLT

  htput <b> <FONT COLOR="#8000FF"> AIC= `aic_final' ,AUC= `auc_final' , Hosmer-Lemeshow= `hos_lem' </b>  </font>
		
  htput <BR>
  
  
}

