* Equilibrio General Computable - Trabajo Práctico N° 2
* Juan Menduiña


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
    tax-dir     impuesto directo ingresos
    h-rur       hogares rural
    h-urb       hogares urbano
    gov         gobierno
    total       total
    /

  s(ac)         sectores
    /s-a, s-m/

  f(ac)         factores
    /lab, cap/

  h(ac)         hogares
    /h-rur, h-urb/

  acnt(ac)      todos los elementos de ac excepto el total

;

ALIAS (acp,ac), (sp,s), (fp,f), (hp, h), (acntp, acnt);

acnt(ac)      = YES;
acnt('total') = NO;

PARAMETER

  SAM(ac,acp)        matriz de contabilidad social
  sambalchk(ac)      chequeo de balance de matriz

;

TABLE SAM(ac,ac)     matriz de contabilidad social

           s-a     s-m     lab     cap     tax-act     tax-dir     h-rur     h-urb     gov     total
s-a         60      30                                                80        61               231
s-m         30      60                                                90        80               260
lab         45      80                                                                           125
cap         75      55                                                                           130
tax-act     21      35                                                                            56
tax-dir                                                               10        35                45
h-rur                       90      20                                                  70       180
h-urb                       35     110                                                  31       176
gov                                             56          45                                   101
total      231     260     125     130          56          45       180       176     101

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
  QH0(s,h)        demanda producto s hogar h
  QINT0(s,sp)     demanda intermedia de s en sp
  LD0(s)          demanda trabajo sector s
  KD0(s)          demanda capital sector s
  LS0             oferta trabajo hogares
  KS0             oferta capital hogares
  WL0             remuneración trabajo
  WK0             remuneración capital
  P0(s)           precio producto s
  PVA0(s)         precio valor agregado sector s
  YL0(h)          ingreso trabajo hogar h
  YK0(h)          ingreso capital hogar h
  YH0(h)          ingreso hogar h
  TRNSFR0(h)      transferencia al hogar h
  SHRYL0(h)       participación hogar h en ingreso trabajo
  SHRYK0(h)       participación hogar h en ingreso capital
  SHRT0(h)        participación hogar h en transferencia

  delta_l(s)      participación trabajo sector s
  delta_k(s)      participación capital sector s
  phi(s)          parámetro eficiencia sector s
  ica(s,sp)       coeficiente insumo-producto s-sp
  alpha(s,h)      participación producto s en consumo hogar h
  ta(s)           tasa impuesto indirecto sector s
  ty(h)           tasa impuesto directo hogar h

;

* Calibración Variables

WL0   = 1;
WK0   = 1;
P0(s) = 1;
DISPLAY WL0, WK0, P0;

Q0(s)       = SAM(s,'total') / P0(s);
QH0(s,h)    = SAM(s,h) / P0(s);
QINT0(s,sp) = SAM(s,sp) / P0(s);
LD0(s)      = SAM('lab',s) / WL0;
KD0(s)      = SAM('cap',s) / WK0;
LS0         = SUM(s, LD0(s));
KS0         = SUM(s, KD0(s));
PVA0(s)     = SUM(f, SAM(f,s)) / SAM('total',s);
YL0(h)      = SAM(h,'lab');
YK0(h)      = SAM(h,'cap');
YH0(h)      = SAM(h,'total');
TRNSFR0(h)  = SAM(h,'gov');
SHRYL0(h)   = YL0(h) / SAM('total','lab');
SHRYK0(h)   = YK0(h) / SAM('total','cap');
SHRT0(h)    = TRNSFR0(h) / SAM('total','gov');
DISPLAY Q0, QH0, QINT0, LD0, KD0, LS0, KS0, PVA0, YL0, YK0, YH0, TRNSFR0, SHRYL0, SHRYK0, SHRT0;

* Calibración Parámetros - Producción

delta_l(s) = WL0 * LD0(s) / (PVA0(s) * Q0(s));
delta_k(s) = WK0 * KD0(s) / (PVA0(s) * Q0(s));
phi(s)     = Q0(s) / (LD0(s)**delta_l(s) * KD0(s)**delta_k(s));
ica(s,sp)  = QINT0(s,sp) / Q0(sp);
DISPLAY delta_l, delta_k, phi, ica;

* Calibración Parámetros - Tasas Impositivas

ta(s) = SAM('tax-act',s) / SAM('total',s);
ty(h) = SAM('tax-dir',h) / SAM('total',h);
DISPLAY ta, ty;

* Calibración Parámetros - Consumo

alpha(s,h) = P0(s) * QH0(s,h) / (YH0(h) * (1 - ty(h)));
DISPLAY alpha;


* ################################################## *
* VARIABLES ENDÓGENAS *
* ################################################## *


VARIABLES

  Q(s)           producción sector s
  QH(s,h)        demanda producto s hogar h
  QINT(s,sp)     demanda intermedia de s en sp
  LD(s)          demanda trabajo sector s
  KD(s)          demanda capital sector s
  LS             oferta trabajo hogares
  KS             oferta capital hogares
  WL             remuneración trabajo
  WK             remuneración capital
  P(s)           precio producto s
  PVA(s)         precio valor agregado sector s
  YL(h)          ingreso trabajo hogar h
  YK(h)          ingreso capital hogar h
  YH(h)          ingreso hogar h
  TRNSFR(h)      transferencia hogar h
  SHRYL(h)       participación hogar h en ingreso trabajo
  SHRYK(h)       participación hogar h en ingreso capital
  SHRT(h)        participación hogar h en transferencia

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
  EQ_LABINC(h)        ingreso trabajo hogar h
  EQ_CAPINC(h)        ingreso capital hogar h
  EQ_SHRYL(h)         participación hogar h en ingreso trabajo
  EQ_SHRYK(h)         participación hogar h en ingreso capital

* Consumo

  EQ_GOVINC(h)        ingreso gobierno
  EQ_HHDINC(h)        ingreso hogar h
  EQ_HHDDEM(s,h)      demanda sector s hogar h
  EQ_SHRT(h)          participación hogar h en transferencia
  
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

EQ_LABINC(h)..
  YL(h) =E= SHRYL(h) * SUM(s, WL * LD(s));

EQ_CAPINC(h)..
  YK(h) =E= SHRYK(h) * SUM(s, WK * KD(s));
  
EQ_SHRYL(h)..
  SHRYL(h) =E= YL(h) / (YL('h-rur') + YL('h-urb'));
  
EQ_SHRYK(h)..
  SHRYK(h) =E= YK(h) / (YK('h-rur') + YK('h-urb'));
  
* Consumo

EQ_GOVINC(h)..
  TRNSFR(h) =E= SHRT(h) * (SUM(s, ta(s) * P(s) * Q(s)) + SUM(hp, ty(hp) * YH(hp)));

EQ_HHDINC(h)..
  YH(h) =E= YL(h) + YK(h) + TRNSFR(h);

EQ_HHDDEM(s,h)..
  QH(s,h) * P(s) =E= alpha(s,h) * YH(h) * (1 - ty(h));

EQ_SHRT(h)..
  SHRT(h) =E= TRNSFR(h) / (SUM(hp, TRNSFR(h)));

* Condiciones de Equilibrio

EQ_LABEQ..
  LS =E= SUM(s, LD(s));

EQ_CAPEQ..
  KS =E= SUM(s, KD(s));

EQ_COMEQ('s-a')..
  Q('s-a') =E= SUM(s, QINT('s-a',s)) + SUM(h, QH('s-a',h));


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
  EQ_SHRYL
  EQ_SHRYK

  EQ_GOVINC
  EQ_HHDINC
  EQ_HHDDEM
  EQ_SHRT

  EQ_LABEQ
  EQ_CAPEQ
  EQ_COMEQ
/

;

* Valores iniciales para las variables endógenas

Q.L(s)       = Q0(s);
QH.L(s,h)    = QH0(s,h);
QINT.L(s,sp) = QINT0(s,sp);
LD.L(s)      = LD0(s);
KD.L(s)      = KD0(s);
LS.L         = LS0;
KS.L         = KS0;
WL.L         = WL0;
WK.L         = WK0;
P.L(s)       = P0(s);
PVA.L(s)     = PVA0(s);
YL.L(h)      = YL0(h);
YK.L(h)      = YK0(h);
YH.L(h)      = YH0(h);
TRNSFR.L(h)  = TRNSFR0(h);
SHRYL.L(h)   = SHRYL0(h);      
SHRYK.L(h)   = SHRYK0(h);     
SHRT.L(h)    = SHRT0(h);

* Numerario

WL.FX = WL0;

* Regla de cierre de los mercados factores

LS.FX = LS0;
KS.FX = KS0;


* ################################################## *
* SOLUCIÓN *
* ################################################## *


OPTION CNS = PATH;

CGE.ITERLIM = 0;

SOLVE CGE USING CNS;
PARAMETER walras;
walras = Q.L('s-m') - SUM(s, QINT.L('s-m',s)) - SUM(h, QH.L('s-m',h));
DISPLAY Q.L, QH.L, LD.L, KD.L, WL.L, WK.L, P.L, YL.L, YK.L, YH.L, TRNSFR.L, walras;

CGE.ITERLIM = 10000;

* Chequeo: Duplicación del numerario

*WL.FX = WL0 * 2;

*SOLVE CGE USING CNS;
*DISPLAY Q.L, QH.L, LD.L, KD.L, WL.L, WK.L, P.L, YL.L, YK.L, YH.L, TRNSFR.L, walras;


* ################################################## *
* SIMULACIONES DE SHOCKS *
* ################################################## *


* 1. Aumentar 25% la oferta de capital

KS.FX = KS0 * 1.25;

SOLVE CGE USING CNS;
DISPLAY Q.L, QH.L, LD.L, KD.L, WL.L, WK.L, P.L, YL.L, YK.L, YH.L, TRNSFR.L, walras;

* 2. Aumentar 10 puntos porcentuales la tasa del impuesto directo del hogar "h-urb"

KS.FX       = KS0;
ty('h-urb') = ty('h-urb') + 0.10;

SOLVE CGE USING CNS;
DISPLAY Q.L, QH.L, LD.L, KD.L, WL.L, WK.L, P.L, YL.L, YK.L, YH.L, TRNSFR.L, walras;