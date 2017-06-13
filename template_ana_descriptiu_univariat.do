

****** FICAR ENTRE COMETES LES VARIABLES CATEGORIQUES ********
local varcat1 = " "
 local varcat2= " "
 local varcat3= " "
 local varcat4= " "
 
****** FICAR ENTRE COMETES LES VARIABLES QUANTITATIVES  ********
local varcuant1 = " "
 local varcuant2= " "
 local varcuant3= " "
 local varcuant4= " "

****** IDENTIFICA LA VARIABLES  QUE GENERA ELS GRUPS *****************

tempvar total
gen `total'=1
label var `total' ""
label define lab_total 1"_"
label val `total' lab_total
local varsgrup= " `total'  " 
****** INDICA SI ES MOSTREN ELS GRAFICS (POR DEFECTE SI) *****************
local grafics_cat=1
local grafics_cuant=1

foreach vargrup of varlist `varsgrup'{
 local nomvargrup: var label `vargrup' 
 if   `"`nomvargrup'"' == "" local nomvargrup = "`vargrup'"
 
htput <H2>An�slisis descriptivo univariante</H2>
htput <BR>
htput <FONT color="#993366">  
htput En primer lugar se presenta un an�lisis descriptivo para cada una de las variables de la base de datos en funci�n de 
htput </FONT color>
htput <BR>
******** GENERAR TAULES DE 2 X 2 PER A VARIABLES CUALITATIVES ***************************************

******************** ACTIVA  EL CATALA O CASTELLA *****************************************
htput <H3> <font color="#993489">Variables cualitativas </font color></H3>
htput <BR>
htput <FONT color="#993366">  
htput Para las variables cualitativas se muestra una tabla de frecuencias con el n�mero de casos y el % de cada una de las categorias<p>
if `grafics_cat'==1 {
htput Se presenta un gr�fico de barras con la distribuci�n del porcentaje de casos acumulado al 100%
}
htput </FONT color>
htput <BR>

******************** ACTIVA  EL CATALA O CASTELLA ***************************************
*htput <H3> <font color="#993489">Variables qualitatives </font color></H3>
*htput <BR>
*htput <FONT color="#993366"> En primer lloc es presenta una an�lisi descriptiva per a cadascuna de les variables de la base de dades en funci� de
* if `grafics_cat'==1 {
*htput Es presenta un gr�fic de barres on es veu la distribuci� del percentage de casos de cada categoria acumulats al 100%
*} 
*htput <BR>
*htput Per a cada variable qualitativa es mostra la taula de freq��ncies amb el nombre de casos i el percentatge de cada categoria<p>
*htput </FONT color>
htput <BR>

 foreach var in   `varcat1' `varcat2'  `varcat3' `varcat4'    {
 
 
 
local var=subinstr("`var'","i.","",1)
 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"
 htput <H4> <b>`nomvar' </b> </H4>

htput <BR>
******************** EFECTUA LA TAULA. CANVIAR PERCENTAGES SEGONS ES VULLGUI 

    ht_tablacat_cast `var' `vargrup' , head close pcol coltotal 

htput <BR>

    if `grafics_cat'==1 {

          ******* EXTRAU EL NOM DE LA VARIABLE I DEL GR�FIC *************************
 
            local nomvar: var label `var' 
            if   `"`nomvar'"' == "" local nomvar = "`var'"
            local grafname = "bar_"+"`vargrup'"+"_"+"`var'"

            ************************ DIBUIXA EL GRAFIC DE FREQ�ENCIES ACUMULAT *****************
            catplot bar `var'  `vargrup', percent("`vargrup'") stack asyvars title (" Diagrama de barras")   ///
            bar(1, bcolor( 196 255 118))      bar(2, bcolor(255 118 128)) bar(3, bcolor(205 205 255))  bar(4,bcolor(255 231 206))  bar(5, bcolor(205 231 255))  ///
		    oversubopts(label(labsize(vsmall))) ylabel( ,labsize(vsmall))ytitle("% acumulado" ,size(small) )  legend(title( "`nomvar'")) 
          
    *********** GUARDA ELS GRAFICS ******************************************
    graph export $htm\png\gr_`grafname'.png, replace
    graph export $gph\wmf\gr_`grafname'.wmf, replace
    graph save $gph\gph\gr_`grafname'.gph, replace
    htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evoluci� `namegraf' ">
    htput <BR>
    *************** TANCA EL BUCLE DELS GRAFICS
   
   }
 }
*************** TANCA EL BUCLE DE LES VARIABLES CATEGORIQUES
htput <BR>

******** GENERAR TAULES DESCRIPTIVES  PER A VARIABLES QUANTITATIVES ***************************************


******************** ACTIVA  EL CATALA O CASTELLA *****************************************
htput <H3> <font color="#993489">Variables cuantitativas </font color></H3>
htput <BR>
htput <BR>
htput <FONT color="#993366">  
htput Para las variables cuantitativas se muestran las medidas descriptivas habituales, media y desviaci�n t�pica , minimo y m�ximo y los percentiles <p>


cap    tab `vargrup'  if `var'!=.
if `grafics_cuant'==1 & r(r)>=1 {
htput Se presenta un gr�fico de cajas con la distribuci�n de la variable. La l�nea del medio representa la mediana y los l�mites de la caja
htput son los percentiles 25 y 75 respectivamente. Los puntos que salen fuera de las l�neas son los valores extremos. Si la linea esta en el centro
htput de la caja, la distribuci�n de la variable es simetrica.   Si la mediana es pr�xima a la media podemos tiene sentido utilizar la
htput media en las pruebas de hip�teis
}
htput </FONT color>
htput <BR>

******************** ACTIVA  EL CATALA O CASTELLA ***************************************
*htput <H3> <font color="#993489">Variables quantitatives </font color></H3>
*htput <BR>
*htput <FONT color="#993366">  
*htput Per a les variables quantitaves es mostren les mesures descriptives habituals, mitjana i desviaci� t�pica , m�nim i m�xim i els percentilss <p>
*cap    tab `vargrup'  if `var'!=.
*if `grafics_cuant'==1 & r(r)>=1 {
*htput Es presenta un gr�fic de caixes amb la distribuci� de la variable la linia del mig representa la mediana i els l�mits de la caixa son 
*htput s�n els percentils 25 i 75 respectivament. Els punts que sorten fora de les l�nies son els valors extrems. Si al l�nia �s al centre 
*htput de la caixa, la distribuci� de la variable es sim�trica. Si la mediana es pr�xima a la mitjana podem dir que te sentit utilitzar la
*htput mitjana a les probes d'hip�tesi
*}
*htput </FONT color>
*htput <BR>htput <BR>


***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES QUANTITATIVES ***************

foreach var of varlist   `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'    {
 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"
 htput <H4> <b>`nomvar' </b> </H4>

htput <BR>
format %5.2f `var'

********** AFEGEIX LES FILES A LA TAULA EN HTML AMB LES FREQUENCIES PER COLUMNA SELECCIONA LA TAULA A FER ****************

ht_tablacont_cast `var' `vargrup' , head close   median minmax 
	   tab `vargrup'  if `var'!=.
	
    if `grafics_cuant'==1 & r(r)>=1 {
		   
        ******* EXTRAU EL NOM DE LA VARIABLE I DEL GR�FIC *************************
 
        local nomvar: var label `var' 
        if   `"`nomvar'"' == "" local nomvar = "`var'"

        local nomvargrup: var label `vargrup' 
        if   `"`nomvargrup'"' == "" local nomvargrup = "`vargrup'"
 
        local grafname = "box_"+"`vargrup'"+"_"+"`var'"

        ***

        ************************* DIBUIXA ELS DIAGRAMES DE CAPSES *****************
        local formvar: format `var' 
        graph box `var' ,  title("Diagrama de cajas  `nomvar'") ytitle(" ")  ylabel(, format(`formvar')) $boxcolor 

   
     
    *********** GUARDA ELS GRAFICS ******************************************
     graph export $htm\png\gr_`grafname'.png, replace
     graph export $gph\wmf\gr_`grafname'.wmf, replace
     graph save $gph\gph\gr_`grafname'.gph, replace
     htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evoluci� `namegraf' ">
     htput <BR>
    ***************** TANCA EL BUCLE DELS GRAFICS

    }
  }
}

