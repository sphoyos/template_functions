
***************************************************************************
********  Datos sf36        ****************************************
**************************************************************************


****** dADES EXEMPLE

 use "$dta\eje36.dta", clear



rename (gh1 ht pf01 pf02 pf03 pf04 pf05 pf06 pf07 pf08 pf09 pf10 rp1 rp2 rp3 rp4 re1 re2 re3 sf1 bp1 bp2 vt1 mh1 mh2 mh3 vt2 mh4 vt3 mh5 vt4 sf2 gh2 gh3 gh4 gh5) ///
 ( v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v15 v16 v17 v18 v19 v20 v21 v22 v23 v24 v25 v26 v27 v28 v29 v30 v31 v32 v33 v34 v35 v36)

 
 
 
 
******************************   RENOMENA LES VARIABLES A Q *************

forvalues k=1(1)36 {
ren v`k' q`k'
}





**************************************************************************
***************** DEFINEIX ETIQUETES  ***********************
**************************************************************************
label define lab_sf36comparativa  ///
1 "Molt millor que fa un any" ///
2 "Quelcom millor que fa una any" ///
3 "Més o menys igual que fa un any" ///
4 "Quelcom pitjor que fa un any" ///
5 "Molt pitjor que fa un any" ///
,modify
label define lab_sf36dificultat  ///
1 "Gens" ///
2 "Una mica" ///
3 "Regular" ///
4 "Bastant" ///
5 "Molt" ///
,modify
label define lab_sf36dolor  ///
1 "No, cap" ///
2 "Sí, molt poc" ///
3 "Sí, una mica" ///
4 "Sí, moderat" ///
5 "Sí, molt" ///
6 "Sí, moltíssim" ///
,modify
label define lab_sf36frequencia  ///
1 "Sempre" ///
2 "Gairebé sempre" ///
3 "Moltes vegades" ///
4 "Algunes vegades" ///
5 "Només alguna vegada" ///
6 "Mai" ///
,modify
label define lab_sf36limitacio  ///
1 "Sí, em limita molt" ///
2 "Sí, em limita una mica" ///
3 "No, no em limita gens" ///
,modify

label define lab_sino  ///
1"No"  ///
2"Si" ///
, modify

**********************************************************************
****************  ETIQUETA LES VARIABLES *****************************
**********************************************************************

label val q1 lab_sf36salut 
label val q2 lab_sf36comparativa 
label val q3 lab_sf36limitacio 
label val q4 lab_sf36limitacio 
label val q5 lab_sf36limitacio 
label val q6 lab_sf36limitacio 
label val q7 lab_sf36limitacio 
label val q8 lab_sf36limitacio 
label val q9 lab_sf36limitacio 
label val q10 lab_sf36limitacio 
label val q11 lab_sf36limitacio 
label val q12 lab_sf36limitacio 
label val q13 lab_sino
label val q14 lab_sino
label val q15 lab_sino
label val q16 lab_sino
label val q17 lab_sino
label val q18 lab_sino
label val q19 lab_sino
label val q20 lab_sf36dificultat
label val q21 lab_sf36dolor
label val q22 lab_sf36frequencia
label val q23 lab_sf36frequencia
label val q24 lab_sf36frequencia
label val q25 lab_sf36frequencia
label val q26 lab_sf36frequencia
label val q27 lab_sf36frequencia
label val q28 lab_sf36frequencia
label val q29 lab_sf36frequencia
label val q30 lab_sf36frequencia
label val q31 lab_sf36frequencia
label val q32 lab_sf36frequencia
label val q33 lab_sf36certfals
label val q34 lab_sf36certfals
label val q35 lab_sf36certfals
label val q36 lab_sf36certfals

label var q1 "(GH1)1. En general, usted diría que su salud es:" 
label var q2 "(HT)2. ¿Cómo diría que es su salud actual, comparada con la de hace un año?" 
label var q3 "(PF01)3. Su salud actual, ¿le limita para hacer esfuerzos intensos, tales como correr, levantar objetos pesados, o participar en deportes agotadores?" 
label var q4 "(PF02)4. Su salud actual, ¿le limita para hacer esfuerzos moderados, como mover una mesa, pasar la aspiradora, jugar a los bolos o caminar más de una hora?" 
label var q5 "(PF03)5. Su salud actual, ¿le limita para coger o llevar la bolsa de la compra?" 
label var q6 "(PF04)6. Su salud actual, ¿le limita para subir varios pisos por la escalera?" 
label var q7 "(PF05)7. Su salud actual, ¿le limita para subir un solo piso por la escalera?" 
label var q8 "(PF06)8. Su salud actual, ¿le limita para agacharse o arrodillarse?" 
label var q9 "(PF07)9. Su salud actual, ¿le limita para caminar un kilómetro o más?" 
label var q10 "(PF08)10. Su salud actual, ¿le limita para caminar varios centenares de metros?" 
label var q11 "(PF09)11. Su salud actual, ¿le limita para caminar unos 100 metros?" 
label var q12 "(PF10)12. Su salud actual, ¿le limita para bañarse o vestirse por sí mismo?" 
label var q13 "(RP1)13. Durante las 4 últimas semanas, ¿tuvo que reducir el tiempo dedicado al trabajo o a sus actividades cotidianas, a causa de su salud física?" 
label var q14 "(RP2)14. Durante las 4 últimas semanas, ¿con qué frecuencia hizo menos de lo que hubiera querido hacer, a causa de su salud física?" 
label var q15 "(RP3)15. Durante las 4 últimas semanas, ¿con qué frecuencia tuvo que dejar de hacer algunas tareas en su  trabajo o en sus actividades cotidianas, a causa de su salud física?" 
label var q16 "(RP4)16. Durante las 4 últimas semanas, ¿con qué frecuencia tuvo dificultad para hacer su trabajo o sus actividades cotidianas (por ejemplo, le costó más de lo normal), a causa de su salud física?" 
label var q17 "(RE1)17. Durante las 4 últimas semanas, ¿con qué frecuencia tuvo que reducir el tiempo dedicado al trabajo o a sus actividades cotidianas, a causa de algún problema emocional (como estar triste, deprimido, o nervioso?" 
label var q18 "(RE2)18. Durante las 4 últimas semanas, ¿con qué frecuencia hizo menos de lo que hubiera querido hacer, a causa de algún problema emocional (como estar triste, deprimido, o nervioso)?" 
label var q19 "(RE3)19. Durante las 4 últimas semanas, ¿con qué frecuencia hizo su trabajo o sus actividades cotidianas menos cuidadosamente que de costumbre, a causa de algún problema emocional (como estar triste, deprimido, o nervioso)? "
label var q20 "(SF1)20. Durante las 4 últimas semanas, ¿hasta qué punto su salud física o los problemas emocionales han dificultado sus actividades sociales habituales con la familia, los amigos, los vecinos u otras personas? "
label var q21 "(BP1)21. ¿Tuvo dolor en alguna parte del cuerpo durante las 4 últimas semanas?" 
label var q22 "(BP2)22. Durante las 4 últimas semanas, ¿hasta qué punto el dolor le ha dificultado su trabajo habitual (incluido el trabajo fuera de casa y las tareas domésticas)?" 
label var q23 "(VT1)23. Durante las 4 últimas semanas, ¿con qué frecuencia se sintió lleno de vitalidad?"
label var q24 "(MH1)24. Durante las 4 últimas semanas, ¿con qué frecuencia estuvo muy nervioso?" 
label var q25 "(MH2)25. Durante las 4 últimas semanas, ¿con qué frecuencia se sintió tan bajo de moral que nada podía animarle?" 
label var q26 "(MH3)26. Durante las 4 últimas semanas, ¿con qué frecuencia se sintió calmado y tranquilo?" 
label var q27 "(VT2)27. Durante las 4 últimas semanas, ¿con qué frecuencia tuvo mucha energía?" 
label var q28 "(MH4)28. Durante las 4 últimas semanas, ¿con qué frecuencia se sintió desanimado y triste?" 
label var q29 "(VT3)29. Durante las 4 últimas semanas, ¿con qué frecuencia se sintió agotado?" 
label var q30 "(MH5)30. Durante las 4 últimas semanas, ¿con qué frecuencia se sintió feliz?" 
label var q31 "(VT4)31. Durante las 4 últimas semanas, ¿con qué frecuencia se sintió cansado?" 
label var q32 "(SF2)32. Durante las 4 últimas semanas, ¿con qué frecuencia la salud física o los problemas emocionales le han dificultado sus actividades sociales (como visitar a los amigos o familiares)?" 
label var q33 "(GH2)33. Creo que me pongo enfermo más fácilmente que otras personas. "
label var q34 "(GH3)34. Estoy tan sano como cualquiera." 
label var q35 "(GH4)35. Creo que mi salud va a empeorar." 
label var q36 "(GH5)36. Mi salud es excelente." 

*************************************************
* *** REANOMENA LES VARIABLES ******
*************************************************
gen GH1=q1
gen HT=q2
gen PF01=q3
gen PF02=q4
gen PF03=q5
gen PF04=q6
gen PF05=q7
gen PF06=q8
gen PF07=q9
gen PF08=q10
gen PF09=q11
gen PF10=q12
gen RP1=q13
gen RP2=q14
gen RP3=q15
gen RP4=q16
gen RE1=q17
gen RE2=q18
gen RE3=q19
gen SF1=q20
gen BP1=q21
gen BP2=q22
gen VT1=q23
gen MH1=q24
gen MH2=q25
gen MH3=q26
gen VT2=q27
gen MH4=q28
gen VT3=q29
gen MH5=q30
gen VT4=q31
gen SF2=q32
gen GH2=q33
gen GH3=q34
gen GH4=q35
gen GH5=q36

******************************************************************
*********************  REEMPLAÇA VALORS PERDUTS ******************
******************************************************************

replace PF01 = . if (PF01 < 1 | PF01 > 3) 
replace PF02 = . if (PF02 < 1 | PF02 > 3) 
replace PF03 = . if (PF03 < 1 | PF03 > 3) 
replace PF04 = . if (PF04 < 1 | PF04 > 3) 
replace PF05 = . if (PF05 < 1 | PF05 > 3) 
replace PF06 = . if (PF06 < 1 | PF06 > 3) 
replace PF07 = . if (PF07 < 1 | PF07 > 3) 
replace PF08 = . if (PF08 < 1 | PF08 > 3) 
replace PF09 = . if (PF09 < 1 | PF09 > 3)
replace PF10 = . if (PF10 < 1 | PF10 > 3) 

replace RP1 = . if (RP1 < 1 | RP1 > 5) 
replace RP2 = . if (RP2 < 1 | RP2 > 5) 
replace RP3 = . if (RP3 < 1 | RP3 > 5)
replace RP4 = . if (RP4 < 1 | RP4 > 5) 

replace BP1 = . if (BP1 < 1 | BP1 > 6) 
replace BP2 = . if (BP2 < 1 | BP2 > 5)  

replace GH1 = . if (GH1 < 1 | GH1 > 5) 
replace GH2 = . if (GH2 < 1 | GH2 > 5)  
replace GH3 = . if (GH3 < 1 | GH3 > 5)  
replace GH4 = . if (GH4 < 1 | GH4 > 5) 
replace GH5 = . if (GH5 < 1 | GH5 > 5)

replace VT1 = . if (VT1 < 1 | VT1 > 5)  
replace VT2 = . if (VT2 < 1 | VT2 > 5) 
replace VT3 = . if (VT3 < 1 | VT3 > 5) 
replace VT4 = . if (VT4 < 1 | VT4 > 5) 

replace SF1 = . if (SF1 < 1 | SF1 > 5) 
replace SF2 = . if (SF2 < 1 | SF2 > 5)

replace RE1 = . if (RE1 < 1 | RE1 > 5) 
replace RE2 = . if (RE2 < 1 | RE2 > 5)  
replace RE3 = . if (RE3 < 1 | RE3 > 5)  

replace MH1 = . if (MH1 < 1 | MH1 > 5) 
replace MH2 = . if (MH2 < 1 | MH2 > 5) 
replace MH3 = . if (MH3 < 1 | MH3 > 5) 
replace MH4 = . if (MH4 < 1 | MH4 > 5) 
replace MH5 = . if (MH5 < 1 | MH5 > 5) 

* RECODIFICACION DE ITEMS DE BP

 gen RCBP1=6 if (BP1==1)
 replace RCBP1=5.4 if (BP1==2)
 replace RCBP1=4.2 if (BP1==3)
 replace RCBP1=3.1 if (BP1==4)
 replace RCBP1=2.2 if (BP1==5)
 replace RCBP1=1 if (BP1==6) 

 gen RCBP2=6 if (BP2==1 & BP1==1)
 replace RCBP2=5 if (BP2==1 & BP1>=2 & BP1!=.)
 replace RCBP2=4 if (BP2==2 & BP1>=1 & BP1!=.)
 replace RCBP2=3 if (BP2==3 & BP1>=1 & BP1!=.)
 replace RCBP2=2 if (BP2==4 & BP1>=1 & BP1!=.)
 replace RCBP2=1 if (BP2==5 & BP1>=1 & BP1!=.)

*** en caso de que no se haya contestado a BP1:

 replace RCBP2=6 if (BP2==1 & BP1==.)
 replace RCBP2=4.75 if (BP2==2 & BP1==.)
 replace RCBP2=3.5 if (BP2==3 & BP1==.) 
 replace RCBP2=2.25 if (BP2==4 & BP1==.) 
 replace RCBP2=1  if (BP2==5 & BP1==.) 

* RECODIFICACION DE ITEMS DE GH

 gen  RCGH1=5 if (GH1==1)
 replace RCGH1=4.4 if (GH1==2) 
 replace RCGH1=3.4 if (GH1==3) 
 replace RCGH1=2 if (GH1==4) 
 replace RCGH1=1  if (GH1==5)

 gen     RCGH5=5 if (GH5==1)
 replace RCGH5=4 if (GH5==2)
 replace RCGH5=3 if (GH5==3)
 replace RCGH5=2 if (GH5==4)
 replace RCGH5=1 if (GH5==5)

 gen     RCGH3=5 if (GH3==1)
 replace RCGH3=4 if (GH3==2) 
 replace RCGH3=3 if (GH3==3)
 replace RCGH3=2 if (GH3==4) 
 replace RCGH3=1 if (GH3==5)

* RECODIFICACION DE ITEMS DE VT

 gen    RCVT1=5 if (VT1==1) 
 replace RCVT1=4 if (VT1==2)
 replace RCVT1=3 if (VT1==3)
 replace RCVT1=2 if (VT1==4)
 replace RCVT1=1 if (VT1==5) 


 gen     RCVT2=5 if (VT2==1)
 replace RCVT2=4 if (VT2==2) 
 replace RCVT2=3 if (VT2==3) 
 replace RCVT2=2 if (VT2==4)
 replace RCVT2=1  if (VT2==5)


* RECODIFICACION DE ITEMS DE SF

 gen     RCSF1=5 if (SF1==1)
 replace RCSF1=4 if (SF1==2)
 replace RCSF1=3 if (SF1==3)
 replace RCSF1=2 if (SF1==4)
 replace RCSF1=1 if (SF1==5)

* RECODIFICACION DE ITEMS DE MH

 gen     RCMH3=5 if (MH3==1) 
 replace RCMH3=4 if (MH3==2)
 replace RCMH3=3 if (MH3==3)
 replace RCMH3=2 if (MH3==4) 
 replace RCMH3=1 if (MH3==5)

 gen     RCMH5=5 if (MH5==1)
 replace RCMH5=4 if (MH5==2) 
 replace RCMH5=3 if (MH5==3) 
 replace RCMH5=2 if (MH5==4) 
 replace RCMH5=1 if (MH5==5) 

* IMPUTACIÓN DE VALORES PARA LOS DATOS PERDIDOS.

egen PF_MISS= rowmiss(PF01 PF02 PF03 PF04 PF05 PF06 PF07 PF08 PF09 PF10)
egen  RP_MISS=rowmiss( RP1 RP2 RP3 RP4)
egen  BP_MISS=rowmiss( RCBP1 RCBP2 )
egen GH_MISS=rowmiss( RCGH1 GH2 RCGH3 GH4 RCGH5)
egen VT_MISS=rowmiss( RCVT1 RCVT2 VT3 VT4)
egen SF_MISS=rowmiss( RCSF1 SF2) 
egen RE_MISS=rowmiss( RE1 RE2 RE3)
egen  MH_MISS=rowmiss( MH1 MH2 RCMH3 MH4 RCMH5)

egen  M_PF= rowmean(PF01 PF02 PF03 PF04 PF05 PF06 PF07 PF08 PF09 PF10)
 
foreach var in PF01 PF02 PF03 PF04 PF05  PF06 PF07 PF08 PF09 PF10 {
   replace `var'=M_PF if `var'==. & PF_MISS<=5
}
 
egen M_RP= rowmean( RP1 RP2 RP3 RP4)

foreach var in   RP1 RP2 RP3 RP4 {
   replace `var'= M_RP if `var'==. & RP_MISS<=2
}

egen M_BP = rowmean(RCBP1 RCBP2)
 
foreach var in RCBP1 RCBP2 {
   replace `var'=M_BP if `var'==. & BP_MISS<=1
}  

egen M_GH=rowmean( RCGH1 GH2 RCGH3 GH4 RCGH5)

foreach var in RCGH1 GH2 RCGH3 GH4 RCGH5 {
   replace `var'=M_GH if `var'==. & GH_MISS<=2
}  

egen M_VT= rowmean(RCVT1 RCVT2 VT3 VT4)

foreach var in RCVT1 RCVT2 VT3 VT4 {
   replace `var'=M_VT if `var'==. & VT_MISS<=2
}  

egen M_SF=rowmean(RCSF1 SF2 )

foreach var in RCSF1 SF2  {
   replace `var'=M_SF if `var'==. & SF_MISS<=1
}  

egen M_RE=rowmean(RE1 RE2 RE3)


foreach var in RE1 RE2 RE3  {
   replace `var'=M_RE if `var'==. & RE_MISS<=1
}  

egen M_MH=rowmean( MH1 MH2 RCMH3 MH4 RCMH5)

foreach var in MH1 MH2 RCMH3 MH4 RCMH5  {
   replace `var'=M_MH if `var'==. & MH_MISS<=2
}  

**********************************************************
*** CALCULO DE LA PUNTUACION DE CADA ESCALA DE SF36    ***
**********************************************************

gen RAWPF=PF01+PF02+PF03+PF04+PF05+PF06+PF07+PF08+PF09+PF10
gen PF=((RAWPF-10)/20)*100

gen RAWRP=RP1+RP2+RP3+RP4
gen RP=((RAWRP-4)/16)*100

gen RAWBP=RCBP1+RCBP2
gen BP=((RAWBP-2)/10)*100

gen RAWGH=RCGH1+RCGH5+RCGH3+GH2+GH4
gen GH=((RAWGH-5)/20)*100

gen RAWVT=RCVT1+RCVT2+VT3+VT4
gen VT=((RAWVT-4)/16)*100

gen RAWSF=RCSF1+SF2
gen SF=((RAWSF-2)/8)*100

gen RAWRE=RE1+RE2+RE3
gen RE=((RAWRE-3)/12)*100

gen RAWMH=MH1+MH2+RCMH3+MH4+RCMH5
gen MH=((RAWMH-5)/20)*100



*************************************************************************************
* CALCULO DE LAS ESCALAS BASADO EN NORMAS AMERICANAS *
*************************************************************************************


* PASO 1: ESTANDARIZACIÓN DE CADA UNA DE LAS ESCALAS DEL SF-36 v2 UTILIZANDO LAS MEDIAS 
*  Y DESVIACIONES STANDARD DE LA POBLACIÓN GENERAL AMERICANA (Año 1998 - Extraído del Manual SF36 v2)


gen PF_Z = (PF-83.29094) / 23.75883 
gen RP_Z = (RP-82.50964) / 25.52028 
gen BP_Z = (BP-71.32527) / 23.66224 
gen GH_Z = (GH-70.84570) / 20.97821 
gen VT_Z = (VT-58.31411) / 20.01923 
gen SF_Z = (SF-84.30250) / 22.91921 
gen RE_Z = (RE-87.39733) / 21.43778 
gen MH_Z = (MH-74.98685) / 17.75604 


* PASO 2: TRANSFORMACIÓN BASADA EN NORMAS DE LAS ESCALAS.

gen PF_NORM = 50 + (PF_Z*10)
gen RP_NORM = 50 + (RP_Z*10)
gen BP_NORM = 50 + (BP_Z*10)
gen GH_NORM = 50 + (GH_Z*10)
gen VT_NORM = 50 + (VT_Z*10)
gen SF_NORM = 50 + (SF_Z*10)
gen RE_NORM = 50 + (RE_Z*10)
gen MH_NORM = 50 + (MH_Z*10)



********************************************************************
* CALCULO DE LAS MEDIDAS SUMARIO DEL SF-36 v2 *
********************************************************************


* PASO 1: AGREGACIÓN DE LAS ESCALAS, USANDO PESOS AMERICANOS, PARA LAS COMPONENTES FÍSICA Y MENTAL. .


gen AGG_PHYS=(PF_Z * 0.42402) + (RP_Z * 0.35119) + (BP_Z * 0.31754) + (GH_Z * 0.24954) + (VT_Z * 0.02877) ///
                  + (SF_Z * -0.00753) + (RE_Z * -0.19206) + (MH_Z * -0.22069) 

gen AGG_MENT=(PF_Z * -0.22999) + (RP_Z * -0.12329) + (BP_Z * -0.09731) + (GH_Z * -0.01571) + (VT_Z * 0.23534) /// 
                    +(SF_Z * 0.26876) + (RE_Z * 0.43407) + (MH_Z * 0.48581)


* PASO 2: TRANSFORMACIÓN DE LOS ÍNDICES SUMARIO FÍSICO Y MENTAL.

gen PCS_US= 50 + (AGG_PHYS*10)
gen MCS_US= 50 + (AGG_MENT*10)

label var  PCS_US "US STANDARDIZED PHYSICAL COMPONENT SCALE"
label var  MCS_US "US STANDARDIZED MENTAL COMPONENT SCALE"

label var  PF "FUNCIÓ FISICA (0-100)"
label var  RP "ROL FISIC (0-100)"
label var  BP "DOLOR CORPORAL (0-100)"
label var  GH "SALUT GENERAL (0-100)"
label var  VT "VITALITAT (0-100)"
label var  SF "FUNCIONAMENT SOCIAL(0-100)"
label var  RE "ROL EMOCIONAL (0-100)"
label var  MH "SALUT MENTAL (0-100)"

lab var PF01 "3a. ESF. INTENSOS"
lab var PF02 "3b. ESF. MODERADOS"
lab var PF03 "3c. BOLSA COMPRA"
lab var PF04 "3d. VARIOS PISOS"
lab var PF05 "3e. UN PISO"
lab var PF06 "3f. AGACHARSE"
lab var PF07 "3g. 1 KM. O MÁS"
lab var PF08 "3h. VARIOS CENTENARES MS"
lab var PF09 "3i. 100 METROS"
lab var PF10 "3j. BAÑARSE / VESTIRSE"

lab var AGG_PHYS "SF36 AGREGAT ESCALA FISICA"
lab var AGG_MENT "SF36 AGREGAT ESCALA MENTAL"

* ETIQUETAS DE LOS ÍTEMS DE RP

lab var RP1 "4a. REDUCIR ACTIVIDAD"
lab var RP2 "4b. MENOS DE LO DESEADO"
lab var RP3 "4c. DEJAR TAREAS"
lab var RP4 "4d. DIFICULTAD ACTIVIDAD"

* ETIQUETAS DE LOS ÍTEMS DE BP

lab var RCBP1 "7. DOLOR"
lab var RCBP2 "8. DOLOR DIFICULTA TRABAJO"
lab var BP1 "7. DOLOR"
lab var BP2 "8. DOLOR DIFICULTA TRABAJO"

* ETIQUETAS DE LOS ÍTEMS DE GH

lab var RCGH1 "1. SALUD EN GENERAL"
lab var GH1 "1. SALUD EN GENERAL"
lab var GH2 "11a. ENFERMO MÁS FACILMENTE"
lab var RCGH3 "11b. SANO COMO CUALQUIERA"
lab var GH3 "11b. SANO COMO CUALQUIERA"
lab var GH4 "11c. MI SALUD EMPEORARÁ"
lab var RCGH5 "11d. SALUD EXCELENTE"
lab var GH5 "11d. SALUD EXCELENTE"

* ETIQUETAS DE LOS ÍTEMS DE VT

lab var RCVT1 "9a. VITALIDAD"
lab var RCVT2 "9e. ENERGÍA"
lab var VT3 "9g. AGOTADO"
lab var VT4 "9i. CANSADO"
* ETIQUETAS DE LOS ÍTEMS DE SF

lab var  RCSF1 "6. FUNCIÓN SOCIAL - INTENSIDAD"
lab var  SF1 "6. FUNCIÓN SOCIAL - INTENSIDAD"
lab var  SF2 "10. FUNCIÓN SOCIAL- FRECUENCIA"

* ETIQUETAS DE LOS ÍTEMS DE RE

lab var  RE1 "5a. REDUCIR ACTIVIDAD POR EMOCIONES"
lab var  RE2 "5b. MENOS DE LO DESEADO POR EMOCIONES"
lab var  RE3 "5c. NO TAN CUIDADOSO POR EMOCIONES"

* ETIQUETAS DE LOS ÍTEMS DE MH

lab var  MH1 "9b. MUY NERVIOSO"
lab var  MH2 "9c. BAJO DE MORAL"
lab var  RCMH3 "9d. CALMADO"
lab var  MH3 "9d. CALMADO"
lab var  MH4 "9f. DESANIMADO"
lab var  RCMH5 "9h. FELIZ"
lab var  MH5 "9h. FELIZ"

lab var  HT "SALUT COMPARADA AMB LA D'UN ANY ENRERE(SF_36>)"






