


htput <BR>



******** GENERAR TAULES DE 2 X 2 PER A VARIABLES CUALITATIVES ***************************************


htput <H3> <font color="#993489">VARIABLES QUALITATIVES </font color></H3>

htput <BR>



****** FICAR ENTRE COMETES LES VARIABLES CATEGORIQUES ********
local varcat1 = " "
 local varcat2= " "
 local varcat3= " "
 local varcat4= " "
 
*****  CONTA EL NOMBRE DE VARIABLES  **************
local nvarcat=wordcount("`varcat1'")+ wordcount("`varcat2'")+wordcount("`varcat3'")+wordcount("`varcat4'")



****** IDENTIFICA LA VARIABLES  QUE GENERA ELS GRUPS *****************
local varsgrup= "  " 

foreach vargrup of varlist `varsgrup'{

 
 local nomvargrup: var label `vargrup' 
 if   `"`nomvargrup'"' == "" local nomvargrup = "`vargrup'"
 
****************************** INITZIALIZA A 0 **********************************
local n_varcat=0


***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES CATEGORIQUES ***************

 foreach var of varlist   `varcat1' `varcat2'  `varcat3' `varcat4'    {

********** CONTABILITZA EL NUMERO DE VARIABLE **************
local n_varcat=`n_varcat'+1

**********  INDICA SI ES LA VARIABLE CABPAÇALERA O DE TANCAMENT DE LA TAULA *****************

local cap=" "
local fin= " "
 if `n_varcat'==1 local cap="head"
 if `n_varcat'==`nvarcat' local fin="close"


********** AFEGEIX LES FILES A LA TAULA EN HTML AMB LES FREQUENCIES PER COLUMNA ****************

ht_tablacat `var' `vargrup' , `cap' `fin' prow coltotal  exact chi color
********************TANCA EL BUCLE PER LA TAULA
}

htput <BR>

 
htput <BR>
htput <BR>
***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES CATEGORIQUES PER FER ELS GRÀFICS ***************

 foreach var of varlist    `varcat1' `varcat2'  `varcat3' `varcat4'    {

 
******* EXTRAU EL NOM DE LA VARIABLE I DEL GRÀFIC *************************
 
 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"
local grafname = "bar_"+"`vargrup'"+"_"+"`var'"

 ********* GENERA UNA TAULA DE 2X2 I EXTRAU EL VALOR CHI **********************
qui tabulate `var' `vargrup', chi 
local pvalue: di %9.4f  r(p)



************************ DIBUIXA EL GRAFIC DE FREQÜENCIES ACUMULAT *****************
catplot bar `var'  `vargrup', percent("`vargrup'") stack asyvars title (" Diagrama de barras para   `nomvar'") subtitle ( "`nomvargrup'") ///
     bar(1, bcolor( 196 255 118))      bar(2, bcolor(255 118 128)) bar(3, bcolor(205 205 255))  bar(4,bcolor(255 231 206))  bar(5, bcolor(205 231 255))  ///
							oversubopts(label(labsize(vsmall))) ylabel( ,labsize(vsmall))ytitle("% acumulado" ,size(small) ) note(Pvalor Chi=`pvalue') 

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


