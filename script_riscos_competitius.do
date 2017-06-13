	

** Establece el tiempo de supervivencia a cualquier evento 
stset NRM_TIME, f(NRM=1 2 ) 

* Calcula Kaplan Meier Global
sts gen KMglob=s
* Calcula Incidencia Acumulada Global
gen CumIncglob=1-KMglob
* Guarda los tiempos en los que cambia la Supervivencia a caulquier evento global
gen  tsegglob=_t


*** Establece el tiempo a evento NRM==1 como resultado de interes
stset NRM_TIME, f(NRM=1  )


* Calcula el Kaplan Meier sin riesgo competitivo ( asumiendo censura) para NRM==1
 sts gen KM1=s
 * Calcula la incidencia acumulada sin riesgo competitivo ( asumiendo censura )  NRM==1
 gen INC1=1-KM1
 
 * Calcula al incidencia teniendo en cuenta 2 como riesgo competititivo 
 stcompet CumInc = ci SError = se, compet1(2)  
 
**  Calcula la incidencia acumulada para  NRM==1
 gen CumInc1 = CumInc if recimort==1
**  Calcula la incidencia acumulada para  NRM==2
 gen CumInc2 = CumInc if recimort==2

*** Establece el tiempo a evento NRM==2 como resultado de interes
stset tarecidiva, f(recimort=2  ) 
* Calcula el Kaplan Meier sin riesgo competitivo ( asumiendo censura) para NRM==2
 sts gen KM2=s
 * Calcula el Kaplan Meier sin riesgo competitivo ( asumiendo censura) para NRM==2
 gen INC2=1-KM2

 
 * Rellena los datos que faltan 

  sort tsegglob
 
 replace CumInc1= CumInc1[_n-1] if CumInc1==.
 replace CumInc2= CumInc2[_n-1] if CumInc2==.

 replace CumInc1=0 if CumInc1==.
 replace CumInc2=0 if CumInc2==.

 
 ***** Dibuja todas las lineas ( incidencia acumulada por Kaplan Meier y Incidencia aculada por riesgos competitivos y total.
  
 twoway line  CumInc1  INC1 CumInc2 INC2   tsegglob, sort lpattern("....-" "--.." "-." "--"  ) lcolor( red orange_red blue midblue ) ///
 || line CumIncglob tsegglob,sort lpattern("l") lcolor("153 52 137") ///
 || , xlabel(#10,labs(small))  ylabel(0(.1)1, angle(h)) ytitle("%") xtitle("Años de seguimiento") note("KM=Kaplan Meier, CR= Riesgos Competitivos") title("Tiempo a evento") ///
 legend(label(1 "CR Recidiva") label(2 "KM Recidiva")  label(3 "CR Muerte")  label(4 "KM Muerte") label(5 "Tiempo libre de enfermedad")) 
 
 
 
 
 
 ***** Dibuja la incidencia acumulada del NRM==1
  
 twoway line  CumInc1   tsegglob, sort 
 
 
 
 