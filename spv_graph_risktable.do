*gen origen=130
stset   diasgestacion_parto, time0( diasdegestacin_random) origin(origen)


label define t 0"130" ///
10"140" ///
20"150" ///
30"160" ///
40"170" ///
50"180" ///
60"190" ///
70"200" ///
80"210" ///
90"220" ///
100"230" ///
110"240" ///
120"250" ///
130"260" ///
140"270" ///
150"280" ///
160"290" ///
170"300" ///
180"310" , modify
label val _t t 
sts graph, by(tiporandom) risktable(,size(vsmall) order(1 "No treatment" 2 "Pessary") title(N at risk,size(small))) xlabel(0(10)180, valuelabel labsize(vsmall)) title(Kaplan Meier curves) ///
legend( label(1 "No treatment" ) label(2 "Pessary") size(small)) ylabel(,labsize(small) angle(horizontal)) xtitle("Duration of pregnancy (Days)",size(small)) plot1opts(lpattern("-") )                                                                                                                                                          
