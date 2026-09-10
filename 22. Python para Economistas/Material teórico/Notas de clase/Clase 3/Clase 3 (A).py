############################################################
						# CLASE 3 #
############################################################


##### ABRIR UN DATAFRAME


import pandas as pd

#pd.read_excel('file_path.xlsx')
#pd.read_excel('file_path.xlsx',sheet_name='Hoja2')
#df=pd.read_excel('file_path.xlsx',sheet_name='Hoja2')

#pd.read_csv('file_path.csv')
#df=pd.read_csv('file_path.csv',sep=';')

#df=pd.read_stata('file_path.dta')


##### CREAR UN DATAFRAME


df=pd.DataFrame(columns=['Nombre','Apellido','Curso','Profesor'])
profesor1=['Belen','Michel','Python',True]
profesor2=['Rodrigo','Bonazzola','Python',True]
alumno=['Juan','Tarufetti','Python', False]

df.loc[0]=profesor1
df.loc[1]=profesor2
df.loc[len(df)]=alumno


##### EXPLORAR UN DATAFRAME


df=pd.read_excel('tabla_ejemplo.xlsx')
print(df.head(2))
print(df.sample(3))

print(df.columns)
print(df.dtypes)

print(df.info(verbose=True))


##### EXPORTAR UN DATAFRAME


df.to_excel('exportar_ejemplo.xlsx',index=False)
df=pd.read_excel('exportar_ejemplo.xlsx')
print(df.sample(1))

df.to_csv('exportar_ejemplo.csv',index=False,sep='|')
df=pd.read_csv('exportar_ejemplo.csv')
print(df.columns)
df=pd.read_csv('exportar_ejemplo.csv',sep='|')
print(df.columns)


##### TRABAJAR CON DATAFRAME


# OPERACIONES CON COLUMNAS

df=pd.read_excel('tabla_ejemplo_2.xlsx')
print(df.columns)
df['inscriptos_total']=df['inscriptos_ronda1']+df['inscriptos_ronda2']
print(df.columns)

df['inscriptos_ronda2']=df['inscriptos_ronda2']+2
df['inscriptos_total']=df['inscriptos_ronda1']+df['inscriptos_ronda2']
df['area_asignatura']=df['area']+df['asignatura']
print(df)
df['area_asignatura']=df['area']+'_'+df['asignatura']
print(df)
df['inscriptos_estado']='CERRADA'
print(df)

# TIPOS DE DATOS

print(df['inscriptos_total'].dtype)
df['inscriptos_total']=df['inscriptos_total'].astype(str)
print(df['inscriptos_total'].dtype)
df['inscriptos_total']=df['inscriptos_total'].astype(int)
print(df['inscriptos_total'].dtype)

# APLICAR FUNCIONES A COLUMNAS

df['edad_promedio_r']=round(df['edad_promedio'])
df['edad_promedio_r']=df['edad_promedio'].apply(round)
print(df)

# SELECCIONAR COLUMNAS

df['grupo']
df[['grupo','inscriptos_total']]
df_resumen=df[['grupo','inscriptos_total']].copy
print(df_resumen)

# SELECCIONAR FILAS

print(df[3:6])
print(df[:3])
print(df[-3:])

print(df[df['inscriptos_total']<30])
print(df[(df['inscriptos_total']<30) & (df['edad_promedio']>40)])

# SELECCIONAR FILAS Y COLUMNAS

print(df.loc[3:4,['grupo','asignatura']])
print(df.iloc[3:5,[0,4]])

# ELIMINAR FILAS Y COLUMNAS

print(df.drop([0,3,12]))
print(df.drop(['inscriptos_estado'],axis=1))
print(df.drop(['inscriptos_estado'],axis=1,inplace=True))
print(df)

# APPEND

df_a=pd.read_excel('tabla_ejemplo_3a.xlsx')
print(len(df_a))

df_b=pd.read_excel('tabla_ejemplo_3b.xlsx')
print(len(df_b))

df=df_a.append(df_b)
print(len(df))

# MERGE

print(df.columns)
df_c=pd.read_excel('tabla_ejemplo_3c.xlsx')
print(df_c.columns)

df=df.merge(df_c)
print(df.columns)
print(df)

# DATOS DUPLICADOS Y RESET INDEX

df.reset_index(drop=True)
print(df.tail(6))
df.drop_duplicates(inplace=True)
print(df)
df.reset_index(drop=True,inplace=True)
print(df)

# AGGREGATE

df_agg=df.groupby(by=['area','asignatura']).agg({'inscriptos_ronda1':'sum','inscriptos_ronda2':'sum','edad_promedio':'mean'})
df_agg.reset_index(inplace=True)
print(df_agg)


##### MATPLOTLIB


import matplotlib.pyplot as plt
import datetime

df=pd.read_csv('potencia_instalada_mod.csv',encoding='latin1',sep='|',index_col='Unnamed: 0')
df.index.name='indice'
print(df)
df_fuente=df.groupby(by=['periodo','fuente_generacion']).agg({'potencia_instalada_mw':'sum'})
df_fuente.reset_index(inplace=True)
df_fuente['periodo']=pd.to_datetime(df_fuente['periodo'],format="%d/%m/%Y %H:%M").dt.strftime("%Y-%m")
df_fuente.sort_values(by='periodo',ascending=True,inplace=True)
print(df_fuente)

y1=df_fuente[df_fuente['fuente_generacion']=='Renovable']['potencia_instalada_mw']
x1=df_fuente[df_fuente['fuente_generacion']=='Renovable']['periodo']
y2=df_fuente[df_fuente['fuente_generacion']=='Térmica']['potencia_instalada_mw']
x2=df_fuente[df_fuente['fuente_generacion']=='Térmica']['periodo']

# PLYPOT

plt.plot(x1,y1,label='Renovable')
plt.plot(x2,y2,label='Térmica')
plt.xlabel('Período')
plt.ylabel('Potencia Instalada (MW)')
plt.title('Producción Energética Argentina Según Fuente')
plt.legend()
plt.show()

# O-O

fig,ax=plt.subplots()
ax.plot(x1,y1,label='Renovable')
ax.plot(x2,y2,label='Térmica')
ax.set_xlabel('Período')
ax.set_ylabel('Potencia Instalada (MW)')
ax.set_title('Producción Energética Argentina Según Fuente (v2)')
ax.legend()
fig.show()

# PLYPLOT MÚLTIPLES GRÁFICOS

plt.figure(figsize=(9,5))

plt.subplot(121)
plt.plot(x1,y1)
plt.title('Fuente Renovable')
plt.xticks(rotation=45)

plt.subplot(122)
plt.plot(x2,y2)
plt.title('Fuente Hidráulica')
plt.xticks(rotation=45)

plt.suptitle('Ejemplo dos gráficos en una figura')
plt.show()