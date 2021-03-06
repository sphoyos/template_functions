


******** TEMPLATE PER ANALISI EVOLUCIO VARIABLES EN TEMPS (CUALITATIU) I 2 GRUPS ****************
*********  El FITXER HA DE SER LONG ********


use "$dta/ana_datos_long.dta", clear




*** Variable Identificadora del subjecte*****
local identifica =  ""
*** Variable Temps en cualitatiu (1,2,3...)*****
local tc= " "
******* Variable grup en 2 nivells 0 i 1 *****************
local vargrup=""


*** Recupera Etiquetes del grup

 local lab0: di  "`:label (`vargrup') 0'"
 disp "`lab0'"
local lab1: di  "`:label (`vargrup') 1'"
disp "`lab1'"
label define lab_sino 0"No" 1"Si", modify


**** GENERA DUMMIES E INTERACCION *********
local igrup="i."+"`vargrup'"
local itc="i."+"`tc'"
local intera=""
 levelsof `tc', local(levels)
 local i=0
   foreach l of local levels {
   cap drop  inter`l'
   gen inter`l'=0 if `tc'!=`l' | `vargrup'==0
    if `i'>0{
   replace inter`l'= 1 if `tc' == `l' & `vargrup'==1
   local intera=   "`intera'"+ " i.inter`l'"
    local eti= "Interaccion "+ "`:label (`vargrup') 1'" +" visita "+"`:label (`tc') `l''"
	label var  inter`l' "`eti'"
	label val  inter`l' lab_sino
      }
    local i=`i'+1   
   }

disp in yellow "`intera'  `igrup'    `itc'"


****** FICAR ENTRE COMETES LES VARIABLES QUANTITATIVES  ********
local varcuant1 = "  "
local varcuant2= " "
local varcuant3= " "
local varcuant4= " "
     
 



***** FA UN BUCLE  PER A CADASCUNA DE LES VARIABLES CUANTITATIVES ***************

 foreach var of varlist   `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'    {


local varlab:variable label `var'  
 if   `"`varlab'"' == "" local varlab = "`var'"
sort `identifica' `tc'
htput <BR>
htput <H2> An�lisis para la variable `varlab' </H2>

htput <BR>

htput <BR>

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

bysort `tc' `vargrup':egen `nname'=count(`var')
bysort `tc' `vargrup': egen `meanname'=mean(`var')
bysort `tc' `vargrup':egen `medname'= median(`var')
bysort `tc' `vargrup':egen `sdname'= sd(`var')
bysort `tc' `vargrup':gen `liname'= `meanname'- invttail(( `nname'-1),.025)*( `sdname' / sqrt(`nname'))
bysort `tc' `vargrup':gen `lsname'= `meanname'+ invttail(( `nname'-1),.025)*( `sdname' / sqrt(`nname'))



sort `identifica'  `tc' 
twoway connected `var' `tc' if `vargrup'==0, c(L)  ms(i) ytitle(" ") color(red) ||connected `var' `tc' if `vargrup'==1, c(L)  ms(i) ytitle(" ") color(blue) ///
||  , title (Evoluci� Individual ) subtitle ( `varlab')  ysc(range(`min',`max'))  xlabel(0(1)2, valuelabel)  ylabel(#10)legend(label(1 "`lab0'") label(2 "`lab1'")) 

tempname graph1
graph rename Graph `graph1'



sort `tc'


htput <BR>
twoway sc `medname' `tc' if `vargrup'==0 ,c(l)  mlabel(`nname') ytitle(" ")  color(red) || sc `medname' `tc' if `vargrup'==1 ,c(l)  mlabel(`nname') ytitle(" ")  color(blue) ///
||, title (Evoluci� de la mediana `nloc' ) subtitle ( `varlab')   ysc(range(`min',`max'))   ylabel(#10)  xlabel(0(1)2, valuelabel)  ///
 legend(label(1 "`lab0'") label(2 "`lab1'")) 

tempname graph2
graph rename Graph `graph2'




twoway sc `meanname' `tc' if `vargrup'==0 ,c(l)   ytitle(" ")  color(red) || sc `meanname' `tc' if `vargrup'==1 ,c(l)  ytitle(" ")  color(blue) ///
 || rcap  `liname'  `lsname' `tc' if `vargrup'==0 ,   color(red) || rcap  `liname'  `lsname' `tc' if `vargrup'==1 ,  color(blue) ///
||, title (Evoluci� de la mitjana `nloc' ) subtitle ( `varlab')      ylabel(#10) xlabel(0(1)2, valuelabel) ///
 legend(label(1 "`lab0'") label(2 "`lab1'") label (3 "CI 95%")  label (4 "CI 95%"))

tempname graph3
graph rename Graph `graph3'

local grafname= "evogr"+"`var'"
grc1leg  `graph1' `graph2' `graph3', legendfrom(`graph3')  position(4) ring(0)

graph drop `graph1'
graph drop  `graph2'
graph drop `graph3'


graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evoluci� `namegraf' ">
htput <BR>



disp  in yellow "************************ MODELO 1 *************************************"


cap noi  htxtmixed_es `var',  id(`identifica') adjust( `igrup'  `itc' )  overall

disp  in yellow "************************ MODELO 2 *************************************"

 xi: xtmixed `var'  `itc'  `igrup' ||`identifica': ,mle iterate(40)
estimates store mod1 
htput <BR>


disp  in yellow "************************ MODELO 3 *************************************"


xi: xtmixed `var'  `intera'   `igrup'    `itc' ||`identifica' : ,mle iterate(40)
htput <BR>


 cap  lrtest mod1 
 qui local pvalue: di %5.3f r(p)

 
 
htput <BR>
disp  in yellow "************************ MODELO 4 *************************************"

htput <FONT COLOR=char(34) blue char(34)><b> P-valor test interaccio `pvalue' </b></FONT COLOR> 

     if `pvalue'<0.05 {
         htput <BR>
         cap noi  htxtmixed_es `var',  id(`identifica' ) adjust(`igrup' `itc' `intera'   )  overall 
     }

}


