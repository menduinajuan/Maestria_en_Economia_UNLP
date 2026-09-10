############################################################
					# CUESTIONARIO 2 #
############################################################


# PREGUNTA 1


#¿Cómo usarían la función gdp_per_capita para agregar el gdp_percapita a cada país del diccionario 'paises info'? (Peguen su código en un chat privado a Belén Michel en Slack. Respondan 'verdadero' cuando lo hayan hecho).

def gdp_per_capita(gdp,pob):
	gdp_pc=round(gdp*1000/pob)
	return gdp_pc

paises_info={'argentina':{'cod':'ARG','pob':44939,'gdp':1031215},'bolivia':{'cod':'BOL','pob':11513,'gdp':104609},'brasil':{'cod':'BRA','pob':211050,'gdp':3220373},'chile':{'cod':'CHL','pob':18952,'gdp':476738},'paraguay':{'cod':'PRY','pob':7045,'gdp':93062},'uruguay':{'cod':'URY','pob':3462,'gdp':77732}}
print(paises_info)

for pais in paises_info:
	print(pais,':',paises_info[pais])
	paises_info[pais]['gdp_pc']=gdp_per_capita(paises_info[pais]['gdp'],paises_info[pais]['pob'])

print(paises_info)


# PREGUNTA 2a


#Si corremos el siguiente bloque de código ¿Cuántos print() se ejecutarán?
#3

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


#PREGUNTA 2b


#¿Qué valores devolverá cada uno de esos print()? (Elijan la opción en el orden que saldrían).
#1108947, 1202009, 1108947


# PREGUNTA 3


#¿Qué imprimiría el siguiente código?
#Juan Tarufetti

class Persona():
	def __init__(self,nombre,apellido,edad):
		self.nombre=nombre
		self.apellido=apellido
		self.edad=edad
	def __str__(self):
		return self.nombre + ' ' + self.apellido

juan=Persona('Juan','Tarufetti',74)
print(juan)


# PREGUNTA 4


#¿Cómo agregarían un método llamado cambio nombre que actualice el nombre de la persona que tramita un cambio de nombre? (Peguen su código en un chat privado a Belén Michel en Slack. Respondan 'verdadero' cuando lo hayan hecho).

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