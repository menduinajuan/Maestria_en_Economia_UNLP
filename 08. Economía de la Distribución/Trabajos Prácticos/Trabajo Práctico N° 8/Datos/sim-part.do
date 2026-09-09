args nombre m_shk agemin agemax

local n_rows=rowsof(`m_shk')
local n_cols=colsof(`m_shk')

if `n_rows'!=$n_gender {
	display as error "error in number of rows"
	exit 198
}

if `n_cols'!=$n_ocup {
	display as error "error in number of columns" 
	exit 198
}

matrix define m_sim=`m_shk'

matrix aux=m_sim*J(`n_cols',1,1)

generate sampsel=1 if (sampocup==1 & edad>=`agemin' & edad<=`agemax')

preserve

table gender ocup [w=pondiio] if (sampsel==1), replace
reshape wide table1, i(gender) j(ocup)
egen tot=rowtotal(table1*)

forvalues i=1(1)$n_ocup {
	generate shr`i'=table1`i'/tot
}

egen shrtot=rowtotal(shr*)

mkmat shr?, matrix(m_obs)

restore

matrix define m_chg=m_sim-m_obs
matrix list m_chg

generate tomove=.

forvalues i=1(1)$n_gender {

	forvalues j=1(1)$n_ocup {

		display as text "i (gender) = " as result `i' _newline as text "j (ocup) = " as result `j'

		summarize pondiio if (sampsel==1 & gender==`i'), meanonly
		local obstot=r(sum)
		display as text "obtot = " as result `obstot'

		gsort -sampsel gender ocup -pr`j' rnd

		generate shrpop=sum(pondiio) if (sampsel==1 & gender==`i' & ocup==`j')
		replace shrpop=shrpop/`obstot'

		summarize shrpop, meanonly
		display as text "obs share in [i=`i',j=`j'] = " as result r(max)

		replace tomove=1 if (shrpop>m_sim[`i',`j'] & shrpop!=.)

		drop shrpop

	}

}

generate ocup_sim=.

forvalues i=1(1)$n_gender {

	forvalues j=1(1)$n_ocup {

		display as text "i (gender) = " as result `i' _newline as text "j (ocup) = " as result `j'

		if m_sim[`i',`j']>m_obs[`i',`j'] {

			display as text "gender = " as result `i' as text " ocup = " as result `j' as text " ... expanding"

			replace ocup_sim=ocup if (gender==`i' & ocup==`j' & sampsel==1)

			generate aux=1 if (tomove==1 & gender==`i' & ocup!=`j' & pr`j'!=. & ocup_sim==.)
			gsort -aux -pr`j' rnd

			generate shrpop=sum(pondiio) if (sampsel==1 & gender==`i')
			summarize shrpop, meanonly
			replace shrpop=shrpop/r(max)

			replace ocup_sim=`j' if (shrpop<=m_chg[`i',`j'])

			drop shrpop aux

		}

		if m_sim[`i',`j']<m_obs[`i',`j'] {
			display as text "gender = " as result `i' as text " ocup = " as result `j' as text " ... shrinking"
		}

	}

}

replace ocup_sim=ocup if (ocup_sim==. & sampsel==1)

bysort gender: tabulate ocup ocup_sim if (sampsel==1)

tabulate gender ocup [iw=pondiio] if (sampocup==1), row

tabulate gender ocup_sim [iw=pondiio] if (sampocup==1), row

preserve

table gender ocup_sim [w=pondiio] if (sampsel==1), replace
reshape wide table1, i(gender) j(ocup_sim)
egen tot=rowtotal(table1*)

forvalues i=1(1)$n_ocup {
	generate shr`i'=table1`i'/tot
}

egen shrtot=rowtotal(shr*)

mkmat shr?, matrix(m_sim2)

restore

matrix list m_sim
matrix list m_sim2
matrix define m_chg2=m_sim2-m_sim
matrix list m_chg2

tabulate ocup_sim, generate(ocupdum_sim)

rename (ocupdum?) (ocupdum?_aux)

rename (ocupdum_sim?) (ocupdum?)

do genera-ing-laboral "`nombre'"

replace ila_`nombre'=ila if (ocup_sim==ocup)

replace ila_`nombre'=. if (ocup_sim==1 & sampsel==1)

drop ocupdum?
rename (ocupdum?_aux) (ocupdum?)

do genera-ing-familiar "`nombre'"

rename ocup_sim occup_`nombre'

drop sampsel tomove