clc;
clear;
close all;

%% Problem Definition

model=CreateModel();

% Internal PSO Params
params.MaxIt=1000;
params.nPop=100;
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

MaxIt=1;      % Maximum Number of Iterations
nPop=1;        % Population Size (Swarm Size)
% w=1;            % Inertia Weight
% wdamp=0.99;     % Inertia Weight Damping Ratio
% c1=2;           % Personal Learning Coefficient
% c2=2;           % Global Learning Coefficient

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
    save('Temp_Result_F11_Me');

%     IsFeas = double(BestSol.Out.BestSol.Sol.IsFeasible);
%     BestCostInternal=BestSol.Out.BestSol.Cost;       
%     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost) ': Best Cost Internal= ' num2str(BestCostInternal) ' IsFeas= ' num2str(IsFeas) ' InternalBestCost= ' num2str(InternalBestSol.Cost) ]);    
end

%% Results
load('BatteryData_F11.mat');
figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');

ChargingPro_5charge30=zeros(size(FR_5charge30_Exp));
ChargingPro_5charge40=zeros(size(FR_5charge40_Exp));
ChargingPro_10charge40=zeros(size(FR_10charge40_Exp));
ChargingPro_5discharge30=zeros(size(FR_5discharge30_Exp));
ChargingPro_5discharge40=zeros(size(FR_5discharge40_Exp));
ChargingPro_10discharge40=zeros(size(FR_10discharge40_Exp));

TopCost_5charge30=zeros(size(FR_5charge30_Exp));
TopCost_5charge40=zeros(size(FR_5charge40_Exp));
TopCost_10charge40=zeros(size(FR_10charge40_Exp));
TopCost_5discharge30=zeros(size(FR_5discharge30_Exp));
TopCost_5discharge40=zeros(size(FR_5discharge40_Exp));
TopCost_10discharge40=zeros(size(FR_10discharge40_Exp));

Predictionbuffer_5charge30=zeros(size(FR_5charge30_Exp));
Predictionbuffer_5charge40=zeros(size(FR_5charge40_Exp));
Predictionbuffer_10charge40=zeros(size(FR_10charge40_Exp));
Predictionbuffer_5discharge30=zeros(size(FR_5discharge30_Exp));
Predictionbuffer_5discharge40=zeros(size(FR_5discharge40_Exp));
Predictionbuffer_10discharge40=zeros(size(FR_10discharge40_Exp));

Errmax = model.Errmax;
DecisionVarViolAlpha = model.DecisionVarViolAlpha;
T30=model.T30;T40=model.T40;

CycLen=model.CycLen;DayLen=24;
topday=DayLen*[repmat(0,1,10),repmat(1,1,10),repmat(2,1,10),repmat(3,1,10),repmat(4,1,10),repmat(5,1,10),repmat(6,1,10),repmat(7,1,10),repmat(8,1,10),repmat(9,1,10),repmat(10,1,10),repmat(11,1,10),repmat(12,1,10),repmat(13,1,10),repmat(14,1,10),repmat(15,1,10),repmat(16,1,10),repmat(17,1,10),repmat(18,1,10),repmat(19,1,10),repmat(20,1,10),repmat(21,1,10),repmat(22,1,10),repmat(23,1,10),repmat(24,1,10)];
topinc=CycLen*linspace(1,250,250) ;
Top=topinc;%Top=topday+topinc;

x = InternalBestSol.Sol.x;%x(9)=0 % without top this line eliminates TopCost 

for N_cyc=1:numel(Predictionbuffer_5charge30)
    Ich=5;Idis=1;T=T30;
    ChargingPro_5charge30(N_cyc)= x(1)*(Ich^x(2))*(Idis^x(3))*exp(x(4)/T)*( N_cyc^(x(5)*(Ich^x(6))*(Idis^x(7))*exp(x(8)/T)) );
    TopCost_5charge30(N_cyc)=x(9)*exp(x(10)/T)*Top(N_cyc)^x(11);
    Predictionbuffer_5charge30(N_cyc) = ChargingPro_5charge30(N_cyc) + TopCost_5charge30(N_cyc);
    
    Ich=5;Idis=1;T=T40;
    ChargingPro_5charge40(N_cyc)=x(1)*(Ich^x(2))*(Idis^x(3))*exp(x(4)/T)*( N_cyc^(x(5)*(Ich^x(6))*(Idis^x(7))*exp(x(8)/T)) );
    TopCost_5charge40(N_cyc)=x(9)*exp(x(10)/T)*Top(N_cyc)^x(11);
    Predictionbuffer_5charge40(N_cyc)=ChargingPro_5charge40(N_cyc) + TopCost_5charge40(N_cyc);
    
    Ich=10;Idis=1;T=T40;
    ChargingPro_10charge40(N_cyc)=x(1)*(Ich^x(2))*(Idis^x(3))*exp(x(4)/T)*( N_cyc^(x(5)*(Ich^x(6))*(Idis^x(7))*exp(x(8)/T)) );
    TopCost_10charge40(N_cyc)=x(9)*exp(x(10)/T)*Top(N_cyc)^x(11);
    Predictionbuffer_10charge40(N_cyc)=ChargingPro_10charge40(N_cyc) + TopCost_10charge40(N_cyc);
    
    Ich=1;Idis=5;T=T30;
    ChargingPro_5discharge30(N_cyc)=x(1)*(Ich^x(2))*(Idis^x(3))*exp(x(4)/T)*( N_cyc^(x(5)*(Ich^x(6))*(Idis^x(7))*exp(x(8)/T)) );
    TopCost_5discharge30(N_cyc)=x(9)*exp(x(10)/T)*Top(N_cyc)^x(11);
    Predictionbuffer_5discharge30(N_cyc)=ChargingPro_5discharge30(N_cyc) + TopCost_5discharge30(N_cyc);
    
    Ich=1;Idis=5;T=T40;
    ChargingPro_5discharge40(N_cyc)=x(1)*(Ich^x(2))*(Idis^x(3))*exp(x(4)/T)*( N_cyc^(x(5)*(Ich^x(6))*(Idis^x(7))*exp(x(8)/T)) );
    TopCost_5discharge40(N_cyc)=x(9)*exp(x(10)/T)*Top(N_cyc)^x(11);
    Predictionbuffer_5discharge40(N_cyc)=ChargingPro_5discharge40(N_cyc) + TopCost_5discharge40(N_cyc);
    
    Ich=1;Idis=10;T=T40;
    ChargingPro_10discharge40(N_cyc)=x(1)*(Ich^x(2))*(Idis^x(3))*exp(x(4)/T)*( N_cyc^(x(5)*(Ich^x(6))*(Idis^x(7))*exp(x(8)/T)) );
    TopCost_10discharge40(N_cyc)=x(9)*exp(x(10)/T)*Top(N_cyc)^x(11);
    Predictionbuffer_10discharge40(N_cyc)=ChargingPro_10discharge40(N_cyc) + TopCost_10discharge40(N_cyc);
    
end

absErrF11=abs([FR_5charge30_Exp-FR_5charge30_F11,FR_5charge40_Exp-FR_5charge40_F11,FR_10charge40_Exp-FR_10charge40_F11,FR_5discharge30_Exp-FR_5discharge30_F11,FR_5discharge40_Exp-FR_5discharge40_F11,FR_10discharge40_Exp-FR_10discharge40_F11]);
absErrMe =abs([FR_5charge30_Exp-Predictionbuffer_5charge30,FR_5charge40_Exp-Predictionbuffer_5charge40,FR_10charge40_Exp-Predictionbuffer_10charge40,FR_5discharge30_Exp-Predictionbuffer_5discharge30,FR_5discharge40_Exp-Predictionbuffer_5discharge40,FR_10discharge40_Exp-Predictionbuffer_10discharge40]);

figure;
plot(1:1500,absErrF11,'b');title('Differencess F11');hold on;
% xticks(1:1:250);xlim([0 251]);ylim([0 4]);
plot(1:1500,absErrMe,'r');legend('absErr F11','absErrMe');
xlabel('N cyc');ylabel('Absolute Error');
ErrF11=sum(absErrF11)
ErrMe=sum(absErrMe)

figure;
plot(1:250,FR_5charge30_Exp,'*b');title('5charge30');hold on;
plot(1:250,FR_5charge30_F11,'*r');
plot(1:250,Predictionbuffer_5charge30,'*g');
plot(1:250,ChargingPro_5charge30,'-.k');
plot(1:250,TopCost_5charge30,'--m');
legend('5charge30 Exp','5charge30 F11','5charge30 Me','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_5charge40_Exp,'*b');title('5charge40');hold on;
plot(1:250,FR_5charge40_F11,'*r');
plot(1:250,Predictionbuffer_5charge40,'*g');
plot(1:250,ChargingPro_5charge40,'-.k');
plot(1:250,TopCost_5charge40,'--m');
legend('5charge40 Exp','5charge40 F11','5charge40 Me','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_10charge40_Exp,'*b');title('10charge40');hold on;
plot(1:250,FR_10charge40_F11,'*r');
plot(1:250,Predictionbuffer_10charge40,'*g');
plot(1:250,ChargingPro_10charge40,'-.k');
plot(1:250,TopCost_10charge40,'--m');
legend('10charge40 Exp','10charge40 F11','10charge40 Me','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_5discharge30_Exp,'*b');title('5discharge30');hold on;
plot(1:250,FR_5discharge30_F11,'*r');
plot(1:250,Predictionbuffer_5discharge30,'*g');
plot(1:250,ChargingPro_5discharge30,'-.k');
plot(1:250,TopCost_5discharge30,'--m');
legend('5discharge30 Exp','5discharge30 F11','5discharge30 Me','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_5discharge40_Exp,'*b');title('5discharge40');hold on;
plot(1:250,FR_5discharge40_F11,'*r');
plot(1:250,Predictionbuffer_5discharge40,'*g');
plot(1:250,ChargingPro_5discharge40,'-.k');
plot(1:250,TopCost_5discharge40,'--m');
legend('5discharge40 Exp','5discharge40 F11','5discharge40 Me','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_10discharge40_Exp,'*b');title('10discharge40');hold on;
plot(1:250,FR_10discharge40_F11,'*r');
plot(1:250,Predictionbuffer_10discharge40,'*g');
plot(1:250,ChargingPro_10discharge40,'-.k');
plot(1:250,TopCost_10discharge40,'--m');
legend('10discharge40 Exp','10discharge40 F11','10discharge40 Me','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
u=zeros(8,1);u(1)=0.016568;u(2)=0.3428;u(3)=0.1905;u(4)=942.76;u(5)=14.2335;u(6)=0.1595;u(7)=0.0257;u(8)=-1059.5988;  

subplot(1,2,1);
bar(1:8,u,'r');title('Decision Variables');legend('F 11');xlabel('Decition');ylabel('Amount');
subplot(1,2,2);
bar(1:11,x,'b');title('Decision Variables');legend('My Sol');xlabel('Decition');ylabel('Amount');

FinalResultx=InternalBestSol.Sol.x
FinalResult=InternalBestSol.Sol

x = randi([1, 100]);
filename = sprintf('Result_F11_Me_pso_%d', x);
save(filename);