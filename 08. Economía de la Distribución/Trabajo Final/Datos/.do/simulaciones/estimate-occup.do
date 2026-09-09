local yvar="ocup"
local xvar edad edad2 hombre jefe pric seci secc supi supc miembros_h

mlogit `yvar' `xvar' [pw=fex_c] if (muestra==1), baseoutcome(1)

matrix define lambda=e(b)
matrix list lambda
matrix lambda21=lambda[1,"2:"]
matrix lambda31=lambda[1,"3:"]
generate sampocup=1 if (e(sample))

matrix score xlambda21=lambda21
matrix score xlambda31=lambda31

sort rnd

generate r21_cal   =.
generate r31_cal   =.
generate draw_e1   =.
generate draw_e2   =.
generate draw_e3   =.
generate r21       =.
generate r31       =.
generate delta_u21 =.
generate delta_u31 =.
generate y_sim	   =.

generate cal=0
replace cal=1 if (sampocup!=1)
count if (cal==0)
local tot=r(N)
local cnt=0

while `tot'!=0 {

	local cnt=`cnt'+1

	replace draw_e1=-ln(-ln(1-runiform())) if (cal==0)
	replace draw_e2=-ln(-ln(1-runiform())) if (cal==0)
	replace draw_e3=-ln(-ln(1-runiform())) if (cal==0)

	replace r21=draw_e2-draw_e1 if (cal==0)
	replace r31=draw_e3-draw_e1 if (cal==0)

	replace delta_u21=xlambda21+r21 if (cal==0)
	replace delta_u31=xlambda31+r31 if (cal==0)

	replace y_sim=1 if (delta_u21<=0         & delta_u31<=0         & cal==0)
	replace y_sim=2 if (delta_u21>0          & delta_u31<=delta_u21 & cal==0)
	replace y_sim=3 if (delta_u21<=delta_u31 & delta_u31>0          & cal==0)
	replace y_sim=. if (sampocup==0)

	replace r21_cal=r21 if (y_sim==`yvar' & cal==0)
	replace r31_cal=r31 if (y_sim==`yvar' & cal==0)

	replace cal=1 if (y_sim==`yvar' & cal==0)

	summarize cal if (sampocup==1)

	if (100*r(mean)>95) {
		replace sampocup=0 if (sampocup==1 & cal==0)
		replace cal=1
	}

	count if (sampocup==1 & cal==0)
	local tot=r(N)

}

tabulate ocup y_sim if (sampocup==1)

generate pr1=exp(0)         / (1+exp(xlambda21)+exp(xlambda31))
generate pr2=exp(xlambda21) / (1+exp(xlambda21)+exp(xlambda31))
generate pr3=exp(xlambda31) / (1+exp(xlambda21)+exp(xlambda31))

generate ut1=0
generate ut2=xlambda21+r21_cal
generate ut3=xlambda31+r31_cal

generate y_sim2=.
replace y_sim2=1 if (ut1==max(ut1,ut2,ut3))
replace y_sim2=2 if (ut2==max(ut1,ut2,ut3))
replace y_sim2=3 if (ut3==max(ut1,ut2,ut3))

tabulate ocup y_sim2 if (sampocup==1)