
use tabladefechas 




forvalues i=1(1)`Ndata' {

use basedatosindividual.dta,clear



local Ncasos=_N

*** ling= numero ingresados
**** luci= numero en uci

local ling=0
local luci=0

forvalues j=1(1)`Ncasos' {

**** dataingr= variable que contiene la fecha de ingreso
***** dataalta  variable que contiene la fecha de alta

if dataingr[`j']<=`data' & dataalta[`j']>=`data'{
local ling= `ling' +1 

}

 if dataiuci[`j']<=`data' & dataltau[`j']>=`data' {
local luci= `luci' +1
}
 
}
 
 restore

qui replace atesos=`ling' if _n==`i'
qui replace  uci=`luci' if _n==`i'


}