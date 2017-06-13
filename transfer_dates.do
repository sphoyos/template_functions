
foreach data in datanaixement  datatph fechaviremia1  fechanegativizacinviremia  dataexitus   ///
                 dataltimseguiment fechamximaviremia fechaenfermedadadv {
				
    local nomvar: var label `data' 
    if   `"`nomvar'"' == "" local nomvar = "`data'"				
	if strpos("`data'", "fecha")!=0  local varname="data_"+substr("`data'",6,4)
    if strpos("`data'", "data")!=0  local varname="data_"+substr("`data'",5,4)
 
   local formvar: format `data'
   if substr("`formvar'" ,1,2)=="%t"{
        ren `data' `varname'  
	    format `varname' %dD_m_CY
        label var `varname' "`nomvar'"
     }
	 else {
        gen `varname' = mdy(real(substr(`data'   ,4,2)), real(substr( `data'   ,1,2)) ,real(substr( `data'    ,7,4)))
	    format `varname' %dD_m_CY
        label var `varname' "`nomvar'"
	    order `varname', before(`data')
	    drop `data'
	}	
}	

