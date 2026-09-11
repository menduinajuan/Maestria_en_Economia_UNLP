clear all
set more off

*local disco="C:/"
local disco="G:/Mi unidad"
cd "`disco'/JM/Facultad de Ciencias Económicas (FCE)/Maestría en Economía/3. Seminario de Stata/Material teórico/Clase 4/Datos"


*Crear una matriz vacía*

matrix define A=J(3,2,.)

*Visualizar el contenido de una matriz*

matrix list A

*Crear una matriz con su contenido*

matrix define B=(1,2\3,4)
matrix list B

*Asignar valores a celdas particulares de la matriz*

matrix B [2,1]=500
matrix list B

matrix define H=B'
matrix list B
matrix list H

*Mostrar las matrices existentes*

matrix dir

*Operaciones con matrices (1)*

matrix define C1=J(3,1,1)
matrix define C2=J(3,1,2)
matrix define Csum=C1+C2
matrix list C1
matrix list C2
matrix list Csum

*Operaciones con matrices (2)*

matrix define P=(1\4)
matrix define Q=(5,2)
matrix list P
matrix list Q

matrix define R=Q*P
matrix define S=P*Q
matrix list R
matrix list S

matrix define T=(1\4\8)
matrix define U=T*Q
matrix list T
matrix list Q
matrix list U

*Vincular dos matrices (agregar filas)*

matrix define C3=C1\C2
matrix list C1
matrix list C2
matrix list C3

*Vincular dos matrices (agregar columnas)*

matrix define C4=C1,C2
matrix list C1
matrix list C2
matrix list C4

*Eliminar matrices*

matrix dir
matrix drop B
matrix dir