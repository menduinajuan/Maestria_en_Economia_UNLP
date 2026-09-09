capture program drop fgt_bs

program define fgt_bs, rclass byable(recall)
syntax varlist (max=1 numeric), Alpha(real) Zeta(string) Weight(varname)
display "varlist:`varlist'" _newline "weight:`weight'" _newline "exp:`exp'"

quietly {

local wt="`weight'"

tempvar each
generate `each'=(1-`varlist'/`zeta')^`alpha' if (`varlist'<`zeta')
replace `each'=0 if (`each'==. & `varlist'!=.)
summarize `each' [weight=`wt']
local fgt=(r(sum)/r(sum_w))*100

}

display as text "FGT (alpha=`alpha', z=`zeta') = " as result `fgt'
return scalar fgt=`fgt'

end