matrix define A=(1,2,3\4,5,6)
matrix list A
display A [1,3]
local b=2
display A [`b',3]

set obs 100
generate q=runiform()
mkmat q, matrix(matq)
matrix list matq