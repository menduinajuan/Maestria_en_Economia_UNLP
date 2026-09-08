*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2018
*UNLP

**GARCH

clear all
import excel "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 6\Excel\garch.xlsx", sheet("Sheet1") firstrow

gen mes=monthly(month,"YM")
format mes %tm

tsset mes
tsline fspcom

gen lfspcom=ln(fspcom)
gen R=D.lfspcom

tsline R

arch R, arch(1/1) garch(1/1) nocon


