


**************************************************************************
****  DEFINIR LA FUNCIÓ DE SUPERVIVÈNCIA 
**************************************************************************



 stset ucontrol, f(estadopaciente==3) origin(data_implantacion) scale(365.25)


 
****** POSAR LES VARIABLES CATEGORIQUES
 local varcat1 = ""
 local varcat2= ""
 local varcat3= ""
 local varcat4= ""

****** FICAR ENTRE COMETES LES VARIABLES QUANTITATIVES  ********
 local varcuant1 = ""
 local varcuant2= ""
 local varcuant3= ""
 local varcuant4= ""
 
 ***** CANVIAR ELS TITOLS DELS GRAFICS
 local tit_analisis ="Análisis de Tiempo libre de enfermedad "
 local titol = "Tiempo a Recidiva, metastasis o muerte"
 local tit_time = "Años de seguimiento"
 local y_ord = "% libre de enfermedad"
 local grtip="dfs_"  /* Tipus de grafic per al grafname */
 local at_time =" 0  1  2 3  4 5 "  /* 0.006(48horas) .08(1 mes) 0.25(3 meses) 0.50(6 meses) 0.75(9 meses) */
local events="eventos" /* sustituir por el tipo de eventos  */



**************************************************************************
********* DESCRIPCIO DEL METODE
**************************************************************************

 htput <font color="#993366">
*htput En las siguientes tablas y gràficas se muestra el anàlisis de `titol' y global para las principales variables. <p>
*htput Para las variable qualitativas se presenta en primer lugar una tabla resumen con el número de casos, el tiempo de seguimiento 
*htput  y las tasas de aparición del evento así como la prueba log-rank de comparación. Después se presentan las tablas donde se presentan para cada categoria el `y_ord' a los tiempos `at time'. <br>
*htput Finalmente se muestran las curvas de Kaplan-Meier con la prueba log-rank. Para las variables cuantitativas se muestra el ajuste
*htput de un modelo de Cox univariante que nos indica si existe relación o no entre la variable y la supervivencia si el p valor<0.05. Para facilitar la 
*htput lectura se muestra coloreadas las tablas con asociación estadísticamente significativa



 htput En les següents taules i gràfiques es mostra l'anàlisi de ` titol ' i global per a les principals variables. < p >
htput Per a les variable qualitatives es presenta en primer lloc una taula resum amb el nombre de casos , el temps de seguiment
htput i les taxes d'aparició de l'esdeveniment així com la prova log - rank de comparació . Després es presenten les taules on es presenten per a cada categoria el ` y_ord ' als temps ` at time ' . <br>
htput Finalment es mostren les corbes de Kaplan - Meier amb la prova log - rank . Per a les variables quantitatives es mostra l'ajust
htput d'un model de Cox univariant que ens indica si hi ha relació o no entre la variable i la supervivència si el p valor < 0.05 . Per facilitar la
htput lectura es mostra acolorides les taules amb associació estadísticament significativa
htput </font color>. 
**************************************************************************

htput  <H2>  <font color=$colorvhir;font-size: 120%> `tit_analisis' global </font></b>  </H2> 
stdes 

**** TAULA RESUM AMB LA TAXA D'INCIDENCIA O MORTALITAT. Cal canviar la llengua

htput <BR>
ht_spvsum, lang("esp")
htput <BR>

*******************  Taula de SPV global segons els temps  ***** *******************

ht_spvlist, at( `at_time' )  years(1) lang("esp") eventos("`events'")
 
*** Gràfic supervivència global  *******************
local grafname= "`grtip'"+"global"
sts graph,    title(`titol')    xtitle(`tit_time') ytitle(`y_ord') 

*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
**************


**************************************************************************
**************    ANÁLISIS PER VARIABLES ************************
**************************************************************************
  htput <H2> `tit_analisis' según variables  cualitativas </H2> 
 
foreach var of varlist   `varcat1' `varcat2'  `varcat3' `varcat4'  {
    local nomvar: var label `var' 
    if   `"`nomvar'"' == ""  local nomvar =  " `var' " 
    ** Funció per crear la llegenda del gràfic 
    crea_llegenda `var'
    local llegenda `r(txt)'
    ** Funció per crear el format de les línies de la corba de spv
	crea_lineopts `var'
	    local lopts `r(lopt)'

		
     htput   <H4> `tit_analisis' para `nomvar' </H4> 
    htput <BR>
	
    **** TAULA RESUM AMB LA TAXA D'INCIDENCIA O MORTALITAT. Cal canviar la llengua
    ht_spvsum, by(`var') color lang("esp") eventos("`events'")
    htput <BR>

    *******************  Taula de SPV global segons els temps  y la variable ***************
    ht_spvlist, at(`at_time'  )  by(`var')  years(1) lang("esp") eventos("`events'")
    htput <BR>


    *** Gràfic supervivència  per categoría de la variable  *******************
    sts test `var'
    local pvalue: di %9.4f  chiprob(r(df),r(chi2))
    local grafname= "`grtip'"+"`var'"
    sts graph,  by(`var')    title(`titol')    subtitle ( `nomvar' )  xtitle(`tit_time') ytitle(`y_ord') ///
    note("P valor = `pvalue'") legend(`llegenda')  `lopts' 
    /*
    plot1opts(lpattern("l") lcolor("153 52 137")) plot2opts(lpattern("_") lcolor( "237 66 243"))  plot3opts(lpattern("-..") lcolor( "206 123 27")) ///
    plot4opts(lpattern(".") lcolor( "12 18 192")) */

    ********** GUARDA ELS GRAFICS ******************************************
    graph export $htm\png\gr_`grafname'.png, replace
    graph export $gph\wmf\gr_`grafname'.wmf, replace
    graph save $gph\gph\gr_`grafname'.gph, replace
    htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
    htput <BR>
    **************
}


 if "`varcuant1'"!="" {
    htput <H2> `tit_analisis' según variables  cuantitativas </H2> 
    htput <BR>

   foreach var of varlist  `varcuant1'  `varcuant2' `varcuant3' `varcuant4' {
       local nomvar:variable label `var'
      if   `"`nomvar'"' == "" local nomvar = "`var'"
 
       htput <H4>`tit_analisis'  para  `nomvar' </H4> 
       htput <BR>
  
       htputvarcox , reg("stcox" ) dep("") indep ("`var' ") color  rr("HR") trans(exp) multi 
       htput <BR>

   }

}



