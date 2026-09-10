* mod.gms
* Martin Cicowiez
* martin@depeco.econo.unlp.edu.ar
* 23/02/2021


* ################################################## *
* PARÁMETROS *
* ################################################## *


PARAMETER

  QA0          producción sector A                        /231/
  QM0          producción sector M                        /260/
  QHA0         demanda producto A hogares                 /141/
  QHM0         demanda producto M hogares                 /170/
  QINTAA0      demanda intermedia de A en A               /60/
  QINTMA0      demanda intermedia de M en A               /30/
  QINTAM0      demanda intermedia de A en M               /30/
  QINTMM0      demanda intermedia de M en A               /60/
  LDA0         demanda trabajo sector A                   /45/
  KDA0         demanda capital sector A                   /75/
  LDM0         demanda trabajo sector M                   /80/
  KDM0         demanda capital sector M                   /55/
  LS0          oferta trabajo hogares                     /125/
  KS0          oferta capital hogares                     /130/
  WL0          remuneración trabajo                       /1/
  WK0          remuneración capital                       /1/
  PA0          precio producto A                          /1/
  PM0          precio producto M                          /1/
  PVAA0        precio valor agregado sector A
  PVAM0        precio valor agregado sector M
  YL0          ingreso trabajo hogares                    /125/
  YK0          ingreso capital hogares                    /130/
  YH0          ingreso hogares                            /311/
  TRNSFR0      recaudación tributaria                     /56/

  delta_la     participación trabajo sector A
  delta_ka     participación capital sector A
  delta_lm     participación trabajo sector M
  delta_km     participación capital sector M
  phi_a        parámetro eficiencia sector A
  phi_m        parametro eficiencia sector M
  ica_aa       coeficiente insumo-producto A-A
  ica_ma       coeficiente insumo-producto M-A
  ica_am       coeficiente insumo-producto A-M
  ica_mm       coeficiente insumo-producto M-M
  alpha_a      participación producto A en consumo hogares
  alpha_m      participación producto M en consumo hogares
  taa          tasa impuesto indirecto sector A
  tam          tasa impuesto indirecto sector M

  ytaxacta     recaudación impuesto indirecto A           /21/
  ytaxactm     recaudación impuesto indirecto M           /35/

;       

* Calibración Variables Endógenas

PVAA0 = (WL0 * LDA0 + WK0 * KDA0) / (PA0 * QA0);
PVAM0 = (WL0 * LDM0 + WK0 * KDM0) / (PM0 * QM0);
DISPLAY PVAA0, PVAM0;

* Calibración Parámetros - Producción

delta_la = WL0 * LDA0 / (PVAA0 * QA0);
delta_ka = WK0 * KDA0 / (PVAA0 * QA0);
delta_lm = WL0 * LDM0 / (PVAM0 * QM0);
delta_km = WL0 * KDM0 / (PVAM0 * QM0);
DISPLAY delta_la, delta_ka, delta_lm, delta_km;

phi_a    = QA0 / (LDA0**delta_la * KDA0**delta_ka);
phi_m    = QM0 / (LDM0**delta_lm * KDM0**delta_km);
DISPLAY phi_a, phi_m;

ica_aa   = QINTAA0 / QA0;
ica_ma   = QINTMA0 / QA0;
ica_am   = QINTAM0 / QM0;
ica_mm   = QINTMM0 / QM0;
DISPLAY ica_aa, ica_mm, ica_am, ica_mm;

* Calibración Parámetros - Consumo

alpha_a = PA0 * QHA0 / YH0;
alpha_m = PM0 * QHM0 / YH0;
DISPLAY alpha_a, alpha_m;

* Calibración Parámetros - Tasas impositivas

taa = ytaxacta / (PA0 * QA0);
tam = ytaxactm / (PM0 * QM0);
DISPLAY taa, tam;


* ################################################## *
* VARIABLES ENDÓGENAS *
* ################################################## *


VARIABLES

  QA          producción sector A
  QM          producción sector M
  QHA         demanda producto A hogares
  QHM         demanda producto M hogares
  QINTAA      demanda intermedia de A en A
  QINTMA      demanda intermedia de M en A
  QINTAM      demanda intermedia de A en M
  QINTMM      demanda intermedia de M en A
  LDA         demanda trabajo sector A
  KDA         demanda capital sector A
  LDM         demanda trabajo sector M
  KDM         demanda capital sector M
  LS          oferta trabajo hogares
  KS          oferta capital hogares
  WL          remuneración trabajo
  WK          remuneración capital
  PA          precio producto A
  PM          precio producto M
  PVAA        precio valor agregado sector A
  PVAM        precio valor agregado sector M
  YL          ingreso trabajo hogares
  YK          ingreso capital hogares
  YH          ingreso hogares
  TRNSFR      recaudación tributaria

;


* ################################################## *
* ECUACIONES *
* ################################################## *


EQUATIONS

* Producción

  EQ_LABADEM      demanda trabajo sector A
  EQ_CAPADEM      demanda capital sector A
  EQ_PRODFNA      producción sector A
  EQ_INTDEMAA     demanda intermedia de A en A
  EQ_INTDEMMA     demanda intermedia de M en A

  EQ_LABMDEM      demanda trabajo sector M
  EQ_CAPMDEM      demanda capital sector M
  EQ_PRODFNM      producción sector M
  EQ_INTDEMAM     demanda intermedia de A en M
  EQ_INTDEMMM     demanda intermedia de M en M

  EQ_PVAADEF      precio valor agregado sector A
  EQ_PVAMDEF      precio valor agregado sector M

  EQ_LABINC       ingreso trabajo hogares
  EQ_CAPINC       ingreso capital hogares

* Consumo

  EQ_GOVINC       ingreso gobierno
  EQ_HHDINC       ingreso hogares

  EQ_HHDDEMA      demanda sector A hogares
  EQ_HHDDEMM      demanda sector M hogares

* Condiciones de Equilibrio

  EQ_LABEQ        equilibrio mercado trabajo
  EQ_CAPEQ        equilibrio mercado capital

  EQ_COMAEQ       equilibrio mercado sector A
  EQ_COMMEQ       equilibrio mercado sector M

;

* Producción

EQ_LABADEM..
  LDA*WL =E= delta_la * PVAA * QA;

EQ_CAPADEM..
  KDA*WK =E= delta_ka * PVAA * QA;

EQ_PRODFNA..
  QA =E= phi_a * LDA**delta_la * KDA**delta_ka;

EQ_INTDEMAA..
  QINTAA =E= ica_aa * QA;

EQ_INTDEMMA..
  QINTMA =E= ica_ma * QA;

EQ_LABMDEM..
  LDM*WL =E= delta_lm * PVAM * QM;

EQ_CAPMDEM..
  KDM*WK =E= delta_km * PVAM * QM;

EQ_PRODFNM..
  QM =E= phi_m * LDM**delta_lm * KDM**delta_km;

EQ_INTDEMAM..
  QINTAM =E= ica_am * QM;

EQ_INTDEMMM..
  QINTMM =E= ica_mm * QM;

EQ_PVAADEF..
  PVAA*QA =E= PA * (1 - taa) * QA - PA * QINTAA - PM * QINTMA;

EQ_PVAMDEF..
  PVAM*QM =E= PM * (1 - tam) * QM - PA * QINTAM - PM * QINTMM;

EQ_LABINC..
  YL =E= WL * LDA + WL * LDM;

EQ_CAPINC..
  YK =E= WK * KDA + WK * KDM;

* Consumo

EQ_GOVINC..
  TRNSFR =E= taa * PA * QA + tam * PM * QM;

EQ_HHDINC..
  YH =E= YL + YK + TRNSFR;

EQ_HHDDEMA..
  QHA*PA =E= alpha_a * YH;

EQ_HHDDEMM..
  QHM*PM =E= alpha_m * YH;

* Condiciones de Equilibrio

EQ_LABEQ..
    LS =E= LDA + LDM;

EQ_CAPEQ..
    KS =E= KDA + KDM;

EQ_COMAEQ..
  QA =E= QINTAA + QINTAM + QHA;

EQ_COMMEQ..
  QM =E= QINTMA + QINTMM + QHM;


* ################################################## *
* MODELO *
* ################################################## *


MODEL CGE

/
  EQ_LABADEM
  EQ_CAPADEM
  EQ_PRODFNA
  EQ_INTDEMAA
  EQ_INTDEMMA
  EQ_LABMDEM
  EQ_CAPMDEM
  EQ_PRODFNM
  EQ_INTDEMAM
  EQ_INTDEMMM
  EQ_PVAADEF
  EQ_PVAMDEF
  EQ_LABINC
  EQ_CAPINC

  EQ_GOVINC
  EQ_HHDINC
  EQ_HHDDEMA
  EQ_HHDDEMM

  EQ_LABEQ
  EQ_CAPEQ
  EQ_COMAEQ
* EQ_COMMEQ
/

;

* Valores iniciales para las variables endógenas

QA.L     = QA0;
QM.L     = QM0;
QHA.L    = QHA0;
QHM.L    = QHM0;
QINTAA.L = QINTAA0;
QINTMA.L = QINTMA0;
QINTAM.L = QINTAM0;
QINTMM.L = QINTMM0;
LDA.L    = LDA0;
KDA.L    = KDA0;
LDM.L    = LDM0;
KDM.L    = KDM0;
LS.L     = LS0;
KS.L     = KS0;
WL.L     = WL0;
WK.L     = WK0;
PA.L     = PA0;
PM.L     = PM0;
PVAA.L   = PVAA0;
PVAM.L   = PVAM0;
YL.L     = YL0;
YK.L     = YK0;
YH.L     = YH0;
TRNSFR.L = TRNSFR0;

* Numerario

WL.FX = WL0;

* Regla de cierre de los mercados de factores

LS.FX = LS0;
KS.FX = KS0;


* ################################################## *
* SOLUCIÓN *
* ################################################## *


OPTION CNS = PATH;

CGE.ITERLIM = 0;

SOLVE CGE USING CNS;
PARAMETER walras;
walras = QM.L - QINTMA.L - QINTMM.L - QHM.L;
DISPLAY QA.L, QM.L, QHA.L, QHM.L, LDA.L, KDA.L, LDM.L, KDM.L, WL.L, WK.L, PA.L, PM.L, YL.L, YK.L, YH.L, walras;

CGE.ITERLIM = 10000;


* ################################################## *
* SIMULACIONES DE SHOCKS *
* ################################################## *


* 1. Duplicar el numerario

WL.FX = WL0 * 2;

SOLVE CGE USING CNS;
PARAMETER walras;
walras = QM.L - QINTMA.L - QINTMM.L - QHM.L;
DISPLAY QA.L, QM.L, QHA.L, QHM.L, LDA.L, KDA.L, LDM.L, KDM.L, WL.L, WK.L, PA.L, PM.L, YL.L, YK.L, YH.L, walras;

* 2. Duplicar la oferta trabajo

WL.FX = WL0;
LS.FX = LS0 * 2;

SOLVE CGE USING CNS;
PARAMETER walras;
walras = QM.L - QINTMA.L - QINTMM.L - QHM.L;
DISPLAY QA.L, QM.L, QHA.L, QHM.L, LDA.L, KDA.L, LDM.L, KDM.L, WL.L, WK.L, PA.L, PM.L, YL.L, YK.L, YH.L, walras;