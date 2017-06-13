

htput <BR>

******** GENERAR TAULES DESCRIPTIVES  PER A VARIABLES QUANTITATIVES ***************************************


htput <H3> <font color="#993489">Variables quantitatives </font color></H3>

htput <BR>

****** IDENTIFICA LA VARIABLE QUE GENERA ELS GRUPS *****************
local varsgrup= "     "

foreach vargrup of varlist `varsgrup'{



****** FICAR ENTRE COMETES LES VARIABLES QUANTITATIVES  ********
local varcuant1 = "     "
 local varcuant2= " "
 local varcuant3= " "
 local varcuant4= " "
 
*****  CONTA EL NOMBRE DE VARIABLES I INITZIALIZA A 0 **************
local nvarcuant=wordcount("`varcuant1'")+ wordcount("`varcuant2'")+wordcount("`varcuant3'")+wordcount("`varcuant4'")
local n_varcuant=0



***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES CATEGORIQUES ***************

 foreach var of varlist   `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'    {

********** CONTABILITZA EL NUMERO DE VARIABLE **************
local n_varcuant=`n_varcuant'+1

**********  INDICA SI ES LA VARIABLE CABPAÇALERA O DE TANCAMENT DE LA TAULA *****************

local cap=" "
local fin=" "
 if `n_varcuant'==1 local cap="head"
 if `n_varcuant'==`nvarcuant' local fin="close"


********** AFEGEIX LES FILES A LA TAULA EN HTML AMB LES FREQUENCIES PER COLUMNA ****************

ht_tablacont `var' `vargrup' , `cap'  `fin' anova kw total median ci color
********************TANCA EL BUCLE PER LA TAULA
}
 


htput <BR> 

htput <BR>

***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES CATEGORIQUES PER FER ELS GRÀFICS ***************

 foreach var of varlist   `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'   {

 
******* EXTRAU EL NOM DE LA VARIABLE I DEL GRÀFIC *************************
 
 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"

 local nomvargrup: var label `vargrup' 
 if   `"`nomvargrup'"' == "" local nomvargrup = "`vargrup'"
 
 local grafname = "box_"+"`vargrup'"+"_"+"`var'"

 ********* GENERA UNA TEST KRUSKAL-WALLIS I EXTRAU EL VALOR P **********************
qui  kwallis `var' , by(  `vargrup') 
local pvalue: di  %8.4f chiprob(r(df),r(chi2)) 

************************* DIBUIXA ELS DIAGRAMES DE CAPSES *****************
local formvar: format `var' 
graph box `var'  , over(`vargrup') title ("Diagrama de capses per `nomvar'" ) subtitle ( "`nomvargrup'")  caption (" `nomvar'") ytitle(" ") note(Pvalor KW=`pvalue') ylabel(, format(`formvar')) $boxcolor 

*********** GUARDA ELS GRAFICS ******************************************

*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
***************** TANCA EL BUCLE DELS GRAFICS

}

}
