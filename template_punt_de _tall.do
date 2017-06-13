
	 
********* TROBAR PUNT DE TALL PER A 2 VARIABLES CONTINUAS (REGRESSION TREE) *******************


***  Inicialitzes un fitxer on guardar combinacions de talls i la verosemblança del model ajustat 
 	 
tempfile mincnt
*** generes variables auxiliars on guardaras els punts de canvi a 0
gen r_vari=0
gen r_varj=0

************************************************ CAL CANVIAR OOOJOOOOOO   **************************************
**** Indiques el nom de les variables que vas a ajustar (i i j)
local vartalli="canvi_ln_plt"
local vartallj=" ln_pcr24"

*** Obres un postfile de texte (tall_cnt) on guardaras els valors de tall i la verosimilitut en un fitxer temporal

postfile tall_cnt  talli tallj veros using `mincnt'


local nobs=_N
*** Comences un bucle que pase per tots els valors de la primera  variable i

forvalues i = 1(1)`nobs' {


**** Generes la variable indicador de estar per damunt o per sota del ièsim valor de la base de dades
qui replace r_vari=0
local talli= `vartallj'[`i']
**** Si el OR de la variable continua es <1 l'indicador valdra 1 per valors per sota (<) Si es mes gran cal posar >*******
qui replace r_vari=1 if `vartalli'< `talli'


*** Comences un bucle que pase per tots els valors de la segona   variable j

forvalues j = 1(1)`nobs' {

**** Generes la variable indicador de estar per damunt o per sota del jèsim valor de la base de dades
qui replace r_varj=0
local tallj= `vartallj'[`j']
**** Si el OR de la variable continua es <1 l'indicador valdra 1 per valors per sota (<) Si es mes gran cal posar >*******
qui replace r_varj=1 if `vartallj'> `tallj'

************************************************ CAL CANVIAR OOOJOOOOOO   ****************************************
**** Cal escriure el model de regressió canviant les variables cuantitatives pels indicadors creats r_vari i r_varj

qui xi:logit   ttoquirurgico   edadgestacional  r_vari r_varj

*** Es guarden al fixter temporal els punts de tall i la versemblança

post tall_cnt  (`talli')  (`tallj') (`e(ll)')
}
}

**** Es tanca el fitxer temporal i es preserven les dades

postclose tall_cnt
preserve

** S'obri el fitxer temporal i s'ordena de menor a major la versemblança
use `mincnt',clear
gsort -veros
*** es guarda en un fitxer fixe totes les combinacions
saveold "$dta/tall_cnt.dta", replace

*** Es guarden en dues variables locals els valors del tall del primer registre (menor versemblança)

local val_tall_i: disp %4.2f talli[1]
local val_tall_j: disp %4.2f tallj[1]
local val_veros_tallveros[1]
restore


***** Reemplaza les variables indicador segons els punts de tall finalment seleccionats
qui replace r_vari=0
qui replace r_vari=1 if `vartalli'<`val_tall_i'

qui replace r_varj=0
qui replace r_varj=1 if `vartallj'>`val_tall_j'

************************************************ CAL CANVIAR OOOJOOOOOO   ******************************
**** Cal posar les etiquetes de les primers variables.
label var r_vari "ln Cambio de plaquetas <`val_tall_i'"
label var r_varj "ln PCR 24h > `val_tall_j' "


**** Si la variable està en escala logaritmica, exponencia per posar els punts de tall en escala original *******
local etalli: disp %8.2f  exp( `val_tall_i')
local etallj: disp %8.2f  exp( `val_tall_j')


*** Imprimex en html els punts de talll

 htput <b> <FONT COLOR="#8000FF">	  Punts de tall per ln Cambio plaquetas en `val_tall_i'  (dif_plaquetas<`etalli') i ln PCR 24h `val_tall_j' (PCR>`etallj')  </b>  </font>

 htput <BR>
************************************************ CAL CANVIAR OOOJOOOOOO   ******************************
***** Ajusta el model amb les variables en qüestió i ho posa en taula html
htputvarcox , reg("logit" ) dep("ttoquirurgico ") indep ("edadgestacional  r_vari r_varj") color  rr("OR") trans(exp)    multi
	 
htput <BR>	 

************************************************ CAL CANVIAR OOOJOOOOOO   ******************************
***** Ajusta el model amb les variables en qüestió.

	 
  qui xi:`tiporeg'  `var_resp' edadgestacional  r_vari r_varj
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
	
**** Imprimeix els resultats en html del AIC, AUC i HLT

  htput <b> <FONT COLOR="#8000FF"> AIC= `aic_final' ,AUC= `auc_final' , Hosmer-Lemeshow= `hos_lem' </b>  </font>
		
  htput <BR>
  
  
