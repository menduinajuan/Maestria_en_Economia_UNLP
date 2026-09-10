* reploop.inc


CPIX('%1')         = CPI.L;        
EGX('%1')          = EG.L;         
EXRX('%1')         = EXR.L;        
KDX(a,'%1')        = KD.L(a);       
KSX('%1')          = KS.L;         
LDX(a,'%1')        = LD.L(a);       
LSX('%1')          = LS.L;         
PAX(a,'%1')        = PA.L(a);       
PDX(c,'%1')        = PD.L(c);       
PEX(c,'%1')        = PE.L(c);       
PMX(c,'%1')        = PM.L(c);       
PQX(c,'%1')        = PQ.L(c);       
PVAX(a,'%1')       = PVA.L(a);      
PXX(c,'%1')        = PX.L(c);       
QAX(a,'%1')        = QA.L(a);       
QDX(c,'%1')        = QD.L(c);       
QEX(c,'%1')        = QE.L(c);       
QHX(c,'%1')        = QH.L(c);       
QINTX(c,a,'%1')    = QINT.L(c,a);   
QINVX(c,'%1')      = QINV.L(c);     
QINVSCALX('%1')    = QINVSCAL.L;   
QMX(c,'%1')        = QM.L(c);       
QQX(c,'%1')        = QQ.L(c);       
QXX(c,'%1')        = QX.L(c);       
WALRASX('%1')      = WALRAS.L;     
WKX(a,'%1')        = WK.L(a);       
WLX('%1')          = WL.L;         
YGX('%1')          = YG.L;         
YHX('%1')          = YH.L;         
YKX('%1')          = YK.L;         
YLX('%1')          = YL.L;         

  
qinvbX(c,'%1')        =   qinvb(c);        
qdstkX(c,'%1')        =   qdstk(c);        
mpsX('%1')            =   mps;            
savfX('%1')            =  savf;           
                        
qgX(c,'%1')           =   qg(c);           
tqX(c,'%1')           =   tq(c);           
tyX('%1')             =   ty;             
trnsfrX(ac,ins,'%1')  =   trnsfr(ac,ins);  
taX(a,'%1')           =   ta(a);            
                        
pweX(c,'%1')          =   pwe(c);           
pwmX(c,'%1')          =   pwm(c);           
teX(c,'%1')           =   te(c);            
tmX(c,'%1')           =   tm(c);            

ehX('%1')             = (1 - mps) * (1 - ty) * YH.L;
  
ev('%1') = PROD(c$QQ0(c), (PQ0(c)/PQ.L(c))**alpha(c)) * ehX('%1') - ehX('base');

dpix('%1') = SUM(c, PD.L(c) * dwts(c));
rexrx('%1') = EXR.L/dpix('%1');

* status modelo
modsolstat('solvestat','%1') = CGE5.SOLVESTAT;
modsolstat('modelstat','%1') = CGE5.MODELSTAT;

* start: gdprep =====================================================

gdprep('PrvCon','%1')  =  SUM((c), PQ0(c)*QH.L(c));
gdprep('FixInv','%1')  =  SUM(c, PQ0(c)*QINV.L(c));
gdprep('StockChange','%1')  =  SUM(c, PQ0(c)*qdstk(c));
gdprep('GovCon','%1')  =  SUM(c, PQ0(c)*qg(c));
gdprep('Exports','%1') =  SUM(c, PWE0(c)*EXR0*QE.L(c));
gdprep('Imports','%1') = -SUM(c, PWM0(c)*EXR0*QM.L(c));
gdprep('GDPMP','%1')   =  SUM(igdp2, gdprep(igdp2,'%1'));
gdprep('GDPFC','%1')  =  SUM(a, PVA0(a)*QA.L(a));
gdprep('NetIndTax','%1') =
  + SUM(c, tq(c)*(PD0(c)*QD.L(c) + PM0(c)*QM.L(c)))
  + SUM(c, tm(c)*EXR0*pwm0(c)*QM.L(c))
  + SUM(c, te(c)*EXR0*pwe0(c)*QE.L(c))
  + SUM(a, ta(a)*PA0(a)*QA.L(a));

gdprep('Absorption','%1')  = gdprep('GDPMP','%1') - 
  gdprep('Imports','%1') - gdprep('Exports','%1');


DISPLAY gdprep;

* end: gdprep =======================================================


* start: sectorstruc ================================================

*Note: For VAshr, PRDshr, and EMPshr, data scaled by share of activity
*in output of commodity to avoid double-counting when there is not a
*one-to-one mapping between activities and commodities.

sectorstruc(c,'VAshr','%1')       = 
  1e-10 + 100 * SUM(a, theta(a,c)*PVA.L(a)*QA.L(a)) / SUM(ap, PVA.L(ap)*QA.L(ap));
sectorstruc('total','VAshr','%1') = SUM(c, sectorstruc(c,'VAshr','%1'));

sectorstruc(c,'PRDshr','%1')      = 1e-10 + 100 * SUM(a, theta(a,c)*PA.L(a)*QA.L(a)) / SUM(ap, PA.L(ap)*QA.L(ap));
sectorstruc('total','PRDshr','%1') = SUM(c, sectorstruc(c,'PRDshr','%1'));

sectorstruc(c,'EMPshr','%1')        =
  1e-10 + 100 * SUM(a, theta(a,c)*LD.L(a)) / SUM(ap, LD.L(ap));
sectorstruc('total','EMPshr','%1') = SUM(c, sectorstruc(c,'EMPshr','%1'));

* expos
*!! a precios mundiales
sectorstruc(c,'EXPshr','%1')       =
  1e-10 + 100 * pwe(c)*EXR.L*QE.L(c) / SUM(cp, pwe(cp)*EXR.L*QE.L(cp));
sectorstruc('total','EXPshr','%1') = SUM(c, sectorstruc(c,'EXPshr','%1'));

* impos
*!! a precios mundiales
sectorstruc(c,'IMPshr','%1')       =
  1e-10 + 100 * pwm(c)*EXR.L*QM.L(c) / SUM(cp, pwm(cp)*EXR.L*QM.L(cp));
sectorstruc('total','IMPshr','%1') = SUM(c, sectorstruc(c,'IMPshr','%1'));

* expos
sectorstruc(c,'EXP-OUTshr','%1')$(PX.L(c)*QX.L(c))
  = 1e-10 + 100 * PE.L(c)*QE.L(c) / (PX.L(c)*QX.L(c));
sectorstruc('total','EXP-OUTshr','%1') =  
  100 * SUM(cp, PE.L(cp)*QE.L(cp)) / SUM(cp, PX.L(cp)*QX.L(cp));

* impos
sectorstruc(c,'IMP-DEMshr','%1')$(PQ.L(c)*QQ.L(c)) =
  1e-10 + 100 * PM.L(c)*QM.L(c) / (PQ.L(c)*QQ.L(c));
sectorstruc('total','IMP-DEMshr','%1') = 
  100 * SUM(cp, PM.L(cp)*QM.L(cp)) / SUM(cp, PQ.L(cp)*QQ.L(cp));

* end: sectorstruc ==================================================



* start: SIMSAM =====================================================

* filas tax
SIMSAM('tax-dir','hhd','%1') = ty * YH.L;
SIMSAM('tax-imp',c,'%1')      = tm(c)*EXR.L*pwm(c)*QM.L(c);
SIMSAM('tax-exp',c,'%1')      = te(c)*EXR.L*pwe(c)*QE.L(c);
SIMSAM('tax-com',c,'%1')      = tq(c)*(PD.L(c)*QD.L(c)+PM.L(c)*QM.L(c));
SIMSAM('tax-act',a,'%1')      = ta(a)*PA.L(a)*QA.L(a);

* filas com
SIMSAM(c,a,'%1')     = PQ.L(c)*QINT.L(c,a);
SIMSAM(c,'hhd','%1')     = PQ.L(c)*QH.L(c);
SIMSAM(c,'sav-inv','%1') = PQ.L(c)*QINV.L(c);
SIMSAM(c,'dstk','%1')  = PQ.L(c)*qdstk(c);
SIMSAM(c,'gov','%1') = PQ.L(c)*qg(c);
SIMSAM(c,'row','%1') = pwe(c)*EXR.L*QE.L(c);

* filas lab
SIMSAM('lab',a,'%1')     = WL.L*LD.L(a);
SIMSAM('lab','row','%1') = trnsfr('lab','row')*EXR.L;

* filas cap
SIMSAM('cap',a,'%1')     = WK.L(a)*KD.L(a);
SIMSAM('cap','row','%1') = trnsfr('cap','row')*EXR.L;


* filas s-i
SIMSAM('sav-inv','hhd','%1') = mps*(1-ty)*YH.L;
SIMSAM('sav-inv','gov','%1')  = YG.L-EG.L;
SIMSAM('sav-inv','row','%1')  = EXR.L*savf;

* filas dstk
SIMSAM('dstk','sav-inv','%1') = SUM(c, PQ.L(c)*qdstk(c));


* filas row
SIMSAM('row',c,'%1')      = EXR.L*pwm(c)*QM.L(c);
SIMSAM('row','gov','%1')  = trnsfr('row','gov')*EXR.L;

* filas hhd
SIMSAM('hhd','lab','%1')       = YL.L;
SIMSAM('hhd','cap','%1')       = YK.L;
SIMSAM('hhd','gov','%1')   = trnsfr('hhd','gov')*CPI.L;
SIMSAM('hhd','row','%1')   = trnsfr('hhd','row')*EXR.L;

* filas act
SIMSAM(a,c,'%1') = theta(a,c)*QA.L(a)*PX.L(c);

* filas gov
SIMSAM('gov','tax-dir','%1') = SIMSAM('tax-dir','hhd','%1');
SIMSAM('gov','tax-com','%1') = SUM(c, SIMSAM('tax-com',c,'%1'));
SIMSAM('gov','tax-imp','%1') = SUM(c, SIMSAM('tax-imp',c,'%1'));
SIMSAM('gov','tax-exp','%1') = SUM(c, SIMSAM('tax-exp',c,'%1'));
SIMSAM('gov','tax-act','%1') = SUM(a, SIMSAM('tax-act',a,'%1'));
SIMSAM('gov','row','%1')  = EXR.L*trnsfr('gov','row');


* filas total
SIMSAM('total',ac,'%1') = SUM(acntp, SIMSAM(acntp,ac,'%1'));
SIMSAM(ac,'total','%1') = SUM(acntp, SIMSAM(ac,acntp,'%1'));

* end: SIMSAM =======================================================

simsambalchk(acnt,'%1') = SIMSAM(acnt,'total','%1') - SIMSAM('total',acnt,'%1');
errsimsambalchk(acnt,'%1')$(ABS(simsambalchk(acnt,'%1')) > 1e-4) = 1/0;
DISPLAY errsimsambalchk;

