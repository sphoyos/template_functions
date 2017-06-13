
use "R:\SCHIAFFINO\Avaluacio\_PCC_MACA\or\identificats\total_identificats.dta", clear

global DDIR="R:\SCHIAFFINO\Avaluacio\_PCC_MACA\or\identificats"
*ren hr or
ren inferior linf
ren superior lsup


foreach var in or linf lsup {

destring `var', dpcomma replace

}

replace categoriatext=trim(categoriatext)


***********************************************************************************************
*****************  Funcio per grafics OR *************************************************
***************************************************************************************


**** local hr= "Nom variable amb OR"
local hr="or"
*local liminf="Nom variable amb limit inferior"
local liminf="linf"
*local liminf="Nom variable amb limit superior"
local limsup="lsup"
*local liminf="Nom variable amb categories"
local categoras "categoriatext"

****** Nom del grafic
local grafname="identificats"
******  nom del grafic

*local graftitle =" "

levels(sectornum), local(levelsector)  // Identifica les etiquetes del sector.

foreach k of local levelsector  {  // Comença el bucle per a cada sector
local eti_sector : value label `k' // recupera la etiqueta del sector per al titol

preserve
keep if sectornum==`k'   // Selecciona el sector 


local grafname="`grafname'"+"_"+"`k'"   // Nom del grafic

gen id=_N-_n+1


gen hr=`hr'
gen liminf=`liminf'
gen limsup=`limsup' 
gen categoras= `categoras'

gen lhr=log(hr)
gen llinf=log(liminf)
gen llsup=log(limsup)

 ***** etiqueta variable categorica amb values
 
 
 * replace  categoras=categoras+ "               "   if hr==.
 levels(id), local(levels)
foreach l of local levels {
       tempvar vartemp
       gen `vartemp'=categoras if id==`l'
	   gsort -`vartemp'
	   local etiq=  `vartemp'[1]
	   if "`etiq'"=="" local etiq="."
	   lab def lab_id `l' "`etiq'", modify
       
      }
  

	
	
sort id
	lab  def lab_id 0"  ", modify
  lab val id lab_id
	local  nobs=_N
twoway rcap  llinf llsup id  , horizontal   color(black) ///
|| sc  id lhr  , color(orange) ///
|| ,xlabel( -2.99 "0.05" -2.3 "0.1" -.69 "0.5" 0 "1" .69 "2"  1.61 "5" 2.3 "10" 2.99 "20" 3.68 "40", labsize(small))  xline(0,lpattern(dash) lcolor(green)) ///
 ylabel(0(1)`nobs',angle(horizontal) valuelabel noticks labgap(2) labsize(small)) ytitle("") xtitle("Odds Ratio") legend(off) title(`eti_sector')
 
 graph export "$DDIR\OR_`grafname'.wmf", replace
 graph save "$DDIR\OR_`grafname'.gph", replace  // guarda el fitxer en stata 
 
 restore
 
 
 } // Tanca el bucle
 
 
 
   