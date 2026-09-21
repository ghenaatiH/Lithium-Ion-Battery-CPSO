%% Table1
format compact;
clc;clear;
close all;

load('BatteryData_JREE.mat');
load('Result_JREE_Me_cpso.mat');
load('Result_JREE_F11_cpso.mat');

ErrJREE
ErrMe
ErrF11
%%
MSE_absErr25_JREE_GA = mean(absErr25_JREE.^2);
RMSE_absErr25_JREE_GA = sqrt(MSE_absErr25_JREE_GA);
MAE_absErr25_JREE_GA = mean(absErr25_JREE);

MSE_absErr35_JREE_GA = mean(absErr35_JREE.^2);
RMSE_absErr35_JREE_GA = sqrt(MSE_absErr35_JREE_GA);
MAE_absErr35_JREE_GA = mean(absErr35_JREE);

MSE_absErr45_JREE_GA = mean(absErr45_JREE.^2);
RMSE_absErr45_JREE_GA = sqrt(MSE_absErr45_JREE_GA);
MAE_absErr45_JREE_GA = mean(absErr45_JREE);

MSE_absErr_JREE_GA = mean(absErrJREE.^2);
RMSE_absErr_JREE_GA = sqrt(MSE_absErr_JREE_GA);
MAE_absErr_JREE_GA = mean(absErrJREE);
SUM_absErr_JREE_GA = sum(absErrJREE);
%---------------------------------------------------------
MSE_absErr25_Me_cpso = mean(absErr25.^2);
RMSE_absErr25_Me_cpso = sqrt(MSE_absErr25_Me_cpso);
MAE_absErr25_Me_cpso = mean(absErr25);

MSE_absErr35_Me_cpso = mean(absErr35.^2);
RMSE_absErr35_Me_cpso = sqrt(MSE_absErr35_Me_cpso);
MAE_absErr35_Me_cpso = mean(absErr35);

MSE_absErr45_Me_cpso = mean(absErr45.^2);
RMSE_absErr45_Me_cpso = sqrt(MSE_absErr45_Me_cpso);
MAE_absErr45_Me_cpso = mean(absErr45);

MSE_absErr_Me_cpso = mean(absErrMe.^2);
RMSE_absErr_Me_cpso = sqrt(MSE_absErr_Me_cpso);
MAE_absErr_Me_cpso = mean(absErrMe);
SUM_absErr_Me_cpso = sum(absErrMe);
%---------------------------------------------------------
MSE_absErr25_F11_cpso = mean(absErr25_F11.^2);
RMSE_absErr25_F11_cpso = sqrt(MSE_absErr25_F11_cpso);
MAE_absErr25_F11_cpso = mean(absErr25_F11);

MSE_absErr35_F11_cpso = mean(absErr35_F11.^2);
RMSE_absErr35_F11_cpso = sqrt(MSE_absErr35_F11_cpso);
MAE_absErr35_F11_cpso = mean(absErr35_F11);

MSE_absErr45_F11_cpso = mean(absErr45_F11.^2);
RMSE_absErr45_F11_cpso = sqrt(MSE_absErr45_F11_cpso);
MAE_absErr45_F11_cpso = mean(absErr45_F11);

MSE_absErr_F11_cpso = mean(absErr_F11.^2);
RMSE_absErr_F11_cpso = sqrt(MSE_absErr_F11_cpso);
MAE_absErr_F11_cpso = mean(absErr_F11);
SUM_absErr_F11_cpso = sum(absErr_F11);
%---------------------------------------------------------
%%
load('Result_JREE_Me_pso.mat');
load('Result_JREE_F11_pso.mat');
ErrMe
ErrF11

MSE_absErr25_Me_pso = mean(absErr25.^2);
RMSE_absErr25_Me_pso = sqrt(MSE_absErr25_Me_pso);
MAE_absErr25_Me_pso = mean(absErr25);

MSE_absErr35_Me_pso = mean(absErr35.^2);
RMSE_absErr35_Me_pso = sqrt(MSE_absErr35_Me_pso);
MAE_absErr35_Me_pso = mean(absErr35);

MSE_absErr45_Me_pso = mean(absErr45.^2);
RMSE_absErr45_Me_pso = sqrt(MSE_absErr45_Me_pso);
MAE_absErr45_Me_pso = mean(absErr45);

MSE_absErr_Me_pso = mean(absErrMe.^2);
RMSE_absErr_Me_pso = sqrt(MSE_absErr_Me_pso);
MAE_absErr_Me_pso = mean(absErrMe);
SUM_absErr_Me_pso = sum(absErrMe);
%---------------------------------------------------------
MSE_absErr25_F11_pso = mean(absErr25_F11.^2);
RMSE_absErr25_F11_pso = sqrt(MSE_absErr25_F11_pso);
MAE_absErr25_F11_pso = mean(absErr25_F11);

MSE_absErr35_F11_pso = mean(absErr35_F11.^2);
RMSE_absErr35_F11_pso = sqrt(MSE_absErr35_F11_pso);
MAE_absErr35_F11_pso = mean(absErr35_F11);

MSE_absErr45_F11_pso = mean(absErr45_F11.^2);
RMSE_absErr45_F11_pso = sqrt(MSE_absErr45_F11_pso);
MAE_absErr45_F11_pso = mean(absErr45_F11);

MSE_absErr_F11_pso = mean(absErr_F11.^2);
RMSE_absErr_F11_pso = sqrt(MSE_absErr_F11_pso);
MAE_absErr_F11_pso = mean(absErr_F11);
SUM_absErr_F11_pso = sum(absErr_F11);
%---------------------------------------------------------
%%

T1=[...
    MAE_absErr25_JREE_GA,  MSE_absErr25_JREE_GA, RMSE_absErr25_JREE_GA;...
    MAE_absErr25_Me_cpso,  MSE_absErr25_Me_cpso, RMSE_absErr25_Me_cpso;...
    MAE_absErr25_Me_pso,  MSE_absErr25_Me_pso, RMSE_absErr25_Me_pso;...
    MAE_absErr25_F11_cpso,  MSE_absErr25_F11_cpso, RMSE_absErr25_F11_cpso;...
    MAE_absErr25_F11_pso,  MSE_absErr25_F11_pso, RMSE_absErr25_F11_pso;...
    MAE_absErr35_JREE_GA,  MSE_absErr35_JREE_GA, RMSE_absErr35_JREE_GA;...
    MAE_absErr35_Me_cpso,  MSE_absErr35_Me_cpso, RMSE_absErr35_Me_cpso;...
    MAE_absErr35_Me_pso,  MSE_absErr35_Me_pso, RMSE_absErr35_Me_pso;...
    MAE_absErr35_F11_cpso,  MSE_absErr35_F11_cpso, RMSE_absErr35_F11_cpso;...
    MAE_absErr35_F11_pso,  MSE_absErr35_F11_pso, RMSE_absErr35_F11_pso;...
	MAE_absErr45_JREE_GA,  MSE_absErr45_JREE_GA, RMSE_absErr45_JREE_GA;...
    MAE_absErr45_Me_cpso,  MSE_absErr45_Me_cpso, RMSE_absErr45_Me_cpso;...
    MAE_absErr45_Me_pso,  MSE_absErr45_Me_pso, RMSE_absErr45_Me_pso;...
    MAE_absErr45_F11_cpso,  MSE_absErr45_F11_cpso, RMSE_absErr45_F11_cpso;...
    MAE_absErr45_F11_pso,  MSE_absErr45_F11_pso, RMSE_absErr45_F11_pso;...   
    MAE_absErr_JREE_GA,  MSE_absErr_JREE_GA, RMSE_absErr_JREE_GA;...
    MAE_absErr_Me_cpso,  MSE_absErr_Me_cpso, RMSE_absErr_Me_cpso;...
    MAE_absErr_Me_pso,  MSE_absErr_Me_pso, RMSE_absErr_Me_pso;...
    MAE_absErr_F11_cpso,  MSE_absErr_F11_cpso, RMSE_absErr45_F11_cpso;...
    MAE_absErr_F11_pso,  MSE_absErr_F11_pso, RMSE_absErr45_F11_pso]

Method = {'Original Paper';'Me+CPSO';'Me+PSO';'Hu+CPSO';'Hu+PSO'};Methods=repmat(Method,[4,1]);
Temperature1=repmat(25,size(Method));Temperature2=repmat(35,size(Method));Temperature3=repmat(45,size(Method));Temperature4=repmat(100,size(Method));
Temperature=[Temperature1;Temperature2;Temperature3;Temperature4];

MAE=T1(:,1);
MSE=T1(:,2);
RMSE=T1(:,3);

results_table = table(Temperature,Methods, MAE, MSE, RMSE, ...
    'VariableNames', {'Temperature','Methods', 'MAE', 'MSE', 'RMSE'});

disp('جدول نتایج مقایسه روش‌ها:');
disp(results_table);




