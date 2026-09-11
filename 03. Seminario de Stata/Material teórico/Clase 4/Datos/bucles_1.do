clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 4/Datos"


*Bucle 1*

local i=1
while `i'<=10 {
  display "i = `i'"
  local i=`i'+1
}

display "i = `i'"

*Bucle 2: Generar 10 variables que se distribuyen de manera uniforme entre 0 y 1*

set obs 10
local i=1
while `i'<=10 {
	generate x`i'=runiform()
	local i=`i'+1
}

*Bucle 3: Se puede hacer lo mismo con el forvalues (no es necesario generar la local anteriormente ni incluir el contador)*

forvalues i=1(1)10 {
	generate y`i'=runiform()
}

*Bucle 4*

foreach i of varlist x1-x10 {
	summarize `i'
	generate `i'_2=`i'*`i'
}

*Bucle 5*

local mylist="Juana Helena María"
foreach i of local mylist {
	display "i = `i'"
}