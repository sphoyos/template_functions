
 use "E:\18949893d\Escritorio\_PROJECTES\Elena_cobos\tabla2.dta", clear
 cap htclose
 htopen using "E:\18949893d\Escritorio\_PROJECTES\Elena_cobos\tabla2.html",replace
  
gen cas_exp= real(   subinstr( var2, substr(var2, strpos(var2,"(" ),.)  ," ",.))
gen nocas_exp=13-cas_exp
gen cas_noexp= real(   subinstr( var3, substr(var3, strpos(var3,"(" ),.)  ," ",.))
gen nocas_noexp=29-cas_noexp


htput <TABLE BORDER=1 CELLSPACING =0 CELlPADDING=2>
   htput <TR>
   htput <TH VALIGN=CENTER ALIGN=CENTER  ROWSPAN= 2 > Variables </TH>
   htput <TH VALIGN=CENTER ALIGN=CENTER  > Caso Familiar</TH>
   htput <TH VALIGN=CENTER ALIGN=CENTER  > Caso Esporàdico </TH>
   htput <TH VALIGN=CENTER ALIGN=CENTER  > p* </TH>
   htput <TH VALIGN=CENTER ALIGN=CENTER  > OR  </TH>
   htput <TH VALIGN=CENTER ALIGN=CENTER  > PR</TH>
   htput </TR>
   htput <TR>
   htput <TH VALIGN=CENTER ALIGN=CENTER  > (n=13), n(%)</TH>
   htput <TH VALIGN=CENTER ALIGN=CENTER  > (n=29) ,n (%)</TH>
   htput <TH VALIGN=CENTER ALIGN=CENTER  >  </TH>
   htput <TH VALIGN=CENTER ALIGN=CENTER  > (IC95%)  </TH>
   htput <TH VALIGN=CENTER ALIGN=CENTER  > (IC 95%) </TH>
   htput </TR>
   
  
  
  local tot=_N
  
 forvalues i=1(1)`tot' {
 
 local etiq=var1[`i']
 local cas_exp=cas_exp[`i']
 local nocas_exp=nocas_exp[`i']
 local cas_noexp=cas_noexp[`i']
 local nocas_noexp=nocas_noexp[`i']
 
local cas_famil: disp  " `cas_exp'("%5.1f (`cas_exp'/13)*100 "%)"
local cas_espor: disp  " `cas_noexp'("%5.1f (`cas_exp'/29)*100 "%)"
 cci `cas_exp' `cas_noexp' `nocas_exp' `nocas_noexp' , exact tb
 
 local pval: disp %5.3f r(p_exact)
 
 local or: disp  %5.2f r(or) "(" %5.2f r(lb_or) "-" %5.2f r(ub_or) ")"
 disp in yellow "`or'"
 
  csi `cas_exp' `cas_noexp' `nocas_exp' `nocas_noexp' , exact tb
 

 
 local rr: disp  %5.2f r(rr) "(" %5.2f r(lb_rr) "-" %5.2f r(ub_rr) ")"
 disp in yellow "`rr'"
 
 
  htput <TR>
     htput <TD VALIGN=CENTER ALIGN=CENTER  >  `etiq' </TD>
   htput <TD VALIGN=CENTER ALIGN=CENTER  > `cas_famil'</TD>
   htput <TD VALIGN=CENTER ALIGN=CENTER  > `cas_espor'</TD>
   htput <TD VALIGN=CENTER ALIGN=CENTER  >`pval' </TD>
   htput <TD VALIGN=CENTER ALIGN=CENTER  >  `or' </TD>
   htput <TD VALIGN=CENTER ALIGN=CENTER  > `rr' </TD>
   htput </TR>
 
  }
  
  htput </TABLE>
  
  htclose