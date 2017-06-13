******** TEMPLATE PER ANALISI EVOLUCIO VARIABLES EN TEMPS (CUALITATIU) I 2 GRUPS ****************
*********  El FITXER HA DE SER LONG ********

*** Variable Identificadora del subjecte*****
local identifica =  "nhc"
*** Variable Temps en cualitatiu (1,2,3...)*****
local tc= "measure"
******* Variable grup en 2 nivells 0 i 1 *****************
local vargrup="sg0sadis1"
local itc="i."+"`tc'"
 local lab0: di  "`:label (`vargrup') 0'"
 disp "`lab0'"
local lab1: di  "`:label (`vargrup') 1'"
disp "`lab1'"
replace `tc'=`tc'+1 if `vargrup'==1
foreach var of varlist peso {

qui summarize `var',detail
local min=r(min)-1
local max= r(max)+1

tempvar meanname
tempvar medname 
tempvar nname
tempvar sdname
tempvar liname
tempvar lsname
tempvar upq
tempvar loq
tempvar iqr
tempvar upw
tempvar lpw
tempvar outli

bysort `tc' `vargrup':egen `nname'=count(`var')
bysort `tc' `vargrup': egen `meanname'=mean(`var')
bysort `tc' `vargrup':egen `medname'= median(`var')
bysort `tc' `vargrup':egen `sdname'= sd(`var')
bysort `tc' `vargrup':gen `liname'= `meanname'- invttail(( `nname'-1),.025)*( `sdname' / sqrt(`nname'))
bysort `tc' `vargrup':gen `lsname'= `meanname'+ invttail(( `nname'-1),.025)*( `sdname' / sqrt(`nname'))

bysort `tc' `vargrup':egen `upq' = pctile(`var'), p(75) 
bysort `tc' `vargrup':egen `loq' = pctile(`var'), p(25) 
bysort `tc' `vargrup':egen `iqr' = iqr(`var'),
bysort `tc' `vargrup':egen `upw' = max(min(`var', `upq' +1.5*`iqr'))
bysort `tc' `vargrup':egen `lpw' = min(max(`var', `loq' -1.5*`iqr'))
bysort `tc' `vagrup': gen `outli'=.
bysort `tc' `vagrup': replace `outli'=`var' if (`var'<`lpw' | `var'>`upw') & `var'!=.
sort `tc'
*|| rcap  `liname'  `lsname' `tc' if `vargrup'==0 ,   color(red) ///
*	|| rcap  `liname'  `lsname' `tc' if `vargrup'==1 ,  color(blue) ///
local grafname= "evomeanCI"+"`var'"
twoway || rbar `medname' `upq' `tc' if `vargrup'==0, pstyle(p1) barw(1) blc("153 52 137") bfc("255 204 204")   ///
    || rbar `medname' `loq' `tc' if `vargrup'==0, pstyle(p1) barw(1) blc("153 52 137") bfc("255 204 204")   ///
	|| rbar `medname' `upq' `tc' if `vargrup'==1, pstyle(p1) barw(1) blc(blue) bfc("205 205 255")   ///
    || rbar `medname' `loq' `tc' if `vargrup'==1, pstyle(p1) barw(1) blc(blue) bfc("205 205 255")    ///  	
	|| rspike `upq' `upw' `tc' if `vargrup'==0, pstyle(p1) lcolor("153 52 137") msize(*4)  ///  	
    || rspike `loq' `lpw' `tc' if `vargrup'==0, pstyle(p1) lcolor("153 52 137") msize(*4)    ///
	|| rspike `upq' `upw' `tc' if `vargrup'==1, pstyle(p1) lcolor(blue) msize(*4)    ///
    || rspike `loq' `lpw' `tc' if `vargrup'==1, pstyle(p1) lcolor(blue) msize(*4)    ///
	|| rcap `upw' `upw' `tc' if `vargrup'==0, pstyle(p1) msize(*2) lcolor("153 52 137") msize(*2)   ///
    || rcap `lpw' `lpw' `tc' if `vargrup'==0, pstyle(p1) msize(*2) lcolor("153 52 137") msize(*2)  ///
    || rcap `upw' `upw' `tc' if `vargrup'==1, pstyle(p1) msize(*2) lcolor(blue) msize(*2)   ///
    || rcap `lpw' `lpw' `tc' if `vargrup'==1 , pstyle(p1) msize(*2) lcolor(blue) msize(*2)  ///
    || sc `meanname' `tc' if `vargrup'==0 ,c(l)   ytitle(" ")  color("153 52 137") ///
    || sc `meanname' `tc' if `vargrup'==1 ,c(l)  ytitle(" ")  color(blue)  ///
	 || sc `outli' `tc' if `vargrup'==0 ,   ytitle(" ")  color("153 52 137") ms(*) ///
    || sc `outli' `tc' if `vargrup'==1 ,  ytitle(" ")  color(blue)  ms(*) ///
		||, title (Weight evolution after Post-sleeve and SADI0 ) subtitle ( `varlab')   xtitle(Measure)    ylabel(#10,angle(h)) xlabel(0 3 6 12 18 24, valuelabel)  ///
     legend(order (1 3 13 14)   label(1 "SG") label(3 "SADI-S") label (13 "Mean SG")  label (14 "Mean SADI-S"))
}
 
 local grafname="grafico1"
*********** GUARDA ELS GRAFICS ******************************************
graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
