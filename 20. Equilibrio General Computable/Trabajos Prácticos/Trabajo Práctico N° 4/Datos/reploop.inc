CPIX('%1')                   = CPI.L;
EGX('%1')                    = EG.L;
EXRX('%1')                   = EXR.L;
KDX(a,'%1')                  = KD.L(a);
KSX('%1')                    = KS.L;
LDX(a,'%1')                  = LD.L(a);
LSX('%1')                    = LS.L;
PAX(a,'%1')                  = PA.L(a);
PDX(c,'%1')                  = PD.L(c);
PEX(c,'%1')                  = PE.L(c);
PMX(c,'%1')                  = PM.L(c);
PQX(c,'%1')                  = PQ.L(c);
PVAX(a,'%1')                 = PVA.L(a);
PXX(c,'%1')                  = PX.L(c);
QAX(a,'%1')                  = QA.L(a);
QDX(c,'%1')                  = QD.L(c);
QEX(c,'%1')                  = QE.L(c);
QHX(c,'%1')                  = QH.L(c);
QINTX(c,a,'%1')              = QINT.L(c,a);
QINVX(c,'%1')                = QINV.L(c);
QINVSCALX('%1')              = QINVSCAL.L;
QMX(c,'%1')                  = QM.L(c);
QQX(c,'%1')                  = QQ.L(c);
QXX(c,'%1')                  = QX.L(c);
WKX(a,'%1')                  = WK.L(a);
WLX('%1')                    = WL.L;
YGX('%1')                    = YG.L;
YHX('%1')                    = YH.L;
YKX('%1')                    = YK.L;
YLX('%1')                    = YL.L;
TYX('%1')                    = TY.L;
TYSCALX('%1')                = TYSCAL.L;
SAVGX('%1')                  = SAVG.L;
SAVGRX('%1')                 = SAVGR.L;
WALRASX('%1')                = WALRAS.L;

qdstkX(c,'%1')               = qdstk(c);
qinvbX(c,'%1')               = qinvb(c);
mpsX('%1')                   = mps;
savfX('%1')                  = savf;
taX(a,'%1')                  = ta(a);
teX(c,'%1')                  = te(c);
tmX(c,'%1')                  = tm(c);
tqX(c,'%1')                  = tq(c);
tybX('%1')                   = tyb;
qgX(c,'%1')                  = qg(c);
trnsfrX(ac,ins,'%1')         = trnsfr(ac,ins);
pweX(c,'%1')                 = pwe(c);
pwmX(c,'%1')                 = pwm(c);

ehX('%1')                    = (1 - mps) * (1 - TY.L) * YH.L;
ev('%1')                     = PROD(c$QQ0(c), (PQ0(c) / PQ.L(c)) ** alpha(c)) * ehX('%1') - ehX('base');

dpiX('%1')                   = SUM(c, PD.L(c) * dwts(c));
rexrX('%1')                  = EXR.L / dpiX('%1');

modsolstat('solvestat','%1') = CGE.SOLVESTAT;
modsolstat('modelstat','%1') = CGE.MODELSTAT;


* ################################################## *
* Reporte "Resultados macroeconómicos (gpprep)" *
* ################################################## *


gdprep('PrvCon','%1')      = SUM(c, PQ0(c) * QH.L(c));
gdprep('GovCon','%1')      = SUM(c, PQ0(c) * qg(c));
gdprep('FixInv','%1')      = SUM(c, PQ0(c) * QINV.L(c));
gdprep('StockChange','%1') = SUM(c, PQ0(c) * qdstk(c));
gdprep('Exports','%1')     = SUM(c, pwe0(c) * EXR0 * QE.L(c));
gdprep('Imports','%1')     = -SUM(c, pwm0(c) * EXR0 * QM.L(c));
gdprep('GDPMP','%1')       = SUM(igdp2, gdprep(igdp2,'%1'));
gdprep('GDPFC','%1')       = SUM(a, PVA0(a) * QA.L(a));
gdprep('NetIndTax','%1')   = SUM(a, ta(a) * PA0(a) * QA.L(a)) + SUM(c, tm(c) * pwm0(c) * EXR0 * QM.L(c)) +
                             SUM(c, te(c) * pwe0(c) * EXR0 * QE.L(c)) + SUM(c, tq(c) * (PD0(c) * QD.L(c) + PM0(c) * QM.L(c)));
gdprep('Absorption','%1')  = gdprep('GDPMP','%1') - gdprep('Exports','%1') - gdprep('Imports','%1');

DISPLAY gdprep, rexrX;


* ################################################## *
* Reporte "Resultados sectoriales (sectorstruc)" *
* ################################################## *


sectorstruc(c,'VAshr','%1')                        = 1e-10 + 100 * SUM(a, theta(a,c) * PVA.L(a) * QA.L(a)) / SUM(ap, PVA.L(ap) * QA.L(ap));
sectorstruc('total','VAshr','%1')                  = SUM(c, sectorstruc(c,'VAshr','%1'));

sectorstruc(c,'PRDshr','%1')                       = 1e-10 + 100 * SUM(a, theta(a,c) * PA.L(a) * QA.L(a)) / SUM(ap, PA.L(ap) * QA.L(ap));
sectorstruc('total','PRDshr','%1')                 = SUM(c, sectorstruc(c,'PRDshr','%1'));

sectorstruc(c,'EMPshr','%1')                       = 1e-10 + 100 * SUM(a, theta(a,c) * LD.L(a)) / SUM(ap, LD.L(ap));
sectorstruc('total','EMPshr','%1')                 = SUM(c, sectorstruc(c,'EMPshr','%1'));

sectorstruc(c,'EXPshr','%1')                       = 1e-10 + 100 * pwe(c) * EXR.L * QE.L(c) / SUM(cp, pwe(cp) * EXR.L * QE.L(cp));
sectorstruc('total','EXPshr','%1')                 = SUM(c, sectorstruc(c,'EXPshr','%1'));

sectorstruc(c,'EXP-OUTshr','%1')$(PX.L(c)*QX.L(c)) = 1e-10 + 100 * PE.L(c) * QE.L(c) / (PX.L(c) * QX.L(c));
sectorstruc('total','EXP-OUTshr','%1')             = 100 * SUM(cp, PE.L(cp) * QE.L(cp)) / SUM(cp, PX.L(cp) * QX.L(cp));

sectorstruc(c,'IMPshr','%1')                       = 1e-10 + 100 * pwm(c) * EXR.L * QM.L(c) / SUM(cp, pwm(cp) * EXR.L * QM.L(cp));
sectorstruc('total','IMPshr','%1')                 = SUM(c, sectorstruc(c,'IMPshr','%1'));

sectorstruc(c,'IMP-DEMshr','%1')$(PQ.L(c)*QQ.L(c)) = 1e-10 + 100 * PM.L(c) * QM.L(c) / (PQ.L(c) * QQ.L(c));
sectorstruc('total','IMP-DEMshr','%1')             = 100 * SUM(cp, PM.L(cp) * QM.L(cp)) / SUM(cp, PQ.L(cp) * QQ.L(cp));

DISPLAY sectorstruc;


* ################################################## *
* Reporte "SIMSAM" *
* ################################################## *


* Filas "Actividades"

SIMSAM(a,c,'%1')              = theta(a,c) * QA.L(a) * PX.L(c);

* Filas "Productos"

SIMSAM(c,a,'%1')              = PQ.L(c) * QINT.L(c,a);
SIMSAM(c,'hhd','%1')          = PQ.L(c) * QH.L(c);
SIMSAM(c,'gov','%1')          = PQ.L(c) * qg(c);
SIMSAM(c,'row','%1')          = pwe(c) * EXR.L * QE.L(c);
SIMSAM(c,'sav-inv','%1')      = PQ.L(c) * QINV.L(c);
SIMSAM(c,'dstk','%1')         = PQ.L(c) * qdstk(c);

* Fila "Trabajo"

SIMSAM('lab',a,'%1')          = WL.L * LD.L(a);
SIMSAM('lab','row','%1')      = trnsfr('lab','row')*EXR.L;

* Fila "Capital"

SIMSAM('cap',a,'%1')          = WK.L(a) * KD.L(a);
SIMSAM('cap','row','%1')      = trnsfr('cap','row') * EXR.L;

* Filas "Impuestos"

SIMSAM('tax-act',a,'%1')      = ta(a) * PA.L(a) * QA.L(a);
SIMSAM('tax-imp',c,'%1')      = tm(c) * pwm(c) * EXR.L * QM.L(c);
SIMSAM('tax-exp',c,'%1')      = te(c) * pwe(c) * EXR.L * QE.L(c);
SIMSAM('tax-com',c,'%1')      = tq(c) * (PD.L(c) * QD.L(c)+ PM.L(c) * QM.L(c));
SIMSAM('tax-dir','hhd','%1')  = TY.L * YH.L;

* Fila "Hogares"

SIMSAM('hhd','lab','%1')      = YL.L;
SIMSAM('hhd','cap','%1')      = YK.L;
SIMSAM('hhd','gov','%1')      = trnsfr('hhd','gov') * CPI.L;
SIMSAM('hhd','row','%1')      = trnsfr('hhd','row') * EXR.L;

* Fila "Gobierno"

SIMSAM('gov','tax-act','%1')  = SUM(a, SIMSAM('tax-act',a,'%1'));
SIMSAM('gov','tax-imp','%1')  = SUM(c, SIMSAM('tax-imp',c,'%1'));
SIMSAM('gov','tax-exp','%1')  = SUM(c, SIMSAM('tax-exp',c,'%1'));
SIMSAM('gov','tax-com','%1')  = SUM(c, SIMSAM('tax-com',c,'%1'));
SIMSAM('gov','tax-dir','%1')  = SIMSAM('tax-dir','hhd','%1');
SIMSAM('gov','hhd','%1')      = trnsfr('gov','hhd') * CPI.L;
SIMSAM('gov','row','%1')      = trnsfr('gov','row') * EXR.L;

* Fila "Resto del mundo"

SIMSAM('row',c,'%1')          = pwm(c) * EXR.L * QM.L(c);
SIMSAM('row','hhd','%1')      = trnsfr('row','hhd') * EXR.L;
SIMSAM('row','gov','%1')      = trnsfr('row','gov') * EXR.L;

* Fila "Ahorro-Inversión"

SIMSAM('sav-inv','hhd','%1')  = mps * (1 - TY.L) * YH.L;
SIMSAM('sav-inv','gov','%1')  = YG.L - EG.L;
SIMSAM('sav-inv','row','%1')  = savf * EXR.L;

* Fila "Variación de existencias"

SIMSAM('dstk','sav-inv','%1') = SUM(c, PQ.L(c) * qdstk(c));

* Chequeo de consistencia de la SIMSAM

SIMSAM('total',ac,'%1')                                        = SUM(acntp, SIMSAM(acntp,ac,'%1'));
SIMSAM(ac,'total','%1')                                        = SUM(acntp, SIMSAM(ac,acntp,'%1'));
simsambalchk(acnt,'%1')                                        = SIMSAM('total',acnt,'%1') - SIMSAM(acnt,'total','%1');
errsimsambalchk(acnt,'%1')$(ABS(simsambalchk(acnt,'%1')>1e-5)) = 1/0;
DISPLAY simsambalchk, errsimsambalchk;

DISPLAY SIMSAM, PVAX, QAX, EXRX, pweX, QEX, pwmX, QMX, PDX, QDX, CPIX, WKX, WLX, ev;