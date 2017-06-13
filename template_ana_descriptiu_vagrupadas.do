
htput <FONT color="#993366"> 
htput  En  este documento se presenta el análisis de las variables referentes agrupadas 
htput <br>
htput </FONT color>


htput <BR>
htput <FONT color="#993366"> 
htput  En primer lugar se presenta un análisis descriptivo para cada una de las variables  de la base de datos en función de 
htput las variables resultado del postoperatorio inmediato .  <br>

htput Para las variables cualitativas se muestra una tabla de frecuencias con el número de casos y el %  de cada categoria de la variable explicativa en la variable de respuesta. 
htput Para comparar la asociación entre las variables resultado  y cada variable se utiliza la prueba de Chi cuadrado o el valor p exacto de Fisher cuando 
htput el valor de casos esperados en cada celdilla es menor de 5.  Para identificar más fácilmente aquellas tablas con un valor p inferior al 5%
htput  se han marcado el fondo de las celdillas del p-valor 
htput </FONT color> <BR>

htput <FONT color="#993366"> 
htput Para las variables cuantitativas se muestran las medidas descriptivas habituales, media  y desviación típica, mínimo y máximo, mediana
htput  y percentiles, según las variables resultado . Se presentan los p valores de dos pruebas de contraste de igualdad de las variables
htput en los grupos. La prueba t y la prueba no paramétrica de Mann-Whitney. Se elegirá el valor p de una u otra según la simetría de la distribución . 
htput Para ello hay que fijarse en el diagrama de cajas que se presenta después de cada tabla . La linea de la caja representa la mediana 
htput y los límites el percentil 25 y 75. Si la línea esta en medio utilizaremos el p-valor de la prueba t, sino el de la U de Mann-Whitney.
htput  </FONT color> <BR>




****** FICAR ENTRE COMETES LES VARIABLES CATEGORIQUES ********
local varcat1 = ""
 local varcat2= ""
 local varcat3= ""
 local varcat4= ""
 
****** FICAR ENTRE COMETES LES VARIABLES QUANTITATIVES  ********
local varcuant1 = ""
 local varcuant2= ""
 local varcuant3= ""
 local varcuant4= ""

****** IDENTIFICA ELS NIVELLS DE AGRUPACIÓ DE LES VARIABLES  EXPLICATIVES *****************
local agrupa1= "" 
local agrupa2= ""
local agrupa3= ""
local agrupa4= ""
 
 
 
****** IDENTIFICA LA VARIABLES  QUE GENERA ELS GRUPS *****************
local varsgrup= "   " 




****** INDICA SI ES MOSTREN ELS GRAFICS (POR DEFECTE SI) *****************
local grafics_cat=1
local grafics_cuant=1

foreach vargrup of varlist `varsgrup'{
  local nomvargrup: var label `vargrup' 
  if   `"`nomvargrup'"' == "" local nomvargrup = "`vargrup'"
 
  htput <H2>Anàlisi descriptiva segons `nomvargrup' </H2>
  htput <BR>

  foreach k in 1 2 3 4 {

    htput <H3> `agrupa`k'' </H3>
    htput <BR>
      if "`varcat`k''"!="" {
        foreach var in   `varcat`k''   {
 
		***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES QUALITATIVES ***************	
 
           local var=subinstr("`var'","i.","",1)
           local nomvar: var label `var' 
           if   `"`nomvar'"' == "" local nomvar = "`var'"
       
	       htput <H4> <b>`nomvar' </b> </H4>
           htput <BR>
           
 		   ******************** EFECTUA LA TAULA. CANVIAR PERCENTAGES SEGONS ES VULLGUI 

           ht_tablacat `var' `vargrup' , head close prow rowtotal coltotal exact chi color

           htput <BR>

           if `grafics_cat'==1 {

               ******* EXTRAU EL NOM DE LA VARIABLE I DEL GRÀFIC *************************
 
             local nomvar: var label `var' 
             if   `"`nomvar'"' == "" local nomvar = "`var'"
             local grafname = "bar_"+"`vargrup'"+"_"+"`var'"

             ********* GENERA UNA TAULA DE 2X2 I EXTRAU EL VALOR CHI **********************
             qui tabulate `var' `vargrup', chi 
             local pvalue: di %9.4f  r(p)
             ************************ DIBUIXA EL GRAFIC DE FREQÜENCIES ACUMULAT *****************
             catplot bar `var'  `vargrup', percent("`vargrup'") stack asyvars title (" Diagrama de barras") subtitle( "`nomvargrup'")  ///
             bar(1, bcolor( 196 255 118))      bar(2, bcolor(255 118 128)) bar(3, bcolor(205 205 255))  bar(4,bcolor(255 231 206))  bar(5, bcolor(205 231 255))  ///
		     oversubopts(label(labsize(vsmall))) ylabel( ,labsize(vsmall))ytitle("% acumulado" ,size(small) ) note(Pvalor Chi=`pvalue')  legend(title( "`nomvar'")) 
           
             *********** GUARDA ELS GRAFICS ******************************************
             graph export $htm\png\gr_`grafname'.png, replace
             graph export $gph\wmf\gr_`grafname'.wmf, replace
             graph save $gph\gph\gr_`grafname'.gph, replace
             htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
             htput <BR>
             *************** TANCA EL BUCLE DELS GRAFICS
   
           } 
        *************** TANCA EL BUCLE DE LES VARIABLES CATEGORIQUES 
		}
	   ***** Tanca if si hi han variables categóriques	 
      }
        ***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES QUANTITATIVES ***************
      htput <BR>
	  if "`varcuant`k''"!="" {
        foreach var of varlist    `varcuant`k''     {
           local nomvar: var label `var' 
           if   `"`nomvar'"' == "" local nomvar = "`var'"
    
	       htput <H4> <b>`nomvar' </b> </H4>
           htput <BR>
           format %5.2f `var'

           ********** AFEGEIX LES FILES A LA TAULA EN HTML AMB LES FREQUENCIES PER COLUMNA SELECCIONA LA TAULA A FER ****************

           ht_tablacont `var' `vargrup' , head close anova kw total median minmax color

           *************************ACTIVAR SI ES VOL POSTHOC TEST 

           *anova `var' `vargrup' 
           *if F(e(df_m), e(df_r), e(F_1))>.95 {
           *htput <BR>
           *ht_scheffe `vargrup'
           *}

	       cap    tab `vargrup'  if `var'!=.
          
		   if `grafics_cuant'==1 & r(r)>1 {
		   
             ******* EXTRAU EL NOM DE LA VARIABLE I DEL GRÀFIC *************************
 
             local nomvar: var label `var' 
             if   `"`nomvar'"' == "" local nomvar = "`var'"

             local nomvargrup: var label `vargrup' 
             if   `"`nomvargrup'"' == "" local nomvargrup = "`vargrup'"
 
             local grafname = "box_"+"`vargrup'"+"_"+"`var'"

             ******** GENERA UNA TEST KRUSKAL-WALLIS I EXTRAU EL VALOR P **********************
             qui  kwallis `var' , by(  `vargrup') 
             local pvalue: di  %8.4f chiprob(r(df),r(chi2)) 

             ************************* DIBUIXA ELS DIAGRAMES DE CAPSES *****************
             local formvar: format `var' 
             graph box `var'  , over(`vargrup') title ("Diagrama de caixes per `nomvar'" ) subtitle ( "`nomvargrup'")  caption (" `nomvar'") ytitle(" ") note(Pvalor KW=`pvalue') ylabel(, format(`formvar')) $boxcolor 
         
             *********** GUARDA ELS GRAFICS ******************************************
             graph export $htm\png\gr_`grafname'.png, replace
             graph export $gph\wmf\gr_`grafname'.wmf, replace
             graph save $gph\gph\gr_`grafname'.gph, replace
             htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
             htput <BR>
             
			 ***************** TANCA EL BUCLE DELS GRAFICS
            }
		*************** TANCA EL BUCLE DE LES VARIABLES CUantitatives 	
		}
	   ***** Tanca if si hi han variables cuantitatives
     }
    *************** TANCA EL BUCLE DE l'AGRUPACIO DE VARIIABELS EXPLICATIVES
	}
************** TANCA EL BUCLE DE LES VARIABLES GRUP RESPOSTA
}

