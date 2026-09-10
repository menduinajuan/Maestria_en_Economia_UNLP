%Clase de Programación

%Matlab u Octave toman cada elemento como una matriz. Si se quieren realizar operaciones elemento por elemento, se debe poner un . antes del operador, por ejemplo: a.+b o a.*b

clear all;
%keyboard

%Se crea un elemento llamado a
%Si no se pone ; , el command window muestra la variable

a=2
b=3;

%Se crea un vector; los vectores se crean entre []

vec_a=[1 2 3 4 5]

%Si, en la definición de vector, se pone ; , se creará una matriz

mat_a=[1 2 3 ; 4 5 6]

%El comando eye crea la matriz identidad de nxn. Si, en vez de eye, se pone ones o zeros crea matrices (o vectores) de unos o ceros

mat_a=eye(3,3)
mat_b=ones(3,3)
mat_c=zeros(3,3)

%Hay funciones para crear vectores, por ejemplo linspace

a=0;
b=1;
n=11;
vec_b=linspace(a,b,n)  %Se crea un vector de 11 elementos equidistantes entre a y b

element_3_1=mat_a(3,1) %Se selecciona el elemento de la fila 3 y la columna 1 de la matriz mat_a

%Para escribir frases en el command window, se puede usar el comando display

a=2;
display("The value of a is:"), display(a)

%Escribir en el archivo

file=fopen('prueba_1.txt', 'w')
dlmwrite("prueba_1.txt", mat_a)
fclose(file)

%Se va a generar un vector como el a con un loop

file=fopen('prueba_2.txt', 'w');

%Los loop FOR repiten el proceso para todos los valores de i indicados

for (i=1:5)
  vec_c(i)=i
  dlmwrite("prueba_2.txt", vec_c(i), "-append"); %Va "apilando" o anexando los resultados 
endfor

fclose(file);

%Los loop WHILE repiten un proceso mientras se cumple la condición

max_iter=10;
iter=0;

while (iter<max_iter)
  iter=iter+1
endwhile

%Llamar una función: En otro archivo, se creó la función utility, que devolverá un valor y que tomará como argumentos un nivel de consumo y un valor para el coeficiente de aversión al riesgo
%util=utility(c,sigma)

sigma1=1;
sigma2=2;

n=10;
vec_d=linspace(0.1,5,n)

for (i=1:n)
  util1(i)=utility(vec_d(i),sigma1)
  util2(i)=utility(vec_d(i),sigma2)
endfor

%Se grafica la utilidad para los distintos valores de consumo
%En el comando plot, está el vector que se usa para el eje x (vec_d), el vector para el eje y (util) y después qué sí­mbolos se utilizarán para identificar esa línea (-o); luego repite lo mismo para el otro vector 

plot(vec_d, util1, 'o-', vec_d, util2, 'd-')

%Notar que, si no se indica el vector para x, entonces, en el eje x, muestra la posición en el vector y no el valor del vector

plot(util1) %Aquí­, el eje x va de 1 a 10, donde cada valor es la posición en el vector util (es decir, el 4 indica que es el cuarto elemento del vector util)

%Ahora, se resuelve un problema

%Se tiene que encontrar la raí­z de la ecuación y=0.05x^3-0.2x^2+0.5x+2 (se puede mostrar que la raí­z estará entre -6 y 6)
%Se usará bisection

x_min=-6;
x_max=6;

%Primero, se evalua la función en el lí­mite inferior y superior

lim_inf=fun_ej(x_min)
lim_max=fun_ej(x_max)

%Los if son condicionales, que pueden estar acompañados de else, elseif o pueden no estar acompañados. Siempre se deben cerrar con end. Realizan una operación si se cumple una determinada condición (pero no la repite como en el caso de while)

if (lim_inf<=0 & lim_max>=0)
  display("Función creciente en x con la raíz incluida en el intervalo")
elseif (lim_inf>=0 & lim_max<=0)
  display("Función decreciente en x con la raíz incluida en el intervalo")
else
  display("Chequear valores de x")
endif

%Rutina de bisection

tol=0.000000001;        %Se define la tolerancia
max_iter=10000;         %Se define una cláusula de escape por si no alcanza el nivel de tolerancia
x_guess=(x_max+x_min)/2 %Se define un guess para empresar a probar que sea la mitad del intervalo considerado
diff=fun_ej(x_guess)    %Se evalua la función en el guess
iter=0;

while (abs(diff)>tol && iter<max_iter)
  iter=iter+1;
  if (diff>0)           %Como se sabe que la función es creciente, la regla de ajuste del intervalo tiene este formato
    x_max=x_guess;
  else
    x_min=x_guess;
  endif
  x_guess=(x_max+x_min)/2;
  diff=fun_ej(x_guess);
  [x_guess, diff]
endwhile

%La rutina de bisection ajusta el intervalo en el cual buscar la raÍ­z de una función. En cada iteración, se cambia el lí­mite inferior o superior según corresponda y se redefine el guess

%Matriz de transición y cálculo de la matriz invariante

inv_guess=[0.5 0.5];
mat_tran=[0.8 0.2; 0.5 0.5];
error=1;
tol=1e-6;
maxiter=1000;
iter=0;

while (error>tol && iter<maxiter)
  iter=iter+1;
  inv_new=inv_guess*mat_tran;
  error=max(abs(inv_guess-inv_new));
  inv_guess=inv_new;
endwhile

inv_new

%Generar números aleatorios
%Generar un vector de números aleatorios de dimensión 3x1

num_alea=rand(3,1)

%Este generador usa el reloj de la computadora para generar los números aleatorios
%Si se quiere generar siempre la misma secuencia, se tiene que usar el comando seed
%Primero, se fija un valor para la seed

val_seed=12345;

%Luego, se indica al generador de números aleatorios que use este seed

rand("seed",val_seed);

%Se genera un vector

num_alea1=rand(3,1)
num_alea2=rand(3,1)

%Si se vuelve a reniciar el generador, genera los mismos números

rand("seed",val_seed);
num_alea1=rand(3,1)
num_alea2=rand(3,1)
rand("seed",val_seed);
num_alea3=rand(6,1)