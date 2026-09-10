############################################################
                    # CUESTIONARIO 4 #
############################################################


# PREGUNTA 1 (PANDAS)


#
#9x4


# PREGUNTA 2 (SEABORN)


#
#sns.boxplot(data=propinas_df,x='size',y='tip')


# PREGUNTA 3a (EXPRESIONES REGULARES)


#

import re

regexs=[
  'a.*b',		  # correcto
  'a.+b',		  # correcto, si se interpreta que debe haber uno o más "cualesquiera carácteres", esta sería la expresión regular correcta
  'a.*?b',		# el ? permite que re.findall encuentre submatches dentro de un match grande (por defecto, devuelve el grande)
  'a.+?b',		# ídem arriba, pero no encuentra el primer match, "ab", porque no hay carácteres entre la "a" y la "b""
  'a\w*b',		# \w sólo tiene en cuenta carácteres alfanuméricos
  'a\w+b',		# ídem arriba
  '[a].*[b]',	# los corchetes alrededor de un solo caracter no son necesarios  
]
string='12ab091a00abaaba---b'

for regex in regexs:
    print(f'{regex}: {re.findall(regex, string)}')


# PREGUNTA 3b (EXPRESIONES REGULARES)


#

regexs=['a+\d*','a+[0-9]*','a+[0123456789]*'] # equivalentes
strings=['asaas0000','a0000','aba0000']

for regex in regexs:
	for string in strings:
   		print(f'{regex,string}:{re.findall(regex, string)}')