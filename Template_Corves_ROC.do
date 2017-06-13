
*************************************************************************
************** Template per corba ROC ***********************************
*************************************************************************



htput <FONT color="#993366">  
htput En este document se muestra la curva ROC de clasificación de cada una de la varaibles cuantitativas con diferentes variables respuestas dicotómicas.  <p>
htput En primer lugar se muestra una tabla con la sensibilidad, especificidad, % de clasificados correctamente y las razones de verosimilitudes positiva 
htput y negativa si se situara el punto de corte en el valor que viene en la primera columna. Obviamente se empieza con una sensibilidad del 100% 
htput y una especificidad del 0% para finalizar al revés en una sensibilidad del 0% y una especificidad del 100%. <p>
htput Los datos de esta tabla se dibujan  en la curva ROC y se calcula el área bajo la curva(AUC) . 
htput Un área próxima al 100% indicaría una clasificación perfecta que no existe.  <p>
htput En la segunda tabla se muestra el valor del AUC y su intervalo de confianza y dos formas para obtener el punto de corte uno basado 
htput en el Indice de Youden y otro en el punto que mejor se acerca a la esquina superior izquierda del gràfico de la curva ROC.<p>
htput Hay que tener en cuenta que cuando hay pocos eventos, la clasificación global puede ser muy grande y justamente fallar en los casos positivos que son pocos. 
htput </FONT>


local vargrup=" "

 local nomvargrup: var label `vargrup' 
 if   `"`nomvargrup'"' == "" local nomvargrup = "`vargrup'"
 
htput <h2> curva ROC para`nomvargrup' </h2>
htput <br>

local varcuant1=" "
local varcuant2=" "
foreach var in `varcuant1'  `varcuant2' {

 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"
 
 htput <h4>  `nomvar' </h4>
local grafname="roc_"+"`vargrup'"+"_"+"`var'"
		  ht_roctab   `vargrup' `var' , detail graph title( Curva ROC `nomvar') subtitle(`nomvargrup') lcolor( "153 52 137") mcolor("153 52 137" )
		  
	    *********** GUARDA ELS GRAFICS ******************************************
    graph export $htm\png\gr_`grafname'.png, replace
    graph export $gph\wmf\gr_`grafname'.wmf, replace
    graph save $gph\gph\gr_`grafname'.gph, replace
	htput <BR>
    htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
    htput <BR>
    *************** TANCA EL BUCLE DELS GRAFICS		 

}
