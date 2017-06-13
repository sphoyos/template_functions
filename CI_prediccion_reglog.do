


** Calculo de 

xi:  logit   RVPERSIS  i.RVR i.EDADDONA i.IL28RECE, or
predict lr_index, xb
predict se_index, stdp



generate p_hat = exp(lr_index)/(1+exp(lr_index))

 gen lb = lr_index - invnormal(0.975)*se_index
 gen ub = lr_index + invnormal(0.975)*se_index
 gen plb = exp(lb)/(1+exp(lb))
 gen pub = exp(ub)/(1+exp(ub))
