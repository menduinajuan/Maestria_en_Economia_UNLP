$TITLE CGE5

* INTRODUCTION ======================================================

$ONTEXT

This model is based on Cicowiez and Lofgren (2013), which in turn descends from 
CGE5 in Lofgren (2003).

last update: Mar 2019

$OFFTEXT


* SETS ==============================================================

SET
  ac          global set (SAM accounts and other items)
  a(ac)       activities
  c(ac)       commodities
  ins(ac)     institutions

  acnt(ac)    all elements in AC except total
  
  trdelas 
    /sigma_q, sigma_x/

;

ALIAS (acp,ac), (cp,c), (ap,a), (insp,ins), (acntp, acnt);

PARAMETER 
  SAM(ac,acp)            social accounting matrix
  tradelas(c,trdelas)    Armington-CET-export demand elasticities by com
  sambalchk(ac)          sam balance check (column total minus row total);

;

* READ DATA FROM EXCEL ==============================================

*$CALL GDXXRW user-files\demo-data.xlsx index=layout!A1
*$GDXIN demo-data.gdx

$CALL GDXXRW user-files\archetype2015-data.xlsx index=layout!A1
$GDXIN archetype2015-data.gdx

*$CALL GDXXRW user-files\cri2012-data.xlsx index=layout!A1
*$GDXIN cri2012-data.gdx

$LOADDC ac
$LOADDC a
$LOADDC c
$LOADDC ins
$LOADDC SAM
$LOADDC tradelas

acnt(ac) = YES;
acnt('total') = NO;

* Check SAM consistency
SAM('total',ac) = SUM(acntp, SAM(acntp,ac));
SAM(ac,'total') = SUM(acntp, SAM(ac,acntp));
sambalchk(acnt) = SAM('total',acnt) - SAM(acnt,'total');
DISPLAY sambalchk;

* activate the following sentence to debug
*$EXIT

* PARAMETERS ========================================================

PARAMETERS
* the following parameters are used to define initial values of model variables
  CPI0             consumer price index
  EG0              government expenditures
  EXR0             exchange rate (dom. currency per unit of foreign currency)
  KD0(a)           quantity demanded of factor capital from activity a
  KS0              supply of factor capital
  LD0(a)           quantity demanded of factor labor from activity a
  LS0              supply of factor labor
  PA0(a)           price of activity a
  PD0(c)           domestic price of domestic output c 
  PE0(c)           export price for c (domestic currency) 
  PM0(c)           import price for c (domestic currency)
  PQ0(c)           composite commodity price for c
  PVA0(a)          value-added price for activity a
  PX0(c)           producer price for commodity c
  QA0(a)           level of activity a
  QD0(c)           quantity sold domestically of domestic output c
  QE0(c)           quantity of exports for commodity c
  QH0(c)           quantity consumed of commodity c by household h
  QINT0(c,a)       qnty of commodity c as intermediate input to activity a
  QINV0(c)         quantity of investment demand for commodity c
  QINVSCAL0        investment adjustment factor
  QM0(c)           quantity of imports of commodity c
  QQ0(c)           quantity of goods supplied domestically (composite supply)
  QX0(c)           quantity of domestic output of commodity c
  WK0(a)           rent of factor capital in activity a
  WL0              wage of factor labor
  YG0              government revenue
  YH0              income of household h
  YK0              factor capital income    
  YL0              factor labor income  

* other parameters
  qinvb(c)         base-year qnty of investment demand for commodity c
  qdstk(c)         changes in inventories
  mps              marginal (and average) propensity to save for household h
  savf             foreign savings (foreign currency)

  qg(c)            government demand for commodity c
  tq(c)            rate of sales tax for commodity c
  ty               rate of income tax for household h
  trnsfr(ac,ins)   transfer from institution ins to institution or factor ac
  ta(a)            rate of tax on producer gross output value

  pwe(c)           export price for c (foreign currency)
  pwm(c)           import price for c (foreign currency)
  te(c)            export subsidy rate for commodity c
  tm(c)            import tariff rate for commodity c

  delta_l(a)       share of value-added to factor labor in activity a
  delta_k(a)       share of value-added to factor capital in activity a
  
  phi_va(a)        efficiency parameter in the production fn for a 
  theta(a,c)       yield of output c per unit of activity a
  ica(c,a)         qnty of c as intermediate input per unit of activity a
  alpha(c)         share of household consumption spending on commodity c

  delta_m(c)       Armington function share parameter for imports commodity c
  delta_dd(c)      Armington function share parameter for domestic commodity c
  phi_q(c)         Armington function shift parameter for commodity c
  sigma_q(c)       elasticity of substitution bt. dom goods and imports for c
  rho_q(c)         Armington function exponent for commodity c

  delta_e(c)       CET function share parameter for exports commodity c
  delta_ds(c)      CET function share parameter for domestic commodity c
  phi_x(c)         CET function shift parameter for commodity c
  sigma_x(c)       elasticity of transformation bt. dom sales and exports for c
  rho_x(c)         CET function exponent for commodity c

  cwts(c)          weight of commodity c in the CPI
;

* ASSIGNMENTS FOR PARAMETERS AND VARIABLES ==========================

* Prices

PA0(a) = 1;
PX0(c) = 1;
WL0    = 1;
WK0(a) = 1;
PD0(c) = 1;
PE0(c) = 1;
PM0(c) = 1;
EXR0   = 1;

* Production

QA0(a) = SAM(a,'total') / PA0(a);
* exported quantity is computed as exporters income divided by the domestic 
* price of exports
QE0(c) = ( SAM(c,'row') - SAM('tax-exp',c) ) / PE0(c);
QM0(c) = ( SAM('row',c) + SAM('tax-imp',c) ) / PM0(c);
QX0(c) = SUM(a, SAM(a,c)) / PX0(c);
QD0(c) = QX0(c) - QE0(c);
QQ0(c) = QD0(c) + QM0(c);
DISPLAY QA0, QE0, QM0, QX0, QD0, QQ0;


* rate of producer (activity) tax = tax divided by output value (i.e., tax 
* base includes the tax value)
ta(a) = SAM('tax-act',a) / (PA0(a)*QA0(a));

* rate of commodity tax; tax base excludes the tax collection
tq(c)$QQ0(c) = SAM('tax-com',c) / ( PD0(c)*QD0(c) + PM0(c)*QM0(c) );
PQ0(c) = ( PM0(c)*QM0(c) + PD0(c)*QD0(c) ) * (1 + tq(c)) / QQ0(c);
DISPLAY tq, PQ0;


* consumer price index
cwts(c) = SAM(c,'hhd') / SUM(cp, SAM(cp,'hhd'));
CPI0    = SUM(c, cwts(c) * PQ0(c));
DISPLAY cwts, CPI0;

* the value-added price is the factor payments per unit of activity
PVA0(a) = ( SAM('lab',a) + SAM('cap',a) ) / ( SAM('total',a) / PA0(a) );
DISPLAY PVA0;

QINT0(c,a) = SAM(c,a) / PQ0(c);
DISPLAY QINT0;

* Factor Employment and Prices

* factor demand
LD0(a) = SAM('lab',a)/WL0;
KD0(a) = SAM('cap',a)/WK0(a);
* factor supply
LS0 = SUM(a, LD0(a));
KS0 = SUM(a, KD0(a));
DISPLAY LD0, KD0, LS0, KS0;

* Factor Incomes

YL0 = SAM('lab','total');
YK0 = SAM('cap','total');
trnsfr('lab','row') = SAM('lab','row')/EXR0;
trnsfr('cap','row') = SAM('cap','row')/EXR0;

* Households

QH0(c)  = SAM(c,'hhd') / PQ0(c);
YH0    = SAM('hhd','total');
ty     = SAM('tax-dir','hhd') / YH0;
trnsfr('hhd','row') = SAM('hhd','row')/EXR0;
DISPLAY QH0, YH0, ty;

* Savings-Investment

QINV0(c)   = SAM(c,'sav-inv') / PQ0(c);
qinvb(c) = QINV0(c);
qdstk(c) = SAM(c,'dstk')/PQ0(c);
mps    = SAM('sav-inv','hhd') / ( SAM('total','hhd') - SAM('tax-dir','hhd') );
QINVSCAL0      = 1;
DISPLAY QINV0, qinvb, mps, QINVSCAL0;
* foreign savings
savf = SAM('sav-inv','row') / EXR0;

* Government

EG0   = SAM('total','gov') - SAM('sav-inv','gov');
YG0   = SAM('gov','total');
qg(c) = SAM(c,'gov') / PQ0(c);
trnsfr('hhd','gov') = SAM('hhd','gov') / CPI0;
trnsfr('gov','row') = SAM('gov','row') / EXR0;
DISPLAY EG0, YG0, qg, trnsfr;

* International Trade

te(c)$SAM(c,'row')  = SAM('tax-exp',c) / SAM(c,'row');
pwe(c) = PE0(c) / ( (1 - te(c))*EXR0 );
tm(c)$SAM('row',c)  = SAM('tax-imp',c) / SAM('row',c);
pwm(c) = PM0(c) / ( EXR0 * (1 + tm(c)) );
DISPLAY te, pwe, tm, pwm;


* activate the following sentence to debug
*$EXIT


*### Calibration Production and Consumption

* Production

theta(a,c) = ( SAM(a,c) / PX0(c) ) / QA0(a);
delta_l(a) = LD0(a)*WL0 / (PVA0(a)*QA0(a));
delta_k(a) = KD0(a)*WK0(a) / (PVA0(a)*QA0(a));
phi_va(a)     = QA0(a) / (LD0(a)**delta_l(a) * KD0(a)**delta_k(a));
ica(c,a)   = QINT0(c,a) / QA0(a);
DISPLAY theta, delta_l, delta_k, phi_va, ica;

* International Trade

sigma_q(c) = tradelas(c,'sigma_q');
sigma_x(c) = tradelas(c,'sigma_x');

rho_x(c) = 1/sigma_x(c) + 1;
rho_q(c) = 1/sigma_q(c) - 1;

* CET
delta_e(c)$(QD0(c)>0 AND QE0(c)>0) = PE0(c) * QE0(c)**(-1/sigma_x(c)) /
  ( PE0(c) * QE0(c)**(-1/sigma_x(c)) + PD0(c) * QD0(c)**(-1/sigma_x(c)) );

delta_ds(c)$(QD0(c)>0 AND QE0(c)>0) = PD0(c) * QD0(c)**(-1/sigma_x(c)) /
  ( PE0(c) * QE0(c)**(-1/sigma_x(c)) + PD0(c) * QD0(c)**(-1/sigma_x(c)) );

phi_x(c)$(QD0(c)>0 AND QE0(c)>0) = QX0(c) /
  ( delta_e(c)*QE0(c)**rho_x(c) + delta_ds(c)*QD0(c)**rho_x(c) ) ** (1/rho_x(c));
DISPLAY delta_e, delta_ds, phi_x;

* Armington
delta_m(c)$(QD0(c)>0 AND QM0(c)>0) = PM0(c) * QM0(c)**(1/sigma_q(c)) /
  ( PM0(c) * QM0(c)**(1/sigma_q(c)) + PD0(c) * QD0(c)**(1/sigma_q(c)) );

delta_dd(c)$(QD0(c)>0 AND QM0(c)>0) = PD0(c) * QD0(c)**(1/sigma_q(c)) /
  ( PM0(c) * QM0(c)**(1/sigma_q(c)) + PD0(c) * QD0(c)**(1/sigma_q(c)) );

phi_q(c)$(QD0(c)>0 AND QM0(c)>0) = QQ0(c) /
  ( delta_m(c)*QM0(c)**(-rho_q(c)) + delta_dd(c)*QD0(c)**(-rho_q(c)) ) ** (-1/rho_q(c));
DISPLAY delta_m, delta_dd, phi_q;



* Consumption

alpha(c) = PQ0(c)*QH0(c) / ( (1-mps)*(1-ty)*YH0 );

DISPLAY alpha;

* activate the following sentence to debug
*$EXIT

* ENDOGENOUS VARIABLES ==============================================

VARIABLES
  CPI          consumer price index
  EG           government expenditures
  EXR          exchange rate (dom. currency per unit of foreign currency)
  KD(a)        quantity demanded of factor capital from activity a
  KS           supply of factor capital
  LD(a)        quantity demanded of factor labor from activity a
  LS           supply of factor labor
  PA(a)        price of activity a
  PD(c)        domestic price of domestic output c 
  PE(c)        export price for c (domestic currency) 
  PM(c)        import price for c (domestic currency)
  PQ(c)        composite commodity price for c
  PVA(a)       value-added price for activity a
  PX(c)        producer price for commodity c
  QA(a)        level of activity a
  QD(c)        quantity sold domestically of domestic output c
  QE(c)        quantity of exports for commodity c
  QH(c)        quantity consumed of commodity c by household h
  QINT(c,a)    qnty of commodity c as intermediate input to activity a
  QINV(c)      quantity of investment demand for commodity c
  QINVSCAL     investment adjustment factor
  QM(c)        quantity of imports of commodity c
  QQ(c)        quantity of goods supplied domestically (composite supply)
  QX(c)        quantity of domestic output of commodity c
  WALRAS       dummy variable (zero at equilibrium)
  WK(a)        rent of factor capital in activity a
  WL           wage of factor labor
  YG           government revenue
  YH           income of households
  YK           factor capital income    
  YL           factor labor income  
;

* EQUATIONS =========================================================

EQUATIONS

* Production

  EQ_PRODFN(a)      Cobb-Douglas production function for activity a
  
  EQ_LABDEM(a)    demand for factor labor from activity a
  EQ_CAPDEM(a)    demand for factor capital from activity a
  
  EQ_INTDEM(c,a)    intermediate demand for commodity c from activity a
  EQ_OUTPUTFN(c)    output of commodity c
  EQ_PADEF(a)       price for activity a
  EQ_PVADEF(a)      value-added price for activity a

  EQ_LABINC      factor labor income
  EQ_CAPINC      factor capital income
  
* International Trade
  
  EQ_PMDEF(c)       import price for commodity c (domestic currency)
  EQ_PEDEF(c)       export price for commodity c (domestic currency)

  EQ_ARMING(c)      composite supply (Armington) function for commodity c
  EQ_IMPDOMRAT(c)   import-domestic demand ratio for commodity c
  EQ_ARMING2(c)     composite supply for commodities without both dom sales and imports
  
  EQ_ABSORB(c)      absorption for commodity c

  EQ_CET(c)         output transformation (CET) function for commodity c
  EQ_EXPDOMRAT(c)   export-domestic supply ratio for commodity c
  EQ_CET2(c)        domestic sales and exports for outputs without both  
  EQ_OUTVAL(c)      output value for commodity c

* Institutions

  EQ_HHDINC      income of household h
  EQ_HHDDEM(c)    consumption demand for household h & commodity c
  EQ_INVDEM(c)      investment demand for commodity c
  EQ_GOVREV         government revenue
  EQ_GOVEXP         government expenditures

* Equilibrium Conditions

  EQ_LABEQ       market equilibrium condition for factor labor
  EQ_CAPEQ       market equilibrium condition for factor capital

  EQ_COMEQ(c)       market equilibrium condition for composite commodity c
  EQ_SAVINV         savings-investment balance
  EQ_CURACC         current account balance for RoW

* Miscellaneous  
  
  EQ_CPIDEF         consumer price index
;

*### Production Activities

* Value Added

EQ_PRODFN(a)..
  QA(a) =E= phi_va(a) * LD(a)**delta_l(a) * KD(a)**delta_k(a);

EQ_LABDEM(a)$LD0(a)..
  LD(a) * WL =E= delta_l(a) * PVA(a) * QA(a);
  
EQ_CAPDEM(a)$KD0(a)..
  KD(a) * WK(a) =E= delta_k(a) * PVA(a) * QA(a);

* Intermediate Inputs
  
EQ_INTDEM(c,a)..
  QINT(c,a) =E= ica(c,a) * QA(a);

* Commodity Production  
  
EQ_OUTPUTFN(c)..
  QX(c) =E= SUM(a, theta(a,c) * QA(a));

* Production Prices
  
EQ_PADEF(a)..
  PA(a) =E= SUM(c, theta(a,c) * PX(c));

EQ_PVADEF(a)..
  PVA(a) =E= PA(a)*(1-ta(a)) - SUM(c, PQ(c) * ica(c,a));

* Factor incomes

EQ_LABINC..
  YL =E= SUM(a, WL*LD(a)) + trnsfr('lab','row')*EXR;

EQ_CAPINC..
  YK =E= SUM(a, WK(a)*KD(a)) + trnsfr('cap','row')*EXR;


*### Domestic and Foreign Trade

* World Prices

EQ_PMDEF(c)..
  PM(c) =E= pwm(c)*EXR*(1+tm(c));

EQ_PEDEF(c)..
  PE(c) =E= pwe(c)*EXR*(1-te(c));

* Armington Function

EQ_ARMING(c)$(QD0(c)>0 AND QM0(c)>0)..
  QQ(c) =E= phi_q(c) *
    ( delta_m(c)*QM(c)**(-rho_q(c)) + delta_dd(c)*QD(c)**(-rho_q(c)) ) ** (-1/rho_q(c));
 
EQ_IMPDOMRAT(c)$(QD0(c)>0 AND QM0(c)>0)..
  QM(c) / QD(c) =E= ( PD(c)/PM(c) * delta_m(c)/delta_dd(c) ) ** sigma_q(c);

EQ_ARMING2(c)$( (QD0(c)>0 AND QM0(c)=0) OR (QD0(c)=0 AND QM0(c)>0) )..
  QQ(c) =E= QD(c) + QM(c);
  
EQ_ABSORB(c)..
  PQ(c) * QQ(c) =E= ( PD(c)*QD(c) + PM(c)*QM(c) ) * (1+tq(c));

* CET Function

EQ_CET(c)$(QD0(c)>0 AND QE0(c)>0)..
  QX(c) =E= phi_x(c) *
    ( delta_e(c)*QE(c)**(rho_x(c)) + delta_ds(c)*QD(c)**(rho_x(c)) ) ** (1/rho_x(c));

EQ_EXPDOMRAT(c)$(QD0(c)>0 AND QE0(c)>0)..
  QE(c) / QD(c) =E= ( PE(c)/PD(c) * delta_ds(c)/delta_e(c) ) ** sigma_X(c);

EQ_CET2(c)$( (QD0(c)>0 AND QE0(c)=0) OR (QD0(c)=0 AND QE0(c)>0) )..
  QX(c) =E= QD(c) + QE(c);
  
EQ_OUTVAL(c)..
  PX(c) * QX(c) =E= PD(c)*QD(c) + PE(c)*QE(c);

*### Domestic Institutions

* Households

EQ_HHDINC..
  YH =E= YL + YK + trnsfr('hhd','gov')*CPI + trnsfr('hhd','row')*EXR;

EQ_HHDDEM(c)..
  QH(c) * PQ(c) =E= alpha(c) * (1 - mps) * (1 - ty) * YH;

* Government

EQ_GOVREV..
  YG =E= ty*YH
  + SUM(a, ta(a)*PA(a)*QA(a))
  + SUM(c, tq(c)*(PM(c)*QM(c) + PD(c)*QD(c)))
  + SUM(c, tm(c)*EXR*pwm(c)*QM(c))
  + SUM(c, te(c)*EXR*pwe(c)*QE(c))
  + EXR*trnsfr('gov','row');

EQ_GOVEXP..
  EG =E= SUM(c, PQ(c)*qg(c)) + trnsfr('hhd','gov')*CPI;

* Investment Demand

EQ_INVDEM(c)..
  QINV(c) =E= qinvb(c) * QINVSCAL;


*### Equilibrium Conditions
  
EQ_LABEQ..
  LS =E= SUM(a, LD(a));  

EQ_CAPEQ..
  KS =E= SUM(a, KD(a));  

EQ_CURACC..
  SUM(c, pwe(c)*QE(c)) 
    + trnsfr('hhd','row') 
    + trnsfr('gov','row')
    + trnsfr('lab','row')
    + trnsfr('cap','row')    
    + savf =E= SUM(c, pwm(c) * QM(c));

EQ_COMEQ(c)..
  QQ(c) =E= SUM(a, QINT(c,a)) + QH(c) + qg(c) + QINV(c) + qdstk(c);

EQ_SAVINV..
  SUM(c, PQ(c)*QINV(c)) + SUM(c, PQ(c)*qdstk(c)) + WALRAS =E= 
    mps*(1-ty)*YH + (YG - EG) + EXR*savf;

*### Miscellaneous  

EQ_CPIDEF..
  SUM(c, PQ(c) * cwts(c)) =E= CPI;

* MODEL =============================================================

MODEL CGE5 /
  EQ_PRODFN
  EQ_LABDEM
  EQ_CAPDEM
  EQ_INTDEM
  EQ_OUTPUTFN
  EQ_PADEF
  EQ_PVADEF
  EQ_LABINC
  EQ_CAPINC

  EQ_PMDEF
  EQ_PEDEF

  EQ_ABSORB
  EQ_ARMING
  EQ_IMPDOMRAT
  EQ_ARMING2

  EQ_OUTVAL
  EQ_CET
  EQ_EXPDOMRAT
  EQ_CET2

  EQ_HHDINC
  EQ_HHDDEM
  EQ_INVDEM
  EQ_GOVREV
  EQ_GOVEXP
  EQ_LABEQ
  EQ_CAPEQ
  EQ_COMEQ
  EQ_SAVINV
  EQ_CURACC
  EQ_CPIDEF
/;


* initial values for endogenous variables
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
WALRAS.L    = 0;
WK.L(a)     = WK0(a);
WL.L        = WL0;
YG.L        = YG0;
YH.L        = YH0;
YK.L        = YK0;
YL.L        = YL0;

* set to zero variables outside the model (i.e., no initial value)
QE.FX(c)$(QE0(c)=0) = 0;
QM.FX(c)$(QM0(c)=0) = 0;
QD.FX(c)$(QD0(c)=0) = 0;
LD.FX(a)$(LD0(a)=0) = 0;
KD.FX(a)$(KD0(a)=0) = 0;
WK.FX(a)$(KD0(a)=0) = 0;


* CLOSURE RULE ======================================================

* Numeraire
CPI.FX = CPI0;

* Factor Markets
LS.FX = LS0;
KD.FX(a) = KD0(a);
  
  
* SOLUTION ==========================================================

*OPTION CNS = CONOPT;
OPTION CNS = PATH;

CGE5.TOLINFREP = 0.0000000001;  
CGE5.ITERLIM=0;
*CGE5.HOLDFIXED=1;

*### Benchmark Replication

SOLVE CGE5 USING CNS;
DISPLAY QQ.L, QA.L, LD.L, KD.L, QH.L, PQ.L, PA.L, WL.L, WK.L, YH.L, QINT.L, QINV.L, trnsfr,
        EG.L, EXR.L, QE.L, CPI.L, QM.L, PX.L, WALRAS.L;


CGE5.ITERLIM = 100000;

* activate the following sentence to debug
*$EXIT

*### Shock Simulation

* duble the numeraire
*CPI.FX = CPI0*2;

* double the labor supply
*QFS.FX('f-lab') = QFS0('f-lab')*2;

* double government consumption both commodities
*qg(c) = qg(c) * 2;

* unilateral tariff elimination
*tm(c) = 0;

pwe('c-prv') = pwe('c-prv')*1.15;

SOLVE CGE5 USING CNS;
DISPLAY QQ.L, QA.L, LD.L, KD.L, QH.L, PQ.L, PA.L, WL.L, WK.L, YH.L, QINT.L, QINV.L, trnsfr,
        EG.L, EXR.L, QE.L, CPI.L, QM.L, PX.L, WALRAS.L;