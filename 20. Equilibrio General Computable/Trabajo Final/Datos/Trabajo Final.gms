* Equilibrio General Computable - Trabajo Final
* Juan Menduiña


* ################################################## *
* SETS *
* ################################################## *


SET

  ac           set global (cuentas sam y otros items)
  a(ac)        actividades
  c(ac)        productos
  ins(ac)      instituciones

  acnt(ac)     todos los elementos de ac excepto el total

  trdelas
    /sigma_q, sigma_x/

;

ALIAS (acp,ac), (ap,a), (cp,c), (insp,ins), (acntp, acnt);

PARAMETER

  SAM(ac,acp)             matriz de contabilidad social
  tradelas(c,trdelas)     elasticidades Armington y CET por producto c
  sambalchk(ac)           chequeo de balance de matriz (total columnas menos total filas)
  errsambalchk(ac)        verificación de saldo de la SAM (total columnas menos total filas)

;


* ################################################## *
* DATA *
* ################################################## *


$CALL GDXXRW brs2017-data.xlsx index=layout!A1
$GDXIN brs2017-data.gdx

$LOADDC ac
$LOADDC a
$LOADDC c
$LOADDC ins
$LOADDC SAM
$LOADDC tradelas

acnt(ac)      = YES;
acnt('total') = NO;

* Chequeo de consistencia de la SAM

SAM('total',ac)                            = SUM(acntp, SAM(acntp,ac));
SAM(ac,'total')                            = SUM(acntp, SAM(ac,acntp));
sambalchk(acnt)                            = SAM('total',acnt) - SAM(acnt,'total');
errsambalchk(ac)$(ABS(sambalchk(ac)>1e-8)) = 1/0;
DISPLAY sambalchk, errsambalchk;


* ################################################## *
* PARÁMETROS *
* ################################################## *


PARAMETERS

  CPI0               índice de precios al consumidor
  EG0                gasto del gobierno
  EXR0               tipo de cambio nominal (moneda nacional por unidad de moneda extranjera)
  KD0(a)             demanda de factor capital de la actividad a
  KS0                oferta de factor capital
  LD0(a)             demanda de factor trabajo de la actividad a
  LS0                oferta de factor trabajo
  PA0(a)             precio de la actividad a
  PD0(c)             precio interno de la producción nacional del producto c
  PE0(c)             precio doméstico de exportación del producto c (moneda nacional)
  PM0(c)             precio doméstico de importación del producto c (moneda nacional)
  PQ0(c)             precio de la producción suministrada a nivel nacional del producto c (precio compuesto)
  PVA0(a)            precio de valor agregado de la actividad a
  PX0(c)             precio de la producción nacional del producto c (precio compuesto)
  QA0(a)             producción de la actividad a
  QD0(c)             producción nacional vendida a nivel nacional del producto c
  QE0(c)             exportaciones del producto c
  QH0(c)             demanda de los hogares del producto c
  QINT0(c,a)         demanda intermedia del producto c en la actividad a
  QINV0(c)           demanda de inversión del producto c
  QINVSCAL0          factor de ajuste de la demanda inversión
  QM0(c)             importaciones del producto c
  QQ0(c)             producción suministrada a nivel nacional del producto c (oferta compuesta)
  QX0(c)             producción nacional del producto c (oferta compuesta)
  WK0(a)             remuneración del factor capital en la actividad a
  WL0                remuneración del factor trabajo
  YG0                ingreso del gobierno
  YH0                ingreso de los hogares
  YK0                ingreso del factor capital
  YL0                ingreso del factor trabajo
  TY0                tasa de impuesto directo
  TYSCAL0            factor de ajuste de la tasa de impuesto directo
  SAVG0              ahorro del gobierno (nominal)
  SAVGR0             ahorro del gobierno (real)
  WALRAS0            variable ficticia (cero en equilibrio)

  qdstk(c)           cambios en inventarios del producto c
  qinvb(c)           demanda de inversión en el año base del producto c
  mps                propensión marginal (y media) a ahorrar de los hogares
  savf               ahorro externo (moneda extranjera)
  ta(a)              tasa de impuesto sobre el valor de la producción bruta de la actividad a
  te(c)              tasa de retención a la exportación del producto c
  tm(c)              tasa arancelaria de importación del producto c
  tq(c)              tasa de impuesto sobre las ventas del producto c
  tyb                tasa de impuesto directo en el año base
  qg(c)              demanda del gobierno del producto c
  trnsfr(ac,ins)     transferencia de la institución ins a la institución o factor ac
  pwe(c)             precio mundial de exportación del producto c (moneda extranjera)
  pwe0(c)            precio mundial de exportación del producto c (moneda extranjera)
  pwm(c)             precio mundial de importación del producto c (moneda extranjera)
  pwm0(c)            precio mundial de importación del producto c (moneda extranjera)

  delta_l(a)         participación del factor trabajo en el valor agregado de la actividad a
  delta_k(a)         participación del factor capital en el valor agregado de la actividad a
  phi_va(a)          parámetro de eficiencia en la producción de la actividad a
  theta(a,c)         cantidad del producto c por unidad de actividad a
  ica(c,a)           cantidad del producto c como insumo intermedio por unidad de actividad a
  alpha(c)           participación en el consumo de los hogares del producto c
  delta_m(c)         participación en la función de Armington de las importaciones del producto c
  delta_dd(c)        participación en la función de Armington de la producción doméstica del producto c
  phi_q(c)           parámetro de cambio de la función de Armington del producto c
  sigma_q(c)         elasticidad de sustitución entre compras domésticas e importaciones del producto c
  rho_q(c)           exponente de la función de Armington del producto c
  delta_e(c)         participación en la función CET de las exportaciones del producto c
  delta_ds(c)        participación en la función CET de la producción doméstica del producto c
  phi_x(c)           parámetro de cambio de la función CET del producto c
  sigma_x(c)         elasticidad de transformación entre ventas domésticas y exportaciones del producto c
  rho_x(c)           exponente de la función CET del producto c
  cwts(c)            ponderación en el IPC del producto c

;


* ################################################## *
* ASIGNACIÓN PARA VARIABLES Y PARÁMETROS *
* ################################################## *


* Calibración Variables - Precios

EXR0   = 1;
PA0(a) = 1;
PX0(c) = 1;
WK0(a) = 1;
WL0    = 1;
PD0(c) = 1;
PE0(c) = 1;
PM0(c) = 1;
DISPLAY EXR0, PA0, PX0, WK0, WL0, PD0, PE0, PM0;

* Calibración Variables y Parámetros - Producción

PVA0(a)      = (SAM('lab',a) + SAM('cap',a)) / (SAM('total',a) / PA0(a));
QA0(a)       = SAM(a,'total') / PA0(a);
QE0(c)       = SAM(c,'row') / PE0(c);
QM0(c)       = (SAM('row',c) + SAM('tax-imp',c)) / PM0(c);
QX0(c)       = SUM(a, SAM(a,c)) / PX0(c);
QD0(c)       = QX0(c) - QE0(c);
QQ0(c)       = QD0(c) + QM0(c);
ta(a)        = SAM('tax-act',a) / (PA0(a) * QA0(a));
tq(c)$QQ0(c) = SAM('tax-com',c) / (PD0(c) * QD0(c) + PM0(c) * QM0(c));
PQ0(c)       = (PD0(c) * QD0(c) + PM0(c) * QM0(c)) * (1 + tq(c)) / QQ0(c);
cwts(c)      = SAM(c,'hhd') / SUM(cp, SAM(cp,'hhd'));
CPI0         = SUM(c, cwts(c) * PQ0(c));
QINT0(c,a)   = SAM(c,a) / PQ0(c);
DISPLAY PVA0, QA0, QE0, QM0, QX0, QD0, QQ0, ta, tq, PQ0, cwts, CPI0, QINT0;

* Calibración Variables - Factores productivos y Remuneraciones

KD0(a) = SAM('cap',a) / WK0(a);
KS0    = SUM(a, KD0(a));
LD0(a) = SAM('lab',a) / WL0;
LS0    = SUM(a, LD0(a));
DISPLAY KD0, KS0, LD0, LS0;

* Calibración Variables y Parámetros - Ingresos de factores

YK0                 = SAM('cap','total');
YL0                 = SAM('lab','total');
trnsfr('lab','row') = SAM('lab','row') / EXR0;
trnsfr('cap','row') = SAM('cap','row') / EXR0;
DISPLAY YK0, YL0, trnsfr;

* Calibración Variables y Parámetros - Hogares

QH0(c)              = SAM(c,'hhd') / PQ0(c);
YH0                 = SAM('hhd','total');
TY0                 = SAM('tax-dir','hhd') / YH0;
TYSCAL0             = 1;
tyb                 = TY0;
trnsfr('hhd','row') = SAM('hhd','row') / EXR0;
DISPLAY QH0, YH0, TY0, TYSCAL0, tyb, trnsfr;

* Calibración Variables y Parámetros - Gobierno

EG0                 = SAM('total','gov') - SAM('sav-inv','gov');
YG0                 = SAM('gov','total');
SAVG0               = SAM('sav-inv','gov');
SAVGR0              = SAVG0 / CPI0;
qg(c)               = SAM(c,'gov') / PQ0(c);
trnsfr('hhd','gov') = SAM('hhd','gov') / CPI0;
trnsfr('gov','row') = SAM('gov','row') / EXR0;
DISPLAY EG0, YG0, SAVG0, SAVGR0, qg, trnsfr;

* Calibración Variables y Parámetros - Ahorro-Inversión

QINV0(c)  = SAM(c,'sav-inv') / PQ0(c);
QINVSCAL0 = 1;
WALRAS0   = 0;
qdstk(c)  = SAM(c,'dstk') / PQ0(c);
qinvb(c)  = QINV0(c);
mps       = SAM('sav-inv','hhd') / (SAM('total','hhd') - SAM('tax-dir','hhd'));
savf      = SAM('sav-inv','row') / EXR0;
DISPLAY QINV0, QINVSCAL0, WALRAS0, qdstk, qinvb, mps, savf;

* Calibración Parámetros - Comercio Internacional

te(c)              = 0;
tm(c)$SAM('row',c) = SAM('tax-imp',c) / SAM('row',c);
pwe(c)             = PE0(c) / ((1 - te(c)) * EXR0);
pwe0(c)            = pwe(c);
pwm(c)             = PM0(c) / ((1 + tm(c)) * EXR0);
pwm0(c)            = pwm(c);
DISPLAY te, tm, pwe, pwe0, pwm, pwm0;

* Calibración Parámetros - Producción

delta_l(a) = LD0(a) * WL0 / (PVA0(a) * QA0(a));
delta_k(a) = KD0(a) * WK0(a) / (PVA0(a) * QA0(a));
phi_va(a)  = QA0(a) / (LD0(a)**delta_l(a) * KD0(a)**delta_k(a));
theta(a,c) = (SAM(a,c) / PX0(c)) / QA0(a);
ica(c,a)   = QINT0(c,a) / QA0(a);
DISPLAY delta_l, delta_k, phi_va, theta, ica;

* Calibración Parámetros - Consumo

alpha(c) = PQ0(c) * QH0(c) / ((1 - mps) * (1 - TY0) * YH0);
DISPLAY alpha;

* Calibración Parámetros - Comercio Internacional

sigma_q(c) = tradelas(c,'sigma_q');
sigma_x(c) = tradelas(c,'sigma_x');
rho_q(c)   = 1 / sigma_q(c) - 1;
rho_x(c)   = 1 / sigma_x(c) + 1;
DISPLAY sigma_q, sigma_x, rho_q, rho_x;

* Calibración Parámetros - Función Armington

delta_m(c) $(QD0(c)>0 AND QM0(c)>0) = PM0(c) * QM0(c)**(1/sigma_q(c)) /
                                      (PM0(c) * QM0(c)**(1/sigma_q(c)) + PD0(c) * QD0(c)**(1/sigma_q(c)));
delta_dd(c)$(QD0(c)>0 AND QM0(c)>0) = PD0(c) * QD0(c)**(1/sigma_q(c)) /
                                      (PM0(c) * QM0(c)**(1/sigma_q(c)) + PD0(c) * QD0(c)**(1/sigma_q(c)));
phi_q(c)   $(QD0(c)>0 AND QM0(c)>0) = QQ0(c) /
                                      (delta_m(c) * QM0(c)**(-rho_q(c)) + delta_dd(c) * QD0(c)**(-rho_q(c))) ** (-1/rho_q(c));
DISPLAY delta_m, delta_dd, phi_q;

* Calibración Parámetros - Función CET

delta_e(c) $(QD0(c)>0 AND QE0(c)>0) = PE0(c) * QE0(c)**(-1/sigma_x(c)) /
                                      (PE0(c) * QE0(c)**(-1/sigma_x(c)) + PD0(c) * QD0(c)**(-1/sigma_x(c)));
delta_ds(c)$(QD0(c)>0 AND QE0(c)>0) = PD0(c) * QD0(c)**(-1/sigma_x(c)) /
                                      (PE0(c) * QE0(c)**(-1/sigma_x(c)) + PD0(c) * QD0(c)**(-1/sigma_x(c)));
phi_x(c)   $(QD0(c)>0 AND QE0(c)>0) = QX0(c) /
                                      (delta_e(c) * QE0(c)**rho_x(c) + delta_ds(c) * QD0(c)**rho_x(c)) ** (1/rho_x(c));
DISPLAY delta_e, delta_ds, phi_x;


* ################################################## *
* VARIABLES ENDÓGENAS *
* ################################################## *


VARIABLES

  CPI           índice de precios al consumidor
  EG            gasto del gobierno
  EXR           tipo de cambio nominal (moneda nacional por unidad de moneda extranjera) 
  KD(a)         demanda de factor capital de la actividad a
  KS            oferta de factor capital
  LD(a)         demanda de factor trabajo de la actividad a
  LS            oferta de factor trabajo
  PA(a)         precio de la actividad a
  PD(c)         precio interno de la producción nacional del producto c
  PE(c)         precio doméstico de exportación del producto c (moneda nacional)
  PM(c)         precio doméstico de importación del producto c (moneda nacional)
  PQ(c)         precio de la producción suministrada a nivel nacional del producto c (precio compuesto)
  PVA(a)        precio de valor agregado de la actividad a
  PX(c)         precio de la producción nacional del producto c (precio compuesto)
  QA(a)         producción de la actividad a
  QD(c)         producción nacional vendida  a nivel nacional del producto c
  QE(c)         exportaciones del producto c 
  QH(c)         demanda de los hogares del producto c
  QINT(c,a)     demanda intermedia del producto c en la actividad a
  QINV(c)       demanda de inversión del producto c
  QINVSCAL      factor de ajuste de la inversión
  QM(c)         importaciones del producto c
  QQ(c)         producción suministrada a nivel nacional del producto c (oferta compuesta)
  QX(c)         producción nacional del producto c (oferta compuesta)
  WK(a)         remuneración del factor capital en la actividad a
  WL            remuneración del factor trabajo
  YG            ingreso del gobierno
  YH            ingreso de los hogares
  YK            ingreso del factor capital
  YL            ingreso del factor trabajo
  TY            tasa de impuesto directo
  TYSCAL        factor de ajuste de la tasa de impuesto directo
  SAVG          ahorro del gobierno (nominal)
  SAVGR         ahorro del gobierno (real)
  WALRAS        variable ficticia (cero en equilibrio)

;


* ################################################## *
* ECUACIONES *
* ################################################## *


EQUATIONS

* Producción, precios relacionados e ingresos de factores

  EQ_PRODFN(a)        producción de la actividad a
  EQ_LABDEM(a)        demanda de factor trabajo de la actividad a
  EQ_CAPDEM(a)        demanda de factor capital de la actividad a
  EQ_INTDEM(c,a)      demanda intermedia del producto c en la actividad a
  EQ_OUTPUTFN(c)      producción nacional del producto c
  EQ_PADEF(a)         precio de la actividad a
  EQ_PVADEF(a)        precio de valor agregado de la actividad a
  EQ_LABINC           ingreso del factor trabajo
  EQ_CAPINC           ingreso del factor capital

* Precios

  EQ_PEDEF(c)         precio de exportación del producto c (moneda nacional)
  EQ_PMDEF(c)         precio de importación del producto c (moneda nacional)
  EQ_CPIDEF           índice de precios al consumidor

* Compras nacionales e importaciones

  EQ_ARMING1(c)       función de oferta compuesta 1 (CES 1) del producto c
  EQ_IMPDOMRAT(c)     relación entre las importaciones y la demanda interna del producto c
  EQ_ARMING2(c)       función de oferta compuesta 2 (CES 2) del producto c
  EQ_ABSORB(c)        absorción del producto c

* Ventas nacionales y exportaciones

  EQ_CET1(c)          función de transformación de la producción 1 (CET 1) del producto c
  EQ_EXPDOMRAT(c)     relación entre las exportaciones y la venta interna del producto c
  EQ_CET2(c)          función de transformación de la producción 2 (CET 2) del producto c
  EQ_OUTVAL(c)        valor de producción del producto c

* Instituciones nacionales

  EQ_HHDINC           ingreso de los hogares
  EQ_HHDDEM(c)        demanda de los hogares del producto c
  EQ_GOVREV           ingreso del gobierno
  EQ_GOVEXP           gasto del gobierno
  EQ_IMPD             tasa de impuesto directo
  EQ_INVDEM(c)        demanda de inversión del producto c

* Condiciones de equilibrio

  EQ_LABEQ            equilibrio en el mercado del factor trabajo
  EQ_CAPEQ            equilibrio en el mercado del factor capital
  EQ_CURACC           equilibrio cuenta corriente de la balanza de pagos
  EQ_COMEQ(c)         equilibrio del mercado del producto c
  EQ_SAVINV           equilibrio ahorro-inversión
  EQ_SAVG             ahorro del gobierno (nominal)
  EQ_SAVGR            ahorro del gobierno (real)

;

* Producción, precios relacionados e ingresos de factores

EQ_PRODFN(a)..
  QA(a) =E= phi_va(a) * LD(a)**delta_l(a) * KD(a)**delta_k(a);

EQ_LABDEM(a)$LD0(a)..
  LD(a) * WL =E= delta_l(a) * PVA(a) * QA(a);

EQ_CAPDEM(a)$KD0(a)..
  KD(a) * WK(a) =E= delta_k(a) * PVA(a) * QA(a);

EQ_INTDEM(c,a)..
  QINT(c,a) =E= ica(c,a) * QA(a);

EQ_OUTPUTFN(c)..
  QX(c) =E= SUM(a, theta(a,c) * QA(a));

EQ_PADEF(a)..
  PA(a) =E= SUM(c, theta(a,c) * PX(c));

EQ_PVADEF(a)..
  PVA(a) =E= PA(a) * (1 - ta(a)) - SUM(c, PQ(c) * ica(c,a));

EQ_LABINC..
  YL =E= SUM(a, WL * LD(a)) + trnsfr('lab','row') * EXR;

EQ_CAPINC..
  YK =E= SUM(a, WK(a) * KD(a)) + trnsfr('cap','row') * EXR;

* Precios

EQ_PEDEF(c)..
  PE(c) =E= (1 - te(c)) * EXR * pwe(c);

EQ_PMDEF(c)..
  PM(c) =E= (1 + tm(c)) * EXR * pwm(c);

EQ_CPIDEF..
  CPI =E= SUM(c, PQ(c) * cwts(c));

* Compras nacionales e importaciones

EQ_ARMING1(c)$(QM0(c)>0 AND QD0(c)>0)..
  QQ(c) =E= phi_q(c) * (delta_m(c) * QM(c)**(-rho_q(c)) + delta_dd(c) * QD(c)**(-rho_q(c)) ) ** (-1/rho_q(c));

EQ_IMPDOMRAT(c)$(QM0(c)>0 AND QD0(c)>0)..
  QM(c) / QD(c) =E= (PD(c) / PM(c) * delta_m(c) / delta_dd(c)) ** sigma_q(c);

EQ_ARMING2(c)$((QM0(c)>0 AND QD0(c)=0) OR (QM0(c)=0 AND QD0(c)>0))..
  QQ(c) =E= QM(c) + QD(c);

EQ_ABSORB(c)..
  PQ(c) * QQ(c) =E= (PD(c) * QD(c) + PM(c) * QM(c)) * (1 + tq(c));

* Ventas nacionales y exportaciones

EQ_CET1(c)$(QE0(c)>0 AND QD0(c)>0)..
  QX(c) =E= phi_x(c) * (delta_e(c) * QE(c)**(rho_x(c)) + delta_ds(c) * QD(c)**(rho_x(c))) ** (1/rho_x(c));

EQ_EXPDOMRAT(c)$(QE0(c)>0 AND QD0(c)>0)..
  QE(c) / QD(c) =E= (PE(c) / PD(c) * delta_ds(c) / delta_e(c)) ** sigma_x(c);

EQ_CET2(c)$((QE0(c)>0 AND QD0(c)=0) OR (QE0(c)=0 AND QD0(c)>0))..
  QX(c) =E= QE(c) + QD(c);

EQ_OUTVAL(c)..
  PX(c) * QX(c) =E= PD(c) * QD(c) + PE(c) * QE(c);

* Instituciones nacionales

EQ_HHDINC..
  YH =E= YL + YK + trnsfr('hhd','gov') * CPI + trnsfr('hhd','row') * EXR;

EQ_HHDDEM(c)..
  QH(c) * PQ(c) =E= alpha(c) * (1 - mps) * (1 - TY) * YH;

EQ_GOVREV..
  YG =E= TY * YH + SUM(a, ta(a) * PA(a) * QA(a)) + SUM(c, tq(c) * (PM(c) * QM(c) + PD(c) * QD(c)))
                 + SUM(c, tm(c) * pwm(c) * EXR * QM(c)) + SUM(c, te(c) * EXR * pwe(c) * QE(c)) + trnsfr('gov','row') * EXR;

EQ_GOVEXP..
  EG =E= SUM(c, PQ(c) * qg(c)) + trnsfr('hhd','gov') * CPI;

EQ_IMPD..
  TY =E= tyb * TYSCAL;

EQ_INVDEM(c)..
  QINV(c) =E= qinvb(c) * QINVSCAL;

* Condiciones de equilibrio

EQ_LABEQ..
  LS =E= SUM(a, LD(a));  

EQ_CAPEQ..
  KS =E= SUM(a, KD(a));  

EQ_CURACC..
  SUM(c, pwe(c) * QE(c)) + trnsfr('hhd','row') + trnsfr('gov','row') + trnsfr('lab','row') + trnsfr('cap','row') + savf
  =E= SUM(c, pwm(c) * QM(c));

EQ_COMEQ(c)..
  QQ(c) =E= SUM(a, QINT(c,a)) + QH(c) + qg(c) + QINV(c) + qdstk(c);

EQ_SAVINV..
  SUM(c, PQ(c) * QINV(c)) + SUM(c, PQ(c) * qdstk(c)) + WALRAS =E= mps * (1 - TY) * YH + SAVG + savf * EXR;

EQ_SAVG..
  SAVG =E= YG - EG;

EQ_SAVGR..
  SAVGR * CPI =E= SAVG;


* ################################################## *
* MODELO *
* ################################################## *


MODEL CGE

/
  EQ_PRODFN
  EQ_LABDEM
  EQ_CAPDEM
  EQ_INTDEM
  EQ_OUTPUTFN
  EQ_PADEF
  EQ_PVADEF
  EQ_LABINC
  EQ_CAPINC

  EQ_PEDEF
  EQ_PMDEF
  EQ_CPIDEF

  EQ_ARMING1
  EQ_IMPDOMRAT
  EQ_ARMING2
  EQ_ABSORB

  EQ_CET1
  EQ_EXPDOMRAT
  EQ_CET2
  EQ_OUTVAL

  EQ_HHDINC
  EQ_HHDDEM
  EQ_GOVREV
  EQ_GOVEXP
  EQ_IMPD
  EQ_INVDEM

  EQ_LABEQ
  EQ_CAPEQ
  EQ_CURACC
  EQ_COMEQ
  EQ_SAVINV
  EQ_SAVG
  EQ_SAVGR

/

;

* Valores iniciales para las variables endógenas

CPI.L       = CPI0;
EG.L        = EG0;
EXR.L       = EXR0;
KD.L(a)     = KD0(a);
KS.L        = KS0;
LD.L(a)     = LD0(a);
LS.L        = LS0;
PA.L(a)     = PA0(a);
PD.L(c)     = PD0(c);
PE.L(c)     = PE0(c);
PM.L(c)     = PM0(c);
PQ.L(c)     = PQ0(c);
PVA.L(a)    = PVA0(a);
PX.L(c)     = PX0(c);
QA.L(a)     = QA0(a);
QD.L(c)     = QD0(c);
QE.L(c)     = QE0(c);
QH.L(c)     = QH0(c);
QINT.L(c,a) = QINT0(c,a);
QINV.L(c)   = QINV0(c);
QINVSCAL.L  = QINVSCAL0;
QM.L(c)     = QM0(c);
QQ.L(c)     = QQ0(c);
QX.L(c)     = QX0(c);
WK.L(a)     = WK0(a);
WL.L        = WL0;
YG.L        = YG0;
YH.L        = YH0;
YK.L        = YK0;
YL.L        = YL0;
TY.L        = TY0;
TYSCAL.L    = TYSCAL0;
SAVG.L      = SAVG0;
SAVGR.L     = SAVGR0;
WALRAS.L    = WALRAS0;

* Variables fuera del modelo (es decir, sin valor inicial) establecidas en cero

QE.FX(c)$(QE0(c)=0) = 0;
QM.FX(c)$(QM0(c)=0) = 0;


* ################################################## *
* REGLA DE CIERRE *
* ################################################## *


* Numerario

CPI.FX    = CPI0;

* Mercado de factores

LS.FX     = LS0;
KD.FX(a)  = KD0(a);

* Gobierno

TYSCAL.LO = -INF;
TYSCAL.UP = +INF;
SAVGR.FX  = SAVGR0;


* ################################################## *
* SOLUCIÓN *
* ################################################## *


OPTION CNS = PATH;

CGE.TOLINFREP = 0.0000000001;
CGE.ITERLIM   = 0;

SET sim

  /
  base
  pwebiofuels
  pwmbiofuels
  pwbiofuels
  /

;

$INCLUDE repsetup.inc

SOLVE CGE USING CNS;
*DISPLAY QA.L, QD.L, QE.L, QM.L, QX.L, QQ.L, QINT.L, QH.L, qg, QINV.L, qdstk, EG.L, LD.L, KD.L,
*        PA.L, PD.L, PE.L, PM.L, PX.L, PQ.L, CPI.L, EXR.L, WL.L, WK.L, YH.L, YL.L, YK.L, trnsfr,
*        TY.L, tyb, TYSCAL.L, SAVG.L, SAVGR.L, WALRAS.L;

$BATINCLUDE reploop.inc base

CGE.ITERLIM = 100000;

* Chequeo: Duplicación del numerario

*CPI.FX = CPI0 * 2;

*SOLVE CGE USING CNS;
*DISPLAY QA.L, QD.L, QE.L, QM.L, QX.L, QQ.L, QINT.L, QH.L, qg, QINV.L, qdstk, EG.L, LD.L, KD.L,
*        PA.L, PD.L, PE.L, PM.L, PX.L, PQ.L, CPI.L, EXR.L, WL.L, WK.L, YH.L, YL.L, YK.L, trnsfr,
*        TY.L, tyb, TYSCAL.L, SAVG.L, SAVGR.L, WALRAS.L;


* ################################################## *
* SIMULACIONES DE SHOCKS *
* ################################################## *


* 1. Aumento del 200% en el precio mundial de exportación del producto "Etanol y otros biocombustibles" ('c-biofuels')

$INCLUDE var+prm-init.inc
pwe('c-biofuels') = pwe0('c-biofuels') * 3;
SOLVE CGE USING CNS;
$BATINCLUDE reploop.inc pwebiofuels

* 2. Disminución del 50% en el precio mundial de importación del producto "Etanol y otros biocombustibles" ('c-biofuels')

$INCLUDE var+prm-init.inc
pwm('c-biofuels') = pwm0('c-biofuels') * 0.5;
SOLVE CGE USING CNS;
$BATINCLUDE reploop.inc pwmbiofuels

* 3. Aumento del 100% en el precio mundial de exportación e importación del producto "Etanol y otros biocombustibles" ('c-biofuels')

$INCLUDE var+prm-init.inc
pwe('c-biofuels') = pwe0('c-biofuels') * 2;
pwm('c-biofuels') = pwm0('c-biofuels') * 2;
SOLVE CGE USING CNS;
$BATINCLUDE reploop.inc pwbiofuels