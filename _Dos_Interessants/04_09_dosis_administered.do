*! docver: 2.0
*!  title: Dosis Administered
*!   html: yes
*!    log: yes
*!comment: 

version 9.2
htput <IMG SRC="UEB_IR.png" ALT="UEB-IR" ALIGN=CENTER WIDTH="80%" height="100">
htput <DIV ALIGN="CENTER" class="RED" style="font-size:small"> 
htput  </DIV>
htput <HR>
htput <H1> $HTtitle </H1>
htput <BR>
htput<p><font size="2" color="blue"> <b>Versión $S_DATE</b></font></p>
htput <br>

version 13.1


use $dta\ana\ana_infusion.dta, clear

drop if controltype==0

gen dosis_teo=.
replace dosis_teo=100 if controltype<=4
replace dosis_teo=200 if controltype>4 & controltype!=.

ren mlsoladmin dosis
label var dosis_teo "Theoretical dosis"
 
 
htput <H2> Analysis of MI solution administered</H2>

htput <BR>
htput <FONT color="#993366"> 
htput The graphs show for each individual the theoretical administered dosis compared for the real one by treatment <p>
htput The shaded area corresponts to the theoretical dose treatment. The green line and points are the real dose received by patient.<p>
htput Two separated graphs by treatment are presented.
htput </FONT color>
htput <BR>




local grafname ="sc_dose_bycontroltype_A"
sort patientid controltype

preserve 
keep if treatment==0

twoway area dosis_teo controltype, lcolor(orange_red) mcolor(orange_red)  fcolor("255 204 204") ///
|| connected dosis controltype , lcolor(green)  mcolor(green)  /// 
||, by(patientid,  title(Treatment A) )   ylabel(2(1)3 ,valuelabel angle(horizontal)) xlabel(1(1)8, valuelabel angle(315) )  
restore

graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace

htput <br>
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' " height="400" witdh="600">
htput <BR>




local grafname ="sc_dose_bycontroltype_B"
sort patientid controltype

preserve 
keep if treatment==1

twoway area dosis_teo controltype, lcolor(orange_red) mcolor(orange_red)  fcolor("255 204 204")  ///
|| connected dosis controltype , lcolor(green)  mcolor(green)  /// 
||, by(patientid,  title(Treatment B) )   ylabel(2(1)3 ,valuelabel angle(horizontal)) xlabel(1(1)8, valuelabel angle(315) )  
restore

graph export $htm\png\gr_`grafname'.png, replace
graph export $gph\gph\gr_`grafname'.wmf, replace
graph save $gph\gph\gr_`grafname'.gph, replace

htput <br>
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' "  height="400" witdh="600">
htput <BR>





