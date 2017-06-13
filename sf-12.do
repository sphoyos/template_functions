clear
input I1-I12
1 1 1 1 1 1 1 1 1 1 1 1 
1 1 3 3 3 3 3 3 3 3 3 3 
1 1 . 3 3 3 3 3 3 3 3 3 
5 5 1 1 1 . . . . . . . 
end

*** le cambio el nombre a las variables
generate I1= GH1
generate I2A= PF02
generate I2B=  PF04
generate I3A=  RP2
generate I3B=   RP3
generate I4A=  RE2
generate I4B=   RE3
generate I5=  BP2
generate I6A=  MH3
generate I6B= VT2
generate I6C=  MH4
generate I7= SF2
 



// Rename variables
local i = 1
foreach l in I1   I2A  I2B  I3A  I3B  I4A  I4B  I5   I6A  I6B  I6C  I7 {
	capture: rename I`i'  `l'
	local ++i
	}
*l
*sf12v2

*----------sf12v2-------------

*program sf12v2
*	version 9.1
*	qui {
	
	// Code out-of-range values to missing
	foreach l in I1 I3A I3B I4A I4B I5 I6A I6B I6C I7 {
		replace `l' = . if `l' != 1 & `l' != 2 &`l' != 3 &`l' != 4 &`l' != 5
	}
		
	foreach l in I2A I2B {
		replace `l' =.  if `l' != 1 & `l' != 2 &`l' != 3
	}
		
	// When necessary, reverse code items so a higher score means better health
	replace I1 = cond(I1 == 1, 5, ///
		cond(I1 == 2, 4.4, ///
		cond(I1 == 3, 3.4, ///
		cond(I1 == 4, 2, ///
		cond(I1 == 5, 1,.)))))
		 
	replace I5 = 6-I5
	replace I6A = 6-I6A
	replace I6B = 6-I6B
	
	//Create Scales
	
	generate PF=I2A+I2B
	generate RP=I3A+I3B
	generate BP=I5
	generate GH=I1
	generate VT=I6B
	generate SF=I7
	generate RE=I4A+I4B
	generate MH=I6A+I6C
	
	replace PF=100*(PF-2)/4
	replace RP=100*(RP-2)/8
	replace BP=100*(BP-1)/4
	replace GH=100*(GH-1)/4
	replace VT=100*(VT-1)/4
	replace SF=100*(SF-1)/4
	replace RE=100*(RE-2)/8
	replace MH=100*(MH-2)/8
	
	// 1) Transform scores to Z-scores
	//    US general population means and sd are used here 
	//    (not age/gender based) 
              
   	generate PF_Z = (PF - 81.18122) / 29.10588 
   	generate RP_Z = (RP - 80.52856) / 27.13526 
   	generate BP_Z = (BP - 81.74015) / 24.53019 
   	generate GH_Z = (GH - 72.19795) / 23.19041 
   	generate VT_Z = (VT - 55.59090) / 24.84380 
   	generate SF_Z = (SF - 83.73973) / 24.75775 
   	generate RE_Z = (RE - 86.41051) / 22.35543 
   	generate MH_Z = (MH - 70.18217) / 20.50597 
   	
   	// 2) Create physical and mental health composite scores: 
	//    multiply z-scores by varimax-rotated factor scoring 
	//    coefficients and sum the products 
	
	generate AGG_PHYS = (PF_Z * 0.42402) + ///
	              (RP_Z * 0.35119) + ///
	              (BP_Z * 0.31754) + ///
	              (GH_Z * 0.24954) + ///
	              (VT_Z * 0.02877) + ///
	              (SF_Z * -.00753) + ///
	              (RE_Z * -.19206) + /// 
	              (MH_Z * -.22069) 
	              
	              
	generate AGG_MENT = (PF_Z * -.22999) + /// 
	              (RP_Z * -.12329) + ///
	              (BP_Z * -.09731) + ///
	              (GH_Z * -.01571) + ///
	              (VT_Z * 0.23534) + ///
	              (SF_Z * 0.26876) + ///
	              (RE_Z * 0.43407) + ///
	              (MH_Z * 0.48581) 
	
	
	// 3) Transform composite and scale scores to t-scores
	
	replace AGG_PHYS = 50 + (AGG_PHYS * 10)
	replace AGG_MENT = 50 + (AGG_MENT * 10)
	
	label var  AGG_PHYS "NEMC Physical Health T-Score - SF12"
	label var AGG_MENT "NEMC Mental Health T-Sscore - SF12"
	
	generate PF_T = 50 + (PF_Z * 10) 
	generate RP_T = 50 + (RP_Z * 10) 
	generate BP_T = 50 + (BP_Z * 10) 
	generate GH_T = 50 + (GH_Z * 10) 
	generate VT_T = 50 + (VT_Z * 10) 
	generate RE_T = 50 + (RE_Z * 10) 
	generate SF_T = 50 + (SF_Z * 10) 
	generate MH_T = 50 + (MH_Z * 10) 
	
	label var PF_T "NEMC Physical Functioning T-Score"
	label var RP_T "NEMC Role Limitation Physical T-Score"
	label var BP_T "NEMC Pain T-Score"
	label var GH_T "NEMC General Health T-Score"
	label var VT_T "NEMC Vitality T-Score"
	label var RE_T "NEMC Role Limitation Emotional T-Score"
	label var SF_T "NEMC Social Functioning T-Score"
	label var MH_T "NEMC Mental Health T-Score"

	local names "PF PF_T RP RP_T  BP BP_T GH GH_T VT VT_T SF SF_T RE RE_T MH MH_T AGG_PHYS AGG_MENT"

	tabstat `names', stat(N mean sd min max) c(s) 









*********************
egen float genant23 = rowmax(D4 D5 D6 D7 D8 D9 D10 D11 D12 L1 L2 L3 L4)
recode genant23 0.5/1=0 2/max=1


tabstat PF, stat(N mean sd min max) c(s)
tabstat RP, stat(N mean sd min max) c(s)
tabstat BP, stat(N mean sd min max) c(s)
tabstat GH, stat(N mean sd min max) c(s)
tabstat VT, stat(N mean sd min max) c(s)
tabstat SF, stat(N mean sd min max) c(s)
tabstat RE, stat(N mean sd min max) c(s)
tabstat MH, stat(N mean sd min max) c(s)

mean AGG_PHYS, over(FRACTURA)
mean AGG_MENT, over(FRACTURA)

mean AGG_PHYS, over(genant23)
mean AGG_MENT, over(genant23)
tabstat AGG_PHYS, stat(N mean sd min max) c(s)

 *******************calculo estos valores para toda la  población, para eso tengo que corregir por lo pesos de cada grupo de edad

mean  PF, stdi(EDAD_GR) stdweight(pes)
mean  RP, stdi(EDAD_GR) stdweight(pes)
mean  BP, stdi(EDAD_GR) stdweight(pes)
mean  GH, stdi(EDAD_GR) stdweight(pes)
mean  VT, stdi(EDAD_GR) stdweight(pes)
mean  SF, stdi(EDAD_GR) stdweight(pes)
mean  RE, stdi(EDAD_GR) stdweight(pes)
mean  MH, stdi(EDAD_GR) stdweight(pes)


 mean PF, stdi(EDAD_GR) stdweight(pes) over(FRACTURA)
 mean RP , stdi(EDAD_GR) stdweight(pes) over(FRACTURA)
 mean BP , stdi(EDAD_GR) stdweight(pes) over(FRACTURA)
 mean GH , stdi(EDAD_GR) stdweight(pes) over(FRACTURA)
 mean VT , stdi(EDAD_GR) stdweight(pes) over(FRACTURA)
 mean SF , stdi(EDAD_GR) stdweight(pes) over(FRACTURA)
 mean RE , stdi(EDAD_GR) stdweight(pes) over(FRACTURA)
 mean MH , stdi(EDAD_GR) stdweight(pes) over(FRACTURA)

 mean PF, stdi(EDAD_GR) stdweight(pes) over(genant1)
 mean RP , stdi(EDAD_GR) stdweight(pes) over(genant1)
 mean BP , stdi(EDAD_GR) stdweight(pes) over(genant1)
 mean GH , stdi(EDAD_GR) stdweight(pes) over(genant1)
 mean VT , stdi(EDAD_GR) stdweight(pes) over(genant1)
 mean SF , stdi(EDAD_GR) stdweight(pes) over(genant1)
 mean RE , stdi(EDAD_GR) stdweight(pes) over(genant1)
 mean MH , stdi(EDAD_GR) stdweight(pes) over(genant1)


 mean PF, stdi(EDAD_GR) stdweight(pes) over(genant23)
 mean RP , stdi(EDAD_GR) stdweight(pes) over(genant23)
 mean BP , stdi(EDAD_GR) stdweight(pes) over(genant23)
 mean GH , stdi(EDAD_GR) stdweight(pes) over(genant23)
 mean VT , stdi(EDAD_GR) stdweight(pes) over(genant23)
 mean SF , stdi(EDAD_GR) stdweight(pes) over(genant23)
 mean RE , stdi(EDAD_GR) stdweight(pes) over(genant23)
 mean MH , stdi(EDAD_GR) stdweight(pes) over(genant23)

*******************
 mean PF, over(EDAD_GR)
 mean RP, over(EDAD_GR)
 mean BP, over(EDAD_GR)
 mean GH, over(EDAD_GR)
 mean VT, over(EDAD_GR)
 mean SF, over(EDAD_GR)
 mean RE, over(EDAD_GR)
 mean MH, over(EDAD_GR)

 by EDAD_GR: sum PF RP BP GH VT SF RE MH

**En esta tabla se observan diferencias en las medias de las diferentes dimensiones, según grupos de edad. 
*Voy a realizar un ANOVA para ver si son significativas, y comparalas con el test de Bonferroni


oneway  PF EDAD_GR , tab bonferroni
oneway  RP EDAD_GR , tab bonferroni
oneway  BP EDAD_GR , tab bonferroni
oneway  GH EDAD_GR , tab bonferroni
oneway  VT EDAD_GR , tab bonferroni
oneway  SF EDAD_GR , tab bonferroni
oneway  RE EDAD_GR , tab bonferroni
oneway  MH EDAD_GR , tab bonferroni


*** genero una variable nueva que llamaré morbi (valora las comorbilidades de las mujeres)

*** genero una variable nueva que llamaré morbi (valora las comorbilidades de las mujeres)

gen obes=imc
recode obes (30/max=1) (nonmiss=0)

egen morbi=rowtotal ( hipoestrogenismo  farm obes tabaco alcohol enf corti FAC_IN2 FAC_IN3 FAC_IN4 FAC_IN5 FAC_IN6 FAC_IN7 FAC_IN8 FAC_EX1 FAC_EX2 FAC_EX3 FAC_EX4)
recode morbi (1/max=1) (0=0), gen (morbi1)
recode morbi (4/max=1) (1/3=0), gen (morbi4mas)
recode morbi (3/max=1) (1/2=0), gen (morbi3mas)


*****regresión lineal

 foreach i in  FRACTURA EDAD OSTEOPOR EDUC2 FOnv  morbi3mas {
  xi:regress  AGG_PHYS i.`i' 
   }
***En el univariante,  son significativas:genant23, EDAD_GR,EDUC2,FOnv,morbi3mas
xi: reg AGG_PHYS  i.FRACTURA
xi: reg AGG_PHYS  i.FRACTURA EDAD
estimates store mod1
xi: reg AGG_PHYS  i.FRACTURA EDAD i.FRACTURA*EDAD

lrtest mod1
**hay confusión entre genant23 y EDAD. Tb hay confusión entre EDADy EDUC"

xi:reg AGG_PHYS i.FRACTURA EDAD i.EDUC2 i.morbi3mas i.FOnv 
xi:stepwise reg AGG_PHYS i.genant23 i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv, pe (.05) pr(.1) 
xi:reg AGG_PHYS i.fractura2 EDAD i.EDUC2 i.morbi3mas i.FOnv 
**Con osteoporosis

xi:reg AGG_PHYS i.FRACTURA EDAD i.EDUC2 i.morbi3mas i.FOnv i.OSTEOPOR
xi:reg AGG_PHYS i.fractura2 EDAD i.EDUC2 i.morbi3mas i.FOnv i.OSTEOPOR

**mental

foreach i in  genant23 EDAD_GR OSTEOPOR EDUC2 FOnv  morbi3mas {
  xi:regress AGG_MENT i.`i' 
   }
** En el univariante, sólo  significativas: OSTEOPOR,morbi3mas,EDAD_GR, . Al ponerlas juntas en el modelo, fr2 deja se ser significativa.  El modelo final es:
xi:reg  AGG_MENT   i.FRACTURA EDAD  i.FOnv  i.morbi3mas  i.EDUC2 i.OSTEOPOR
xi:reg  AGG_MENT   i.FRACTURA EDAD  i.FOnv  i.morbi3mas  i.EDUC2 
xi:reg  AGG_MENT   i.FRACTURA EDAD  i.morbi3mas  i.EDUC2
xi:reg  AGG_MENT   i.FRACTURA EDAD  i.morbi3mas  
xi:reg  AGG_MENT   i.FRACTURA  i.morbi3mas  
xi:reg AGG_MENT   i.morbi3mas i.OSTEOP


xi:stepwise reg AGG_MENT i.genant23 i.EDAD_GR i.morbi3mas i.OSTEOP, pe(.05) pr(.1)


**AHORA HAGO EL ANÁLISIS CON LA VARIBLE FRACTURA

xi:reg AGG_PHYS i.FRACTURA i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv

xi:stepwise reg AGG_PHYS i.FRACTURA i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv, pe(.05) pr(.1)

 xi:reg AGG_MENT i.FRACTURA i.EDAD_GR i.morbi3mas i.OSTEOP

xi:stepwise reg AGG_MENT i.FRACTURA i.EDAD_GR i.morbi3mas i.OSTEOP, pe(.05) pr(.1)


**REG para cada una de las dimensiones del cuestionario

xi:reg PF i.FRACTURA i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv
xi:reg RP i.FRACTURA i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv
xi:reg BP i.FRACTURA i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv
xi:reg GH i.FRACTURA i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv
xi:reg VT i.FRACTURA i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv
xi:reg SF i.FRACTURA i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv
xi:reg RE i.FRACTURA i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv
xi:reg MH i.FRACTURA i.EDAD_GR i.EDUC2 i.morbi3mas i.FOnv
******************
by EDAD_GR FRACTURA: tabstat  AGG_PHYS

tab EDAD_GR  genant23, row colum chi2


