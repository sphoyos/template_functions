

display as text _n " ------------  multiple prtests, with Bonferroni correction" _n
local group = "VARIABLE GRUPO"
local numgrp = NUMERO DE GRUPOS
local bin = "VARIABLE SI/NO(0/1)"
local alpha=0.05

local numcomps= `numgrp'*(`numgrp'-1)/2
display "p-value compared to alpha/(#groups*(#groups-1)/2) =`alpha'/`numcomps'"

forvalues i=1/`numgrp'{
local i1=`i'+1
  forvalues j=`i1'/`numgrp'{
  qui  prtest `bin' if `group'==`i' |`group'==`j' , by(`group')
  local ts=r(z)
  local p=2*(1 - normal(abs(r(z))))
  if `p' < 10^(-6) local p=0
  if `p' < `alpha'/`numcomps' {
  local reject = "reject"
  }
  else{
  local reject= "fail to reject"
  }

  display as result "prtest " `i' ", " `j' /*
  */ "  test stat = " %8.4f  `ts' /*
  */ _col(37) "   p value  = " %8.4f `p' /*
  */ _col(63) "     `reject'"
  }
display _newline
}
?