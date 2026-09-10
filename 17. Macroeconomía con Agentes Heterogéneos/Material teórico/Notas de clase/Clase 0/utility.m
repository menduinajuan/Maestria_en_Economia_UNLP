%Esta función toma como insumos el consumo y el parámetro de aversión al riesgo y devuelve la utilidad de una función CRRAA

function retval=utility(c,sigma)
  if (sigma==1)
    retval=log(c);
  else
    retval=(c^(1-sigma))/(1-sigma);
  endif
endfunction