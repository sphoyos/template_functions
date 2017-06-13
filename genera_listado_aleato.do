

clear all

global DDIR="C:\Users\18949893D\Desktop\_projectes\ARO\llistats_aleato"


local semilla=date("$S_DATE","DMY")
disp `semilla'
set seed `semilla'
ralloc bloc size treatment, nsubj(30) osize(3) eq ntreat(2) sav("$DDIR\tab_aleato_maxilo")

label define treat 1"Grupo Experimental:Pentoxifilina y Tocoferol" 2"Grupo Control:Tratamiento Estándar. ", modify


htopen using "$DDIR\listado.html" , replace

htlist treatment 
htclose


gen id=_n
save "$DDIR\tab_aleato_maxilo.dta", replace


 export excel id treat  SeqInBlk using "$DDIR\tabla_aleato_maxilo.xls", firstrow(variables) replace

