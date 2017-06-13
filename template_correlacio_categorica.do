
*********************************************************************************************************************
************ Taula de correlació V de Cramer i Chi Quadrada per a variables categòriques ****************************
*********************************************************************************************************************

*** Cal inidcar la llista de variables a correlacionar

local listavar =""


*** Initzialitza la taula 
	htput <TABLE BORDER=1 CELLSPACING =0 CELlPADDING=2>
	  htput <TR>
      htput  <TH VALIGN=CENTER ALIGN=CENTER   >Cramer<br> Chi p value </TH> 
		
*** Genera la capsalera de  les columnes de taula 		
   foreach var1 in `listavar'{
   
           htput  <TH VALIGN=CENTER ALIGN=CENTER   > `var1'</TH> 
		}
	
	  htput </TR>
   
*** Genera la capsalera de cadascuna de les files
   
   foreach var2 in `listavar' {
          htput <TR>
	      htput  <TH VALIGN=CENTER ALIGN=CENTER   > `var2'</TH>   
   foreach var1 in `listavar' {
*** Genera la cel·la en blanc si fila i columna son la mateixa variable
	    if "`var1'"=="`var2'" {
		
	      htput  <TD VALIGN=CENTER ALIGN=CENTER   > </TD>
       	  }
		else {
*** Calcula la taula 2x2 i extrau p valor i V de Cramer
          tab `var1' `var2' ,chi V 
          local pvalue: di %5.4f r(p)
		  local vcramer: di %5.3f r(CramersV)
		  htput  <TD VALIGN=CENTER ALIGN=CENTER   > `vcramer' <br>`pvalue'  </TD>
		 }
	  }
		 htput </TR>
	  
    }

*** Tanca la taula

   htput </TABLE>
   
   
     