
 clear all
local D=18
set obs `D'
gen dbs=8
gen pcr=0
label define lab_pcr 0"Negativo" 1"Positivo", modify
label val pcr lab_pcr
label var pcr "Resultado PCR"
label var dbs "Medida DBS"

local D=18+26
set obs `D'
replace dbs=8 if dbs==.
replace pcr=1 if pcr==.
 

 local D=18+26+1
set obs `D'
replace dbs=9 if dbs==.
replace pcr=0 if pcr==.

 local D=18+26+1+0
set obs `D'
replace dbs=9 if dbs==.
replace pcr=1 if pcr==.


 local D=18+26+1+0+15
set obs `D'
replace dbs=12 if dbs==.
replace pcr=0 if pcr==.


 local D=18+26+1+0+15+13
set obs `D'
replace dbs=12 if dbs==.
replace pcr=1 if pcr==.


 local D=18+26+1+0+15+13+9
set obs `D'
replace dbs=13 if dbs==.
replace pcr=0 if pcr==.

local D=18+26+1+0+15+13+9+16
set obs `D'
replace dbs=13 if dbs==.
replace pcr=1 if pcr==.

local D=18+26+1+0+15+13+9+16+2
set obs `D'
replace dbs=15 if dbs==.
replace pcr=0 if pcr==.

local D=18+26+1+0+15+13+9+16+2+1
set obs `D'
replace dbs=15 if dbs==.
replace pcr=1 if pcr==.
