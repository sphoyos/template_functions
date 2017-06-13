
fs $orig\*.xls* 
foreach f in `r(files)' {
    local tblexcel: disp "\$orig\\`f'"
    import excel using `tblexcel', describe
    forvalues s = 1/`r(N_worksheet)' {
	    if  "`r(range_`s')'" !="" {
	            import excel using `tblexcel',         ///
                      sheet(`r(worksheet_`s')')   ///
                      cellrange(`r(range_`s')')   ///
                      firstrow clear llstring case(lower)
	   		    local tbldta: disp "\$dta\\`r(worksheet_`s')'"
                if  "`r(worksheet_`s')'"=="Hoja1" local tbldta: disp "\$dta\\`f'"
				disp in yellow "`tbldta'" 
                save `tbldta', replace
		    }
        }   
    } 