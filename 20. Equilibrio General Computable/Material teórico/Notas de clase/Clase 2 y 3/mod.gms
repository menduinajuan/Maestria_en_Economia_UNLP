* mod.gms
* Martin Cicowiez
* martin@depeco.econo.unpl.edu.ar
* 23/02/2021


* ################################################## *
* SETS *
* ################################################## *


SET

  ac            set global (cuentas sam y otros items)
    /
    s-a         sector A
    s-m         sector M
    lab         trabajo
    cap         capital
    tax-act     impuesto indirecto actividades
    hhd         hogares
    total       total
    /

  s(ac)         sectores
    /s-a, s-m/

  acnt(ac)      todos los elementos de ac excepto el total

;

ALIAS (acp,ac), (sp,s), (acntp, acnt);

acnt(ac)      = YES;
acnt('total') = NO;

PARAMETER

  SAM(ac,acp)        matriz de contabilidad social
  sambalchk(ac)      chequeo de balance de matriz

;

TABLE SAM(ac,ac)     matriz de contabilidad social

           s-a     s-m     lab     cap     tax-act     hhd     total
s-a         60      30                                 141       231
s-m         30      60                                 170       260
lab         45      80                                           125
cap         75      55                                           130
tax-act     21      35                                            56
hhd                        125     130          56               311
total      231     260     125     130          56     311

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

  Q0(s)           producción sector s
  QH0(s)          demanda producto s hogares
  QINT0(s,sp)     demanda intermedia de s en sp
  LD0(s)          demanda trabajo sector s
  KD0(s)          demanda capital sector s
  LS0             oferta trabajo hogares
  KS0             oferta capital hogares
  WL0             remuneración trabajo
  WK0             remuneración capital
  P0(s)           precio producto s
  PVA0(s)         precio valor agregado sector s
  YL0             ingreso trabajo hogares
  YK0             ingreso capital hogares
  YH0             ingreso hogares
  TRNSFR0         recaudación tributaria

  delta_l(s)      participación trabajo sector s
  delta_k(s)      participación capital sector s
  phi(s)          parámetro eficiencia sector s
  ica(s,sp)       coeficiente insumo-producto s-sp
  alpha(s)        participación producto s en consumo hogares
  ta(s)           tasa impuesto indirecto sector s

;

* Calibración Variables Endógenas

WL0   = 1;
WK0   = 1;
P0(s) = 1;
DISPLAY WL0, WK0, P0;

Q0(s)       = SAM(s,'total') / P0(s);
QH0(s)      = SAM(s,'hhd') / P0(s);
QINT0(s,sp) = SAM(s,sp) / P0(s);
LD0(s)      = SAM('lab',s) / WL0;
KD0(s)      = SAM('cap',s) / WK0;
LS0         = SUM(s, LD0(s));
KS0         = SUM(s, KD0(s));
PVA0(s)     = (SAM('lab',s) + SAM('cap',s)) / SAM('total',s);
YL0         = SAM('hhd','lab');
YK0         = SAM('hhd','cap');
YH0         = SAM('hhd','total');
TRNSFR0     = SAM('hhd','tax-act');
DISPLAY Q0, QH0, QINT0, LD0, KD0, LS0, KS0, PVA0, YL0, YK0, YH0, TRNSFR0;

* Calibración Parámetros - Producción

delta_l(s) = WL0 * LD0(s) / (PVA0(s) * Q0(s));
delta_k(s) = WK0 * KD0(s) / (PVA0(s) * Q0(s));
phi(s)     = Q0(s) / (LD0(s)**delta_l(s) * KD0(s)**delta_k(s));
ica(s,sp)  = QINT0(s,sp) / Q0(sp);
DISPLAY delta_l, delta_k, phi, ica;

* Calibración Parámetros - Consumo

alpha(s) = P0(s) * QH0(s) / YH0;
DISPLAY alpha;

* Calibración Parámetros - Tasas Impositivas

ta(s) = SAM('tax-act',s) / SAM('total',s);
DISPLAY ta;


* ################################################## *
* VARIABLES ENDÓGENAS *
* ################################################## *


VARIABLES

  Q(s)           producción sector s
  QH(s)          demanda producto s hogares
  QINT(s,sp)     demanda intermedia de s en sp
  LD(s)          demanda trabajo sector s
  KD(s)          demanda capital sector s
  LS             oferta trabajo hogares
  KS             oferta capital hogares
  WL             remuneración trabajo
  WK             remuneración capital
  P(s)           precio producto s
  PVA(s)         precio valor agregado sector s
  YL             ingreso trabajo hogares
  YK             ingreso capital hogares
  YH             ingreso hogares
  TRNSFR         recaudación tributaria

;


* ################################################## *
* ECUACIONES *
* ################################################## *


EQUATIONS

* Producción

  EQ_LABADEM(s)       demanda trabajo sector s
  EQ_CAPADEM(s)       demanda capital sector s
  EQ_PRODFN(s)        producción sector s
  EQ_INTDEM(s,sp)     demanda intermedia de s en sp
  EQ_PVADEF(s)        precio valor agregado sector s
  EQ_LABINC           ingreso trabajo hogares
  EQ_CAPINC           ingreso capital hogares

* Consumo

  EQ_GOVINC           ingreso gobierno
  EQ_HHDINC           ingreso hogares
  EQ_HHDDEM(s)        demanda sector s

* Condiciones de Equilibrio

  EQ_LABEQ      ´     equilibrio mercado trabajo
  EQ_CAPEQ            equilibrio mercado capital
  EQ_COMEQ(s)         equilibrio mercado sector s

;

* Producción

EQ_LABADEM(s)..
  LD(s) * WL =E= delta_l(s) * PVA(s) * Q(s);

EQ_CAPADEM(s)..
  KD(s) * WK =E= delta_k(s) * PVA(s) * Q(s);

EQ_PRODFN(s)..
  Q(s) =E= phi(s) * LD(s)**delta_l(s) * KD(s)**delta_k(s);

EQ_INTDEM(s,sp)..
  QINT(s,sp) =E= ica(s,sp) * Q(sp);

EQ_PVADEF(s)..
  PVA(s) * Q(s) =E= P(s) * (1 - ta(s)) * Q(s) - SUM(sp, P(sp) * QINT(sp,s));

EQ_LABINC..
  YL =E= SUM(s, WL * LD(s));

EQ_CAPINC..
  YK =E= SUM(s, WK * KD(s));

* Consumo

EQ_GOVINC..
  TRNSFR =E= SUM(s, ta(s) * P(s) * Q(s));

EQ_HHDINC..
  YH =E= YL + YK + TRNSFR;

EQ_HHDDEM(s)..
  QH(s) * P(s) =E= alpha(s) * YH;

* Condiciones de Equilibrio

EQ_LABEQ..
  LS =E= SUM(s, LD(s));

EQ_CAPEQ..
  KS =E= SUM(s, KD(s));

EQ_COMEQ('s-a')..
  Q('s-a') =E= SUM(s, QINT('s-a',s)) + QH('s-a');


* ################################################## *
* MODELO *
* ################################################## *


MODEL CGE

/
  EQ_LABADEM
  EQ_CAPADEM
  EQ_PRODFN
  EQ_INTDEM
  EQ_PVADEF
  EQ_LABINC
  EQ_CAPINC
  EQ_GOVINC
  EQ_HHDINC
  EQ_HHDDEM
  EQ_LABEQ
  EQ_CAPEQ
  EQ_COMEQ
/

;

* Valores iniciales para las variables endógenas

Q.L(s)       = Q0(s);
QH.L(s)      = QH0(s);
QINT.L(s,sp) = QINT0(s,sp);
LD.L(s)      = LD0(s);
KD.L(s)      = KD0(s);
LS.L         = LS0;
KS.L         = KS0;
WL.L         = WL0;
WK.L         = WK0;
P.L(s)       = P0(s);
PVA.L(s)     = PVA0(s);
YL.L         = YL0;
YK.L         = YK0;
YH.L         = YH0;
TRNSFR.L     = TRNSFR0;

* Numerario

WL.FX = WL0;

* Regla de cierre mercados factores

LS.FX = LS0;
KS.FX = KS0;


* ################################################## *
* SOLUCIÓN *
* ################################################## *


OPTION CNS = PATH;

CGE.ITERLIM = 0;

SOLVE CGE USING CNS;
PARAMETER walras;
walras = Q.L('s-m') - SUM(s, QINT.L('s-m',s)) - QH.L('s-m');
DISPLAY Q.L, QH.L, LD.L, KD.L, WL.L, WK.L, P.L, YL.L, YK.L, YH.L, walras;

CGE.ITERLIM = 10000;


* ################################################## *
* SIMULACIONES DE SHOCKS *
* ################################################## *


* 1. Duplicar el numerario

WL.FX = WL0 * 2;

SOLVE CGE USING CNS;
PARAMETER walras;
walras = Q.L('s-m') - SUM(s, QINT.L('s-m',s)) - QH.L('s-m');
DISPLAY Q.L, QH.L, LD.L, KD.L, WL.L, WK.L, P.L, YL.L, YK.L, YH.L, walras;

* 2. Duplicar la oferta trabajo

WL.FX = WL0;
LS.FX = LS0 * 2;

SOLVE CGE USING CNS;
PARAMETER walras;
walras = Q.L('s-m') - SUM(s, QINT.L('s-m',s)) - QH.L('s-m');
DISPLAY Q.L, QH.L, LD.L, KD.L, WL.L, WK.L, P.L, YL.L, YK.L, YH.L, walras;