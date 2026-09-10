* Equilibrio General Computable - Trabajo Práctico N° 3 (Ejercicio 5)
* Juan Menduiña


* ################################################## *
* SETS *
* ################################################## *


SET

  ac           set global (cuentas sam y otros items)
    /
    s-x        sector X
    s-y        sector Y
    lab        trabajo
    cap        capital
    hhd        hogares
    row        resto del mundo
    savf       ahorro del resto del mundo
    total      total
    /

  s(ac)        sectores
    /s-x, s-y/

  acnt(ac)     todos los elementos de ac excepto el total

;

ALIAS (acp,ac), (sp,s), (acntp, acnt);

acnt(ac)      = YES;
acnt('total') = NO;

PARAMETER

  SAM(ac,acp)       matriz de contabilidad social
  sambalchk(ac)     chequeo de balance de matriz

;

TABLE SAM(ac,ac)  matriz de contabilidad social

          s-x     s-y     lab     cap     hhd     row     savf     total
s-x                                        95       5                100
s-y                                       110                        110
lab        25     75                                                 100
cap        75     25                                                 100
hhd                       100     100                        5       205
row               10                                                  10
savf                                                5                  5
total     100    110      100     100     205      10        5

;

DISPLAY SAM;

* Chequeo consistencia de la SAM

SAM('total',ac)  = SUM(acntp, SAM(acntp,ac));
SAM(ac,'total')  = SUM(acntp, SAM(ac,acntp));
sambalchk(acntp) = SAM('total',acntp) - SAM(acntp,'total');
DISPLAY sambalchk;


* ################################################## *
* PARÁMETROS *
* ################################################## *


PARAMETER

  Q0(s)          producción sector s
  QH0(s)         demanda producto s hogares
  LD0(s)         demanda trabajo sector s
  KD0(s)         demanda capital sector s
  LS0            oferta trabajo hogares
  KS0            oferta capital hogares
  WL0            remuneración trabajo
  WK0            remuneración capital
  P0(s)          precio doméstico producto s
  YH0            ingreso hogares
  CPI0           índice precios consumidor
  EXR0           tipo cambio nominal (factor conversión)
  WALRAS0        walras (agregada al exogeneizar LS y KS y al establecer como numerario a CPI)

  delta_l(s)     participación trabajo sector s
  delta_k(s)     participación capital sector s
  phi(s)         parámetro eficiencia sector s
  alpha(s)       participación sector s en consumo hogares
  cwts(s)        participación producto s en CPI
  pw(s)          precio internacional producto s
  savf           ahorro resto del mundo (moneda extranjera)

;

* Calibración Variables

WL0   = 1;
WK0   = 1;
P0(s) = 1;
EXR0  = 1;
DISPLAY WL0, WK0, P0, EXR0;

Q0(s)  = (SAM('lab',s) + SAM('cap',s)) / P0(s);
QH0(s) = SAM(s,'hhd') / P0(s);
LD0(s) = SAM('lab',s) / WL0;
KD0(s) = SAM('cap',s) / WK0;
LS0    = SUM(s, LD0(s));
KS0    = SUM(s, KD0(s));
YH0    = SAM('hhd','total');
DISPLAY Q0, QH0, LD0, KD0, LS0, KS0, YH0;

* Calibración Parámetros - Producción

delta_l(s) = WL0 * LD0(s) / (P0(s) * Q0(s));
delta_k(s) = WK0 * KD0(s) / (P0(s) * Q0(s));
phi(s)     = Q0(s) / (LD0(s)**delta_l(s) * KD0(s)**delta_k(s));
DISPLAY delta_l, delta_k, phi;

* Calibración Parámetros - Consumo

alpha(s) = P0(s) * QH0(s) / YH0;
cwts(s)  = QH0(s) / SUM(sp, QH0(sp));
CPI0     = SUM(s, P0(s) * cwts(s));
DISPLAY alpha, cwts, CPI0;

* Calibración Parámetros - Sector Externo

pw(s)   = P0(s) / EXR0;
savf    = - SUM (s, P0(s) * (Q0(s) - QH0(s)));
WALRAS0 = - SUM(s, P0(s) * (Q0(s) - QH0(s))) - savf;
DISPLAY pw, savf, WALRAS0;


* ################################################## *
* VARIABLES ENDÓGENAS *
* ################################################## *


VARIABLES

  Q(s)       producción sector s
  QH(s)      demanda producto s hogares
  LD(s)      demanda trabajo sector s
  KD(s)      demanda capital sector s
  LS         oferta trabajo hogares
  KS         oferta capital hogares
  WL         remuneración trabajo
  WK         remuneración capital
  P(s)       precio doméstico producto s
  YH         ingreso hogar
  CPI        índice precios consumidor
  EXR        tipo cambio nominal (factor conversión)
  WALRAS     walras (agregada por exogeneizar WL y KL y establecer como numerario a CPI)

;


* ################################################## *
* ECUACIONES *
* ################################################## *


EQUATIONS

* Producción

  EQ_LABADEM(s)     demanda trabajo sector s
  EQ_CAPADEM(s)     demanda capital sector s
  EQ_PRODFN(s)      producción sector s

* Consumo

  EQ_HHDINC         ingreso hogares
  EQ_HHDDEM(s)      demanda sector s hogares

* Condiciones de Equilibrio

  EQ_LABEQ          equilibrio mercado trabajo
  EQ_CAPEQ          equilibrio mercado capital

* Índice de Precios al Consumidor

  EQ_CPI            índice precios consumidor

* Sector Externo

  EQ_P(s)           precio doméstico producto s
  EQ_CC             cuenta corriente balanza de pagos

;

* Producción

EQ_LABADEM(s)..
  LD(s) * WL =E= delta_l(s) * P(s) * Q(s);

EQ_CAPADEM(s)..
  KD(s) * WK =E= delta_k(s) * P(s) * Q(s);

EQ_PRODFN(s)..
  Q(s) =E= phi(s) * LD(s)**delta_l(s) * KD(s)**delta_k(s);

* Consumo

EQ_HHDINC..
  YH =E= WL * SUM(s, LD(s)) + WK * SUM(s, KD(s)) + savf * EXR;

EQ_HHDDEM(s)..
  QH(s) * P(s) =E= alpha(s) * YH;

* Condiciones de Equilibrio

EQ_LABEQ..
  LS =E= SUM(s, LD(s));

EQ_CAPEQ..
  KS =E= SUM(s, KD(s));

* Índice de Precios al Consumidor

EQ_CPI..
  CPI =E= SUM(s, P(s)* cwts(s));

* Sector Externo

EQ_P(s)..
  P(s) =E= pw(s) * EXR;

EQ_CC..
  SUM(s, pw(s) * (Q(s) - QH(s))) + WALRAS =E= -savf;


* ################################################## *
* MODELO *
* ################################################## *


MODEL CGE

/
  EQ_LABADEM
  EQ_CAPADEM
  EQ_PRODFN
  EQ_HHDINC
  EQ_HHDDEM
  EQ_LABEQ
  EQ_CAPEQ
  EQ_CPI
  EQ_P
  EQ_CC
/

;

* Valores iniciales para las variables endógenas

Q.L(s)   = Q0(s);
QH.L(s)  = QH0(s);
LD.L(s)  = LD0(s);
KD.L(s)  = KD0(s);
LS.L     = LS0;
KS.L     = KS0;
WL.L     = WL0;
WK.L     = WK0;
P.L(s)   = P0(s);
YH.L     = YH0;
CPI.L    = CPI0;
EXR.L    = EXR0;
WALRAS.L = WALRAS0;

* Numerario

CPI.FX = CPI0;

* Regla de cierre de los mercados de factores

LS.FX = LS0;
KS.FX = KS0;


* ################################################## *
* SOLUCIÓN *
* ################################################## *


OPTION CNS = PATH;

CGE.ITERLIM = 0;

SOLVE CGE USING CNS;
DISPLAY Q.L, QH.L, LD.L, KD.L, WL.L, WK.L, P.L, YH.L, CPI.L, EXR.L, WALRAS.L;

CGE.ITERLIM = 10000;

* Chequeo: Duplicación del numerario

*CPI.FX = CPI0 * 2

*SOLVE CGE USING CNS;
*DISPLAY Q.L, QH.L, LD.L, KD.L, WL.L, WK.L, P.L, YH.L, CPI.L, EXR.L, WALRAS.L;