

* ****************************************************
* ******** GENERA ETIQUETAS  **********
* ****************************************************


    local curdir : pwd
	local curdir= "`curdir'"+"\dta\pri"  

******************************************************************
* Obtain the filename  & check for uniqueness                                            *
******************************************************************

	local files : dir `"`curdir'"' files "lab_*.dta",  nofail
	




*** Entre cometes cal posar el nom deles taules on estan els dos camps (numero, etiqueta)


foreach filename in  `files'  {

* Cambia el nom de la taula substituint els espais en blan per _				 
				 
local filename=subinstr("`filename'"," ","_",.)

* Identficca on ests la taula

local name: disp "\$dta\pri\\`filename'
use `name' , clear
* htdesc
local filename=subinstr("`filename'",".dta","",.)
local filename=subinstr("`filename'","lab_","",.)




******* canvia format a variables string eliminant blancs

 ds , has(type string)
local var_etiqueta "`r(varlist)'"



foreach var in  `var_etiqueta' {

tempvar len
cap drop `len'

gen `len'=length(trim(`var'))
qui summarize `len'
drop `len'
local l=r(max)
local format : di "%`l's"
format `format' `var'
}





*"  Identifica la variable caracter con las etiquetas
ds , has(type string)
tokenize "`r(varlist)'"
local var_etiqueta "`1'"
if  lower("`filename'") =="lt_centre_hosp" local var_etiqueta="abrevcentrehosp"
if  lower("`filename'") =="lt_clasfarm" local var_etiqueta="clas_nom"
local filename=subinstr("`filename'","_lt","",.)
* Identifica la variable numèrica con los valores a etiquetar
ds , has(type numeric)
tokenize "`r(varlist)'"
local var_valor "`1'"




local n_file =_N
* Obre un ficher de texte on guardara les etidquetes en un fitxer do
cap file close prg_code

file open prg_code using "$labels\\lab_`filename'.do", write replace

*  Fila d'inici 

local linewrite: disp   "label define lab_`filename'  ///" 
file write prg_code "`linewrite'" _n


* Genera un bucle que va  passant per tots els registres

forvalues i=1(1)`n_file' {

* selecciona el valor i l'etiqueta a assignar 
local valor =`var_valor'[`i']
local etiqueta =`var_etiqueta'[`i']


* Escriu en el fitxer la linea d'assignació
local linewrite: disp   "`valor' " char(34) "`etiqueta'" char(34)  " ///"
file write prg_code `"`linewrite'"' _n
}

*" Escriu la linea final on  es termina la definicio
local linewrite: disp ",modify"
file write prg_code "`linewrite'" _n
* Tanca el fitxer
file close prg_code
}
do_label


     htput <TABLE BORDER=1 CELLSPACING =0 CELlPADDING=2>
   htput <TR>
   htput <TH VALIGN=CENTER ALIGN=CENTER  > Fitxer Etiquetes   </TH>
   htput </TR>
   labelbook 
   local etiquetes=r(names)
foreach etiq in  `etiquetes' {

  htput <TR>
   htput <TD VALIGN=CENTER ALIGN=CENTER  > `etiq' </TD>
   htput </TR>

}

htput </table>