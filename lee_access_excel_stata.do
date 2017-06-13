
**************************************************+ lectura tablas 

* Identifica la base de dades i el tipo
local my_workbook "cancer_ovari"

local source "MS Access Database;DBQ=$orig\\`my_workbook'"
odbc query "`source'" 


foreach tabla in "ALTRES"  "ANTECEDENTS"  "AP"  "Copia de RECIDIVA" "DARRER_CONTROL" "EXPLORACIONS" "FINAL"  "INTERVENCIO" ///
                 "QT" "RECIDIVA" "Sino" "Tipus Q" "xx_altresantecedents" "XX_Ant" "xx_antecedentscirurgia" "xx_AP_recidiva" ///
				 "xx_cirurgiavalle" "xx_exploracio" "xx_extirpació" "xx_famaltres" "xx_FIGO" "xx_localitzacions_recidiva" ///
				 "xx_lugarproc" "xx_mida" "xx_motvisita" "xx_proves_realitzades" "xx_provesrx" "xx_QT" "xx_resultat"  ///
				 "xx_resultatAP" "xx_ttt_recidiva" "xx_variables_cirurgia" "xx_variables_cirurgia2" "xx_visceres" {

local my_file     "`tabla'"

odbc load, dsn("`source'") table("`my_file'") clear  lower datestring

desc



local tabla=subinstr("`tabla'"," ","_",.)


local tablasav: disp "\$orig\\`tabla'"
save "`tablasav'", replace

}



local my_workbook "nenexp_old_revised"

local source "Excel Files;DBQ=$orig\\`my_workbook'"
odbc query "`source'" 


 
 foreach tabla in "INV_MARE"   "GESTACIO_INV_MARE" "GESTACIO_ANALITICA" "TAR_GESTACIO" "COMBINACIO_INV"  "RESULTATS_NEN" ///
                  "SEGUIMENT_NEN_ANTROPOMETRIA_NEN" "ARV_PROF_NEN" {

clear
*local my_file     "`tabla'"

*odbc load, dsn("`source'") table("`my_file'$") clear  lower datestring



local worksheet "$orig\\`my_workbook';].[`tabla'$]"
odbc load,  exec("SELECT * FROM [Excel 8.0; HDR=YES;IMEX=1;Database=`worksheet';")  

local tablasav: disp "\$orig\\`tabla'_old"
save "`tablasav'", replace

}








gen data_nac = mdy(real(substr(fechanacimiento   ,6,2)), real(substr( fechanacimiento  ,9,2)) ,real(substr( fechanacimiento  ,1,4)))
format data_nac  %dD_m_CY
label var data_nac "Fecha de nacimiento"