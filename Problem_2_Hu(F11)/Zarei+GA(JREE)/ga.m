clc;
clear;
close all;

%% Problem Definition

global NFE;
NFE=0;
model=CreateModel();
CostFunction=@(xhat) InternalCost(xhat,model);     % Cost Function

nVar=model.n;             % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin=-1;         % Lower Bound of Variables
VarMax= 1;         % Upper Bound of Variables


%% GA Parameters

MaxIt=5000;      % Maximum Number of Iterations
nPop=10000;        % Population Size
pc=0.8;                 % Crossover Percentage
nc=2*round(pc*nPop/2);  % Number of Offsprings (Parnets)
pm=0.3;                 % Mutation Percentage
nm=round(pm*nPop);      % Number of Mutants
gamma=0.05;
mu=0.02;         % Mutation Rate

% ANSWER=questdlg('Choose selection method:','Genetic Algorith',...
%     'Roulette Wheel','Tournament','Random','Roulette Wheel');
% 
ANSWER='Roulette Wheel';
UseRouletteWheelSelection=strcmp(ANSWER,'Roulette Wheel');
UseTournamentSelection=strcmp(ANSWER,'Tournament');
UseRandomSelection=strcmp(ANSWER,'Random');

if UseRouletteWheelSelection
    beta=8;         % Selection Pressure
end
if UseTournamentSelection
    TournamentSize=3;   % Tournamnet Size
end
% pause(0.1);

%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];

pop=repmat(empty_individual,nPop,1);

for i=1:nPop
    
    % Initialize Position
    pop(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    % Evaluation
    pop(i).Cost=CostFunction(pop(i).Position);
    
end

% Sort Population
Costs=[pop.Cost];
[Costs, SortOrder]=sort(Costs);
pop=pop(SortOrder);

% Store Best Solution
BestSol=pop(1);

% Array to Hold Best Cost Values
BestCost=zeros(MaxIt,1);

% Store Cost
WorstCost=pop(end).Cost;

% Array to Hold Number of Function Evaluations
nfe=zeros(MaxIt,1);


%% Main Loop

for it=1:MaxIt
    
    % Calculate Selection Probabilities
    if UseRouletteWheelSelection
        P=exp(-beta*Costs/WorstCost);
        P=P/sum(P);
    end
    
    % Crossover
    popc=repmat(empty_individual,nc/2,2);
    for k=1:nc/2
        
        % Select Parents Indices
        if UseRouletteWheelSelection
            i1=RouletteWheelSelection(P);
            i2=RouletteWheelSelection(P);
        end
        if UseTournamentSelection
            i1=TournamentSelection(pop,TournamentSize);
            i2=TournamentSelection(pop,TournamentSize);
        end
        if UseRandomSelection
            i1=randi([1 nPop]);
            i2=randi([1 nPop]);
        end

        % Select Parents
        p1=pop(i1);
        p2=pop(i2);
        
        % Apply Crossover
        [popc(k,1).Position popc(k,2).Position]=...
            Crossover(p1.Position,p2.Position,gamma,VarMin,VarMax);
        
        % Evaluate Offsprings
        popc(k,1).Cost=CostFunction(popc(k,1).Position);
        popc(k,2).Cost=CostFunction(popc(k,2).Position);
        
    end
    popc=popc(:);
    
    
    % Mutation
    popm=repmat(empty_individual,nm,1);
    for k=1:nm
        
        % Select Parent
        i=randi([1 nPop]);
        p=pop(i);
        
        % Apply Mutation
        popm(k).Position=Mutate(p.Position,mu,VarMin,VarMax);
        
        % Evaluate Mutant
        popm(k).Cost=CostFunction(popm(k).Position);
        
    end
    
    % Create Merged Population
    pop=[pop
         popc
         popm];
     
    % Sort Population
    Costs=[pop.Cost];
    [Costs, SortOrder]=sort(Costs);
    pop=pop(SortOrder);
    
    % Update Worst Cost
    WorstCost=max(WorstCost,pop(end).Cost);
    
    % Truncation
    pop=pop(1:nPop);
    Costs=Costs(1:nPop);
    
    % Store Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost Ever Found
    BestCost(it)=BestSol.Cost;
    
    % Store NFE
    nfe(it)=NFE;
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ': NFE = ' num2str(nfe(it)) ', Best Cost = ' num2str(BestCost(it))]);
    
end

%% Results
load('BatteryData_F11.mat');
figure;
semilogy(nfe,BestCost,'LineWidth',2);
xlabel('NFE');
ylabel('Cost');

figure;
Predictionbuffer_5charge30_ga=zeros(size(FR_5charge30_Exp));
Predictionbuffer_5charge40_ga=zeros(size(FR_5charge40_Exp));
Predictionbuffer_10charge40_ga=zeros(size(FR_10charge40_Exp));
Predictionbuffer_5discharge30_ga=zeros(size(FR_5discharge30_Exp));
Predictionbuffer_5discharge40_ga=zeros(size(FR_5discharge40_Exp));
Predictionbuffer_10discharge40_ga=zeros(size(FR_10discharge40_Exp));
Errmax = model.Errmax;
DecisionVarViolAlpha = model.DecisionVarViolAlpha;
T30=model.T30;T40=model.T40;

x = ParseSolution(BestSol.Position); 
for N_cyc=1:numel(Predictionbuffer_5charge30_ga)
    Ich=5;Idis=1;T=T30;
    Predictionbuffer_5charge30_ga(N_cyc) = (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
    
    Ich=5;Idis=1;T=T40;
    Predictionbuffer_5charge40_ga(N_cyc) = (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
    
    Ich=10;Idis=1;T=T40;
    Predictionbuffer_10charge40_ga(N_cyc) = (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
    
    Ich=1;Idis=5;T=T30;
    Predictionbuffer_5discharge30_ga(N_cyc) = (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
    
    Ich=1;Idis=5;T=T40;
    Predictionbuffer_5discharge40_ga(N_cyc) = (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
    
    Ich=1;Idis=10;T=T40;
    Predictionbuffer_10discharge40_ga(N_cyc)= (x(1)*exp(x(2)/T)*N_cyc^x(3))+(x(4)*exp(x(5)/T)*N_cyc^x(6));
end

absErrF11=abs([FR_5charge30_Exp-FR_5charge30_F11,FR_5charge40_Exp-FR_5charge40_F11,FR_10charge40_Exp-FR_10charge40_F11,FR_5discharge30_Exp-FR_5discharge30_F11,FR_5discharge40_Exp-FR_5discharge40_F11,FR_10discharge40_Exp-FR_10discharge40_F11]);
absErrJREE =abs([FR_5charge30_Exp-Predictionbuffer_5charge30_ga,FR_5charge40_Exp-Predictionbuffer_5charge40_ga,FR_10charge40_Exp-Predictionbuffer_10charge40_ga,FR_5discharge30_Exp-Predictionbuffer_5discharge30_ga,FR_5discharge40_Exp-Predictionbuffer_5discharge40_ga,FR_10discharge40_Exp-Predictionbuffer_10discharge40_ga]);

plot(1:1500,absErrF11,'b');title('Differencess F11');hold on;
% xticks(1:1:250);xlim([0 251]);ylim([0 4]);
plot(1:1500,absErrJREE,'r');legend('absErr F11','absErrMe');
xlabel('N cyc');ylabel('Absolute Error');
ErrF11=sum(absErrF11)
ErrJREE=sum(absErrJREE)

figure;
plot(1:250,FR_5charge30_Exp,'*b');title('5charge30');hold on;
plot(1:250,FR_5charge30_F11,'*r');
plot(1:250,Predictionbuffer_5charge30_ga,'*g');
legend('5charge30 Exp','5charge30 F11','5charge30 JREE');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_5charge40_Exp,'*b');title('5charge40');hold on;
plot(1:250,FR_5charge40_F11,'*r');
plot(1:250,Predictionbuffer_5charge40_ga,'*g');
legend('5charge40 Exp','5charge40 F11','5charge40 JREE');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_10charge40_Exp,'*b');title('10charge40');hold on;
plot(1:250,FR_10charge40_F11,'*r');
plot(1:250,Predictionbuffer_10charge40_ga,'*g');
legend('10charge40 Exp','10charge40 F11','10charge40 JREE');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_5discharge30_Exp,'*b');title('5discharge30');hold on;
plot(1:250,FR_5discharge30_F11,'*r');
plot(1:250,Predictionbuffer_5discharge30_ga,'*g');
legend('5discharge30 Exp','5discharge30 F11','5discharge30 JREE');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_5discharge40_Exp,'*b');title('5discharge40');hold on;
plot(1:250,FR_5discharge40_F11,'*r');
plot(1:250,Predictionbuffer_5discharge40_ga,'*g');
legend('5discharge40 Exp','5discharge40 F11','5discharge40 JREE');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_10discharge40_Exp,'*b');title('10discharge40');hold on;
plot(1:250,FR_10discharge40_F11,'*r');
plot(1:250,Predictionbuffer_10discharge40_ga,'*g');
legend('10discharge40 Exp','10discharge40 F11','10discharge40 JREE');xlabel('N cyc');ylabel('Fading Rate %');

figure;
bar(1:6,x,'b');title('Decision Variables');legend('My Sol');xlabel('Decition');ylabel('Amount');

FinalResultx=x
[~,FinalResult]=CostFunction(x)
save('Result_model_JREE_2');

