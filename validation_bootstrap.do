*------------------------------------- begin example
-------------------------------------
// data preparation
webuse nhefs, clear
stset age_lung_cancer if age_lung_cancer < . [pw=swgt2], fail(lung_cancer) gen byte married = marital_status == 2 if marital_status < .
gen byte black = revised_race == 3 if revised_race < .
tempfile orig
save `orig'

// preparations for the loop
tempfile results
tempname b memhold
local vars "former_smoker smoker male urban1 rural married black"
postfile `memhold' `vars' using `results'
local k = 20
_dots 0, title(Selecting varialbes in bootstrap samples) reps(`k')

// k (in this case 20) bootstrap samples forvalues i = 1/`k' {
	// get the bootstrap sample and estimate model
	use `orig', clear
	bsample
	capture stepwise, pr(.15) pe(.05) forward : stcox `vars'

	// gives you something to look at while the loop is running
	nois _dots `i' `=_rc'
	
	// get names of included variables
	matrix `b' = e(b)
	local incl : colnames `b'
	
	// reset local res to empty
	local res ""
	
	// a variable gets a 1 if included and a 0 when not
	foreach var of local vars {
		if `: list var in incl' {
			local res "`res' (1)"
		}
		else {
			local res "`res' (0)"
		}
	}
	
	// post those results
	post `memhold' `res'
}
postclose `memhold'

// look at the results
use `results', clear
sum
list