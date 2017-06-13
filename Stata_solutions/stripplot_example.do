use "C:\Users\189498~1\AppData\Local\Temp\Augusto- FLUJOS-MRI-2-6Spss_12.dta" , clear
clonevar marfan_3=A__marfanORIG
replace marfan=3 if ACTA==1
label define lab_marfan 0"Non-Marfan" 1"Marfan" 3"ACTA II", modify
label val marfan lab_marfan
label define lab_class 1"I" 2"II" 3"III",modify
label val A__Classification lab_class
label var A__Classification  "Classification versus mm change"
stripplot  YearlyGrowthmmy,over(A__Classification) stack  bar(lcolor(black) mean(mcolor(black)) ) vertical separate(marfan) ///
            boffset(0.1)  ylabel(0(1)6, grid glstyle(dot)) xlabel(, grid glstyle(dot)) ///
			msymbol(Oh plus Sh) legend(position(10) ring(0)) mcolor(black black black )
			
			
stripplot  YearlyGrowthmmy,over(A__Classification) stack  bar(lcolor(black) mcolor(magenta) ) vertical separate(marfan) ///
            boffset(0.1)  ylabel(0(1)6, grid glstyle(dot)) xlabel(, grid glstyle(dot)) ///
			msymbol(Oh plus Sh) legend(position(10) ring(0)) 