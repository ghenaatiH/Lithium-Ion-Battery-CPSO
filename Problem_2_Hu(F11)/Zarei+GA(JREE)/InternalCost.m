function [z, sol]=InternalCost(xhat,model)
global NFE;
NFE=NFE+1;
n=model.n;
FR_5charge30_Exp=model.FR_5charge30_Exp;
FR_5charge40_Exp=model.FR_5charge40_Exp;
FR_10charge40_Exp=model.FR_10charge40_Exp;
FR_5discharge30_Exp=model.FR_5discharge30_Exp;
FR_5discharge40_Exp=model.FR_5discharge40_Exp;
FR_10discharge40_Exp=model.FR_10discharge40_Exp;
%     FR_5charge30_F11=model.FR_5charge30_F11;
%     FR_5charge40_F11=model.FR_5charge40_F11;
%     FR_10charge40_F11=model.FR_10charge40_F11;
%     FR_5discharge30_F11=model.FR_5discharge30_F11;
%     FR_5discharge40_F11=model.FR_5discharge40_F11;
%     FR_10discharge40_F11=model.FR_10discharge40_F11;

Predictionbuffer_5charge30=zeros(size(FR_5charge30_Exp));
Predictionbuffer_5charge40=zeros(size(FR_5charge40_Exp));
Predictionbuffer_10charge40=zeros(size(FR_10charge40_Exp));
Predictionbuffer_5discharge30=zeros(size(FR_5discharge30_Exp));
Predictionbuffer_5discharge40=zeros(size(FR_5discharge40_Exp));
Predictionbuffer_10discharge40=zeros(size(FR_10discharge40_Exp));

Errmax = model.Errmax;
DecisionVarViolAlpha = model.DecisionVarViolAlpha;
T30=model.T30;T40=model.T40;
TopCostmax=model.TopCostmax;TopCostmin=model.TopCostmin;

% CycLen=4;DayLen=24;
% topday=DayLen*[repmat(0,1,10),repmat(1,1,10),repmat(2,1,10),repmat(3,1,10),repmat(4,1,10),repmat(5,1,10),repmat(6,1,10),repmat(7,1,10),repmat(8,1,10),repmat(9,1,10),repmat(10,1,10),repmat(11,1,10),repmat(12,1,10),repmat(13,1,10),repmat(14,1,10),repmat(15,1,10),repmat(16,1,10),repmat(17,1,10),repmat(18,1,10),repmat(19,1,10),repmat(20,1,10),repmat(21,1,10),repmat(22,1,10),repmat(23,1,10),repmat(24,1,10)];
% topinc=CycLen*linspace(1,250,250) ;
% Top=topinc;% Top=topday+topinc;

x=ParseSolution(xhat);  
 
for N_cyc=1:numel(Predictionbuffer_5charge30)
    Ich=5;Idis=1;T=T30;
    Predictionbuffer_5charge30(N_cyc) = (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
    
    Ich=5;Idis=1;T=T40;
    Predictionbuffer_5charge40(N_cyc) = (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
    
    Ich=10;Idis=1;T=T40;
    Predictionbuffer_10charge40(N_cyc) = (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
    
    Ich=1;Idis=5;T=T30;
    Predictionbuffer_5discharge30(N_cyc) = (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
    
    Ich=1;Idis=5;T=T40;
    Predictionbuffer_5discharge40(N_cyc) = (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
    
    Ich=1;Idis=10;T=T40;
    Predictionbuffer_10discharge40(N_cyc)= (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
end

absErr5charge30 = abs(FR_5charge30_Exp-Predictionbuffer_5charge30)';
absErr5charge40 = abs(FR_5charge40_Exp-Predictionbuffer_5charge40)';
absErr10charge40 = abs(FR_10charge40_Exp-Predictionbuffer_10charge40)';
absErr5discharge30 = abs(FR_5discharge30_Exp-Predictionbuffer_5discharge30)';
absErr5discharge40 = abs(FR_5discharge40_Exp-Predictionbuffer_5discharge40)';
absErr10discharge40 = abs(FR_10discharge40_Exp-Predictionbuffer_10discharge40)';

absErr=[absErr5charge30;absErr5charge40;absErr10charge40;absErr5discharge30;absErr5discharge40;absErr10discharge40];
% z = sum(absErr);
% SubV1=max(0,(TopCost_5charge30(numel(TopCost_5charge30))/TopCostmax) -1);
% SubV2=max(0,1-(TopCost_5charge30(numel(TopCost_5charge30))/TopCostmin));
% SubV3=max(0,(TopCost_5charge40(numel(TopCost_5charge40))/TopCostmax) -1);
% SubV4=max(0,1-(TopCost_5charge40(numel(TopCost_5charge40))/TopCostmin));

% Viol1=DecisionVarViolAlpha*(SubV1+SubV2+SubV3+SubV4);
% NumViol1=double(SubV1>0)+double(SubV2>0)+double(SubV3>0)+double(SubV4>0);

SumViol=DecisionVarViolAlpha*sum(max(0,absErr/Errmax-1));
NumViol=sum(double(max(0,absErr/Errmax-1)>0));

z = sum(absErr)+SumViol;

%z=VB+(alpha(1)*SumViol+alpha(2)*NumViol)*1000;
%z = VB+1000*alpha*SumViol;
%z=(1000+VB)*(1+alpha*SumViol)-1000;

sol.x=x;
sol.SumViol=SumViol;
sol.NumViol=NumViol;
sol.IsFeasible=(NumViol==0);
sol.z=z;
end