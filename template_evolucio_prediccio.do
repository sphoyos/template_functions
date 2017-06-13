******** TEMPLATE PER ANALISI EVOLUCIO VARIABLES EN TEMPS (CUALITATIU) I 2 GRUPS ****************
*********  El FITXER HA DE SER LONG ********

*** Variable Identificadora del subjecte*****
local identifica =  "ident"
*** Variable Temps en cualitatiu (1,2,3...)*****
local tc= "nmed"
******* Variable grup en 2 nivells 0 i 1 *****************
local vargrup=""
local itc="i."+"`tc'"

****** FICAR ENTRE COMETES LES VARIABLES QUANTITATIVES  ********
local varcuant1 = "lafs_"
local varcuant2= " "
local varcuant3= " "
local varcuant4= " "

foreach var of varlist   `varcuant1'  `varcuant2' `varcuant3'  `varcuant4'    {

******* Variable grup en 2 nivells 0 i 1 *****************
local vargrups="poli_is_ini never  noprope_ini prope_tol_ini"

foreach vargrup in `vargrups' {

local igrup="i."+"`vargrup'"
tempvar  prednointer
tempvar  predinter 
*** Recupera Etiquetes del grup

 local lab0: di  "`:label (`vargrup') 0'"
 disp "`lab0'"
local lab1: di  "`:label (`vargrup') 1'"
disp "`lab1'"
label define lab_sino 0"No" 1"Si", modify

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


**** GENERA DUMMIES E INTERACCION *********
 local igrup="i."+"`vargrup'"

 local varlabgrup:variable label `vargrup'  
 if   `"`varlabgrup'"' == "" local varlabgrup = "`vargrup'"
 
sort `identifica' `tc'
htput <BR>
disp  in yellow "************************ MODELO 1  EFECTES PRINCIPALS *************************************"

htput <BR>
htput <H4> Modelo efecto principales para `varlab' segun `varlabgrup' </H4>
*  
cap noi  htxtmixed_es `var',  id(`identifica') adjust(  `igrup'  `itc')  

xi: xtmixed `var'  `itc'  `igrup' ||`identifica': ,mle iterate(40)
estimates stats
matrix ZZ=r(S)
local aic: di %6.2f ZZ[1, 5]

estimates store mod1 
predict  `prednointer', xb

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



sort `tc'

local grafname= "evomeanCI"+"`var'"
twoway sc `meanname' `tc' if `vargrup'==0 ,c(l)   ytitle(" ")  color(red) || sc `meanname' `tc' if `vargrup'==1 ,c(l)  ytitle(" ")  color(blue) ///
 || rcap  `liname'  `lsname' `tc' if `vargrup'==0 ,   color(red) || rcap  `liname'  `lsname' `tc' if `vargrup'==1 ,  color(blue) ///
||, title (Evolució de la mitjana `nloc' ) subtitle ( `varlab')      ylabel(#10)  ///
 legend(label(1 "`lab0'") label(2 "`lab1'") label (3 "CI 95%")  label (4 "CI 95%"))

*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>






htput <BR>


sort `tc'

replace `ctc'  =`tc'+15


local grafname= "prednointer"+"`var'"+"`vargrup'"
twoway line `prednointer' `ctc' if `vargrup'==0 ,  ytitle(" ")  color(red)  ||  sc `var' `ctc' if `vargrup'==0, msize(tiny) mcolor(erose) ///
|| line  `prednointer' `ctc' if `vargrup'==1 ,c(l)  ytitle(" ")  color(blue) || sc `var' `ctc' if `vargrup'==1, msize(tiny) mcolor(ltblue) ///
||, title (Evolució de predicció efecte principals per `varlab') subtitle ( `varlabgrup')   ysc(range(`min',`max'))   ylabel(#10)  ///
 legend(label(1 "") label(2 "`lab0'")  label(3 "") label(4 "`lab1'"))  note("AIC = `aic'") 

graph export $htm\gr_`grafname'.png, replace
graph export $gph\gr_`grafname'.wmf, replace
graph save $gph\gr_`grafname'.gph, replace
htput <IMG SRC=gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR/>




disp  in yellow "************************ MODELO 2 INTERACCIÓ  *************************************"

htput <BR>
xi: xtmixed `var'    `igrup'    `itc'  `intera'  ||`identifica' : ,mle iterate(40)
estimates stats
matrix ZZ=r(S)
local aic: di %6.2f ZZ[1, 5]

predict  `predinter',xb

 cap  lrtest mod1 
 qui local pvalue: di %5.3f r(p)

htput  <FONT COLOR="blue"><b> P-valor test interaccio `pvalue' </b></FONT COLOR> 
 htput <BR>
 if `pvalue' <0.05 {
htput <BR>
htput <H4> Modelo  con interacción  para `varlab' segun `varlabgrup' </H4>
htput <BR>


htput <BR>
cap noi  htxtmixed_es `var',  id(`identifica' ) adjust(`igrup' `tc' `intera'   )  overall 


local grafname= "predinter"+"`var'"+"`vargrup'"
twoway line `predinter' `ctc' if `vargrup'==0 ,   ytitle(" ")  color(red) || line `predinter' `ctc' if `vargrup'==1 , ytitle(" ")  color(blue) ///
||, title (Evolució de predicció amb interacció per `varlab') subtitle ( `varlabgrup')   ysc(range(`min',`max'))   ylabel(#10)  ///
 legend(label(1 "`lab0'") label(2 "`lab1'"))  note("AIC = `aic'") 

graph export $htm\gr_`grafname'.png, replace
graph export $gph\gr_`grafname'.wmf, replace
graph save $gph\gr_`grafname'.gph, replace
htput <IMG SRC=gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>

}

}
}
