function [z, sol]=InternalCost(xhat,model,alpha)

% n=model.n;
FadingRate25_Exp=model.FadingRate25_Exp;
FadingRate35_Exp=model.FadingRate35_Exp;
FadingRate45_Exp=model.FadingRate45_Exp;
% FadingRateEQ_25=model.FadingRateEQ_25;
% FadingRateEQ_35=model.FadingRateEQ_35;
% FadingRateEQ_45=model.FadingRateEQ_45;

ChargingPro_25=zeros(size(FadingRate25_Exp));
ChargingPro_35=zeros(size(FadingRate35_Exp));
ChargingPro_45=zeros(size(FadingRate45_Exp));
TopCost_25=zeros(size(FadingRate25_Exp));
TopCost_35=zeros(size(FadingRate35_Exp));
TopCost_45=zeros(size(FadingRate45_Exp));
Predictionbuffer_25=zeros(size(FadingRate25_Exp));
Predictionbuffer_35=zeros(size(FadingRate35_Exp));
Predictionbuffer_45=zeros(size(FadingRate45_Exp));

Errmax = model.Errmax;
DecisionVarViolAlpha = model.DecisionVarViolAlpha;
T25=model.T25;T35=model.T35;T45=model.T45;
Batery_MaxCap=model.Batery_MaxCap;I_charge=model.I_charge;I_Discharge=model.I_Discharge; 
TopCostmax=model.TopCostmax;TopCostmin=model.TopCostmin;

CycLen=model.CycLen;%DayLen=24;
% topday=DayLen*[repmat(0,1,10),repmat(1,1,10),repmat(2,1,10),repmat(3,1,10),repmat(4,1,10),repmat(5,1,10),repmat(6,1,10),repmat(7,1,10),repmat(8,1,10),repmat(9,1,10),repmat(10,1,10),repmat(11,1,10),repmat(12,1,10),repmat(13,1,10),repmat(14,1,10),repmat(15,1,10),repmat(16,1,10),repmat(17,1,10),repmat(18,1,10),repmat(19,1,10),repmat(20,1,10),repmat(21,1,10),repmat(22,1,10),repmat(23,1,10),repmat(24,1,10)];
topinc=CycLen*linspace(1,60,60) ;
Top=topinc;% Top=topday+topinc;

x=ParseSolution(xhat);  %x(9)=0 in ParseSolution(xhat) % without top this line eliminates TopCost 

Ich=I_charge/Batery_MaxCap;  
Idis=I_Discharge/Batery_MaxCap;
for N_cyc=1:numel(Predictionbuffer_25)
    T=T25;
    ChargingPro_25(N_cyc)= x(1)*(Ich^x(2))*(Idis^x(3))*exp(x(4)/T)*( N_cyc^(x(5)*(Ich^x(6))*(Idis^x(7))*exp(x(8)/T)) );
    TopCost_25(N_cyc)=x(9)*exp(x(10)/T)*Top(N_cyc)^x(11);
    Predictionbuffer_25(N_cyc) = ChargingPro_25(N_cyc) + TopCost_25(N_cyc);
    T=T35;
    ChargingPro_35(N_cyc)= x(1)*(Ich^x(2))*(Idis^x(3))*exp(x(4)/T)*( N_cyc^(x(5)*(Ich^x(6))*(Idis^x(7))*exp(x(8)/T)) );
    TopCost_35(N_cyc)=x(9)*exp(x(10)/T)*Top(N_cyc)^x(11);
    Predictionbuffer_35(N_cyc) = ChargingPro_35(N_cyc) + TopCost_35(N_cyc);
    T=T45;
    ChargingPro_45(N_cyc)= x(1)*(Ich^x(2))*(Idis^x(3))*exp(x(4)/T)*( N_cyc^(x(5)*(Ich^x(6))*(Idis^x(7))*exp(x(8)/T)) );
    TopCost_45(N_cyc)=x(9)*exp(x(10)/T)*Top(N_cyc)^x(11);
    Predictionbuffer_45(N_cyc) = ChargingPro_45(N_cyc) + TopCost_45(N_cyc);
    
end

absErr25 = abs(FadingRate25_Exp-Predictionbuffer_25)';
absErr35 = abs(FadingRate35_Exp-Predictionbuffer_35)';
absErr45 = abs(FadingRate45_Exp-Predictionbuffer_45)';

absErr=[absErr25;absErr35;absErr45];
z = sum(absErr);

SubV1=max(0,(TopCost_25(numel(TopCost_25))/TopCostmax) -1);
% SubV2=max(0,1-(TopCost_25(numel(TopCost_25))/TopCostmin));
SubV2=0;% For without top( F11 model)

SubV3=max(0,(TopCost_35(numel(TopCost_35))/TopCostmax) -1);
% SubV4=max(0,1-(TopCost_35(numel(TopCost_35))/TopCostmin));
SubV4=0;% For without top( F11 model)

SubV5=max(0,(TopCost_45(numel(TopCost_45))/TopCostmax) -1);
% SubV6=max(0,1-(TopCost_45(numel(TopCost_45))/TopCostmin));
SubV6=0;% For without top( F11 model)

Viol1=DecisionVarViolAlpha*(SubV1+SubV2+SubV3+SubV4+SubV5+SubV6);
NumViol1=double(SubV1>0)+double(SubV2>0)+double(SubV3>0)+double(SubV4>0)+double(SubV5>0)+double(SubV6>0);

Viol2=sum(max(0,absErr/Errmax-1));
NumViol2=sum(double(max(0,absErr/Errmax-1)>0));

SumViol = Viol1 + Viol2;
NumViol = NumViol1 + NumViol2;

%z=VB+(alpha(1)*SumViol+alpha(2)*NumViol)*1000;
%z = VB+1000*alpha*SumViol;
%z=(1000+VB)*(1+alpha*SumViol)-1000;

sol.x=x;
sol.SubV1=SubV1;sol.SubV2=SubV2;sol.SubV3=SubV3;sol.SubV4=SubV4;sol.SubV5=SubV5;sol.SubV6=SubV6;
sol.Viol1=Viol1;
sol.Viol2=Viol2;
sol.NumViol1=NumViol1;
sol.NumViol2=NumViol2;
sol.SumViol=SumViol;
sol.NumViol=NumViol;
sol.IsFeasible=(NumViol==0);
sol.z=z;
end