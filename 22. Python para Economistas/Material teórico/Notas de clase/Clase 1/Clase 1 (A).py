############################################################
						# CLASE 1 #
############################################################


##### 1. DATOS NUMÉRICOS, DE TEXTO Y BOOLEANOS


# CARÁCTERES

print("A")
print("t")
print('r')
print("1")

# CADENAS DE CARÁCTERES

print('Hola!')
print('Nos, los representantes del pueblo de la')

# LÓGICO

print('texto'=='texto')
print('texto'!='texto')
print(256<76)
print(256>=76)
print(256>=256)

# PREGUNTAS

print(17==17.0)
print(524=='524')
print("Argentina"=='Argentina')
print('Argentina'=='ARGENTINA')


##### 2. OPERACIONES BÁSICAS


# SUMAR Y RESTAR

print(100+45)
print(100.5-12.3)
suma_mins=15+60
suma_mins+=60

# MULTIPLICAR Y DIVIDIR

print(10.1*3)
print(80/4)

# EXPONENCIAL

print(12**2)

# COCIENTE DE UNA DIVISIÓN

print(10.0//4)

# MÓDULO (RESTO DE UNA DIVISIÓN)

print(5%2)
print(10%2)
print(4.5%2)

# CONCATENAR (SUMAR)

print('Esto es '+'concatenar dos strings')
print('a'+'bb'+'ccc')

# REPETIR (MULTIPLICAR)

print('Muy bueno!'*2)


##### 3. OPERADORES LÓGICOS


4<7 and 4>1
4==1 or 4>1
4==1 or 4>9
not(4==1)


##### 4. INTERLUDO: DEFINICIÓN DE VARIABLES


# VARIABLES

mivariable="a"
print(mivariable)
a=100
b=17
print(a+b)

nombre_universidad="Universidad de San Andrés"
print(nombre_universidad)

# PREGUNTAS

#print(12+"34")
resultado="a"
RESULTADO="B"
print(resultado); print(RESULTADO)
#2variable="a"
#mi-variable="a"
mi__var_iab_="a"


##### 5. COLECCIONES: LISTAS, TUPLAS, SETS Y DICCIONARIOS


# LISTAS

paises=['ARG','BOL','BRA','CHL','PRY','URY']
pob_m=[44939,11513,211050,18952,7045.5,3462]
print(len(paises))
print(paises[0])
print(pob_m[-1])

print(paises[:])
print(paises[4:])
print(paises[:3])
print(paises[2:-2])

pob_m[-2]=7045
print(pob_m)

paises.append('PER')
pob_m.insert(pob_m[-1],31989)
print(pob_m)
print(paises[-1],'-->',pob_m[-1])

paises2=['COL','ECU','GUY','SUR','TTO','VEN']
paises.extend(paises2)
print(paises)

paises.remove('COL')
print(paises.pop(-1))
del paises[-4:]
print(paises)

paises_sa=paises2
paises_sa.append('ARG')
print(paises_sa)
print(paises2)

paises2.remove('ARG')
paises_sa=paises2.copy()
paises_sa.extend(paises)
print(paises2)
print(paises_sa)

pob_tot=0
for pob in pob_m:
	pob_tot+=pob
print(pob_tot)

for n, pais in enumerate(paises):
	print(pais,':',pob_m[n])

# PREGUNTAS

print(paises+pob_m)
#paises.append(pob_m)
print(paises)
paises.extend(pob_m)
print(paises)

# TUPLAS

argentina=('ARG',44939)
bolivia=('BOL',11513)
brasil=('BRA',211050)

#argentina[0]='ARGEN'

argentina=('ARG',44939,22947)
bolivia=('BOL',11513,9086)
brasil=('BRA',211050,15259)

print(len(brasil))

print(bolivia[0])
print(bolivia[1])

print(argentina[:])
print(argentina[1:])
print(argentina[:2])

# SETS

chl_limit=set(['ARG','BOL','PER'])
paises=['ARG','BOL','BRA','CHL','PRY','URY']
arg_limit=set(paises)
print(arg_limit)
print(type(arg_limit))
print(len(chl_limit))

#chl.limit[:]
#chl_limit[-2]='AAA'

arg_limit.add('ARG')
chl_limit.add('CHL')

ar_cl_limit=arg_limit.union(chl_limit)
print(ar_cl_limit)

arg_limit.remove('ARG')
chl_limit.discard('CHL')
#print(arg_limit.pop())
arg_limit.add('URY')

print(arg_limit.difference(chl_limit))
print(arg_limit.intersection(chl_limit))

print(chl_limit.issubset(arg_limit))
print(chl_limit.isdisjoint(arg_limit))

pry_limit=arg_limit
#pry_limit.remove('CHL')
print(arg_limit)

pry_limit=arg_limit.copy()
pry_limit.remove('CHL')
print(arg_limit)

# PREGUNTAS

print(pry_limit)
temp1=pry_limit.remove('URY')
temp2=pry_limit.pop()
print(temp1); print(temp2)

# DICCIONARIOS

arg_carac={'cod':'ARG','pob':44939,'gdp':'N'}
bol_carac={'cod':'BOL','pob':11513,'gdp':'N'}

print(len(bol_carac))

print(bol_carac['cod'])
print(arg_carac['pob'])

arg_carac['gdp']=1031215
bol_carac['gdp']=104609

arg_carac['gdp_pc']=arg_carac['gdp']/arg_carac['pob']*100
print(arg_carac)

arg_carac.pop('gdp_pc')
print(arg_carac)

print(bol_carac.keys())
print(bol_carac.values())
print(bol_carac.items())
print('cod' in bol_carac.keys())

#arg_carac['gdp_pc']
#bol_carac['gdp_pc']
print(bol_carac.get('gdp_pc','No value'))

print(paises)
info_paises=dict.fromkeys(paises,"")
print(info_paises)

print(pob_m)
poblacion=dict(zip(paises,pob_m))
print(poblacion)

bra_carac={'cod':'BRA','pob':211050,'gdp':3220373}
chl_carac={'cod':'CHL','pob':18952,'gdp':476738}
pry_carac={'cod':'PRY','pob':7045,'gdp':93062}
ury_carac={'cod':'URY','pob':3462,'gdp':77732}

paises_info={'argentina':arg_carac,'bolivia':bol_carac,'brasil':bra_carac,'chile':chl_carac,'paraguay':pry_carac,'uruguay':ury_carac}
print(paises_info['brasil']['gdp'])

# PREGUNTA

set_arg_carac=set(arg_carac)
print(set_arg_carac)


##### 6. SENTENCIAS CONDICIONALES Y CICLOS


lista_paises=['Argentina','Bolivia','Chile']
for pais in lista_paises:
	print('Nombre: ' +pais)

for n, pais in enumerate(lista_paises):
	print(n,':',pais)

for n, pais in enumerate(paises):
	print(pais,':',pob_m[n])

cupos_libres=3
while cupos_libres>0:
	print('Inscripción aceptada')
	cupos_libres-=1
print('Cupo lleno')

pob_tot=0
for pob in pob_m:
	pob_tot+=pob
print(pob_tot)

edad=25
if edad<18:
	print('Menor de edad')
elif edad>=18 and edad<=30:
	print('Mayor de edad')
else:
	print('No se admiten Mayores de 30')

listado_numeros=[10,11,12,13]
for numero in listado_numeros:
	if numero%2==0:
		print(numero,'es par')
	else:
		print(numero,'es impar')