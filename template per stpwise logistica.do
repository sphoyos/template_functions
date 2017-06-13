

xi: stepwise, pe(.1) pr(.2) forward: logit dbp  i.sexe (i.recoeg) (i.gpesnac) (i.cortismam) (i.pcaqui) (i.grauhipv) (i.gdiesippv) (i.voaf) (i.on) (i.pca) (i.hipv)  ///
                                        ///  (i.leucomala) (i.ecn)  (i.ecnquir)  (i.rpotrat) (i.sepsisp) (i.sepsisnoso) (i.sepsiscli) 

local var_resp="dbp"
 
foreach var in  sexe recoeg gpesnac cortismam pcaqui grauhipv gdiesippv voaf on pca hipv {

 local nomvar: var label `var' 
 if   `"`nomvar'"' == "" local nomvar = "`var'"
 
local c=substr("`var'",1,9)
disp  in yellow "`c'"


 local val_grup_lab: value label `var'

    levelsof `var', local(gruplevels)
    foreach  g  in `gruplevels'  {
    if "`val_grup_lab'"!="" { 
    local lab_S_`c'_`g':  label `val_grup_lab' `g'
	
        }
 else {
  local lab_S_`c'_`g' ="`g'"
    }
	local lab_S_`c'_`g': disp  "`nomvar' =  `lab_S_`c'_`g'' "
}	
}
 local nomvar_resp: var label `var_resp' 
 if   `"`nomvar_resp'"' == "" local nomvar_resp = "`var_resp'"
 
local swvar :  colfullnames e(b)
disp  "`swvar'"
local depvar:di e(depvar)+":"
local swvar= subinstr("`swvar'", "`depvar'" ," ",.) 



  if "`swvar'"!="_cons" { 
  
  
    local swvar= subinstr("`swvar'", "_cons" ," ",.) 
     local swvar=subinstr("`swvar'","_I","S_",.)
      disp  in yellow  "`swvar'"
     cap renpfix _I S_

	 foreach varname of varlist S_* {
	 
	 label var  `varname' "`lab_`varname''"
	 tab `varname'
	 }
	 
 
	 
 version 9.2

     htput <H2> "Análisis Multivariat per a variable resposta  `nomvar_resp'  despres de stepwise " </H2>
     htput <BR/>
     htput <BR/>

     htputvarcox , reg("logit" ) dep("`var_resp'") indep ("`swvar'") color  rr("OR") trans(exp)    multi
  }  
   else { 
     htput <H2> "Cap variable explica la  variable resposta  `nomvar'  i no hi ha model multivariat " </H2>
     htput <BR/>
  }


