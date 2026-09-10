capture program drop fgt

program define fgt, rclass byable(recall)
syntax varlist (max=1 numeric) [iweight] [if], Alpha(real) Zeta(string)
display "varlist:`varlist'" _newline "weight:`weight'" _newline "exp:`exp'"

quietly {

preserve

*touse=1 -> observación si cumple if & !=.
*touse=0 -> observación no cumple if | ==.

marksample touse
keep if (`touse'==1)

local wt: word 2 of `exp'

if ("`wt'"=="") {
	local wt=1
}

tempvar each
generate `each'=(1-`varlist'/`zeta')^`alpha' if (`varlist'<`zeta')
replace `each'=0 if (`each'==. & `varlist'!=.)
summarize `each' [`weight' `exp']
local fgt=(r(sum)/r(sum_w))*100

restore

}

display as text "FGT (alpha=`alpha', z=`zeta') = " as result `fgt'
return scalar fgt=`fgt'

end