


local vars=""
 htput <BR>
htput <FONT color="#993366"> 
htput En este documento se presenta la concordancia entre dos variables. En primer lugar se muestran los estadísticos descriptivos de  <br>
htput la variable entre las dos observaciones donde se puede apreciar si en promedio hay diferencias o no <p>
htput En primer lugar se muestra un diagrama de dispersión de las dos observacines . La linea continua corresponde a la concordancia perfecta.
htput La línea discontinua corresponde a la relación y muestar el sesgo. Si es paralela a la línea continua muestra un error sistemàtico. 
htput Si se cruza indica la existencia de mala concordancia <p>
htput Seguidamente se muestra la tabla de analisis de concordancia. Se calcula el coeficiente de correlación de concordancia de Lin (rho_c).
htput Un valor próximo a 1 indica una buena concordancia. El intervalo de confianza y el p-valor que se muestra indica si hay concordancia no debida al azar.
htput Ademàs se muestra el sesgo ( cociente entre el rho_c y la correlación de Pearson) . Un valor pròximo a 1 indicaria que no hay sesgo.  <p>
htput La comparación de Bland-Altman y su gràfico muestran la existencia de concordancia o no, los límites de las diferencias y la existencia de
htput sesgo sistemàtico.
htput </FONT color>
htput <BR>


 
 foreach var in `vars' {
 
 
 local var1= "`var'1"
 
 local var2= "`var'2"
 
 
  
 disp in red "`var1'"
 disp in red "`var2'"

 
 local nomvar1: var label `var1' 
 if   `"`nomvar1'"' == "" local nomvar1 = "`var1'"
 local nomvar2: var label `var2' 
 if   `"`nomvar2'"' == "" local nomvar2 = "`var2'"

local titol=subinstr(lower("`nomvar1'"),"obs1"," ",.)

htput <h2> Concordancia interobservador para `titol' </h2>
 htput <br>
htsuma1 `var1', head
htsuma1 `var2' ,close
htput <br>
 
 twoway   sc `var1'  `var2' || lfit `var1' `var1' || lfit `var1' `var2', lpattern(dash) ||, aspect(1) plotregion(margin(none)) xtitle("`nomvar1'",size(small)) yla(,ang(h)) ytitle("`nomvar2'",size(small)) legend(off) subtitle("Comparació  medicions 2 observadors")

 local grafname="ccc_`var1'_`var2'"
 graph export $htm\gr_`grafname'.png, replace
graph save $gph\gr_`grafname'.gph, replace
htput <IMG SRC=gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
 
 ht_concord `var1' `var2'
htput <BR>

 ht_baplot `var1' `var2', nograph
htput <BR>

batplot `var1' `var2', title("Acuerdo entre" "`nomvar1'" "`nomvar2'") ///
  notrend  moptions(mlabp(9)) 

 local grafname="bad_`var1'_`var2'"
 graph export $htm\gr_`grafname'.png, replace
graph save $gph\gr_`grafname'.gph, replace
htput <IMG SRC=gr_`grafname'.png ALT="grafic evolució `namegraf' ">
htput <BR>
 

}
 
 
 