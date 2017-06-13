

clear all

global DDIR="C:\Users\18949893D\Desktop\_PROJECTES\M\MARIA_GOYA\Ordesa"
local nom_estudio="Estudio_PROPEV"
local treat1="Grupo A : Probiotico"
local treat2="Grupo B:Placebo"
local N_size=12
local N_blocks=1

local semilla= 20170216
disp `semilla'
*set seed `semilla'
ralloc bloc size treat, nsubj(`N_size') osize(`N_blocks') eq ntreat(2) sav("$DDIR\tab_aleato_`nom_estudio'" ) seed( `semilla')

label define treat 1"`treat1'" 2"`treat2'",  modify

label var treat "Tratamiento"
label val treat treat 
gen id=_n
htopen using "$DDIR\listado.html" , replace

htput "Listado de aleatorización por bloques de tamaño 2,4,6,8  para  `N_size'sujetos con semilla de aleatorización `semilla'"
htlist id treat , noobs
htclose



save "$DDIR\tab_aleato_`nom_estudio'_12.dta", replace

keep id treat  SeqInBlk 
gen code=  int(1000*runiform())
tempfile fitxer
save `fitxer', replace

forvalues i=1(1)96 {

append using `fitxer'
}
drop id 
gen id=_n
save "$DDIR\tab_aleato_`nom_estudio'_rep.dta", replace


 export excel id code  treat  SeqInBlk using "$DDIR\tabla_aleato_`nom_estudio'_rep.xls", firstrow(variables) replace
 
 
 
 
 
 

