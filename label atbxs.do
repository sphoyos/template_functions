
use "C:\Documents and Settings\sperez\Escritorio\__EPINE_EEPPS\Analisi_Epine_EEPPS\dta\label_atb.dta" ,clear
decode code_atb, gen(code_atb_text)

gen code_atb_4=.
gen desc_atb_4=.

replace code_atb_4=1 if substr(trim(code_atb_text),1,4)=="J01A"
replace desc_atb_4=1 if substr(trim(code_atb_text),1,4)=="J01A"


replace code_atb_4=2 if substr(trim(code_atb_text),1,4)=="J01B"
replace desc_atb_4=2 if substr(trim(code_atb_text),1,4)=="J01B"

replace code_atb_4=3 if substr(trim(code_atb_text),1,4)=="J01C"
replace desc_atb_4=3 if substr(trim(code_atb_text),1,4)=="J01C"

replace code_atb_4=4 if substr(trim(code_atb_text),1,4)=="J01D"
replace desc_atb_4=4 if substr(trim(code_atb_text),1,4)=="J01D"

replace code_atb_4=5 if substr(trim(code_atb_text),1,4)=="J01E"
replace desc_atb_4=5 if substr(trim(code_atb_text),1,4)=="J01E"

replace code_atb_4=6 if substr(trim(code_atb_text),1,4)=="J01F"
replace desc_atb_4=6 if substr(trim(code_atb_text),1,4)=="J01F"

replace code_atb_4=7 if substr(trim(code_atb_text),1,4)=="J01G"
replace desc_atb_4=7 if substr(trim(code_atb_text),1,4)=="J01G"

replace code_atb_4=8 if substr(trim(code_atb_text),1,4)=="J01M"
replace desc_atb_4=8 if substr(trim(code_atb_text),1,4)=="J01M"

replace code_atb_4=9 if substr(trim(code_atb_text),1,4)=="J01R"
replace desc_atb_4=9 if substr(trim(code_atb_text),1,4)=="J01R"

replace code_atb_4=10 if substr(trim(code_atb_text),1,4)=="J01X"
replace desc_atb_4=10 if substr(trim(code_atb_text),1,4)=="J01X"



label define code_atb_4  1"J01A" 2"J01B" 3"J01C" 4"J01D" 5"J01E" 6"J01F" 7"J01G" 8"J01M" 9"J01R" 10"J01X", modify
label val code_atb_4 code_atb_4
label define desc_atb_4 1"Tretacilinas" 2"Afenicoles" 3"Antibacterianos betalactámicos, penicilinas" 3"Otros antibacterianos betalactámicos" ///
                        4"Sulfonamidas y trimetoprima" 5"Sulfonamidas y trimetoprima" 6"Macrólidos, lincosamidas y estreptograminas"  ///
						7"Aminoglicósidos antibacterianos" 8"Quinolonas antibacterianas" 9"Combinaciones de antibacterianos" 10"Otros antibacterianos", modify
label val desc_atb_4 desc_atb_4


save "C:\Documents and Settings\sperez\Escritorio\__EPINE_EEPPS\Analisi_Epine_EEPPS\dta\label_atb.dta" , replace
