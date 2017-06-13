


 ******************************************************************************************
 ******************************************************************************************
 *********************** GENERA GRAFICS DESCRIPTIUS  ******************
 ******************************************************************************************
 ** Indica les varaibles 

local vargraph1=" peso fc pas pad sato2 fvc fev1 pef hemates hb hematocrito leuco plaquetas neutrofilos  creatinina sodio potasio"
local vargraph2="glucosa colest hdl ldl tgl ast alt "

local vargrup="visit"
local graftitle =""
local gname=""
  ******************************************************************************************
disp in yellow wordcount("`vargraph1'") +wordcount("`vargraph2'")
local ngrfs= wordcount("`vargraph1'") +wordcount("`vargraph2'") 
local ngrafs= round((wordcount("`vargraph1'") +wordcount("`vargraph2'") )/4+0.25)
disp in yellow "************************************************   "`ngrafs'

local k=0
graph drop _all
foreach var in `vargraph1' `vargraph2' {
	local k=`k'+1

	if strpos("`var'","i.")!=0 {
		local var=subinstr("`var'","i.","",1) 
		graf_cat `var'   `vargrup' , noprint
	}
	else {
		graf_cont `var'   `vargrup' , noprint 
	}
	tempname graph`k'
	graph rename Graph `graph`k''
}

// create a blank graph
twoway scatteri 1 1,               ///
       msymbol(i)                  ///
       ylab("") xlab("")           ///
       ytitle("") xtitle("")       ///
       yscale(off) xscale(off)     ///
       plotregion(lpattern(blank)) ///
       name(blank, replace)

forvalues k=1(1)`ngrafs' {

	local g1=1+(`k'-1)*4
	if `g1'>`ngrfs' local graph`g1' ="blank"
	local g2=2+(`k'-1)*4
	if `g2'>`ngrfs' local graph`g2' ="blank"
	local g3=3+(`k'-1)*4
	if `g3'>`ngrfs' local graph`g3' ="blank"
	local g4=4+(`k'-1)*4
	if `g4'>`ngrfs' local graph`g4' ="blank"
	
	local grafname= "`gname'_`k'"
	graph combine  `graph`g1'' `graph`g2''   `graph`g3''  `graph`g4'' , title("`graftitle'") 
	graph export $htm\png\gr_`grafname'.png, replace
	graph export $gph\wmf\gr_`grafname'.wmf, replace
	graph save $gph\gph\gr_`grafname'.gph, replace

	htput <br>
	htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' " >
	htput <BR>

}

graph drop _all

 ******************************************************************************************
 ******************************************************************************************
 *********************** FIN GRAFICS DESCRIPTIUS  ******************
 ******************************************************************************************