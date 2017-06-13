global DDIR="F:\Residents\moodle\sample_size\"
clear all
set obs 1
generate var1 = 1 in 1
expand 10000
ren var1 ident
replace ident=_n
local sd=13
local ssize=107
local ee=`sd'*sqrt((1/`ssize')+(1/`ssize'))
*local ee=`sd'/sqrt(`ssize')
disp in green  `ee'
local mu=5
*local ee=3*1/(sqrt(.5))
** Genera una mostra de 1000 mostres amb diferència 0 i 10 amb error estàndar de multiplicant la mostra un 10%
set seed 123
gen nuldiff=rnormal(0, `ee')
set seed 567
 gen dif`mu'=rnormal(`mu',`ee')
local ls=1.96*`ee'
local potencia: di %5.2f 1-normal((`ls'-`mu')/ `ee')
label var nuldiff" Hipòtesi Nul·la"
label var dif`mu' "Hipòtesi alternativa diferencia `mu'"
summarize nuldiff
local pstart0= r(min)
summarize dif`mu'
local pstart`mu'= r(min)
disp in red `pstart`mu''
local pstart=min(`pstart0', `pstart`mu'')

tempname graf1
tempname graf2

hist nuldiff ,legend(off) fcolor(ltblue) freq width(.5) start(`pstart') xline(`ls') addplot(hist nuldiff if nuldiff>`ls', fcolor(orange_red) start(`pstart')  freq width(.5)) note("N=`ssize'" )
 graph save `graf1'.gph , replace


hist dif`mu' , fcolor(olive_teal  ) legend(off) freq width(.5) start(`pstart') xline(`ls') addplot(hist dif`mu' if dif`mu'>`ls', fcolor(midblue ) start(`pstart')  freq width(.5)) note("potencia= `potencia'") subtitle("dif=`mu', sd=`sd'")
graph save `graf2.gph' , replace

graph combine `graf1'.gph `graf2'.gph, xcommon cols(1)

local grafname="dif"+"`mu'"+"_s"+"`sd'"+"_n"+"`ssize'"
disp in yellow "`grafname'"
graph save "$DDIR\`grafname'.gph", replace
graph export  "$DDIR\`grafname'.png" , replace




