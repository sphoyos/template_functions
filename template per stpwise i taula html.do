



 foreach var in  i.qt {
 
local lvar=subinstr("`var'","i.","",1)
local varlab:variable label `lvar'

 htput <H2> "Análisis per a `varlab' SPV Global " </H2>
 
 htput <BR>
 htputvarcox , reg("stcox" ) dep("") indep ("`var' ") color  rr("HR") trans(exp) multi  options (  "iterate(50)") 
 htput <BR>
 }
 htput <H2> "Análisis multivariat CLR1 despres stepwise" </H2>

 xi:sw,pe(.1) lr lockterm1: stcox  i.qt (i.tipo_tum ) (i.ecn) (i.ectnm )  (i.pn)  (i.ilv) (i.ipn) (i.marg_) (i.ece)  (i.ptnm)  (i.bonprono)   edat_cirug 

 
local swvar:di substr(e(datasignaturevars), 11,.)
disp "`swvar'"

local swvar=subinstr("`swvar'","_I","S_",.)
disp  "`swvar'"
renpfix _I S_

 htputvarcox , reg("stcox" ) dep("") indep ("`swvar'") color  rr("HR") trans(exp)  options (  "iterate(50)") 