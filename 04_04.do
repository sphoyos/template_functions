*! docver: 2.0
*!  title: Validacio model logístic
*!   html: yes
*!    log: yes
*! comment: 


version 9.2
htput <IMG SRC="UEB_IR.png" ALT="UEB-IR" ALIGN=CENTER WIDTH="80%" height="100">
htput <DIV ALIGN="CENTER" class="RED" style="font-size:small"> 
htput  </DIV>
htput <HR>
htput <H1> $HTtitle </H1>
htput <BR>





use "$dta/ana_datos.dta", clear

label var dosis_acum2 "dosis acumulada"
tempname b bs
 xi:logit nosensible i.tos i.surgery  i.fluco_previ  i.m_hematologica 




 
***  Inicialitzes un fitxer on guardar combinacions de talls i la verosemblança del model ajustat 
 	 
tempfile mincnt
*** generes variables auxiliars on guardaras els punts de canvi a 0
gen r_vari=0


************************************************ CAL CANVIAR OOOJOOOOOO   **************************************
**** Indiques el nom de les variables que vas a ajustar (i i j)
local vartalli="dosis_acum"


*** Obres un postfile de texte (tall_cnt) on guardaras els valors de tall i la verosimilitut en un fitxer temporal
cap postclose tall_cnt
postfile tall_cnt  talli veros using `mincnt'


local nobs=_N
*** Comences un bucle que pase per tots els valors de la primera  variable i
sort `vartalli'
forvalues i = 1(1)`nobs' {

if `vartalli'[`i']!=0 {

**** Generes la variable indicador de estar per damunt o per sota del ièsim valor de la base de dades
qui replace r_vari=0
local talli= `vartalli'[`i']
**** Si el OR de la variable continua es <1 l'indicador valdra 1 per valors per sota (<) Si es mes gran cal posar >*******
qui replace r_vari=1 if `vartalli'< `talli' & `talli'!=0
qui replace r_vari=2 if `vartalli'>= `talli' & `talli'!=0

*** Comences un bucle que pase per tots els valors de la segona   variable j



qui xi:logit   nosensible i.tos i.surgery  i.fluco_previ  i.m_hematologica   i.r_vari 
*** Es guarden al fixter temporal els punts de tall i la versemblança
disp in yellow " `talli' ; " e(rank) ";" e(k)

 if e(rank)==e(k) {
  disp in green "a"
        post tall_cnt  (`talli')   (`e(ll)')
   }
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
local val_veros_tallveros[1]
restore


***** Reemplaza les variables indicador segons els punts de tall finalment seleccionats
qui replace r_vari=0
qui replace r_vari=1 if `vartalli'<`val_tall_i' & `vartalli'!=0
qui replace r_vari=2 if `vartalli'>=`val_tall_i' & `vartalli'!=0


************************************************ CAL CANVIAR OOOJOOOOOO   ******************************
**** Cal posar les etiquetes de les primers variables.
label var r_vari "dosis acumulada"
label define r_vari 0"0" 1"<`val_tall_i'" 2">`val_tall_i'"

 xi:logit nosensible i.tos i.surgery  i.fluco_previ  i.m_hematologica 
 estimates store mod1
xi:logit nosensible i.tos i.surgery  i.fluco_previ  i.m_hematologica i.r_vari
lrtest mod1

