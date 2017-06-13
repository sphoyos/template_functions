


******************** ACTIVA  EL CATALA O CASTELLA ***************************************
*htput <BR>
*htput En aquest document es presenta la correlaci� entre ************************************* <br>
*htput <FONT color="#993366"> Per veure la relaci� entre variables cuantitatives es calcula l'index de correlaci� de Pearson. 
*htput Un valor proper a 1 sugereix una correlaci� positiva perfecta. Un valor proper a -1 sugereix una correlaci� negativa perfecta.
*htput El p valor nomes mostra l'exist�ncia d'una relaci� entre les dues variables en mitja, encara que pot haver-hi molta dispersi� </FONT color>
*htput <BR>


******************** ACTIVA  EL CATALA O CASTELLA ***************************************
htput <BR>
htput <FONT color="#993366"> 
htput En este documento se presenta la correlaci�n entre ************************************* <br>
htput Para ver la relaci�n entre variables cuantitativas se calcula el �ndice de correlaci�n de Pearson
htput Un valor pr�ximo a 1 sugiere una correlaci�n positiva perfecta. Un valor pr�ximo a -1 sugeiere una correlaci�n negativa perfecta.
htput El p valor s�lo muestra la existencia de una relaci�n entre les dos variables en promedio, aunque puede haber mucha dispersi�n.
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

	htput <H4> Correlaci� entre  `nomvarX'  y `nomvarY' </H4>
	htput <br>
	
	**** Correlaci� de Pearson 
	qui correlate `varY' `varX' if `varY' !=0 
	local corr: di  %5.3f  r(rho)
	local pvalue: di  %6.4f  tprob((r(N)-2),r(rho)* sqrt( (r(N)-2)/(1-r(rho)^2)))
	qui cii2 r(N) r(rho), corr
	local r_inf: di %5.3f r(lb)
	local r_sup: di %5.3f r(ub)

	***** Correlaci� de Spearman
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
	htput <TH> Correlaci� </TH>
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


	twoway sc `varY'  `varX' [fweight=repe] ,mcolor("253 169 255") msize(.9)  || lfit `varY'  `varX' ,lcolor("153 52 137")  lw(medthick) ||,  title(Relaci�n `nomvarY' con `nomvarX',size(medsmall) ) ///
             xtitle(,size(small)) ytitle(,size(small))  note("Correlaci�n =`corr' [95%CI `r_inf'; `r_sup']   pvalor= `pvalue'")   legend(off) ytitle( `nomvarY') 
	*********** GUARDA ELS GRAFICS ******************************************
	graph export $htm\png\gr_`grafname'.png, replace
	graph export $gph\wmf\gr_`grafname'.wmf, replace
	graph save $gph\gph\gr_`grafname'.gph, replace
	htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evoluci� `namegraf' ">
	htput <BR>

   }
}

