SET

  igdp1               elementos para el PBI y las cuentas nacionales
    /
      Absorption      Absorción
      PrvCon          Consumo Privado
      GovCon          Consumo Público
      FixInv          Formación Bruta de Capital
      StockChange     Variación de Existencias
      Exports         Exportaciones
      Imports         Importaciones
      GDPMP           PBI (a precio de mercado)
      NetIndTax       Impuestos Indirectos Netos
      GDPFC           PBI (a costo de factores)
    /

  igdp2(igdp1)        elementos para la suma de GDPMP
    /
      PrvCon          Consumo Privado
      GovCon          Consumo Público
      FixInv          Formación Bruta de Capital
      StockChange     Variación de Existencias
      Exports         Exportaciones
      Imports         Importaciones
    /

  sectorcol
    /
      VAshr           Participación en el valor agregado (%)
      PRDshr          Participación en la producción (%)
      EMPshr          Participación en el empleo total (%)
      EXPshr          Participación del sector en las exportaciones totales (%)
      EXP-OUTshr      Participación de las exportaciones en la producción del sector (%)
      IMPshr          Participación del sector en las importaciones totales (%)
      IMP-DEMshr      Participación de las importaciones en la demanda interna del sector (%)
    /

  solcol
    /
      solvestat
      modelstat
    /

;

PARAMETERS

* Nombre de la variable + X  = valores para las variables endógenas
* Nombre de la variable + XP = cambio porcentual respecto de la base

  CPIX(sim)                         índice de precios al consumidor
  CPIXP(sim)                        índice de precios al consumidor
  EGX(sim)                          gasto del gobierno
  EGXP(sim)                         gasto del gobierno
  EXRX(sim)                         tipo de cambio nominal (moneda nacional por unidad de moneda extranjera)
  EXRXP(sim)                        tipo de cambio nominal (moneda nacional por unidad de moneda extranjera)
  KDX(a,sim)                        demanda de factor capital de la actividad a
  KDXP(a,sim)                       demanda de factor capital de la actividad a
  KSX(sim)                          oferta de factor capital
  KSXP(sim)                         oferta de factor capital
  LDX(a,sim)                        demanda de factor trabajo de la actividad a
  LDXP(a,sim)                       demanda de factor trabajo de la actividad a
  LSX(sim)                          oferta de factor trabajo
  LSXP(sim)                         oferta de factor trabajo
  PAX(a,sim)                        precio de la actividad a
  PAXP(a,sim)                       precio de la actividad a
  PDX(c,sim)                        precio interno de la producción nacional del producto c
  PDXP(c,sim)                       precio interno de la producción nacional del producto c
  PEX(c,sim)                        precio doméstico de exportación del producto c (moneda nacional)
  PEXP(c,sim)                       precio doméstico de exportación del producto c (moneda nacional)
  PMX(c,sim)                        precio doméstico de importación del producto c (moneda nacional)
  PMXP(c,sim)                       precio doméstico de importación del producto c (moneda nacional)
  PQX(c,sim)                        precio de la producción suministrada a nivel nacional del producto c (precio compuesto)
  PQXP(c,sim)                       precio de la producción suministrada a nivel nacional del producto c (precio compuesto)
  PVAX(a,sim)                       precio de valor agregado de la actividad a
  PVAXP(a,sim)                      precio de valor agregado de la actividad a
  PXX(c,sim)                        precio de la producción nacional del producto c (precio compuesto)
  PXXP(c,sim)                       precio de la producción nacional del producto c (precio compuesto)
  QAX(a,sim)                        producción de la actividad a
  QAXP(a,sim)                       producción de la actividad a
  QDX(c,sim)                        producción nacional vendida a nivel nacional del producto c
  QDXP(c,sim)                       producción nacional vendida a nivel nacional del producto c
  QEX(c,sim)                        exportaciones del producto c
  QEXP(c,sim)                       exportaciones del producto c
  QHX(c,sim)                        demanda de los hogares del producto c
  QHXP(c,sim)                       demanda de los hogares del producto c
  QINTX(c,a,sim)                    demanda intermedia del producto c en la actividad a
  QINTXP(c,a,sim)                   demanda intermedia del producto c en la actividad a
  QINVX(c,sim)                      demanda de inversión del producto c
  QINVXP(c,sim)                     demanda de inversión del producto c
  QINVSCALX(sim)                    factor de ajuste de la demanda inversión
  QINVSCALXP(sim)                   factor de ajuste de la demanda inversión
  QMX(c,sim)                        importaciones del producto c
  QMXP(c,sim)                       importaciones del producto c
  QQX(c,sim)                        producción suministrada a nivel nacional del producto c (oferta compuesta)
  QQXP(c,sim)                       producción suministrada a nivel nacional del producto c (oferta compuesta)
  QXX(c,sim)                        producción nacional del producto c (oferta compuesta)
  QXXP(c,sim)                       producción nacional del producto c (oferta compuesta)
  WKX(a,sim)                        remuneración del factor capital en la actividad a
  WKXP(a,sim)                       remuneración del factor capital en la actividad a
  WLX(sim)                          remuneración del factor trabajo
  WLXP(sim)                         remuneración del factor trabajo
  YGX(sim)                          ingreso del gobierno
  YGXP(sim)                         ingreso del gobierno
  YHX(sim)                          ingreso de los hogares
  YHXP(sim)                         ingreso de los hogares
  YKX(sim)                          ingreso del factor capital
  YKXP(sim)                         ingreso del factor capital
  YLX(sim)                          ingreso del factor trabajo
  YLXP(sim)                         ingreso del factor trabajo
  TYX(sim)                          tasa de impuesto directo
  TYXP(sim)                         tasa de impuesto directo
  TYSCALX(sim)                      factor de ajuste de la tasa de impuesto directo
  TYSCALXP(sim)                     factor de ajuste de la tasa de impuesto directo
  SAVGX(sim)                        ahorro del gobierno (nominal)
  SAVGXP(sim)                       ahorro del gobierno (nominal)
  SAVGRX(sim)                       ahorro del gobierno (real)
  SAVGRXP(sim)                      ahorro del gobierno (real)
  WALRASX(sim)                      variable ficticia (cero en equilibrio)
  WALRASXP(sim)                     variable ficticia (cero en equilibrio)

  qdstkX(c,sim)                     cambios en inventarios del producto c
  qdstkXP(c,sim)                    cambios en inventarios del producto c
  qinvbX(c,sim)                     demanda de inversión en el año base del producto c
  qinvbXP(c,sim)                    demanda de inversión en el año base del producto c
  mpsX(sim)                         propensión marginal (y media) a ahorrar de los hogares
  mpsXP(sim)                        propensión marginal (y media) a ahorrar de los hogares
  savfX(sim)                        ahorro externo (moneda extranjera)
  savfXP(sim)                       ahorro externo (moneda extranjera)
  taX(a,sim)                        tasa de impuesto sobre el valor de la producción bruta de la actividad a
  taXP(a,sim)                       tasa de impuesto sobre el valor de la producción bruta de la actividad a
  teX(c,sim)                        tasa de retención a la exportación del producto c
  teXP(c,sim)                       tasa de retención a la exportación del producto c
  tmX(c,sim)                        tasa arancelaria de importación del producto c
  tmXP(c,sim)                       tasa arancelaria de importación del producto c
  tqX(c,sim)                        tasa de impuesto sobre las ventas del producto c
  tqXP(c,sim)                       tasa de impuesto sobre las ventas del producto c
  tybX(sim)                         tasa de impuesto directo en el año base
  tybXP(sim)                        tasa de impuesto directo en el año base
  qgX(c,sim)                        demanda del gobierno del producto c
  qgXP(c,sim)                       demanda del gobierno del producto c
  trnsfrX(ac,ins,sim)               transferencia de la institución ins a la institución o factor ac
  trnsfrXP(ac,ins,sim)              transferencia de la institución ins a la institución o factor ac
  pweX(c,sim)                       precio mundial de exportación del producto c (moneda extranjera)
  pweXP(c,sim)                      precio mundial de exportación del producto c (moneda extranjera)
  pwmX(c,sim)                       precio mundial de importación del producto c (moneda extranjera)
  pwmXP(c,sim)                      precio mundial de importación del producto c (moneda extranjera)

  ehX(sim)                          demanda de los hogares
  ehXP(sim)                         demanda de los hogares
  ev(sim)                           variación equivalente

  rexrX(sim)                        tipo de cambio real
  rexrXP(sim)                       tipo de cambio real
  dpiX(sim)                         índice de precios de la producción nacional (basado en PD)
  dpiXP(sim)                        índice de precios de la producción nacional (basado en PD)
  dwts(c)                           ponderación de los precios de ventas nacionales

  gdprep(igdp1,sim)                 tabla del PBI
  gdprepXP(igdp1,sim)               tabla del PBI
  sectorstruc(ac,sectorcol,sim)     estructura sectorial

  modsolstat(solcol,sim)            solucionador de estado y modelo

  SIMSAM(ac,acp,sim)                matriz de contabilidad social definida usando los resultados de las simulaciones
  simsambalchk(ac,sim)              chequeo de balance de matriz (total columnas menos total filas)
  errsimsambalchk(ac,sim)           verificación de saldo de la SAM (total columnas menos total filas)

;

dwts(c) = (SUM(a, SAM(a,c)) - SAM(c,'row')) / (SUM(cp, SUM(a, SAM(a,cp)) - SAM(cp,'row')));