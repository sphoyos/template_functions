


***********************************************************************************************
*****************  Funcio per grafics OR +CI  en  TEXTE *************************************************
***************************************************************************************



**** local hr= "Nom variable amb OR"
local hr="var1"
*local liminf="Nom variable amb limit inferior"
local liminf="var2"
*local liminf="Nom variable amb limit superior"
local limsup="var3"
*local liminf="Nom variable amb categories"
local categoras ="var4"

****** Nom del grafic
local grafname="proba"
******  nom del grafic

local graftitle =" "

preserve

gen id=_N-_n+1


gen HR=`hr'
gen LIMINF=`liminf'
gen LIMSUP=`limsup' 
gen CATEGORAS= `categoras'
gen ic=""
gen lhr=log(HR)
gen llinf=log(LIMINF)
gen llsup=log(LIMSUP)

 ***** etiqueta variable categorica amb values
 
 
 * replace  categoras=categoras+ "               "   if hr==.
 levels(id), local(levels)
foreach l of local levels {
       tempvar vartemp
       gen `vartemp'=CATEGORAS if id==`l'
	   gsort -`vartemp'
	   local etiq=  `vartemp'[1]
	   if "`etiq'"=="" local etiq="."
	   lab def lab_id `l' "`etiq'", modify
       local   ic`l':   disp  %5.2f HR[1] "["%5.2f LIMINF[1] ";"%5.2f LIMSUP[1] "]" 

	   replace ic="`ic`l''" if id==`l'
	   
	   
      }
  
summarize llsup
gen temp= min(5.5,r(max)+.2)
disp  in red r(max)+1
local xmax=max(5.5, r(max)+3)
disp in yellow(`xmax')
	
sort id
	lab  def lab_id 0"  ", modify
  lab val id lab_id
	local  nobs=_N
twoway rcap  llinf llsup id  , horizontal   color(red) ///
|| sc  id lhr  , color(blue) ///
|| sc  id temp  , ms(i)  mlabel(ic)  msize(vsmall) ///
|| ,xlabel( -2.99 "0.05" -2.3 "0.1" -.69 "0.5" 0 "1" .69 "2"  1.61 "5" 2.3 "10" 2.99 "20" 3.68 "40", labsize(small))  xline(0,lpattern(dash) lcolor(green)) ///
 ylabel(0(1)`nobs',angle(horizontal) valuelabel noticks labgap(2) labsize(small)) ytitle("") xtitle("Odds Ratio") legend(off) title(`graftitle')
 
 *graph export "$DDIR\OR_`grafname'.wmf", replace
 
 
 restore
 