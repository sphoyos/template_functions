*********** GUARDA ELS GRAFICS ******************************************

local grafname="gr_"+"`var'"

graph export $htm\png\gr_`grafname'.png, replace
graph save $gph\gph\gr`grafname'.gph, replace
graph export $gph\wmf\gr_`grafname'.wmf, replace
htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>

