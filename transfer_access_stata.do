
************************************
************************************
********* OJO ES TE QUE FER EN STATA 11
**************************************
**************************************



* Identifica la base de dades i el tipo de ACCESS 2008 .mbd
*local my_workbook "    .mdb"
*local source "MS Access Database;DBQ=$orig\\`my_workbook'"
*odbc query "`source'" 

* Identifica la base de dades i el tipo de ACCESS 2010 .mbd
local my_workbook " accdb"
local source "MS_ACCESS_64;DBQ=$orig\\`my_workbook'"
odbc query "`source'" 


************************************************************************************
*** Cal incloure en aquesta part del programa  les taules del query d'abans
************************************************************************************

foreach tabla in  ///
" " ///
" " ///
 {


*** llegueix cada taula 

   local my_file     "`tabla'"
   odbc load, dsn("`source'") table("`my_file'") clear  lower datestring

   *** Canvia el nom  de la taula
   
	local tabla=subinstr("`tabla'"," ","_",.)
	local tabla=subinstr("`tabla'","plaquetesadmin_","",.)

*** Envia al html un adescripció de la taula de dades
 
   htput <H1> `tabla' </H1>
   htdesc

*** Guarda les bases de dades  
   
	local tablasav: disp "\$dta\\pri\\`tabla'"
	save "`tablasav'", replace

	htput  <BR>
}
