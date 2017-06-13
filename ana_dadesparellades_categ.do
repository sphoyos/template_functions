use "$dta\ana_dades.dta", clear



********************* Genera fitxer wide


foreach v of varlist /*  Variables que es volen comparar  */ {
        local l`v' : variable label `v'

 }

 /* save the value labels for variables in local list*/
 foreach var of varlist  /*  Variables que es volen comparar  */ {
     local eti`var': value label `var'
   
	 if "`eti`var''"!="" {
	 
 	   qui  levelsof `var', local(`var'_levels)       /* create local list of all values of `var' */
	   foreach val of local `var'_levels {       /* loop over all values in local list `var'_levels */
      	   local `var'vl`val' : label `var' `val'    /* create macro that contains label for each value */
        }
	}   
 }

 *** la variable visita ha de estar codificada com 1 i 2

reshape wide /*  Variables que es volen comparar  */ ////
     ,i(identificador) j(visita)	 
						 

 foreach var in  /*  Variables que es volen comparar  */{ 

	 
	 
	local nomvar="l`var'"
	local varlab="eti`var'"
	
	label var `var'1 "``nomvar'' visita 1"
	*disp `var'  "`varlab'"
	if "``varlab''" !=""  label val `var'1  "``varlab''"
	    if "``varlab''"=="" {
		
	        local varlab="eti`var'"
	        if "``varlab''"!="" label val `var'1  "``varlab''"
		}
	
 
    label var `var'2 "``nomvar'' visita 2"
	*disp `var'  "`varlab'"
	if "``varlab''" !=""  label val `var'2  "``varlab''"
	    if "``varlab''"=="" {
		
	        local varlab="eti`var'"
	        if "``varlab''"!="" label val `var'2  "``varlab''"
		}


}


        htput <BR>
        
        htput <FONT color="#993366">
        htput Es presenta una analisi del canvi de categoria entre la visita 1 i la visita 2. Es presenta una taula de freqüencies on en 
		htput  columna estàn els resultats del dato inicial i en files els de la segona visita. Es presenten els percentages de canvi i es mostra
		htput un text de simetria exacte per veure si els canvis son significatius <br><br>
		htput </FONT color>





	local nvar=0					 
     foreach var in 	diarrea restrenyiment sens_evacua diglenta difdiggrasa difdigalgun acidesa reflux ///
      distabdom0 dolor zonadeldolor stress despertanit sonreparador fatigintel fatigfisica irritabilitat depressio ///
     ictericia secapell desccapilar greixcapilar alitosis escalabristol			{		

	 local nomvar: var label `var'1 
     if   `"`nomvar'"' == "" local nomvar = "`var'"
	 local nomvar=subinstr("`nomvar'","visita 1","",.)

     local nvar=`nvar'+1
     local nom_`nvar'="`nomvar'"
	        htput <H4> <b>`nomvar' </b> </H4>
            htput <BR>
	        ht_tablacat_cat `var'2 `var'1 , head close  pcol  coltotal   symexact color		
            htput <BR>
	 
            local grafname = "bar_"+"`vargrup'"+"_"+"`var'"

            ********* GENERA UNA TAULA DE 2X2 I EXTRAU EL VALOR CHI **********************
            qui symmetry `var'1 `var'2 ,  exact 
            local pvalue: di %9.4f  r(p_exact)
			 local p_`nvar' =`pvalue'
             local m_`nvar' ="p Simetria Exacta"
			 
            ************************ DIBUIXA EL GRAFIC DE FREQÜENCIES ACUMULAT *****************
            catplot bar `var'2  `var'1, percent("`var'1") stack asyvars title ("`nomvar'")  ///
            bar(1, bcolor( 196 255 118))      bar(2, bcolor(255 118 128)) bar(3, bcolor(205 205 255))  bar(4,bcolor(255 231 206))  bar(5, bcolor(205 231 255))  ///
		    oversubopts(label(labsize(vsmall))) ylabel( ,labsize(vsmall))ytitle("`ytit1'" ,size(small) ) note(P value Simetria=`pvalue')  legend(title( "Visita 2")) 
          
            *********** GUARDA ELS GRAFICS ******************************************
            graph export $htm\png\gr_`grafname'.png, replace
            graph export $gph\wmf\gr_`grafname'.wmf, replace
            graph save $gph\gph\gr_`grafname'.gph, replace
            htput <IMG SRC=png\gr_`grafname'.png ALT="grafic evolució `namegraf' ">
            htput <BR>
            *************** TANCA EL BUCLE DELS GRAFICS
	 
		 
}			




**************************************************************************************************
**********************  TAULA EN COLUMNA GRUPS I EN FILA VARCAT, VARCUANT ***********************
**************************************************************************************************

htput <TABLE BORDER=1 CELLSPACING =0 CELlPADDING=2>
   htput <TR>

 htput <TH VALIGN=CENTER ALIGN=CENTER  > Variables </TH>

htput <TH VALIGN=CENTER ALIGN=CENTER  >  Comparacio visita 1-2 </TH>

htput </TR>




local coloret=""
local coloret= `"BGCOLOR="#CC66FF""' 

local nvar=0
	foreach var in diarrea restrenyiment sens_evacua diglenta difdiggrasa difdigalgun acidesa reflux ///
     distabdom0 dolor zonadeldolor stress despertanit sonreparador fatigintel fatigfisica irritabilitat depressio ///
     ictericia secapell desccapilar greixcapilar alitosis escalabristol		  {
htput <TR>
local nvar=`nvar'+1

htput <TH VALIGN=CENTER ALIGN=LEFT  > `nom_`nvar''</TH>

if round(`p_`nvar'',0.001) <=0.05 {	
	                local coloret= `"BGCOLOR="#FFCCCC""' 
	               		    }
		       else	{
                    local coloret=""
                   }

local pval:disp %5.3f `p_`nvar''
htput <TD VALIGN=CENTER ALIGN=CENTER `coloret' > `m_`nvar'' <br> `pval'</TD>

htput </TR>
}


htput </TABLE>
