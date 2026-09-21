function model=CreateModel()
    load('BatteryData_JREE.mat');
    % Values
    n=11;
    Errmax=0.5;
    DecisionVarViolAlpha=1000;
    T25=25+273.15;
    T35=35+273.15;
    T45=45+273.15; 
    Batery_MaxCap=3350;
    I_charge=975;
    I_Discharge=3250;
    TopCostmax=0.5;
    TopCostmin=0.05;
    CycLen=5;
    % Export Model
    model.n=n;
    model.FadingRate25_Exp=FadingRate25Discharge;
    model.FadingRate35_Exp=FadingRate35Discharge;
    model.FadingRate45_Exp=FadingRate45Discharge;
        
    model.FadingRateEQ_25=FadingRateEQ_25;
    model.FadingRateEQ_35=FadingRateEQ_35;
    model.FadingRateEQ_45=FadingRateEQ_45; 
    model.Errmax=Errmax;
    model.DecisionVarViolAlpha=DecisionVarViolAlpha;
    model.T25=T25;
    model.T35=T35;
    model.T45=T45;
    model.Batery_MaxCap=Batery_MaxCap;
    model.I_charge=I_charge;
    model.I_Discharge=I_Discharge;
    model.TopCostmax=TopCostmax;
    model.TopCostmin=TopCostmin;
    model.CycLen=CycLen;
end