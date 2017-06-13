
** Identifica la variable qualitativa que  te la mesura



*label define n_mesura 1"Inicio"  2"6 meses" 3"12 meses"
*label val n_mesura n_mesura
*label var n_mesura "Instante Medición"
 
****** Indica el identificador del sujeto *****************
 local identifica="id "

 *** Variable Temps en cualitatiu (1,2,3...)*****
local tc= "mesure "
local itc="i."+"`tc'"
local vargrup="mesure" /* la variable te que ser categòrica*/

****  dosinife sildenafilo dosisilde bosentan dosibosen iloprost dosiilo diawt
****** FICAR ENTRE COMETES LES VARIABLES QUANTITATIVES  ********
local varcuant1 = "dhi_  "
 local varcuant2= ""
 local varcuant3= " "
 local varcuant4= ""

 

htput <BR>

******** GENERAR TAULES DESCRIPTIVES  PER A VARIABLES QUANTITATIVES EN FUNCIO DE LES MESURES ABANS/DESPRES ***************************


htput <H3> <font color="#993489">Variables quantitatives </font color></H3>

htput <BR>

*****  CONTA EL NOMBRE DE VARIABLES I INITZIALIZA A 0 **************
local nvarcuant=wordcount("`varcuant1'")+ wordcount("`varcuant2'")+wordcount("`varcuant3'")+wordcount("`varcuant4'")
local n_varcuant=0


***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES CATEGORIQUES ***************

 foreach var of varlist   `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'    {

 format  %6.2f `var'
********** CONTABILITZA EL NUMERO DE VARIABLE **************
local n_varcuant=`n_varcuant'+1

**********  INDICA SI ES LA VARIABLE CABPAÇALERA O DE TANCAMENT DE LA TAULA *****************

local cap=" "
local fin=" "
 if `n_varcuant'==1 local cap="head"
 if `n_varcuant'==`nvarcuant' local fin="close"
 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"
htput <H3> `nomvar'  </H3>
htput <BR>
********** AFEGEIX LES FILES A LA TAULA EN HTML AMB LES FREQUENCIES PER COLUMNA ****************

ht_tablacont `var' `vargrup' ,  head close  median  skilmack color id(" `identifica' ")
********************TANCA EL BUCLE PER LA TAULA
*}
htput <BR>




 
htput <BR>

***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES CATEGORIQUES PER FER ELS GRÀFICS ***************
* foreach var of varlist   `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'   {
 
******* EXTRAU EL NOM DE LA VARIABLE I DEL GRÀFIC *************************
 
 

 
 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"

 local nomvargrup: var label `vargrup' 
 if   `"`nomvargrup'"' == "" local nomvargrup = "`vargrup'"
 
 local grafname = "box_"+"`vargrup'"+"_"+"`var'"

 ********* GENERA UNA TEST KRUSKAL-WALLIS I EXTRAU EL VALOR P **********************

   qui skilmack `var' , id(`identifica') repeated(`vargrup')
   local pval_skil: di %5.3f r(p_2)
   if r(p_2)==.  local pval_skil: di %5.3f r(p) 
************************* DIBUIXA ELS DIAGRAMES DE CAPSES *****************
local formvar: format `var' 
graph box `var'  , over(`vargrup') title ("Diagrama de capses " ) subtitle ( "`nomvar'")   ytitle(" ") note(Pvalor SkilMack=`pval_skil') ylabel(, format(`formvar') angle(horizontal)) $boxcolor 

*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>

***************** TANCA EL BUCLE DELS GRAFICS

*}

***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES CUANTITATIVES ***************

* foreach var of varlist   `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'    {


local varlab:variable label `var'  
if   `"`varlab'"' == "" local varlab = "`var'"
sort `identifica' `tc'

htput <BR>

disp  in yellow "************************ MODELO 1 *************************************"

tempvar predvar
cap noi  htxtmixed_es `var',  id(`identifica') adjust(   `itc' )  overall
  xi: xtmixed `var'  `itc'   ||`identifica': ,mle iterate(40)
 predict `predvar' 
 label var `predvar' "Predicción  lineal"
disp  in yellow "************************	FEINMODELOS *************************************"

summarize `var'
local min=r(min)-1
local max= r(max)+1

tempvar meanname
tempvar medname 
tempvar nname
tempvar sdname
tempvar liname
tempvar lsname

bysort `tc' :egen `nname'=count(`var')
bysort `tc' : egen `meanname'=mean(`var')
bysort `tc' :egen `medname'= median(`var')
bysort `tc' :egen `sdname'= sd(`var')
bysort `tc' :gen `liname'= `meanname'- invttail(( `nname'-1),.025)*( `sdname' / sqrt(`nname'))
bysort `tc' :gen `lsname'= `meanname'+ invttail(( `nname'-1),.025)*( `sdname' / sqrt(`nname'))


local grafname= "evoind"+"`var'"
sort `identifica'  `tc' 
twoway connected `var' `tc' , c(L)  ms(i) ytitle(" ") color(red) ///
||  , title (Evolución Individual ) subtitle ( `varlab')  ysc(range(`min',`max'))   ylabel(#10, angle(Horizontal)) xlabel(1(1)3,valuelabel)

*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
**************


sort `tc'

local grafname= "evomeanCI"+"`var'"
twoway sc `meanname' `tc'  ,c(l)   ytitle(" ")  color(red)  ///
|| rcap  `liname'  `lsname' `tc'  ,   color(red) ///
|| line `predvar' `tc', c(l)   lcolor(blue) ///
||, title (Evolución de la media) subtitle ( `varlab')      ylabel(#10,angle(Horizontal))  xlabel(1(1)3,valuelabel) ///
 legend(label(1 "Media")  label (2 "CI 95%") label (2 "Predicción lineal") )

*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
**************
 }
 