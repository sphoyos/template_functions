


******************** ACTIVA  EL CATALA O CASTELLA ***************************************
*htput <BR>
*htput En aquest document es presenta la correlació entre ************************************* <br>
*htput <FONT color="#993366"> Per veure la relació entre variables cuantitatives es calcula l'index de correlació de Pearson. 
*htput Un valor proper a 1 sugereix una correlació positiva perfecta. Un valor proper a -1 sugereix una correlació negativa perfecta.
*htput El p valor nomes mostra l'existència d'una relació entre les dues variables en mitja, encara que pot haver-hi molta dispersió </FONT color>
*htput <BR>


******************** ACTIVA  EL CATALA O CASTELLA ***************************************
htput <BR>
htput <FONT color="#993366"> 
htput En este documento se presenta la correlación entre ************************************* <br>
htput Para ver la relación entre variables cuantitativas se calcula el índice de correlación de Pearson
htput Un valor próximo a 1 sugiere una correlación positiva perfecta. Un valor próximo a -1 sugeiere una correlación negativa perfecta.
htput El p valor sólo muestra la existencia de una relación entre les dos variables en promedio, aunque puede haber mucha dispersión.
htput </FONT color>
htput <BR>




htput <BR>


foreach varX of varlist  ca199 {

   local nomvarX: var label `varX' 
   if   `"`nomvarX'"' == "" local nomvarX = "`varX'"
 
  foreach varY of varlist ca199hxadk  {
    cap drop repe 

    duplicates tag `varY' `varX' if  `varY'!=. & `varX'!=.  , generate(repe)

    replace repe= repe+1
	local nomvarY: var label `varY' 
	if   `"`nomvarY'"' == "" local nomvarY = "`varY'"
 
	local grafname = "sc_cor_"+"`varX'"+"_"+"`varY'"

	htput <H4> Correlació entre  `nomvarX'  y `nomvarY' </H4>
	htput <br>
	
	**** Correlació de Pearson 
	qui correlate `varY' `varX' if `varY' !=0 
	local corr: di  %5.3f  r(rho)
	local pvalue: di  %6.4f  tprob((r(N)-2),r(rho)* sqrt( (r(N)-2)/(1-r(rho)^2)))
	qui cii2 r(N) r(rho), corr
	local r_inf: di %5.3f r(lb)
	local r_sup: di %5.3f r(ub)

	***** Correlació de Spearman
	*qui spearman  `varY' `varX' if `varY' !=0 
	*local corr: di  %5.3f  r(rho)
	*local pvalue: di  %6.4f  tprob((r(N)-2),r(rho)* sqrt( (r(N)-2)/(1-r(rho)^2)))
	*qui cii2 r(N) r(rho), corr
	*local r_inf: di %5.3f r(lb)
	*local r_sup: di %5.3f r(ub)

	htput <br>
	htput <TABLE>
	htput <TR>
	htput <TH> Variable X </TH>
	htput <TH> Variable Y </TH>
	htput <TH> Correlació </TH>
	htput <TH> pvalor </TH>
	htput </TR>
	
	htput <TR>
	htput <TD>  `nomvarX' </TD>
	htput <TD>  `nomvarY'  </TD>
	htput <TD>  `corr' (`r_inf';`r_sup') </TD>
	htput <TD>  `pvalue' </TD>
	htput </TR>
	htput </TABLE>

	htput <BR>


	twoway sc `varY'  `varX' [fweight=repe] ,mcolor("253 169 255") msize(.9)  || lfit `varY'  `varX' ,lcolor("153 52 137")  lw(medthick) ||,  title(Relación `nomvarY' con `nomvarX',size(medsmall) ) ///
             xtitle(,size(small)) ytitle(,size(small))  note("Correlación =`corr' [95%CI `r_inf'; `r_sup']   pvalor= `pvalue'")   legend(off) ytitle( `nomvarY') 
	*********** GUARDA ELS GRAFICS ******************************************
	graph export $htm\png\gr_`grafname'.png, replace
	graph export $gph\wmf\gr_`grafname'.wmf, replace
	graph save $gph\gph\gr_`grafname'.gph, replace
	htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
	htput <BR>

   }
}

