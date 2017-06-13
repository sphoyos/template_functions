
 stset At30 , f(new_exitus==1)
 sts test TRATAMIENTO_DEFINITIVO
 sts graph, by(TRATAMIENTO_DEFINITIVO ) f  xlabel(0(5)30) censored(single) risktable(, order(1 "t1" 2 "t2" 3 "t3" 4 "t4" 5 "t5") size(vsmall) title(,size(small)  at(rowtitle)))   ///
 plot1opts(lpattern(solid)) plot2opts(lpattern(.-)) plot3opts(lpattern(...---)) plot4opts(lpattern(dot)) plot5opts(lpattern(---)) ///
 legend( label(1 "treat1") label(2 "treat2") label(3 "treat3") label(4 "treat4") label(5 "treat5") rows(1) ) note(log_rank p value<0.001)
 