############################################################
					# CUESTIONARIO 1 #
############################################################


# PREGUNTA 1


#¿Es equivalente un número escrito como entero o en formato de coma flotante? (¿17==17.0?).

print(17==17.0)


# PREGUNTA 2


#¿Es equivalente un número escrito como entero o en formato de string? (¿524=="524"?).

print(524=='524')


# PREGUNTA 3


#¿Los strings, o cadena de caracteres, son sensibles al uso de " " o ' '? ("Argentina"=='Argentina').

print("Argentina"=='Argentina')


# PREGUNTA 4


#¿Los strings, o cadena de caracteres, son sensibles al uso de mayúsculas y minúsculas? ("Argentina"=="ARGENTINA").

print('Argentina'=='ARGENTINA')


# PREGUNTA 5


#Vimos que el operador "+" se puede usar para valores numéricos y para strings. ¿Se puede usar para una combinación de ambos? (12+"34").

#print(12+"34")


# PREGUNTA 6


#Al nombrar dos variables de manera similar pero modificando mayúsculas/minúsculas, ¿estamos creando dos variables o pisando el valor de la primera con el valor de la segunda?

resultado='a'
RESULTADO='B'
print(resultado); print(RESULTADO)


# PREGUNTA 7


#¿Alguno de estos nombres de variable es válido?

#2variable='a'
#mi-variable='a'
mi__var_iab_='a'


# PREGUNTA 8


#¿Cuál es el resultado de sumar la lista de países con la lista de población?

paises=['ARG','BOL','BRA','CHL','PRY','URY']
pob_m=[44939,11513,211050,18952,7045.5,3462]
print(paises+pob_m)
paises.extend(pob_m)
print(paises)


# PREGUNTA 9


#¿Una lista puede tener valores repetidos?
#Sí


# PREGUNTA 10


#¿Cuál de estas características de una secuencia describe a las tuplas?
#Ordenada e inmutable


# PREGUNTA 11


#¿El valor de temp1 y temp2 será el mismo?
#No

pry_limit={'BOL','BRA','PRY','URY'}
print(pry_limit)
temp1=pry_limit.remove('URY')
print(pry_limit)
temp2=pry_limit.pop()
print(temp1); print(temp2)


# PREGUNTA 12


#¿Cuál es un posible valor de temp2?
#{'BOL','PRY'}


# PREGUNTA 13


#Siguiendo el ejemplo de la ppt, ¿qué pasa si intento crear un set de un diccionario?
#{'cod','pob','gdp'}

arg_carac={'cod':'ARG','pob':44939,'gdp':'N'}
set_arg_carac=set(arg_carac)
print(set_arg_carac)