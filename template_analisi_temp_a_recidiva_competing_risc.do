
use "$dta\ana_datos.dta", clear

version  13.1



gen tarecidiva= trecidiva if recidiva==1
replace tarecidiva=tfollowup if tarecidiva==.
gen recimort=1 if recidiva==1
replace recimort=2 if exitus==1 & recimort==.
replace recimort=0 if recimort==.



htput   <H2> Análisis de Tiempo a Recidiva ( Riesgos Competitivos) </H2> 
htput <BR>

htput <font color="#993366"> 
htput Se presenta el análisis de riesgos competitivos . En primer lugar se muestra el  la curva del ajuste del modelo
htput de Kaplan Meier y el riesgo competitivo y la curva de supervivencia global. Si las curva de Kaplan-Meier i la incidencia acumlada por riesgo comeptitivo
htput no coincide indica que hay que utilizar riesgos competitivos para explicar las diferencias.<p>
htput  El gráfico de areas muestra la distribución de los casos de la causa analizada, el riesgo competitivo y el grupo de pacientes libres de enfermedad.<p> 
htput Luego se analizan los efectos de cada variable en la respuesta
htput de interes teniendo en cuenta los riesgos competitivos. Los resultados se presentan en forma de "suhazards" segun el modelo de Fine & Gray.
htput  En este análisis se tienen en cuenta que en el tiempo a recidiva la muerte juega un papel de competidor.
htput </font color> 
htput <BR>
	


stset tarecidiva, f(recimort=1 2 ) scale(365.25)
sts gen KMglob=s
gen CumIncglob=1-KMglob
gen  tsegglob=_t
stset tarecidiva, f(recimort=1  ) scale(365.25)

 sts gen KM1=s
 gen INC1=1-KM1
 stcompet CumInc = ci SError = se, compet1(2)  compet2(3)
 
 gen CumInc1 = CumInc if recimort==1
 gen CumInc2 = CumInc if recimort==2


 xi:stcrreg  , compete(recimort==2) 
predict aaa, basecif
gen FineInc1= aaa if recimort==1
cap drop aaa



stset tarecidiva, f(recimort=2  ) scale(365.25)

 sts gen KM2=s
 gen INC2=1-KM2

  xi:stcrreg  , compete(recimort==1) 
predict aaa, basecif
gen FineInc2= aaa if recimort==2
cap drop aaa

 
  gen tseg=_t
  
 stset tarecidiva, f(recimort==1 ) scale(365.25)

  
 sort tseg
 
 replace CumInc1= CumInc1[_n-1] if CumInc1==.
 replace CumInc2= CumInc2[_n-1] if CumInc2==.

 replace CumInc1=0 if CumInc1==.
 replace CumInc2=0 if CumInc2==.

 
 
 twoway line  CumInc1  INC1 CumInc2 INC2   tsegglob, sort lpattern("....-" "--.." "-." "--"  ) lcolor( red orange_red blue midblue ) ///
 || line CumIncglob tsegglob,sort lpattern("l") lcolor("153 52 137") ///
 || , xlabel(#10,labs(small))  ylabel(0(.1)1, angle(h)) ytitle("%") xtitle("Años de seguimiento") note("KM=Kaplan Meier, CR= Riesgos Competitivos") title("Tiempo a evento") ///
 legend(label(1 "CR Recidiva") label(2 "KM Recidiva")  label(3 "CR Muerte")  label(4 "KM Muerte") label(5 "Tiempo libre de enfermedad")) 
 
local grafname ="cr_recimort"
 
*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_spv_`grafname'.png, replace
graph export $gph\wmf\gr_spv_`grafname'.wmf, replace
graph save $gph\gph\gr_spv_`grafname'.gph,   replace
htput <IMG SRC=png\gr_spv_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
**************

gen b1=0
gen b2=1

gen CumInc12=CumInc1+CumInc2


twoway rarea  b1 CumInc1 tsegglob, color("160 160 255") c(J) ///
   ||    rarea  CumInc1 CumInc12 tsegglob, color("255 160 160") c(J) ///
   ||    rarea  CumInc12 b2 tsegglob, color("160 255 160") c(J)  ///
   ||, legend(label(1 "Recidiva") label(2 "Muerte")  label(3 "Libre de enfermedad"))   ylabel(0(.1)1, angle(h)) xtitle("Años de seguimiento") xlabel(#10,labs(small))
   
local grafname ="recimortfree"
 
*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_spv_`grafname'.png, replace
graph export $gph\wmf\gr_spv_`grafname'.wmf, replace
graph save $gph\gph\gr_spv_`grafname'.gph,   replace
htput <IMG SRC=png\gr_spv_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
**************




************************************************************
*************** AJUSTE DE MODELOS CR METASTASIS ************
************************************************************
   *************** TIPUS DE REGRESSIO ************
 *local tiporeg ="logit"
 local tiporeg ="stcrreg"
  
* ******* Variable Resposta **********
local var_resp=""

* ********* Variables explicatives  i. identifica les variables cualitatives **********

local varreg1= "i.sexo i.tabaquismo i.dmpreiq i.htapreiq i.stentcardsn i.arrtmiapreiqsn i.bypasscorsn  i.pared i.sutbronmanmec i.muonrecsn i.pt i.pn i.pm i.ap i.margenesafectosn "
local varreg2= "i.any2000 i.N2mas i.N1mas i.N1 i.N2 i.rt i.qtneoad i.qtady i.rtady  i.rtneoad i.fistulabpntemptar"
local varreg3= "edad imc fev1preiq fev1preiqlts fvcpreiq fvcpreiqlts ggppa vo2premlkgmin " 
local varreg4=" eje1 eje2 eje3 tamaotumoral gg n1 aj n2 al"

* ****** Variables iniciales fijas i. identifica las variables cualitativas *******************
local varadd_mod=""


************************** AJUSTE MODELOS UNIVARIANTES  ***********************************

htput <H3> Análisis Univariante del  tiempo a recidiva (muerte como riesgo competitivo)  </H3>
htput <BR>
 stset tarecidiva, f(recimort==1 ) scale(365.25)

*foreach varreg in `varreg1' `varreg2' `varreg3'  `varreg4' {
 display in yellow  "`varreg'"
capture noisily  htputvarcox , reg("`tiporeg'" ) dep("`var_resp'") indep (" `varreg1' `varreg2' `varreg3'  `varreg4' ") color  rr("SHR") trans(exp)    options("compete(recimort==2)")
htput <BR>
*}
