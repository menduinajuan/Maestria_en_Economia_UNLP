*MAGDALENA CORNEJO
*SERIES DE TIEMPO 2019
*UNLP

use trends
tsset year, yearly

gen time = _n

gen lrpcgdpus = ln(rpcgdpus)
gen lrpcgdpuk = ln(rpcgdpuk)

*GRAFICOS:

reg temps year
predict tempshat

twoway (tsline temps) (tsline tempshat), ytitle(Degrees Celsius) ttitle(Year) tscale(range(1900 2012)) tlabel(#8) title(Annual Averaged Global Temperatures (Land and Sea)) legend(order(1 "Temperatures" 2 "Fitted Linear Time Trend"))

graph export "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 3\STATA\temps.emf", as(emf) replace

twoway (tsline lrpcgdpus), ytitle(Log Real Per Capita GDP) ttitle(Year) tscale(range(1900 2012)) tlabel(#8) title(Log Real Per Capita GDP: United States) legend(order(1 "log(rpcgdpus)"))

graph export "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 3\STATA\lpcgdpus.emf", as(emf) replace

twoway (tsline lrpcgdpuk), ytitle(Log Real Per Capita GDP) ttitle(Year) tscale(range(1900 2012)) tlabel(#8) title(Log Real Per Capita GDP: United Kingdom) legend(order(1 "log(rpcgdpuk)"))

graph export "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 3\STATA\lpcgdpuk.emf", as(emf) replace


twoway (tsline lrpcgdpus, yaxis(2)) (tsline lrpcgdpuk, yaxis(2)) (tsline temps), ytitle(Degrees Celsius) ytitle(Log Real Per Capita GDP, axis(2)) ttitle(Year) tscale(range(1900 2012)) tlabel(#8) title(Global Temperatures and Log of Real Per Capita GDP) legend(order(1 "log(rpcgdpus)" 2 "log(rpcgdpuk)" 3 "Temperatures"))

graph export "C:\Users\Magdalena Cornejo\Dropbox\UNLP\Clase 3\STATA\tempsusuk.emf", as(emf) replace

*ESTIMACIONES:


reg temps lrpcgdpus, robust
reg temps lrpcgdpus time, robust

reg temps time
predict rtemp1, res

reg lrpcgdpus time
predict rlrpcgdpus, res

reg rtemp1 rlrpcgdpus
reg rtemp1 rlrpcgdpus time

drop rtemp1

reg temps lrpcgdpuk, robust
reg temps lrpcgdpuk time, robust

reg temps time
predict rtemp1, res

reg lrpcgdpuk time
predict rlrpcgdpuk, res

reg rtemp1 rlrpcgdpuk
reg rtemp1 rlrpcgdpuk time
