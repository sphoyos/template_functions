
version 13.1
import excel "$orig\Dra_Quesada_BBDD_ANALISIS_FINAL_Oct_2016.xlsx", sheet("SF36") firstrow clear

unab listavar:*

foreach var of varlist `listavar' {
 cap ren `var' `=lower("`var'")'
}

foreach var  in    p1sf36 p2sf36 p3asf36 p3bsf36 p3csf36 p3dsf36 p3esf36 p3fsf36 p3gsf36 p3hsf36 p3isf36 p3jsf36 p4asf36 p4bsf36 p4csf36 p4dsf36 p5asf36 p5bsf36 p5csf36 p6sf36 p7sf36 p8sf36 p9asf36 p9bsf36 p9csf36 p9dsf36 p9esf36 p9fsf36 ///
                    p9gsf36 p9hsf36 p9isf36 p10sf36 p11asf36 p11bsf36 p11csf36 p11dsf36  {
	destring `var', replace force
}	
			
rename  ( p1sf36 p2sf36 p3asf36 p3bsf36 p3csf36 p3dsf36 p3esf36 p3fsf36 p3gsf36 p3hsf36 p3isf36 p3jsf36 p4asf36 p4bsf36 p4csf36 p4dsf36 p5asf36 p5bsf36 p5csf36 p6sf36 p7sf36 p8sf36 p9asf36 p9bsf36 p9csf36 p9dsf36 p9esf36 p9fsf36 ///
 p9gsf36 p9hsf36 p9isf36 p10sf36 p11asf36 p11bsf36 p11csf36 p11dsf36 ) ///
 ( gh1 ht pf01 pf02 pf03 pf04 pf05 pf06 pf07 pf08 pf09 pf10 rp1 rp2 rp3 rp4 re1 re2 re3 sf1 bp1 bp2 vt1 mh1 mh2 mh3 vt2 mh4 vt3 mh5 vt4 sf2 gh2 gh3 gh4 gh5 ) 

 
******************************
* CUESTIONARIO sf-36 *
******************************
**********************************************************
* SE CONVIERTEN EN MISSING LOS ITEMS CON reSP. FUERA DE RANGO
**********************************************************
replace  pf01 = . if (pf01 < 1 | pf01 > 3)
replace   pf02 =. if (pf02 < 1 | pf02 > 3)
replace  pf03 = . if (pf03 < 1 | pf03 > 3)
replace  pf04 = . if (pf04 < 1 | pf04 > 3)
replace  pf05 = . if (pf05 < 1 | pf05 > 3)
replace  pf06 = . if (pf06 < 1 | pf06 > 3)
replace  pf07 = . if (pf07 < 1 | pf07 > 3)
replace  pf08 = . if (pf08 < 1 | pf08 > 3)
replace  pf09 = . if (pf09 < 1 | pf09 > 3) 
replace  pf10 = . if (pf10 < 1 | pf10 > 3)

replace  rp1 = . if (rp1 < 1 | rp1 > 2)
replace  rp2 = . if (rp2 < 1 | rp2 > 2)
replace  rp3 = . if (rp3 < 1 | rp3 > 2)
replace  rp4 = . if (rp4 < 1 | rp4 > 2)

replace  bp1 = . if (bp1 < 1 | bp1 > 6)
replace  bp2 = . if (bp2 < 1 | bp2 > 5)

replace  gh1 = . if (gh1 < 1 | gh1 > 5) 
replace  gh2 = . if (gh2 < 1 | gh2 > 5)
replace  gh3 = . if (gh3 < 1 | gh3 > 5) 
replace  gh4 = . if (gh4 < 1 | gh4 > 5) 
replace  gh5 = . if (gh5 < 1 | gh5 > 5)

replace  vt1 = . if (vt1 < 1 | vt1 > 6)
replace  vt2 = . if (vt2 < 1 | vt2 > 6)
replace  vt3 = . if (vt3 < 1 | vt3 > 6)
replace  vt4 = . if (vt4 < 1 | vt4 > 6)

replace  sf1 = . if (sf1 < 1 | sf1 > 5)
replace  sf2 = . if (sf2 < 1 | sf2 > 5)

replace  re1 = . if (re1 < 1 | re1 > 2)
replace  re2 = . if (re2 < 1 | re2 > 2)
replace  re3 = . if (re3 < 1 | re3 > 2)

replace  mh1 = . if (mh1 < 1 | mh1 > 6)
replace  mh2 = . if (mh2 < 1 | mh2 > 6)
replace  mh3 = . if (mh3 < 1 | mh3 > 6)
replace  mh4 = . if (mh4 < 1 | mh4 > 6) 
replace  mh5 = . if (mh5 < 1 | mh5 > 6)



* reCODifICACION DE ITEMS DE bp
gen rcbp1=.
replace  rcbp1=6 if (bp1 == 1)
replace  rcbp1=5.4 if (bp1 == 2)
replace  rcbp1=4.2 if (bp1 == 3)
replace  rcbp1=3.1 if (bp1 == 4)
replace  rcbp1=2.2 if (bp1 == 5) 
replace  rcbp1=1 if (bp1 == 6)

gen rcbp2=.
replace  rcbp2=6 if (bp2 == 1 & bp1 == 1)
replace  rcbp2=5 if (bp2 == 1 & bp1 >= 2)
replace  rcbp2=4 if (bp2 == 2 & bp1 >= 1) 
replace  rcbp2=3 if (bp2 == 3 & bp1 >= 1) 
replace  rcbp2=2 if (bp2 == 4 & bp1 >= 1)
replace  rcbp2=1 if (bp2 == 5 & bp1 >= 1) 

*** en caso de que no se haya contestado a bp1:

replace  rcbp2=6 if (bp2 == 1 & bp1==.)
replace  rcbp2=4.75 if (bp2 == 2 & bp1==.)
replace  rcbp2=3.5 if (bp2 == 3 & bp1==.)
replace  rcbp2=2.25 if (bp2 == 4 & bp1==.)
replace  rcbp2=1 if (bp2 == 5 & bp1==.) 

* reCODifICACION DE ITEMS DE gh
gen rcgh1=.
replace  rcgh1=5 if (gh1 == 1)
replace  rcgh1=4.4 if (gh1 == 2)
replace  rcgh1=3.4 if (gh1 == 3)
replace  rcgh1=2 if (gh1 == 4) 
replace  rcgh1=1 if (gh1 == 5) 

gen rcgh5=.
replace  rcgh5=5 if (gh5 == 1) 
replace  rcgh5=4 if (gh5 == 2) 
replace  rcgh5=3 if (gh5 == 3) 
replace  rcgh5=2 if (gh5 == 4) 
replace  rcgh5=1 if (gh5 == 5) 

gen rcgh3=.
replace  rcgh3=5 if (gh3 == 1) 
replace  rcgh3=4 if (gh3 == 2) 
replace  rcgh3=3 if (gh3 == 3) 
replace  rcgh3=2 if (gh3 == 4) 
replace  rcgh3=1 if (gh3 == 5) 

* reCODifICACION DE ITEMS DE vt

gen rcvt1=.
replace  rcvt1=6 if (vt1 == 1) 
replace  rcvt1=5 if (vt1 == 2) 
replace  rcvt1=4 if (vt1 == 3) 
replace  rcvt1=3 if (vt1 == 4) 
replace  rcvt1=2 if (vt1 == 5) 
replace  rcvt1=1 if (vt1 == 6) 

gen rcvt2=.
replace  rcvt2=6 if (vt2 == 1) 
replace  rcvt2=5 if (vt2 == 2) 
replace  rcvt2=4 if (vt2 == 3) 
replace  rcvt2=3 if (vt2 == 4) 
replace  rcvt2=2 if (vt2 == 5) 

* reCODifICACION DE ITEMS DE sf

gen rcsf1=1
replace  rcsf1=5 if (sf1 == 1) 
replace  rcsf1=4 if (sf1 == 2) 
replace  rcsf1=3 if (sf1 == 3) 
replace  rcsf1=2 if (sf1 == 4) 
replace  rcsf1=1 if (sf1 == 5) 

* reCODifICACION DE ITEMS DE mh

gen rcmh3=.
replace  rcmh3=6 if (mh3 == 1) 
replace  rcmh3=5 if (mh3 == 2) 
replace  rcmh3=4 if (mh3 == 3) 
replace  rcmh3=3 if (mh3 == 4) 
replace  rcmh3=2 if (mh3 == 5) 
replace  rcmh3=1 if (mh3 == 6) 

gen rcmh5=.
replace  rcmh5=6 if (mh5 == 1) 
replace  rcmh5=5 if (mh5 == 2) 
replace  rcmh5=4 if (mh5 == 3) 
replace  rcmh5=3 if (mh5 == 4) 
replace  rcmh5=2 if (mh5 == 5) 
replace  rcmh5=1 if (mh5 == 6) 

**********************************************************
* IMPUTACIÓN DE VALOreS PARA LOS DATOS PERDIDOS.
**********************************************************
egen pf_miss= rowmiss(pf01 pf02 pf03 pf04 pf05 pf06 pf07 pf08 pf09 pf10 )
egen rp_miss= rowmiss(rp1 rp2 rp3 rp4 )
egen bp_miss= rowmiss(rcbp1 rcbp2 )
egen gh_miss= rowmiss(rcgh1 gh2 rcgh3 gh4 rcgh5 )
egen vt_miss= rowmiss(rcvt1 rcvt2 vt3 vt4 )
egen sf_miss= rowmiss(rcsf1 sf2 )
egen re_miss= rowmiss(re1 re2 re3 )
egen  mh_miss= rowmiss(mh1 mh2 rcmh3 mh4 rcmh5 )

egen m_pf=rowmean(pf01 pf02 pf03 pf04 pf05 pf06 pf07 pf08 pf09 pf10)


egen m_rp= rowmean( rp1 rp2 rp3 rp4)

foreach var in   rp1 rp2 rp3 rp4 {
   replace `var'= m_rp if `var'==. & rp_miss<=2
}

egen m_bp = rowmean(rcbp1 rcbp2)
 
foreach var in rcbp1 rcbp2 {
   replace `var'=m_bp if `var'==. & bp_miss<=1
}  

egen m_gh=rowmean( rcgh1 gh2 rcgh3 gh4 rcgh5)

foreach var in rcgh1 gh2 rcgh3 gh4 rcgh5 {
   replace `var'=m_gh if `var'==. & gh_miss<=2
}  

egen m_vt= rowmean(rcvt1 rcvt2 vt3 vt4)

foreach var in rcvt1 rcvt2 vt3 vt4 {
   replace `var'=m_vt if `var'==. & vt_miss<=2
}  

egen m_sf=rowmean(rcsf1 sf2 )

foreach var in rcsf1 sf2  {
   replace `var'=m_sf if `var'==. & sf_miss<=1
}  

egen m_re=rowmean(re1 re2 re3)


foreach var in re1 re2 re3  {
   replace `var'=m_re if `var'==. & re_miss<=1
}  

egen m_mh=rowmean( mh1 mh2 rcmh3 mh4 rcmh5)

foreach var in mh1 mh2 rcmh3 mh4 rcmh5  {
   replace `var'=m_mh if `var'==. & mh_miss<=2
}  

* CALCULO DE LA PUNTUACION DE CADA ESCALA DE sf36

gen rawpf=pf01+pf02+pf03+pf04+pf05+pf06+pf07+pf08+pf09+pf10
gen pf=((rawpf-10)/20)*100

gen rawrp=rp1+rp2+rp3+rp4
gen rp=((rawrp-4)/4)*100

gen rawbp=rcbp1+rcbp2
gen bp=((rawbp-2)/10)*100

gen rawgh=rcgh1+rcgh5+rcgh3+gh2+gh4
gen gh=((rawgh-5)/20)*100

gen rawvt=rcvt1+rcvt2+vt3+vt4
gen vt=((rawvt-4)/20)*100

gen rawsf=rcsf1+sf2
gen sf=((rawsf-2)/8)*100

gen rawre=re1+re2+re3
gen re=((rawre-3)/3)*100

gen rawmh=mh1+mh2+rcmh3+mh4+rcmh5
gen mh=((rawmh-5)/25)*100

/*
* ETIQUETAS DE LOS ÍTEMS DE pf

VAR LABEL pf01 '3a. Esf. INTENSOS'
         pf02 '3b. Esf. MODERADOS'
         pf03 '3c. BOLSA COMPRA'
         pf04 '3d. VARIOS PISOS'
         pf05 '3e. UN PISO'
         pf06 '3f. AGACHARSE'
         pf07 '3g. 1 KM. O MÁS'
         pf08 '3h. VARIOS CENTENAreS MS'
         pf09 '3i. 100 METROS'
         pf10 '3j. BAÑARSE / VESTIRSE'.

VALUE LABELS pf01 pf02 pf03 pf04 pf05 pf06 pf07 pf08 pf09 pf10
         1 'SI, LIMITA MUCHO'
         2 'SI, LIMITA UN POCO'
         3 'NO, NO LIMITA NADA'
         9 'NO CONSTA'.

* ETIQUETAS DE LOS ÍTEMS DE rp

VAR LABEL rp1 '4a. reDUCIR ACTIVIDAD'
         rp2 '4b. MENOS DE LO DESEADO'
         rp3 '4c. DEJAR TAreAS'
         rp4 '4d. DifICULTAD ACTIVIDAD'.

VALUE LABELS rp1 rp2 rp3 rp4
         1 'SÍ'
         2 'NO'
         9 'NO CONSTA'.

* ETIQUETAS DE LOS ÍTEMS DE bp

VAR LABEL rcbp1 '7. DOL|'
         rcbp2 '8. DOL| DifICULTA TRABAJO'.

VALUE LABELS rcbp1
        6 'NO, NINGUNO'
        5.4 'SÍ, MUY POCO'
        4.2 'SÍ, UN POCO'
        3.1 'SÍ, MODERADO'
        2.2 'SÍ, MUCHO'
        1.0 'SÍ, MUCHÍSIMO'. 

VALUE LABELS rcbp2
        6 'NADA'
        5 'NADA'
        4.75 'UN POCO'
        4 'UN POCO'
        3.5 'reGULAR'
        3 'reGULAR'
        2.25 'BASTANTE'
        2 'BASTANTE'
        1'MUCHO'.

* ETIQUETAS DE LOS ÍTEMS DE gh

VAR LABEL rcgh1 '1. SALUD EN GENERAL'
        gh2 '11a. ENFERMO MÁS FACILMENTE'
        rcgh3 '11b. SANO COMO CUALQUIERA'
        gh4 '11c. MI SALUD EMPE|ARÁ'
        rcgh5 '11d. SALUD EXCELENTE'.

VALUE LABELS rcgh1
        5 'EXCELENTE'
        4.4 'MUY BUENA'
        3.4 'BUENA'
        2.0 'reGULAR'
        1.0 'MALA'.

VALUE LABELS gh2 gh4
        1 'TOTALMENTE CIERTA'
        2 'BASTANTE CIERTA'
        3 'NO LO SÉ'
        4 'BASTANTE FALSA'
        5 'TOTALMENTE FALSA'
        9 'NO CONSTA'.

VALUE LABELS rcgh3 rcgh5
        5 'TOTALMENTE CIERTA'
        4 'BASTANTE CIERTA'
        3 'NO LO SÉ'
        2 'BASTANTE FALSA'
        1 'TOTALMENTE FALSA'.

* ETIQUETAS DE LOS ÍTEMS DE vt

VAR LABEL rcvt1 '9a. VITALIDAD'
        rcvt2 '9e. ENERGÍA'
        vt3 '9g. AGOTADO'
        vt4 '9i. CANSADO'.

VALUE LABELS rcvt1 rcvt2
        6 'SIEMPre'
        5 'CASI SIEMPre'
        4 'MUCHAS VECES'
        3 'ALGUNAS VECES'
        2 'SÓLO ALGUNA VEZ'
        1 'NUNCA'.

VALUE LABELS vt3 vt4
        1 'SIEMPre'
        2 'CASI SIEMPre'
        3 'MUCHAS VECES'
        4 'ALGUNAS VECES'
        5 'SÓLO ALGUNA VEZ'
        6 'NUNCA'
        9 'NO CONSTA'.

* ETIQUETAS DE LOS ÍTEMS DE sf

VAR LABEL rcsf1 '6. FUNCIÓN SOCIAL - INTENSIDAD'
         sf2 '10. FUNCIÓN SOCIAL- FreCUENCIA'.

VALUE LABELS rcsf1
       5 'NADA'
       4 'UN POCO'
       3 'reGULAR'
       2 'BASTANTE'
       1 'MUCHO'.

VALUE LABELS sf2
       1 'SIEMPre'
       2 'CASI SIEMPre'
       3 'ALGUNAS VECES'
       4 'SÓLO ALGUNA VEZ'
       5 'NUNCA'
        9 'NO CONSTA'.
 
* ETIQUETAS DE LOS ÍTEMS DE re

VAR LABEL re1 '5a. reDUCIR ACTIVIDAD P| EMOCIONES'
       re2 '5b. MENOS DE LO DESEADO P| EMOCIONES'
       re3 '5c. NO TAN CUIDADOSO P| EMOCIONES'.

VALUE  LABELS re1 re2 re3
       1 'SÍ'
       2 'NO'
       9 'NO CONSTA'.

* ETIQUETAS DE LOS ÍTEMS DE mh

VAR LABEL mh1 '9b. MUY NERVIOSO'
      mh2 '9c. BAJO DE M|AL'
      rcmh3 '9d. CALMADO'
      mh4 '9f. DESANIMADO'
      rcmh5 '9h. FELIZ'.

VALUE LABELS mh1 mh2 mh4
      1 'SIEMPre'
      2 'CASI SIEMPre'
      3 'MUCHAS VECES'
      4 'ALGUNAS VECES'
      5 'SÓLO ALGUNA VEZ'
      6 'NUNCA' 
      9 'NO CONSTA'.

VALUE LABELS rcmh3 rcmh5
      6 'SIEMPre'
      5 'CASI SIEMPre'
      4 'MUCHAS VECES'
      3 'ALGUNAS VECES'
      2 'SÓLO ALGUNA VEZ'
      1 'NUNCA'.
      

VAR LABEL HT 'SALUD COMPARADA CON HACE UN AÑO'.

VALUE LABELS HT
      1 'MUCHO MEJ| AH|A'
      2 'ALGO MEJ| AH|A'
      3 'MÁS O MENOS IGUAL'
      4 'ALGO PE| AH|A'
      5 'MUCHO PE| AH|A'
      9 'NO CONSTA'.
*/
label var pf "sf-36 PHYSICAL FUNCTIONING (0-100)" 
label var rp "sf-36 ROLE PHYSICAL (0-100)"
label var bp "sf-36 BODILY PAIN (0-100)"
label var gh "sf-36 GENERAL HEALTH (0-100)"
label var vt "sf-36 VITALITY (0-100)"
label var sf "sf-36 SOCIAL FUNCTIONING (0-100)"
label var re "sf-36 ROLE EMOTIONAL (0-100)"
label var mh "sf-36 MENTAL HEALTH (0-100)"
label var rawpf "raw sf-36 PHYSICAL FUNCTIONING"
label var rawrp "raw sf-36 ROLE PHYSICAL"
label var rawbp "raw sf-36 BODILY PAIN"
label var rawgh "raw sf-36 GENERAL HEALTH"
label var rawvt "raw sf-36 VITALITY "
label var rawsf "raw sf-36 SOCIAL FUNCTIONING "
label var rawre "raw sf-36 ROLE EMOTIONAL"
label var rawmh "raw sf-36 MENTAL HEALTH"





lab var pf01 "3a. ESF. INTENSOS"
lab var pf02 "3b. ESF. MODERADOS"
lab var pf03 "3c. BOLSA COMPRA"
lab var pf04 "3d. VARIOS PISOS"
lab var pf05 "3e. UN PISO"
lab var pf06 "3f. AGACHARSE"
lab var pf07 "3g. 1 KM. O MÁS"
lab var pf08 "3h. VARIOS CENTENARES MS"
lab var pf09 "3i. 100 METROS"
lab var pf10 "3j. BAÑARSE / VESTIRSE"



* ETIQUETAS DE LOS ÍTEMS DE rp

lab var rp1 "4a. REDUCIR ACTIVIDAD"
lab var rp2 "4b. MENOS DE LO DESEADO"
lab var rp3 "4c. DEJAR TAREAS"
lab var rp4 "4d. DIFICULTAD ACTIVIDAD"

* ETIQUETAS DE LOS ÍTEMS DE bp

lab var rcbp1 "7. DOLOR"
lab var rcbp2 "8. DOLOR DIFICULTA TRABAJO"
lab var bp1 "7. DOLOR"
lab var bp2 "8. DOLOR DIFICULTA TRABAJO"

* ETIQUETAS DE LOS ÍTEMS DE gh

lab var rcgh1 "1. SALUD EN GENERAL"
lab var gh1 "1. SALUD EN GENERAL"
lab var gh2 "11a. ENFERMO MÁS FACILMENTE"
lab var rcgh3 "11b. SANO COMO CUALQUIERA"
lab var gh3 "11b. SANO COMO CUALQUIERA"
lab var gh4 "11c. MI SALUD EMPEORARÁ"
lab var rcgh5 "11d. SALUD EXCELENTE"
lab var gh5 "11d. SALUD EXCELENTE"

* ETIQUETAS DE LOS ÍTEMS DE vt

lab var rcvt1 "9a. VITALIDAD"
lab var rcvt2 "9e. ENERGÍA"
lab var vt3 "9g. AGOTADO"
lab var vt4 "9i. CANSADO"
* ETIQUETAS DE LOS ÍTEMS DE SF

lab var  rcsf1 "6. FUNCIÓN SOCIAL - INTENSIDAD"
lab var  sf1 "6. FUNCIÓN SOCIAL - INTENSIDAD"
lab var  sf2 "10. FUNCIÓN SOCIAL- FRECUENCIA"

* ETIQUETAS DE LOS ÍTEMS DE RE

lab var  re1 "5a. REDUCIR ACTIVIDAD POR EMOCIONES"
lab var  re2 "5b. MENOS DE LO DESEADO POR EMOCIONES"
lab var  re3 "5c. NO TAN CUIDADOSO POR EMOCIONES"

* ETIQUETAS DE LOS ÍTEMS DE MH

lab var  mh1 "9b. MUY NERVIOSO"
lab var  mh2 "9c. BAJO DE MORAL"
lab var  rcmh3 "9d. CALMADO"
lab var  mh3 "9d. CALMADO"
lab var  mh4 "9f. DESANIMADO"
lab var  rcmh5 "9h. FELIZ"
lab var  mh5 "9h. FELIZ"

lab var  ht "SALUT COMPARADA AMB LA D'UN ANY ENRERE(SF_36>)"



*********************************************************************************
*    OBTENCIÓN DE LOS ÍNDICES SUMARIO FÍSICO Y MENTAL    *
*********************************************************************************

* EST&ARIZACIÓN DE CADA UNA DE LAS ESCALAS DEL sf-36 UTILIZ&O LAS MEDIAS 
* Y DESVIACIONES ST&ARD DE LA POBLACIÓN ESPAÑOLA QUE APAreCEN PUBLICADAS EN:
* Alonso J., Regidor E., Barrio G., Prieto L., Rodríguez C., de la Fuente L. Valores Poblacionales de 
*  Referencia de la versión española del cuestionario de la salud sf-36. Med Clin (Barc) 1998; 111:410-416.


gen pf_z = (pf-84.7) / 24.0 
gen rp_z = (rp-83.2) / 35.2 
gen bp_z = (bp-79.0) / 27.9 
gen gh_z = (gh-68.3) / 22.3 
gen vt_z = (vt-66.9) / 22.1 
gen sf_z = (sf-90.1) / 20.0 
gen re_z = (re-88.6) / 30.1 
gen mh_z = (mh-73.3) / 20.1 


************************************************************************************************************************************************
* AGreGACIÓN DE LAS ESCALAS, US&O PESOS ESPAÑOLES, PARA LAS COMPONENTES FÍSICA Y MENTAL.  *
************************************************************************************************************************************************

gen agg_phys=(pf_z * 0.407) + (rp_z * 0.359) + (bp_z * 0.332) + (gh_z * 0.292) + (vt_z * 0.039) + ///
             (sf_z * 0.031) + (re_z * -0.240) + (mh_z * -0.242)

gen aqg_ment=(pf_z * -0.219) + (rp_z * -0.163) + (bp_z * -0.133) + (gh_z * -0.069) + (vt_z * 0.232) + ///
         (sf_z * 0.241) + (re_z * 0.512) + (mh_z * 0.536)

* TRANsf|MACIÓN DE LOS ÍNDICES SUMARIO FÍSICO Y MENTAL.

gen pcs_sp= 50 + (agg_phys*10)
gen mcs_sp= 50 + (aqg_ment*10)

label var  pcs_sp "STANDARDIZED PHYSICAL COMPONENT SCALE-00"
label var  mcs_sp "STANDARDIZED MENTAL COMPONENT SCALE-00"


