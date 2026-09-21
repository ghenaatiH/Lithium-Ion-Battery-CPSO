clc;
clear;
close all;

%% Problem Definition

model=CreateModel();

% Internal PSO Params
params.MaxIt=1000;
params.nPop=50;
params.w=0.7298;
params.wdamp=1;
params.c1=1.4962;
params.c2=1.4962;
params.nVar=model.n;
params.VarMin=-1;
params.VarMax=1;

CostFunction=@(alpha) ExternalCost(alpha,params,model);        % Cost Function

nVar=1;             % Number of Decision Variables

VarSize=[1 nVar];   % Size of Decision Variables Matrix

VarMin=0.001;       % Lower Bound of Variables
VarMax=20;          % Upper Bound of Variables

%% PSO Parameters

MaxIt=10;      % Maximum Number of Iterations
nPop=5;        % Population Size (Swarm Size)

% Constriction Coefficients
phi1=2.05;
phi2=2.05;
phi=phi1+phi2;
chi=2/(phi-2+sqrt(phi^2-4*phi));
w=chi;          % Inertia Weight
wdamp=1;        % Inertia Weight Damping Ratio
c1=chi*phi1;    % Personal Learning Coefficient
c2=chi*phi2;    % Global Learning Coefficient

% Velocity Limits
VelMax=0.1*(VarMax-VarMin);
VelMin=-VelMax;

%% Initialization

empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Out=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];

particle=repmat(empty_particle,nPop,1);

BestSol.Cost=inf;
InternalBestSol.Cost=inf;
BestCost=zeros(MaxIt,1);

for i=1:nPop
    
    % Initialize Position
    particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Initialize Velocity
    particle(i).Velocity=zeros(VarSize);
    
    % Evaluation
    [particle(i).Cost, particle(i).Out]=CostFunction(particle(i).Position);
    
    % Update Personal Best
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    particle(i).Best.Out=particle(i).Out;
    
    % Update Global Best
    if particle(i).Best.Cost<BestSol.Cost
        
        BestSol=particle(i).Best;
        
    end
    
    % Update Internal Best Solution Ever Found
    if particle(i).Out.BestSol.Sol.IsFeasible
        if particle(i).Out.BestSol.Cost<InternalBestSol.Cost
            InternalBestSol=particle(i).Out.BestSol;
        end
    end    
    
end

particle=CalcInvalidCosts(particle);
for i=1:nPop
    % Update Personal Best
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    particle(i).Best.Out=particle(i).Out;
    
    % Update Global Best
    if particle(i).Best.Cost<BestSol.Cost
        BestSol=particle(i).Best;
        
    end
end



%% PSO Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        
        % Update Velocity
        particle(i).Velocity = w*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(BestSol.Position-particle(i).Position);
        
        % Apply Velocity Limits
        particle(i).Velocity = max(particle(i).Velocity,VelMin);
        particle(i).Velocity = min(particle(i).Velocity,VelMax);
        
        % Update Position
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % Velocity Mirror Effect
        IsOutside=(particle(i).Position<VarMin | particle(i).Position>VarMax);
        particle(i).Velocity(IsOutside)=-particle(i).Velocity(IsOutside);
        
        % Apply Position Limits
        particle(i).Position = max(particle(i).Position,VarMin);
        particle(i).Position = min(particle(i).Position,VarMax);
        
        % Evaluation
        [particle(i).Cost, particle(i).Out] = CostFunction(particle(i).Position);
        
        % Update Personal Best
        if particle(i).Cost<particle(i).Best.Cost
            
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            particle(i).Best.Out=particle(i).Out;
            
            % Update Global Best
            if particle(i).Best.Cost<BestSol.Cost
                
                BestSol=particle(i).Best;
                
            end
            
        end
        
        % Update Internal Best Solution Ever Found
        if particle(i).Out.BestSol.Sol.IsFeasible
            if particle(i).Out.BestSol.Cost<InternalBestSol.Cost
                InternalBestSol=particle(i).Out.BestSol;
            end
        end    
        
    end
    
    particle=CalcInvalidCosts(particle);
    for i=1:nPop
        % Update Personal Best
        if particle(i).Cost<particle(i).Best.Cost            
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            particle(i).Best.Out=particle(i).Out;
            
            % Update Global Best
            if particle(i).Best.Cost<BestSol.Cost
                BestSol=particle(i).Best;
            end
        end
    end
    
    BestCost(it)=BestSol.Cost;
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) ' InternalBestCost= ' num2str(InternalBestSol.Cost) ]);
    w=w*wdamp;
    save('Temp_Result_JREE_Me');

%     IsFeas = double(BestSol.Out.BestSol.Sol.IsFeasible);
%     BestCostInternal=BestSol.Out.BestSol.Cost;       
%     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost) ': Best Cost Internal= ' num2str(BestCostInternal) ' IsFeas= ' num2str(IsFeas) ' InternalBestCost= ' num2str(InternalBestSol.Cost) ]);    
end

%% Results
load('BatteryData_JREE.mat');
% figure;
% plot(BestCost,'LineWidth',2);
% xlabel('Iteration');
% ylabel('Best Cost');

FadingRate25_Exp=model.FadingRate25_Exp;
FadingRate35_Exp=model.FadingRate35_Exp;
FadingRate45_Exp=model.FadingRate45_Exp;
FadingRateEQ_25=model.FadingRateEQ_25;
FadingRateEQ_35=model.FadingRateEQ_35;
FadingRateEQ_45=model.FadingRateEQ_45;

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

x = InternalBestSol.Sol.x;%x(9)=0 % without top this line eliminates TopCost 

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

absErr25_JREE = abs(FadingRate25_Exp-FadingRateEQ_25)';
absErr35_JREE = abs(FadingRate35_Exp-FadingRateEQ_35)';
absErr45_JREE = abs(FadingRate45_Exp-FadingRateEQ_45)';

absErrMe=[absErr25;absErr35;absErr45];
absErrJREE=[absErr25_JREE;absErr35_JREE;absErr45_JREE];

figure;
plot(1:180,absErrJREE,'b');title('Differencess JREE');hold on;
% xticks(1:1:250);xlim([0 251]);ylim([0 4]);
plot(1:180,absErrMe,'r');legend('absErr JREE','absErrMe');
xlabel('N cyc');ylabel('Absolute Error');
ErrJREE=sum(absErrJREE)
ErrMe=sum(absErrMe)

figure;
plot(1:60,FadingRate25_Exp,'*b');title('T25');hold on;
plot(1:60,FadingRateEQ_25,'*r');
plot(1:60,Predictionbuffer_25,'*g');
plot(1:60,ChargingPro_25,'-.k');
plot(1:60,TopCost_25,'--m');
legend('T25 Exp','T25 JREE','T25 Me','ChargingPro 25','TopCost 25');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:60,FadingRate35_Exp,'*b');title('T35');hold on;
plot(1:60,FadingRateEQ_35,'*r');
plot(1:60,Predictionbuffer_35,'*g');
plot(1:60,ChargingPro_35,'-.k');
plot(1:60,TopCost_35,'--m');
legend('T35 Exp','T35 JREE','T35 Me','ChargingPro 35','TopCost 35');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:60,FadingRate45_Exp,'*b');title('T45');hold on;
plot(1:60,FadingRateEQ_45,'*r');
plot(1:60,Predictionbuffer_45,'*g');
plot(1:60,ChargingPro_45,'-.k');
plot(1:60,TopCost_45,'--m');
legend('T45 Exp','T45 JREE','T45 Me','ChargingPro 45','TopCost 45');xlabel('N cyc');ylabel('Fading Rate %');

figure;
u=zeros(8,1);u(1)=0.016568;u(2)=0.3428;u(3)=0.1905;u(4)=942.76;u(5)=14.2335;u(6)=0.1595;u(7)=0.0257;u(8)=-1059.5988;  
subplot(1,2,1);
bar(1:8,u,'r');title('Decision Variables');legend('F 11');xlabel('Decition');ylabel('Amount');
subplot(1,2,2);
bar(1:11,x,'b');title('Decision Variables');legend('My Sol');xlabel('Decition');ylabel('Amount');

FinalResultx=InternalBestSol.Sol.x
FinalResult=InternalBestSol.Sol
save('Result_JREE_Me_cpso_3');
