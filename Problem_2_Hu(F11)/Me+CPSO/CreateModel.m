function model=CreateModel()
    load('BatteryData_F11.mat');
    % Values
    n=11;
    Errmax=1.4;
    DecisionVarViolAlpha=1000;
    T30=30+273.15;
    T40=40+273.15;
	CycLen=4;
    TopCostmax=1;
    TopCostmin=0.1;
    % Export Model
    model.n=n;
    model.FR_5charge30_Exp=FR_5charge30_Exp;
    model.FR_5charge40_Exp=FR_5charge40_Exp;
    model.FR_10charge40_Exp=FR_10charge40_Exp;
    model.FR_5discharge30_Exp=FR_5discharge30_Exp;
    model.FR_5discharge40_Exp=FR_5discharge40_Exp;
    model.FR_10discharge40_Exp=FR_10discharge40_Exp;
    model.FR_5charge30_F11=FR_5charge30_F11;
    model.FR_5charge40_F11=FR_5charge40_F11;
    model.FR_10charge40_F11=FR_10charge40_F11;
    model.FR_5discharge30_F11=FR_5discharge30_F11;
    model.FR_5discharge40_F11=FR_5discharge40_F11;
    model.FR_10discharge40_F11=FR_10discharge40_F11;

    model.Errmax=Errmax;
    model.DecisionVarViolAlpha=DecisionVarViolAlpha;
    model.T30=T30;
    model.T40=T40;
	model.CycLen=CycLen;
    model.TopCostmax=TopCostmax;
    model.TopCostmin=TopCostmin;
end