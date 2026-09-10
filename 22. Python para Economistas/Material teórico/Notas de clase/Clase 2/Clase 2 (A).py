############################################################
						# CLASE 2 #
############################################################


##### 1. FUNCIONES


def gdp_per_capita(gdp,poblacion):
	gdp_pc=round(gdp*1000/poblacion)
	return gdp_pc

print(gdp_per_capita(77732,3462))
#gdp_per_capita(ury_carac['gdp'],ury_carac['pob'])

def gdp_per_capita(gdp,pob,gdp_billon=False):
	if gdp_billon:
		gdp_pc=round(gdp*1000000/pob)
	else:
		gdp_pc=round(gdp/pob)
	return gdp_pc

print(gdp_per_capita(445445000000,44938712))
print(gdp_per_capita(445445,44938712,True))

def gdp_per_capita(gdp,pob,gdp_billon=False,gdp_millon=False):
	if gdp_billon:
		gdp_pc=round(gdp*1000000/pob)
	elif gdp_millon:
		gdp_pc=round(gdp*1000/pob)
	else:
		gdp_pc=round(gdp/pob)
	return gdp_pc

print(gdp_per_capita(445445000000,44938712))
print(gdp_per_capita(445445,44938712,True,False))
print(gdp_per_capita(445445000,44938712,gdp_millon=True))

# DOCSTRING

def gdp_per_capita(gdp,poblacion):
	'''
	Esta función calcula el GDP per cápita
	Input:
		gdp(int): el GDP de un país X
		poblacion(int): la población de un país X
	Output:
		gdp_pc(int): el gdp per cápita del país X
	'''
	gdp_pc=round(gdp/poblacion*1000)

help(gdp_per_capita)

# PREGUNTA

paises_info={'argentina':{'cod':'ARG','pob':44939,'gdp':1031215},'bolivia':{'cod':'BOL','pob':11513,'gdp':104609},'brasil':{'cod':'BRA','pob':211050,'gdp':3220373},'chile':{'cod':'CHL','pob':18952,'gdp':476738},'paraguay':{'cod':'PRY','pob':7045,'gdp':93062},'uruguay':{'cod':'URY','pob':3462,'gdp':77732}}
print(paises_info)

for pais in paises_info:
	print(pais,':',paises_info[pais])
#	paises_info[pais['gdp_pc']]=gdp_per_capita(paises_info[pais['gdp']],paises_info[pais['pob']])

print(paises_info)

# ÁMBITO INTERNO VS. ÁMBITO GLOBAL

a=3
def suma_uno(numero):
	a=numero+1
	print(a)
suma_uno(10)
print(a)

# PREGUNTA

gdp_arg=1031215
gdp_uru=77732
gdp_regional=gdp_arg+gdp_uru

def suma_gdp(gdp_regional,gdp_pais):
 	gdp_regional+=gdp_pais
 	print(gdp_regional)

print(gdp_regional)
gdp_pry=93062

suma_gdp(gdp_regional,gdp_pry)
print(gdp_regional)


##### 2. MANEJO DE ERRORES


def suma_uno(num):
	'''
	Reciibe un número y devuelve ese número más uno
	'''
	return num+1
print(suma_uno(1))

mi_lista=[1,20,'30']
# for elemento in mi_lista:
#  	suma_uno(elemento)

for elemento in mi_lista:
	#suma_uno(elemento)
	print('item:',elemento)
	print('tipo:',type(elemento))

for elem in mi_lista:
	try:
		suma_uno(elem)
	except:
		print('No se pudo sumar',elem,'. Es',type(elem))


##### 3. MÓDULOS


import csv
archivo=csv.reader('archivo.csv')

import csv as comma_separated_values
archivo=comma_separated_values.reader("archivo.csv")

from csv import reader, writer
archivo=reader("archivo.csv")

from csv import reader as lector


##### 4. CLASES Y OBJETOS


class Persona():
	dni=57000000
	pasaporte='ABN'+str(dni)

print(Persona.dni)
print(Persona.pasaporte)

class Persona():
	dni=57000000
	pasaporte='ABN'+str(dni)
	def __init__(self,nombre,apellido,edad,sexo):
		self.nombre=nombre
		self.apellido=apellido
		self.edad=edad
		self.sexo=sexo

juan=Persona('Juan','Tarufetti',76,'M')
lucia=Persona('Lucía','Varela',45,'F')

print(lucia.apellido)

class Persona():
	dni=57000000
	pasaporte='ABN'+str(dni)
	def cambio_sexo(self,nuevo_sexo):
		self.sexo=nuevo_sexo
	def __init__(self,nombre,apellido,edad,sexo):
		self.nombre=nombre
		self.apellido=apellido
		self.edad=edad
		self.sexo=sexo

lucia=Persona('Lucía','Varela',45,'F')
lucia.cambio_sexo('M')
print(lucia.sexo)

class Persona():
	dni=57000000
	pasaporte='ABN'+str(dni)
	def cambio_sexo(self,nuevo_sexo):
		self.sexo=nuevo_sexo
	def __init__(self,nombre,apellido,edad,sexo):
		self.nombre=nombre
		self.apellido=apellido
		self.edad=edad
		self.sexo=sexo
		self.dni=Persona.dni
		Persona.dni+=1

mateo=Persona('Mateo','Michel',0,'M')
sofia=Persona('Sofía','Torino',0,'F')
axel=Persona('Axel','López',0,'M')

print(mateo.dni)
print(sofia.dni)
print(axel.dni)

print(mateo.pasaporte)
print(sofia.pasaporte)
print(axel.pasaporte)

class Estudiante(Persona):
	def __init__ (self,nombre,apellido,edad,sexo,carrera,materias_aprobadas):
		super().__init__(nombre,apellido,edad,sexo,carrera,materias_aprobadas)
		self.carrera=carrera
		self.materias_aprobadas=materias_aprobadas
	def aprobar(self,nueva_materia):
		self.materias_aprobadas.append(nueva_materia)

# PREGUNTA

class Persona():
	def __init__(self,nombre,apellido,edad):
		self.nombre=nombre
		self.apellido=apellido
		self.edad=edad
	def __str__(self):
		return self.nombre + ' ' + self.apellido
	def cambio_nombre(self,nuevo_nombre):
		self.nombre=nuevo_nombre

juan=Persona('Juan','Tarufetti',74)
juan.cambio_nombre('Ignacio')
print(juan)


##### 5. IMPORTAR/EXPORTAR ARCHIVOS TXT


f=open('archivo.txt')
print(f.read())
f.close()

f=open('archivo.txt','w')
f.write('Estas serán las primeras palabras en el archivo. \n')
f.close()

f=open('archivo.txt','a')
f.write('Estas palabras se agregarán al final del archivo.')
f.close()

with open ('archivo.txt') as f:
	print (f.read())


##### 6. IMPORTAR/EXPORTAR ARCHIVOS DE TABLAS


#pip install pandas
#import sys
#!{sys. executable} -m pip install pandas

import pandas as pd

#pd.read_excel()
#pd.read_csv()
#pd.read_stata()
#pd.read_spss()

pd.read_excel('archivo.xlsx')
pd.read_excel('archivo.xlsx',sheet_name='Hoja1')

df=pd.read_excel('archivo.xlsx',sheet_name='Hoja1')
df=pd.read_csv('archivo.csv')
df=pd.read_csv('archivo.csv',sep=';')
df=pd.read_stata('archivo.dta')

print(df.head(5))
print(df.tail(5))
print(df.sample(5))