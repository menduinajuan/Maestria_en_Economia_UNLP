############################################################
					# CUESTIONARIO 3 #
############################################################


import numpy as np
print(f'Tenemos instalada la versión {np.__version__} de NumPy.')
import pandas as pd


# PREGUNTA 1


#¿Cuáles de las siguientes opciones dan error? Puede haber más de una respuesta correcta.
#a=np.random.rand(2,3); b=np.random.rand(2,3); print(a.dot(b))
#a=np.random.rand(2,3); b=np.random.rand(3,2); print(a**b)

a=np.random.rand(2,3)
b=np.random.rand(2,3)
print(a*b)

#a=np.random.rand(2,3)
#b=np.random.rand(2,3)
#print(a.dot(b))

a=np.random.rand(2,3)
b=np.random.rand(3,2)
print(a.dot(b))

#a=np.random.rand(2,3)
#b=np.random.rand(3,2)
#print(a**b)


# PREGUNTA 2


#¿Cuál es el código correcto para crear un vector de 5 números aleatorios entre 100 y 200, con distribución uniforme?
#100+np.random.rand(5)*100

#np.random.rand(shape=5,range=[100,200])
#np.random.rand(5,min=100,max=200)
a=100+np.random.rand(5)*100
print(a)


# PREGUNTA 3


#¿Cuáles de las siguientes son formas válidas de inicializar un pd.DataFrame? No fueron vistas en clase, deben probarlo (por ejemplo en Jupyter).

df1=pd.DataFrame([[0,1,2],[3,4,5]],columns=['a','b','c'])
df2=pd.DataFrame([[0,1,2],[3,4,5]])
df3=pd.DataFrame({'a':[0,1,2],'b':[3,4,5]})
df4=pd.DataFrame({'a':[0,1,2],'b':[3,4,5]},index=['10','11','12'])
print(df1)
print(df2)
print(df3)
print(df4)


# # PREGUNTA 4


#En base a la salida de los códigos anteriores, ¿cuál es el nombre asignado por defecto a las columnas de un pd.DataFrame (es decir, cuando no se especifican explícitamente)? Escribir una oración corta describiendo.
#El nombre asignado por defecto a las columnas de un pd.DataFrame (es decir, cuando no se especifican explícitamente) es 0, 1, 2, ... , n-1, siendo n el número total de columnas.


# PREGUNTA 5


#¿Qué código escribimos para saber el tipo de dato de una columna? Usar un dataframe/columna cualquiera de los vistos en clase para ejemplificar.

df=pd.read_excel('tabla_ejemplo.xlsx')
print(df.dtypes)


# PREGUNTA 6


#¿Qué resultado arroja el código df[df['inscriptos_total']<30]?
#Las filas del dataframe que tienen en la columna 'inscriptos_total' una valor menor a 30.

df=pd.read_excel('tabla_ejemplo_2.xlsx')
df['inscriptos_total']=df['inscriptos_ronda1']+df['inscriptos_ronda2']
print(df[df['inscriptos_total']<30])


# PREGUNTA 7


#¿Cuáles de los siguientes códigos funcionan para cambiar el tipo de dato de una columna?
#df.a=str(df.a)

df=pd.DataFrame({'a':[0,1,2],'b':[3,4,5]})
print(df.dtypes)
#df.a.dtype=str
#type(df.a)=str
#df.a.astype(str)
df.a=str(df.a)
print(df.dtypes)