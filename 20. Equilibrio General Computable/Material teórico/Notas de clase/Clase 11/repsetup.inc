* repsetup.inc


SET

  igdp           items for GDP and national accounts
    /
      Absorption     total absorption
      PrvCon         private consumption
      GovCon         government consumption                        
      FixInv         fixed investment
      StockChange    stock change                 
      Exports        exports                                       
      Imports        imports                                       
      GDPMP          GDP at market prices (alt. 1: spending)       
      GDPMP2         GDP at market prices (alt. 2: value-added)    
      NetIndTax      net indirect taxes                            
      GDPFC          GDP at factor cost                            
    /

  igdp2(igdp)    items for GDPMP summation
    /
      PrvCon         private consumption
      FixInv         fixed investment
      StockChange    stock change               
      GovCon         government consumption                        
      Exports        exports                                       
      Imports        imports                                       
    /

  sectorcol
    /
   VAshr       value-added share (%)
   PRDshr      production share (%)
   EMPshr      share in total employment (%)
   EXPshr      sector share in total exports (%)
   EXP-OUTshr  exports as share in sector output (%)
   IMPshr      sector share in total imports (%)
   IMP-DEMshr  imports as share of domestic demand (%)
   
    /

  solcol
    /
    solvestat
    modelstat    
    /     
;


    

PARAMETER

* Variable name + X = values for endogenous variables
* Variabe name + XP = percentage change from base
  
  
  CPIX(sim)          consumer price index
  CPIXP(sim)         consumer price index
  EGX(sim)           government expenditures
  EGXP(sim)          government expenditures
  EXRX(sim)          exchange rate (dom. currency per unit of foreign currency)
  EXRXP(sim)         exchange rate (dom. currency per unit of foreign currency)
  KDX(a,sim)         quantity demanded of factor capital from activity a
  KDXP(a,sim)        quantity demanded of factor capital from activity a
  KSX(sim)           supply of factor capital
  KSXP(sim)          supply of factor capital
  LDX(a,sim)         quantity demanded of factor labor from activity a
  LDXP(a,sim)        quantity demanded of factor labor from activity a
  LSX(sim)           supply of factor labor
  LSXP(sim)          supply of factor labor
  PAX(a,sim)         price of activity a
  PAXP(a,sim)        price of activity a
  PDX(c,sim)         domestic price of domestic output c 
  PDXP(c,sim)        domestic price of domestic output c 
  PEX(c,sim)         export price for c (domestic currency) 
  PEXP(c,sim)        export price for c (domestic currency) 
  PMX(c,sim)         import price for c (domestic currency)
  PMXP(c,sim)        import price for c (domestic currency)
  PQX(c,sim)         composite commodity price for c
  PQXP(c,sim)        composite commodity price for c
  PVAX(a,sim)        value-added price for activity a
  PVAXP(a,sim)       value-added price for activity a
  PXX(c,sim)         producer price for commodity c
  PXXP(c,sim)        producer price for commodity c
  QAX(a,sim)         level of activity a
  QAXP(a,sim)        level of activity a
  QDX(c,sim)         quantity sold domestically of domestic output c
  QDXP(c,sim)        quantity sold domestically of domestic output c
  QEX(c,sim)         quantity of exports for commodity c
  QEXP(c,sim)        quantity of exports for commodity c
  QHX(c,sim)         quantity consumed of commodity c by household h
  QHXP(c,sim)        quantity consumed of commodity c by household h
  QINTX(c,a,sim)     qnty of commodity c as intermediate input to activity a
  QINTXP(c,a,sim)    qnty of commodity c as intermediate input to activity a
  QINVSCALX(sim)     investment adjustment factor
  QINVSCALXP(sim)    investment adjustment factor
  QINVX(c,sim)       quantity of investment demand for commodity c
  QINVXP(c,sim)      quantity of investment demand for commodity c
  QMX(c,sim)         quantity of imports of commodity c
  QMXP(c,sim)        quantity of imports of commodity c
  QQX(c,sim)         quantity of goods supplied domestically (composite supply)
  QQXP(c,sim)        quantity of goods supplied domestically (composite supply)
  QXX(c,sim)         quantity of domestic output of commodity c
  QXXP(c,sim)        quantity of domestic output of commodity c
  WALRASX(sim)       dummy variable (zero at equilibrium)
  WALRASXP(sim)      dummy variable (zero at equilibrium)
  WKX(a,sim)         rent of factor capital in activity a
  WKXP(a,sim)        rent of factor capital in activity a
  WLX(sim)           wage of factor labor
  WLXP(sim)          wage of factor labor
  YGX(sim)           government revenue
  YGXP(sim)          government revenue
  YHX(sim)           income of households
  YHXP(sim)          income of households
  YKX(sim)           factor capital income    
  YKXP(sim)          factor capital income    
  YLX(sim)           factor labor income  
  YLXP(sim)          factor labor income    
  
                       
  mpsX(sim)               marginal (and average) propensity to save for household h
  mpsXP(sim)              marginal (and average) propensity to save for household h
  pweX(c,sim)             export price for c (foreign currency)
  pweXP(c,sim)            export price for c (foreign currency)
  pwmX(c,sim)             import price for c (foreign currency)
  pwmXP(c,sim)            import price for c (foreign currency)
  qdstkX(c,sim)           changes in inventories
  qdstkXP(c,sim)          changes in inventories
  qgX(c,sim)              government demand for commodity c
  qgXP(c,sim)             government demand for commodity c
  qinvbX(c,sim)           base-year qnty of investment demand for commodity c
  qinvbXP(c,sim)          base-year qnty of investment demand for commodity c
  savfX(sim)              foreign savings (foreign currency)
  savfXP(sim)             foreign savings (foreign currency)
  taX(a,sim)              rate of tax on producer gross output value
  taXP(a,sim)             rate of tax on producer gross output value
  teX(c,sim)              export subsidy rate for commodity c
  teXP(c,sim)             export subsidy rate for commodity c
  tmX(c,sim)              import tariff rate for commodity c
  tmXP(c,sim)             import tariff rate for commodity c  
  tqX(c,sim)              rate of sales tax for commodity c
  tqXP(c,sim)             rate of sales tax for commodity c
  trnsfrX(ac,ins,sim)     transfer from institution ins to institution or factor ac
  trnsfrXP(ac,ins,sim)    transfer from institution ins to institution or factor ac
  tyX(sim)                rate of income tax for household h
  tyXP(sim)               rate of income tax for household h
  ehX(sim)                household consumption spending
  ehXP(sim)               household consumption spending
  ev(sim)                 equivalent variation
  
  rexrx(sim)              real exchange rate
  rexrxp(sim)             real exchange rate

  dpix(sim)               index for domestic producer prices (PD-based)
  dpixp(sim)              index for domestic producer prices (PD-based)
  dwts(c)                 domestic sales price weights
  
  gdprep(igdp,sim)          gdp table
  gdprepXP(igdp,sim)        gdp table

  modsolstat(solcol,sim)                   status solver and model

  sectorstruc(ac,sectorcol,sim)            sectoral structure

  SIMSAM(ac,acp,sim)                       SAM defined using simulation results
  simsambalchk(ac,sim)                     simsam account surplus (row less column total)
  errsimsambalchk(ac,sim)                  sam balance check (column total minus row total)

  
;

dwts(c) = ( SUM(a, SAM(a,c)) - SAM(c,'row') ) /
          (  SUM(cp, SUM(a, SAM(a,cp)) - SAM(cp,'row')) );




