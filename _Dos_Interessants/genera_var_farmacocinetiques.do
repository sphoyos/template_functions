

version 13.1

use "$dta\ana\ana_blood.dta" , clear






foreach var in `var' nh4  alanine alphaaminobutyric arginine asparagine aspartic citrulline cysteine glutamic glutamine glycine /// 
             histidine hydroxyproline isoleucine leucine lysine methionine  ornithine phenylalanine proline serine  ///
            taurine threonine tryptophan tyrosine valine ratioaromramif  spaaconc spagconc   {
local varlab:variable label `var'  
 if   `"`varlab'"' == "" local varlab = "`var'"
disp in red upper("`var'")			
preserve
quietly {
local var="nh4"
keep  patientid treatment controltype  childpugh_no_HE childpugh_num childpugh_class tmeasure `var' 
order  patientid treatment controltype childpugh_no_HE childpugh_num childpugh_class tmeasure `var' 
gen auc_`var'=.
format auc_`var' %10.2f
gen auc24_`var'=.
format auc24_`var' %10.2f
gen tauc_`var'=.
format tauc_`var' %10.2f
gen tauc_b_`var'=.
format tauc_b_`var' %10.2f
levels tmeasure
local measures=r(levels)
foreach med in  `measures' {
gen `var'_`med'=.
}
gen slope_12_`var'=.
format slope_12_`var' %10.2f
gen slope_24_`var'=.
format slope_24_`var' %10.2f
gen slope_48_`var'=.
format slope_48_`var' %10.2f
gen slope_120_`var'=.
format slope_120_`var' %10.2f

levels patientid
local id_levels=r(levels)
foreach lev in `id_levels' {

    cap   qui pkexamine tmeasure `var' if patientid==`lev' & tmeasure<125, trapezoid
    if _rc==0 {
        replace auc_`var'=r(auc) if patientid==`lev'
	}	
	
	cap   qui pkexamine tmeasure `var' if patientid==`lev' & tmeasure<30, trapezoid
    if _rc==0 {
        replace auc24_`var'=r(auc) if patientid==`lev'
	}
	
	
   levels tmeasure
   local measures=r(levels)
   foreach med in  `measures' {
      summarize `var' if patientid==`lev' & tmeasure==`med'
      local `var'`med'=r(max)
      replace `var'_`med'=``var'`med''  if patientid==`lev'
      cap regress `var' tmeasure if tmeasure<=24  & patientid==`lev'
      if _rc==0 {
        replace slope_24_`var'=_b[tmeasure] if   patientid==`lev'
      }
      cap regress `var' tmeasure if tmeasure<=48  & patientid==`lev'
      if _rc==0 {
        replace slope_48_`var'=_b[tmeasure] if  patientid==`lev'
      }
      cap regress `var' tmeasure if tmeasure<=120  & patientid==`lev'
      if _rc==0 {
        replace slope_120_`var'=_b[tmeasure] if  patientid==`lev'
      }
	  cap regress `var' tmeasure if tmeasure<=12  & patientid==`lev'
      if _rc==0 {
        replace slope_12_`var'=_b[tmeasure] if  patientid==`lev'
      }
    }
}

replace tauc_`var'=auc_`var'/120 
replace tauc_b_`var'= tauc_`var'-`var'_0

foreach med in 12 24 36 48 72 96 120 144 672{

gen `var'_abs_dif_0_`med'= `var'_`med'-`var'_0
gen `var'_rel_dif_0_`med'= ((`var'_`med'-`var'_0)/`var'_0 )*100
} 


keep if tmeasure==0


label var auc_`var' "`varlab' AUC <sub> 0-120h </sub> "
label var tauc_`var' "`varlab' TN-AUC <sub> 0-120h </sub>"
label var tauc_b_`var' "`varlab' TN-AUCMB <sub> 0-120h </sub>"
label var slope_24_`var' "`varlab' Slope <sub> 0-24h </sub>"
label var slope_48_`var' "`varlab' Slope <sub> 0-48h </sub>"
label var slope_120_`var' "`varlab' Slope <sub> 0-120h </sub>"
label var slope_120_`var' "`varlab' Slope <sub> 0-12h </sub>"
foreach med in 0 12 24 36 48 72 96 120 144 {
label var `var'_`med' "`varlab' at `med'h"
format `var'_`med' %5.2f 
}
label var `var'_672 "`varlab' at week 4"
format `var'_672 %5.2f 

foreach med in  12 24 36 48 72 96 120 144 672 {
label var `var'_abs_dif_0_`med' " `varlab' Absolute difference <sub> 0-`med' </sub> "
format `var'_abs_dif_0_`med' %5.2f 
label var `var'_rel_dif_0_`med' " `varlab' Relative difference <sub> 0-`med' </sub> "
format `var'_rel_dif_0_`med' %5.2f 
}

}
label var `var'_abs_dif_0_672 " Absolute difference <sub> 0-week4 </sub> "
label var `var'_rel_dif_0_672 " Relative difference <sub> 0-week4 </sub> "

clonevar  `var'_decrease24=`var'_abs_dif_0_24
label var `var'_decrease24 " Change in `varlab' within first 24 hours"

save "$dta\ana\ana_`var'.dta", replace

restore
}
