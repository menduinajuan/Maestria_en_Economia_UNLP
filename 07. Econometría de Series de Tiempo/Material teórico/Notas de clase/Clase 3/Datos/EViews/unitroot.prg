'Magdalena Cornejo
UNLP 2019
'Simulando procesos no estacionarios

'create workfile
wfcreate unitroot u 1 100

'set seed for random number generator
'rndseed 123456

'Ejemplo 1: Tendencia determinística
genr e=nrnd 'Genera una N(0,1)
genr y1=5+0.2*@trend+e

'Ejemplo 2: Tendencia estocástica
genr y2=0
smpl @first+1 @last
genr y2=y2(-1)+e      'random walk

'Ejemplo 3: y=phi*y(-1)+e
smpl @all 
'Para phi=0.8
genr y3=0
smpl @first+1 @last
genr y3=0.8*y3(-1)+e
'Para phi=1
smpl @all 
genr y4=0
smpl @first+1 @last
genr y4=y4(-1)+e
'Para phi=1.05
smpl @all 
genr y5=0
smpl @first+1 @last
genr y5=1.05*y5(-1)+e

'Ejemplo 3: Tipos de Randow Walk

'Random Walk (puro)
smpl @all 
genr x1=0
smpl @first+1 @last
genr x1=x1(-1)+e

'Random Walk + Constante
smpl @all 
genr x2=0
smpl @first+1 @last
genr x2=2+x2(-1)+e

'Random Walk + Tendencia Lineal
smpl @all 
genr x3=0
smpl @first+1 @last
genr x3=2+0.1*@trend+x3(-1)+e


