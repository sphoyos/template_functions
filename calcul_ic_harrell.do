
capture program drop harrell
program define harrell, rclass
	xi:stcox edat i.ecg, efron
	estat concordance
	return scalar c = r(C)
end
bootstrap c=r(c), reps(1000): harrell
