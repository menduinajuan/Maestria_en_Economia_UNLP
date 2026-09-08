'News Impact Curve Example for EGARCH(1,1) Model

'Obtaining a feasible curve depends on the significance of parameter values,
'which you may fail to obtain in each run.

'*************************************************************************************
'THIS SECTION SIMULATES AND ESTIMATES AN EGARCH(1,1) MODEL
'*************************************************************************************

'Decide a range and create a workfile
!range = 200
wfcreate u !range

'Assign initial values to series
smpl @first @first
series res = 1
series gar =1
series y = 1

'Simulate an EGARCH(1,1) model
coef(5) theta
theta(1) = 2
theta(2) = .1
theta(3) = .5
theta(4) = .3   'You can change this value or its sign to see the differences in the assymetric effect.
theta(5) = .6

for !i=1 to !range-1
  smpl !i+1 !i+1
  gar = exp(theta(2) + theta(3)*@abs(res(-1)/gar(-1)) + theta(4)*(res(-1)/gar(-1)) + theta(5)*log(gar(-1)))
  res = @sqrt(gar)*nrnd
  y = theta(1)+res
next

smpl @all
delete gar res

'Estimate the EGARCH(1,1) model with the above generated series
equation eq01.arch(1,1,egarch) y c

'Retrieve residuals, conditional variance and standardized errors
eq01.makeresids res_eq
eq01.makegarch gar_eq
series z = res_eq/@sqrt(gar_eq)

'Replace the estimated coefficent values with the old ones.
for !i=1 to eq01.@ncoef
  theta(!i) = eq01.@coef(!i)
next

'*************************************************************************************
'THIS IS THE ACTUAL PART THAT GENERATES THE NEWS IMPACT CURVE
'*************************************************************************************
!uvar = @mean(gar_eq) 'An estimate of unconditional variance
!np = 100 'Number of points
!lb =-2*@round(@max(@abs(z))) 'Lower bound
!ub =2*@round(@max(@abs(z))) 'Upper bound
!s = (!ub-!lb)/(!np-1) 'Step size
matrix(!np,2) nic 'Generate a matrix to store the components

'First observations of standardized error and conditional variance
nic(1,1)=!lb
nic(1,2)=exp(theta(2) + theta(3)*@abs(!lb-!s) + theta(4)*(!lb-!s) + theta(5)*log(!uvar))

'Generate the components, columns being the standardized error and conditional variance, respectively.
for !i=2 to !np
   nic(!i,1) = !lb+(!i-1)*!s
   nic(!i,2) = exp(theta(2) + theta(3)*@abs(nic(!i-1,1)) + theta(4)*(nic(!i-1,1)) + theta(5)*log(!uvar))
next

'Plot the News Impact Curve (NIC)
nic.xypair

delete gar_eq res_eq z
