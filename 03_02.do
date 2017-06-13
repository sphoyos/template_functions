


*! docver: 2.0
*!  title: Lectura de dades
*!   html: yes
*!    log: yes
*!comment: 
version 9.1


version 13.1
htput <IMG SRC="UEB_IR.png" ALT="UEB-IR" ALIGN=CENTER WIDTH="80%" height="100">
htput <DIV ALIGN="CENTER" class="RED" style="font-size:small"> 
htput  </DIV>
htput <HR>

htput <H1> $HTtitle </H1>
htput <BR>


htput<p><font size=" 3" color="blue"> <b>Versión $S_DATE</b></font></p>

htput <br>



use  "dta\dades_tesis_wide.dta",replace 

local eti_n ="Nectar"
local eti_l="Líquido"
local eti_p="Pudding"

foreach tipo in n l p {
 foreach num in _5 _10 _20 {

	   #delimit ;
egen alt_eficacia_`tipo'`num'=anymatch( 	   
	vfs`tipo'segell`num' 
	vfs`tipo'apraxia`num'
	vfs`tipo'contpropul`num' 
	vfs`tipo'deglfracc`num' 
	vfs`tipo'residuvallec`num'
	vfs`tipo'residufaring`num' 
	vfs`tipo'defobertees`num'
	fees`tipo'segell`num' 
	fees`tipo'apraxia`num'
	fees`tipo'contpropul`num' 
	fees`tipo'deglfracc`num' 
	fees`tipo'residuvallec`num'
	fees`tipo'residufaring`num' 
	fees`tipo'defobertees`num'
	),values(1)
;
#delimit cr

label var alt_eficacia_`tipo'`num' "Signos de eficacia para  `eti_`tipo'' `num'"
 }
}

foreach tipo in n l p {
 foreach num in _5 _10 _20 {

	   #delimit ;
egen alt_seguretat_`tipo'`num'=anymatch( 	   
	vfs`tipo'predeg`num' 
    vfs`tipo'durantdegl`num' 
    vfs`tipo'postdegl`num' 
	fees`tipo'predeg`num' 
    fees`tipo'durantdegl`num' 
    fees`tipo'postdegl`num' 
	),values(1)
;
#delimit cr

label var alt_seguretat_`tipo'`num' "Signos de seguridad para  `eti_`tipo'' `num'"
 }
}

label var vfspudin_5 "VFS PUDIN 5ml"
label var vfspsegell_5 "VFS segell labial pudin 5ml"
label var vfspapraxia_5 "VFS apraxia pudin 5ml"
label var vfspcontpropul_5 "VFS control propulsion pudin 5ml"
label var vfspdeglfracc_5 "VFS deglucio fraccionada pudin 5ml"
label var vfspnumdegl_5 "VFS numero degluciones pudin 5ml"
label var vfspinsufpalglos_5 "VFS insuf palatogloso pudin5ml"
label var vfsppredeg_5 "VFS Seguridad predeglucion pudin 5ml"
label var vfspresiduvallec_5 "VFS residu vallec pudin 5ml"
label var vfspresidufaring_5 "VFS residu faringi pudin 5ml"
label var vfspinsufvelopal_5 "VFS insuf vel paladar pudin5ml"
label var vfspretardreflex_5 "VFS retard reflexe deglucio pudin 5ml"
label var vfspascenslarinx_5 "VFS Ascens laringi pudin 5ml"
label var vfspdefobertees_5 "VFS deficit apertura EES pudin 5ml"
label var vfsptosreflex_5 "VFS Tos reflex pudin 5ml"
label var vfspdurantdegl_5 "VFS Seguridad durant deglucion pudin 5ml"
label var vfsppostdegl_5 "VFS Seguridad postdeglucion pudin 5ml"


foreach tipo in n l p {
 foreach num in _5 _10 _20 {

	   #delimit ;
egen alt_seguretat_`tipo'`num'=anymatch( 	   
	vfs`tipo'predeg`num' 
    vfs`tipo'durantdegl`num' 
    vfs`tipo'postdegl`num' 
	fees`tipo'predeg`num' 
    fees`tipo'durantdegl`num' 
    fees`tipo'postdegl`num' 
	),values(1)
;
#delimit cr

label var alt_seguretat_`tipo'`num' "Signos de seguridad para  `eti_`tipo'' `num'"
 }
}


