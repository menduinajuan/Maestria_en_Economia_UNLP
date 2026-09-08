*===================================================================*
* Maestria en Economia                                              *
* Facultad de Ciencias Economicas                                   *
* Universidad Nacional de La Plata                                  *
*-------------------------------------------------------------------*
* A consistent test of functional form via nonparametric estimation *
* techniques                                                        *
* from Zheng (1996)                                                 *
*                                                                   *
* Malena Arcidiacono        Dario Tortarolo                         *
* marcidiacono@cedlas.org   dtortarolo@cedlas.org                   *
* Date: 02-11-2012 (second draft)                                   *
*===================================================================*


capture program drop zheng
program define zheng, rclass

* Ejemplo: zheng food_sh lila lila2

  clear matrix
  qui set matsize 5000

	version 8.2
	syntax varlist(min=2 max=3) [if] [in] [,  ///
		XWidth(real 0.0) Saving(string) REPLACE] 

  local nvar : word count `varlist'

	local iy: word 1 of `varlist'
	local iyl: variable label `iy'
	local ix: word 2 of `varlist'
	local ixl: variable label `ix'

* solo para los casos en que se incluye un termino cuadratico
  if `nvar'==3 {
    local iz: word 3 of `varlist'
    local izl: variable label `iz'
  }
* si no se incluye termino cuadratico, la variable queda vacia (evita error posterior el usar regress)
  if `nvar'==2 {
    local iz = ""
  }

* si no trae label, le ponemos el nombre de la variable como label
	if `"`iyl'"'=="" { 
		local iyl "`iy'"
	}
  if `"`ixl'"'=="" { 
		local ixl "`ix'"
	}

* foto a la base de datos
  preserve

* armamos el codigo solo para un kernel gaussiano
	local kernel=`"Gaussian"'
	marksample use
	qui count if `use'
	if r(N)==0 { 
		error 2000 
	} 

* generamos este mensaje para que vea el usuario debido a que el test demora unos segundos
di _newline
di in red "Please wait for a while"
di in red "The test is running..."

* obtenemos el vector de errores de la estimacion parametrica
* --------------------------------------------------------------- Matriz eiej ---------------  
* hacemos regresiones parametrica (notar que no esta puesta la opcion de pweigth)
  qui {
    regress `iy' `ix' `iz' if `use', robust
    local ndim = e(N)
    keep if e(sample)
    predict double resid if `use', residuals
    gen resid2 = resid*resid

    mkmat resid, matrix(resid)
    matrix residT = resid'

    mkmat resid2, matrix(resid2)
    matrix resid2T = resid2'
  }
* crea matriz de NxN y la rellena de missings
  matrix Eij = J(`ndim',`ndim', .)
* obtenemos el producto de e_i*e_j
  matrix  Eij = resid*residT
  matrix  Eij2 = resid2*resid2T

  qui forv i = 1/`ndim' {
    matrix  Eij[`i',`i'] = 0
    matrix  Eij2[`i',`i'] = 0
  }
* --------------------------------------------------------------- Matriz e ---------------


* hacemos un summarize de nuestra variable de interes, guardamos su media y varianza
	quietly summ `ix' if `use', detail

* construimos el half-bandwidth optimo
	tempname xwwidth

* si especificamos un numero particular en la opcion XWidth(real 0.0)
	scalar `xwwidth' = `xwidth'
* si no especificamos nada en XWidth(real 0.0), que ponga el optimo
	if `xwwidth' <= 0.0 { 
		scalar `xwwidth' = min( sqrt(r(Var)), (r(p75)-r(p25))/1.349)
		scalar `xwwidth' = 0.9*`xwwidth'/(r(N)^.20)
	}

* calculamos la raiz de 2*pi
	local con1 = sqrt(2*_pi)


* obtenemos la matriz W(nxn) con ponderadores kernel gaussianos
* --------------------------------------------------------------- Matriz Wn ---------------
* calculamos matriz de phi_i de cada observacion con respecto al resto de las observaciones
* calculamos matriz de kernel gaussiano K(phi): elementos Wij

  qui forv i = 1/`ndim' {
    gen `ix'_`i' = (((`ix' - `ix'[`i']) / (`xwwidth'))^2)*(-0.5) if _n != `i'
    replace `ix'_`i' = exp(`ix'_`i') / `con1' if _n != `i'
  }
  mkmat `ix'_1-`ix'_`ndim', matrix(Kphi)
 
  qui forv i = 1/`ndim' {
    gen `ix'_`i'_2 = `ix'_`i'*`ix'_`i' 
  }
  mkmat `ix'_1_2-`ix'_`ndim'_2, matrix(Kphi2)

* ponemos ceros en la diagonal principal
  qui forv i = 1/`ndim' {
    matrix  Kphi[`i',`i'] = 0
    matrix  Kphi2[`i',`i'] = 0
   }
* --------------------------------------------------------------- Matriz Wn ---------------


* --------------------------------------------------------------- Numerador ---------------
* operaciones para armar numerador del estadistico Tn
  matrix A = Kphi * Eij
* Creamos una matriz B con la diagonal principal de la matriz A
  matrix BT = vecdiag(A)
  matrix B = BT'

* numerador del estadistico Tn
  svmat B, names(B)
  qui summ B
  if r(sum)>0 loc numerador = r(sum)
  if r(sum)<0 loc numerador = -r(sum)
* --------------------------------------------------------------- Numerador ---------------

* --------------------------------------------------------------- Denominador -------------
* operaciones para armar denominador del estadistico Tn
  matrix C = Kphi2 * Eij2
* Creamos una matriz D con la diagonal principal de la matriz C
  matrix DT = vecdiag(C)
  matrix D = DT'
  matrix D = D*2

* denominador del estadistico Tn
  svmat D, names(D)
  qui summ D
  loc denominador = sqrt(r(sum))
* --------------------------------------------------------------- Denominador -------------


* --------------------------------------------------------------- Estadistico Tn ----------
loc estadistico = `numerador'/`denominador' 
* --------------------------------------------------------------- Estadistico Tn ----------


* --------------------------------------------------------------- Zheng test --------------
* Critical values: the critical values for the test are from the standard normal table:
* for 1% significance level  = 2.576
* for 5% significance level  = 1.960
* for 10% significance level = 1.645

loc p_value = ttail(`ndim',`estadistico')*2
* --------------------------------------------------------------- Zheng test --------------

  restore 

	return local kernel "Gaussian"
	return local xvar "`ix'"
  ret scalar bwidth = `xwwidth'
  ret scalar numerador = `numerador'
  ret scalar denominador = `denominador'
  ret scalar estadistico = `estadistico'
  ret scalar p_value = `p_value'
  ret scalar observaciones = `ndim'


* REPORT OF THE RESULTS ++++++++++++++++++++++++++++++++++++++++++++++++

  tempvar indice_nombre indice_valor

  gen     `indice_valor'=.
  label variable `indice_valor' "Output"
  replace `indice_valor' = `estadistico' if _n==1  
  replace `indice_valor' = `p_value' if _n==2 
    
  gen     `indice_nombre'=.  
  label variable `indice_nombre' "Results of the Zheng (1996) test"
  replace `indice_nombre'=_n if `indice_valor'!=.
  
  label define `indice_nombre' /* 
    */ 1 "estadistico Tn --d-->  N(0,1)" /*
    */ 2 "p-value"
    label values `indice_nombre' `indice_nombre'
  
  tabdisp `indice_nombre', cellvar(`indice_valor') concise format(%6.4f) left center
	if `nvar'==2 display as text "Ho: linear parametric form"
  if `nvar'==3 display as text "Ho: quadratic parametric form" 
  display as text "Based on Zheng (1996) [A consistent test of functional form via nonparametric estimation techniques]"

end	