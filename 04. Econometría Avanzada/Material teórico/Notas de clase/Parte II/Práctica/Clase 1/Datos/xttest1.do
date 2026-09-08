*This version: 2/14/2001 by Walter Sosa Escudero and Anil Bera
program define xttest1, rclass
	version 6.0
	if "`e(cmd)'"!="xtreg" { error 301 }
	if "`e(model)'" != "re" {
		di in red "last estimates not xtreg, re"
		exit 301
	}
	if "`*'"!="" { error 198 }
      if "$S_E_Tcon" != "1" {
		di in red "panel not balanced"
		exit 301
       }
	tempvar touse e sum Ti elag em
	tempname cur Tn T ee LM1 LM2 LM3 LM4 LM5 LM6 LM7
	tempname SD SD1 A1 B1

	qui gen  byte `touse' =e(sample)
	
      _evlist
	local rhs "`s(varlist)'"
      sret clear
	local lhs "`e(depvar)'"
	local ivar "`e(ivar)'"

	estimate hold `cur'
	capture {
		regress `lhs' `rhs' if `touse'
		predict double `e' if `touse', resid
	}
	if _rc {
		estimate unhold `cur'
		error _rc
	}
	estimate unhold `cur'
	quietly {
            sort `e(ivar)'
		by `e(ivar)': gen double `sum' = cond(_n==_N,sum(`e')^2,.) 
		replace `sum' = sum(`sum')
		scalar `A1' = `sum'[_N]

		replace `sum' = sum(`e'^2)
            scalar `SD' = `sum'[_N]
            scalar `A1' = (`A1'/`SD')-1

		by `e(ivar)': gen double `elag' = `e'[_n-1]
            by `e(ivar)': gen double `em' = `e'
            by `e(ivar)': replace `em' = . if _n==1
		replace `sum' = sum(`em'^2)
		scalar `SD1' = `sum'[_N]
		replace `sum' = sum(`e'*`elag')
  	      scalar `B1' = `sum'[_N]/`SD1'
	}
	scalar `LM1'=scalar( S_E_nobs / (2*(S_E_T-1))  * (`A1'^2) )
      scalar `LM2'= scalar( S_E_nobs * S_E_T * `B1'^2 / (S_E_T-1) )
      scalar `LM3'=scalar((S_E_nobs *(2*`B1'-`A1')^2) / (2*(S_E_T-1)*(1-(2/S_E_T))))
	scalar `LM4'=scalar(`LM2'-`LM1' + `LM3')
      scalar `LM5'=scalar(`LM1'+`LM4')
      scalar `LM6'=scalar(sqrt(S_E_nobs / (2*(S_E_T-1))) * `A1')
      scalar `LM7'=scalar(sqrt( S_E_nobs/(2*( S_E_T-1) * (1-(2/S_E_T)) ))*(-2*`B1'+`A1'))
	#delimit ;
	di _n in gr 
	"Tests for the error component model:" ;
	di _n in gr _col(9) 
		"$S_E_depv[$S_E_ivar,t] = Xb + u[$S_E_ivar] + v[$S_E_ivar,t]" _n
              _col(12) "v[$S_E_ivar,t] = rho v[$S_E_ivar,(t-1)] + e[$S_E_ivar,t]";

	di _n in gr _col(9) "Estimated results:" _n
		_col(34) "Var" _col(42) "sd = sqrt(Var)" _n 
		_col(17) "---------+" _dup(29) "-" ;
		
	qui summ $S_E_depv if `touse' ;
	local skip = 9 - length("$S_E_depv") ;
	di _col(16) _skip(`skip') in gr "$S_E_depv |  " in ye
		%9.0g _result(4) _skip(6) %9.0g sqrt(_result(4)) ;
	di _col(24) in gr "e |  " in ye 
		%9.0g scalar(S_E_eit)^2 _skip(6) scalar(S_E_eit) ;
	di _col(24) in gr "u |  "  in ye 
		%9.0g scalar(S_E_ui)^2 _skip(6) scalar(S_E_ui) ;

	di _n in gr _col(9) "Tests:" _n 
		_col(12) in blue "Random Effects, Two Sided:" _n in gr
		_col(12) "LM(Var(u)=0)       =" in ye %8.2f `LM1' in gr 
		_col(43) "Pr>chi2(1) = " in ye %7.4f 
		chiprob(1,`LM1') in gr _n

		_col(12) "ALM(Var(u)=0)      =" in ye %8.2f `LM3' in gr 
		_col(43) "Pr>chi2(1) = " in ye %7.4f 
		chiprob(1,`LM3') in gr _n _n
		
		_col(12) in blue "Random Effects, One Sided:" _n in gr
		_col(12) "LM(Var(u)=0)       =" in ye %8.2f `LM6' in gr 
		_col(43) "Pr>N(0,1)  = " in ye %7.4f 
		1-normprob(`LM6') in gr _n

		_col(12) "ALM(Var(u)=0)      =" in ye %8.2f `LM7' in gr 
		_col(43) "Pr>N(0,1)  = " in ye %7.4f 
		1-normprob(`LM7') in gr _n _n

		_col(12) in blue "Serial Correlation:" _n in gr
		_col(12) "LM(rho=0)          =" in ye %8.2f `LM2' in gr 
		_col(43) "Pr>chi2(1) = " in ye %7.4f 
		chiprob(1,`LM2') in gr _n

		_col(12) "ALM(rho=0)         =" in ye %8.2f `LM4' in gr 
		_col(43) "Pr>chi2(1) = " in ye %7.4f 
		chiprob(1,`LM4') in gr _n _n

		_col(12) in blue "Joint Test:" _n in gr
		_col(12) "LM(Var(u)=0,rho=0) =" in ye %8.2f `LM5' in gr 
		_col(43) "Pr>chi2(2) = " in ye %7.4f 
		chiprob(2,`LM5') in gr _n;



#delimit cr
	global S_1 = `LM1'
	global S_2 = `LM3'
	global S_3 = `LM6'
	global S_4 = `LM7'
	global S_5 = `LM2'
	global S_6 = `LM4'
	global S_7 = `LM5'
end
exit