
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
local varsgrup1= "   " 
local varsgrup2= "   " 
local varsgrup3= "   " 

****** INDICA SI ES MOSTREN ELS GRAFICS (POR DEFECTE SI) *****************
local grafics_cat=1
local grafics_cuant=1
local nvgrup=0
foreach vargrup of varlist `varsgrup1' `varsgrup2' `varsgrup3'{
 local nomvargrup: var label `vargrup' 
 if   `"`nomvargrup'"' == "" local nomvargrup = "`vargrup'"
local nvgrup=`nvgrup'+1
local nomg_`nvgrup'="`nomvargrup'" 

htput <H2>Anàlisi descriptiva segons `nomvargrup' </H2>
htput <BR>

******** GENERAR TAULES DE 2 X 2 PER A VARIABLES CUALITATIVES ***************************************

******************** ACTIVA  EL CATALA O CASTELLA *****************************************
htput <H3> <font color="#993489">Variables cualitativas </font color></H3>
htput <BR>
htput <FONT color="#993366">
htput   En primer lugar se presenta un análisis descriptivo para cada una de las variables de la base de datos en función de 
htput las implantacion  <br>
htput Para las variables cualitativas se muestra una tabla de frecuencias con el número de casos y el % de vivos y muertos en cada categoria. 
htput Para comparar la asociación entre las variables resultado  y cada variable se utiliza la prueba de Chi cuadrado o el valor p exacto de Fisher cuando 
htput el valor de casos esperados en cada celdilla es menor de 5.  Para identificar más fácilmente aquellas tablas con un valor p inferior al 5%
htput  se han marcado el fondo de las celdillas del p-valor 
htput </FONT color>
htput <BR>

local nvar=0
 foreach var in   `varcat1' `varcat2'  `varcat3' `varcat4'    {
 local var=subinstr("`var'","i.","",1)
 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"
 local nvar=`nvar'+1
local nom_`nvar'="`nomvar'"

disp in red  "`nvar' ; `nom_`nvar''"
 
 htput <H4> <b>`nomvar' </b> </H4>

htput <BR>
******************** EFECTUA LA TAULA. CANVIAR PERCENTAGES SEGONS ES VULLGUI 

    ht_tablacat `var' `vargrup' , head close prow rowtotal  exact chi color
local p_`nvgrup'_`nvar' =r(pvalue)
local m_`nvgrup'_`nvar' =r(metodo)
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
 }
*************** TANCA EL BUCLE DE LES VARIABLES CATEGORIQUES
htput <BR>

******** GENERAR TAULES DESCRIPTIVES  PER A VARIABLES QUANTITATIVES ***************************************



******************** ACTIVA  EL CATALA O CASTELLA *****************************************
htput <H3> <font color="#993489">Variables cuantitativas </font color></H3>
htput <BR>
htput <FONT color="#993366">
htput Para las variables cuantitativas se muestran las medidas descriptivas habituales, media  y desviación típica, mínimo y màximo, mediana
htput  y percentiles, según la implantacion  . Se presentan los p valores de dos pruebas de contraste de igualdad de las variables
htput en los grupos. La prueba t y la prueba no paramètrica de Mann-Whitney. Se elegirà el valor p de una u otra según la simetria de la distribución . 
htput Para ello hay que fijarse en el diagrama de cajas que se presenta después de cada tabla . La linea de la caja representa la mediana 
htput y los límites el percentil 25 y 75.. Si la línea esta en medio utilizaremos el p-valor de la prueba t, sino el de la U de Mann-Whitney.
htput </FONT color>
htput <BR>

******************** ACTIVA  EL CATALA O CASTELLA ***************************************
*htput <H3> <font color="#993489">Variables quantitatives </font color></H3>
*htput <BR>
*htput <FONT color="#993366"> Per a les variables quantitatives es mostren les mesures descriptives habituals, mitjana i desviació típica, mínim i màxim, mediana
*htput i percentils, segons les variables resultat. Es presenten els p valors de dues proves de contrast d'igualtat de les variables
*htput en els grups. La prova t i la prova no paramètrica de Mann-Whitney. Es triarà el valor p d'una o altra segons la simetria de la distribució.
*htput Per això cal fixar-se en el diagrama de caixes que es presenta després de cada taula. La línia de la caixa representa la mediana
*htput i els límits el percentil 25 i 75 . Si la línia està en mig utilitzarem el p-valor de la prova t, sinó el de la U de Mann-Whitney. </FONT color>
*htput <BR>
*htput <BR>


***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES QUANTITATIVES ***************

foreach var of varlist   `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'    {
 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"
 local nvar=`nvar'+1
 local nom_`nvar'="`nomvar'"
disp in red  "`nvar' ; `nom_`nvar''"
htput <H4> <b>`nomvar' </b> </H4>

htput <BR>
format %5.2f `var'

********** AFEGEIX LES FILES A LA TAULA EN HTML AMB LES FREQUENCIES PER COLUMNA SELECCIONA LA TAULA A FER ****************

ht_tablacont `var' `vargrup' , head close anova kw total median minmax color
local p_`nvgrup'_`nvar' =r(pvalue)
local m_`nvgrup'_`nvar' =r(metodo)
**************************ACTIVAR SI ES VOL POSTHOC TEST 

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

        ********* GENERA UNA TEST KRUSKAL-WALLIS I EXTRAU EL VALOR P **********************
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
  }
}




**************************************************************************************************
**********************  TAULA EN COLUMNA GRUPS I EN FILA VARCAT, VARCUANT ***********************
**************************************************************************************************


htput <H2> Resumen de las asociaciones </H2>
htput <FONT color="#993366" size="4" >  
htput En la siguiente tabla se presenta un resumen de las asociaciones entre las varaiables cuantitativas  consideradas
htput y las variables que generan grupo. <br>
htput Se muestra la prueba estadística elegida y el p valor <p>


htput <TABLE BORDER=1 CELLSPACING =0 CELlPADDING=2>
   htput <TR>

 htput <TH VALIGN=CENTER ALIGN=CENTER  > Variables </TH>



local nvgrup=0
foreach vargrup of varlist `varsgrup1' `varsgrup2'  `varsgrup3' {
local  nvgrup=`nvgrup'+1
htput <TH VALIGN=CENTER ALIGN=CENTER  >  `nomg_`nvgrup'' </TH>
}
htput </TR>




local coloret=""
local coloret= `"BGCOLOR="#CC66FF""' 

local nvar=0
foreach var of varlist   `varcat1'  `varcat2' `varcat3'  `varcat4'  `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'    {
htput <TR>
local nvar=`nvar'+1
disp in yellow "`nvar' ; `nom_`nvar''"
htput <TH VALIGN=CENTER ALIGN=LEFT  > `nom_`nvar''</TH>

local nvgrup=0
foreach vargrup of varlist `varsgrup1' `varsgrup2'  `varsgrup3' {
local  nvgrup=`nvgrup'+1

if round(`p_`nvgrup'_`nvar'',0.001) <=0.05 {	
	                local coloret= `"BGCOLOR="#FFCCCC""' 
	               		    }
		       else	{
                    local coloret=""
                   }

local pval:disp %5.3f `p_`nvgrup'_`nvar''
htput <TD VALIGN=CENTER ALIGN=CENTER `coloret' > `m_`nvgrup'_`nvar'' <br> `pval'</TD>
}
htput </TR>

}

htput </TABLE>


/*

**************************************************************************************************
**********************  TAULA EN COLUMNA VARCAT, VARCUANT I EN FILA VARGRUP   ********************
**************************************************************************************************


htput <H2> Resumen de las asociaciones </H2>
htput <FONT color="#993366" size="4" >  
htput En la siguiente tabla se presenta un resumen de las asociaciones entre las variables cuantitativas y cualitativas  consideradas
htput y las variables que generan grupo. <br>
htput Se muestra la prueba estadística elegida y el p valor <p>


htput <TABLE BORDER=1 CELLSPACING =0 CELlPADDING=2>
   htput <TR>

 htput <TH VALIGN=CENTER ALIGN=CENTER  > Variables </TH>



local nvar=0
foreach var of varlist   `varcat1'  `varcat2' `varcat3'  `varcat4'  `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'  {
local  nvar=`nvar'+1
htput <TH VALIGN=CENTER ALIGN=CENTER  >  `nom_`nvar'' </TH>
}
htput </TR>




local coloret=""
local coloret= `"BGCOLOR="#CC66FF""' 

local nvgrup=0
foreach vargrup of varlist `varsgrup1' `varsgrup2'  `varsgrup3' {
htput <TR>
local  nvgrup=`nvgrup'+1

disp in yellow "`nvar' ; `nomg_`nvgrup''"
htput <TH VALIGN=CENTER ALIGN=LEFT  > `nomg_`nvgrup''</TH>


local nvar=0
foreach var of varlist   `varcat1'  `varcat2' `varcat3'  `varcat4'  `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'    {
local nvar=`nvar'+1



if round(`p_`nvgrup'_`nvar'',0.001) <=0.05 {	
	                local coloret= `"BGCOLOR="#FFCCCC""' 
	               		    }
		       else	{
                    local coloret=""
                   }

local pval:disp %5.3f `p_`nvgrup'_`nvar''
htput <TD VALIGN=CENTER ALIGN=CENTER `coloret' > `m_`nvgrup'_`nvar'' <br> `pval'</TD>
}
htput </TR>

}

htput </TABLE>

*/








