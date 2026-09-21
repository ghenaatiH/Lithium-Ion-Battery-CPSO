%% Table1
format compact;
clc;clear;
close all;

load('BatteryData_F11.mat');
load('Result_F11_JREE_GA.mat');
load('Result_F11_Me_cpso.mat');

ErrF11
ErrMe
ErrJREE

absErrF11=abs([FR_5charge30_Exp-FR_5charge30_F11,FR_5charge40_Exp-FR_5charge40_F11,FR_10charge40_Exp-FR_10charge40_F11,FR_5discharge30_Exp-FR_5discharge30_F11,FR_5discharge40_Exp-FR_5discharge40_F11,FR_10discharge40_Exp-FR_10discharge40_F11]);
absErrMe =abs([FR_5charge30_Exp-Predictionbuffer_5charge30,FR_5charge40_Exp-Predictionbuffer_5charge40,FR_10charge40_Exp-Predictionbuffer_10charge40,FR_5discharge30_Exp-Predictionbuffer_5discharge30,FR_5discharge40_Exp-Predictionbuffer_5discharge40,FR_10discharge40_Exp-Predictionbuffer_10discharge40]);
absErrJREE =abs([FR_5charge30_Exp-Predictionbuffer_5charge30_ga,FR_5charge40_Exp-Predictionbuffer_5charge40_ga,FR_10charge40_Exp-Predictionbuffer_10charge40_ga,FR_5discharge30_Exp-Predictionbuffer_5discharge30_ga,FR_5discharge40_Exp-Predictionbuffer_5discharge40_ga,FR_10discharge40_Exp-Predictionbuffer_10discharge40_ga]);

absErrF11_5charge30=absErrF11(1:250);
absErrF11_5charge40=absErrF11(251:500);
absErrF11_10charge40=absErrF11(501:750);
absErrF11_5discharge30=absErrF11(751:1000);
absErrF11_5discharge40=absErrF11(1001:1250);
absErrF11_10discharge40=absErrF11(1251:1500);

absErr_Me_CPSO_5charge30=absErrMe(1:250);
absErr_Me_CPSO_5charge40=absErrMe(251:500);
absErr_Me_CPSO_10charge40=absErrMe(501:750);
absErr_Me_CPSO_5discharge30=absErrMe(751:1000);
absErr_Me_CPSO_5discharge40=absErrMe(1001:1250);
absErr_Me_CPSO_10discharge40=absErrMe(1251:1500);

absErr_JREE_GA_5charge30=absErrJREE(1:250);
absErr_JREE_GA_5charge40=absErrJREE(251:500);
absErr_JREE_GA_10charge40=absErrJREE(501:750);
absErr_JREE_GA_5discharge30=absErrJREE(751:1000);
absErr_JREE_GA_5discharge40=absErrJREE(1001:1250);
absErr_JREE_GA_10discharge40=absErrJREE(1251:1500);
%-------------------------------------------
MAE_absErrF11_5charge30 = mean(absErrF11_5charge30);
MSE_absErrF11_5charge30 = mean(absErrF11_5charge30.^2);
RMSE_absErrF11_5charge30 = sqrt(MSE_absErrF11_5charge30);

MAE_absErrF11_5charge40 = mean(absErrF11_5charge40);
MSE_absErrF11_5charge40 = mean(absErrF11_5charge40.^2);
RMSE_absErrF11_5charge40 = sqrt(MSE_absErrF11_5charge40);

MAE_absErrF11_10charge40 = mean(absErrF11_10charge40);
MSE_absErrF11_10charge40 = mean(absErrF11_10charge40.^2);
RMSE_absErrF11_10charge40 = sqrt(MSE_absErrF11_10charge40);

MAE_absErrF11_5discharge30 = mean(absErrF11_5discharge30);
MSE_absErrF11_5discharge30 = mean(absErrF11_5discharge30.^2);
RMSE_absErrF11_5discharge30 = sqrt(MSE_absErrF11_5discharge30);

MAE_absErrF11_5discharge40 = mean(absErrF11_5discharge40);
MSE_absErrF11_5discharge40 = mean(absErrF11_5discharge40.^2);
RMSE_absErrF11_5discharge40 = sqrt(MSE_absErrF11_5discharge40);

MAE_absErrF11_10discharge40 = mean(absErrF11_10discharge40);
MSE_absErrF11_10discharge40 = mean(absErrF11_10discharge40.^2);
RMSE_absErrF11_10discharge40 = sqrt(MSE_absErrF11_10discharge40);
%-------------------------------------------
MAE_absErr_Me_CPSO_5charge30 = mean(absErr_Me_CPSO_5charge30);
MSE_absErr_Me_CPSO_5charge30 = mean(absErr_Me_CPSO_5charge30.^2);
RMSE_absErr_Me_CPSO_5charge30 = sqrt(MSE_absErr_Me_CPSO_5charge30);

MAE_absErr_Me_CPSO_5charge40 = mean(absErr_Me_CPSO_5charge40);
MSE_absErr_Me_CPSO_5charge40 = mean(absErr_Me_CPSO_5charge40.^2);
RMSE_absErr_Me_CPSO_5charge40 = sqrt(MSE_absErr_Me_CPSO_5charge40);

MAE_absErr_Me_CPSO_10charge40 = mean(absErr_Me_CPSO_10charge40);
MSE_absErr_Me_CPSO_10charge40 = mean(absErr_Me_CPSO_10charge40.^2);
RMSE_absErr_Me_CPSO_10charge40 = sqrt(MSE_absErr_Me_CPSO_10charge40);

MAE_absErr_Me_CPSO_5discharge30 = mean(absErr_Me_CPSO_5discharge30);
MSE_absErr_Me_CPSO_5discharge30 = mean(absErr_Me_CPSO_5discharge30.^2);
RMSE_absErr_Me_CPSO_5discharge30 = sqrt(MSE_absErr_Me_CPSO_5discharge30);

MAE_absErr_Me_CPSO_5discharge40 = mean(absErr_Me_CPSO_5discharge40);
MSE_absErr_Me_CPSO_5discharge40 = mean(absErr_Me_CPSO_5discharge40.^2);
RMSE_absErr_Me_CPSO_5discharge40 = sqrt(MSE_absErr_Me_CPSO_5discharge40);

MAE_absErr_Me_CPSO_10discharge40 = mean(absErr_Me_CPSO_10discharge40);
MSE_absErr_Me_CPSO_10discharge40 = mean(absErr_Me_CPSO_10discharge40.^2);
RMSE_absErr_Me_CPSO_10discharge40 = sqrt(MSE_absErr_Me_CPSO_10discharge40);
%-------------------------------------------
MAE_absErr_JREE_GA_5charge30 = mean(absErr_JREE_GA_5charge30);
MSE_absErr_JREE_GA_5charge30 = mean(absErr_JREE_GA_5charge30.^2);
RMSE_absErr_JREE_GA_5charge30 = sqrt(MSE_absErr_JREE_GA_5charge30);

MAE_absErr_JREE_GA_5charge40 = mean(absErr_JREE_GA_5charge40);
MSE_absErr_JREE_GA_5charge40 = mean(absErr_JREE_GA_5charge40.^2);
RMSE_absErr_JREE_GA_5charge40 = sqrt(MSE_absErr_JREE_GA_5charge40);

MAE_absErr_JREE_GA_10charge40 = mean(absErr_JREE_GA_10charge40);
MSE_absErr_JREE_GA_10charge40 = mean(absErr_JREE_GA_10charge40.^2);
RMSE_absErr_JREE_GA_10charge40 = sqrt(MSE_absErr_JREE_GA_10charge40);

MAE_absErr_JREE_GA_5discharge30 = mean(absErr_JREE_GA_5discharge30);
MSE_absErr_JREE_GA_5discharge30 = mean(absErr_JREE_GA_5discharge30.^2);
RMSE_absErr_JREE_GA_5discharge30 = sqrt(MSE_absErr_JREE_GA_5discharge30);

MAE_absErr_JREE_GA_5discharge40 = mean(absErr_JREE_GA_5discharge40);
MSE_absErr_JREE_GA_5discharge40 = mean(absErr_JREE_GA_5discharge40.^2);
RMSE_absErr_JREE_GA_5discharge40 = sqrt(MSE_absErr_JREE_GA_5discharge40);

MAE_absErr_JREE_GA_10discharge40 = mean(absErr_JREE_GA_10discharge40);
MSE_absErr_JREE_GA_10discharge40 = mean(absErr_JREE_GA_10discharge40.^2);
RMSE_absErr_JREE_GA_10discharge40 = sqrt(MSE_absErr_JREE_GA_10discharge40);
%-------------------------------------------
MAE_absErr_F11 = mean(absErrF11);
MSE_absErr_F11 = mean(absErrF11.^2);
RMSE_absErr_F11 = sqrt(MSE_absErr_F11);
% SUM_absErr_F11 = sum(absErrF11);

MAE_absErr_JREE_GA = mean(absErrJREE);
MSE_absErr_JREE_GA = mean(absErrJREE.^2);
RMSE_absErr_JREE_GA = sqrt(MSE_absErr_JREE_GA);
% SUM_absErr_JREE_GA = sum(absErrJREE);

MAE_absErr_Me_cpso = mean(absErrMe);
MSE_absErr_Me_cpso = mean(absErrMe.^2);
RMSE_absErr_Me_cpso = sqrt(MSE_absErr_Me_cpso);
% SUM_absErr_Me_cpso = sum(absErrMe);

%%

T1=[...
    MAE_absErrF11_5charge30,MSE_absErrF11_5charge30,RMSE_absErrF11_5charge30;
    MAE_absErr_Me_CPSO_5charge30,MSE_absErr_Me_CPSO_5charge30,RMSE_absErr_Me_CPSO_5charge30;
    MAE_absErr_JREE_GA_5charge30,MSE_absErr_JREE_GA_5charge30,RMSE_absErr_JREE_GA_5charge30;
    
    MAE_absErrF11_5discharge30,MSE_absErrF11_5discharge30,RMSE_absErrF11_5discharge30;
    MAE_absErr_Me_CPSO_5discharge30,MSE_absErr_Me_CPSO_5discharge30,RMSE_absErr_Me_CPSO_5discharge30;
    MAE_absErr_JREE_GA_5discharge30,MSE_absErr_JREE_GA_5discharge30,RMSE_absErr_JREE_GA_5discharge30;
    
    MAE_absErrF11_5charge40,MSE_absErrF11_5charge40,RMSE_absErrF11_5charge40;
    MAE_absErr_Me_CPSO_5charge40,MSE_absErr_Me_CPSO_5charge40,RMSE_absErr_Me_CPSO_5charge40;
    MAE_absErr_JREE_GA_5charge40,MSE_absErr_JREE_GA_5charge40,RMSE_absErr_JREE_GA_5charge40;
    
    MAE_absErrF11_5discharge40,MSE_absErrF11_5discharge40,RMSE_absErrF11_5discharge40;
    MAE_absErr_Me_CPSO_5discharge40,MSE_absErr_Me_CPSO_5discharge40,RMSE_absErr_Me_CPSO_5discharge40;
    MAE_absErr_JREE_GA_5discharge40,MSE_absErr_JREE_GA_5discharge40,RMSE_absErr_JREE_GA_5discharge40;
    
    MAE_absErrF11_10charge40,MSE_absErrF11_10charge40,RMSE_absErrF11_10charge40;
    MAE_absErr_Me_CPSO_10charge40,MSE_absErr_Me_CPSO_10charge40,RMSE_absErr_Me_CPSO_10charge40;
    MAE_absErr_JREE_GA_10charge40,MSE_absErr_JREE_GA_10charge40,RMSE_absErr_JREE_GA_10charge40;
    
    MAE_absErrF11_10discharge40,MSE_absErrF11_10discharge40,RMSE_absErrF11_10discharge40;
    MAE_absErr_Me_CPSO_10discharge40,MSE_absErr_Me_CPSO_10discharge40,RMSE_absErr_Me_CPSO_10discharge40;
    MAE_absErr_JREE_GA_10discharge40,MSE_absErr_JREE_GA_10discharge40,RMSE_absErr_JREE_GA_10discharge40;    
    
    MAE_absErr_F11,MSE_absErr_F11,RMSE_absErr_F11;...
    MAE_absErr_Me_cpso,MSE_absErr_Me_cpso,RMSE_absErr_Me_cpso;...
    MAE_absErr_JREE_GA,MSE_absErr_JREE_GA,RMSE_absErr_JREE_GA];

Method = {'Original Paper';'Me+CPSO';'zarei+GA'};Methods=repmat(Method,[7,1]);
current1 = {'5 charge';'5 charge';'5 charge';'5 discharge';'5 discharge';'5 discharge'};
current2 = {'10 charge';'10 charge';'10 charge';'10 discharge';'10 discharge';'10 discharge'};
current3 = {'All';'All';'All'};currents=[current1;current1;current2;current3];

Temperature1=repmat(30,[6,1]);Temperature2=repmat(40,[6,1]);Temperature3=repmat(40,[6,1]);Temperature4=repmat(100,[3,1]);
Temperature=[Temperature1;Temperature2;Temperature3;Temperature4];

MAE=T1(:,1);
MSE=T1(:,2);
RMSE=T1(:,3);

results_table = table(Temperature,currents,Methods, MAE, MSE, RMSE, ...
    'VariableNames', {'Temperature','currents','Method', 'MAE', 'MSE', 'RMSE'});
disp('جدول نتایج مقایسه روش‌ها:');
disp(results_table);




