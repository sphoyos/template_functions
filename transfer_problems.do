ds ,has(format %d*)
local listavar  "`r(varlist)'"
foreach var of varlist   `listavar' {
 replace `var'=. if `var'== -137775
 }
 
 
 
 
ds , has(type string)
local listavar  "`r(varlist)'"
foreach var of varlist   `listavar' {
 replace `var'="" if `var'=="NULL"
 }
 