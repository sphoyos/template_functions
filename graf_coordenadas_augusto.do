twoway scatter AVA_1 Q_1 || sc AVA_2 Q_2 || pcspike AVA_1 Q_1 AVA_2 Q_2



twoway scatter AVA_1 Q_1 if LOWFLOW==0, mcolor(red) || sc AVA_2 Q_2 if  LOWFLOW==0  , mcolor(red)|| pcspike AVA_1 Q_1 AVA_2 Q_2  if  LOWFLOW==0  , lcolor(red) ///
                   || scatter AVA_1 Q_1 if LOWFLOW==1, mcolor(blue) || sc AVA_2 Q_2 if  LOWFLOW==1  , mcolor(blue) || pcspike AVA_1 Q_1 AVA_2 Q_2  if  LOWFLOW==1  , lcolor(blue) ///
	               || scatter AVA_1 Q_1 if LOWFLOW==2, mcolor(olive) || sc AVA_2 Q_2 if  LOWFLOW==2  , mcolor(olive) || pcspike AVA_1 Q_1 AVA_2 Q_2  if  LOWFLOW==2  , lcolor(olive) ///
			       || scatter AVA_1 Q_1 if LOWFLOW==3, mcolor(magenta) || sc AVA_2 Q_2 if  LOWFLOW==3  , mcolor(magenta) || pcspike AVA_1 Q_1 AVA_2 Q_2  if  LOWFLOW==3  , lcolor(magenta) ///
				   || ,legend(order( 3 6 9 12) label(3 "AVA >1") label(6 "LFLG") label(9 "Severe") label(12 "True severe")) xtitle(Flow) ytitle(AVA)
				    
					
gen pdte= (AVA_2-AVA_1) / (Q_2-Q_1)
oneway pdte LOWFLOW, tabulate

