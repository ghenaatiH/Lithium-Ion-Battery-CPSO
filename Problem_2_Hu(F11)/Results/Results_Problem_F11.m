%% Results
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
%-------------------------------------------
T30_5_charge_Exp='Experimental Values';
T40_5_charge_Exp='Experimental Values';
T40_10_charge_Exp='Experimental Values';

T30_5_charge_F11='Original Paper (Model Hu)';
T40_5_charge_F11='Original Paper (Model Hu)';
T40_10_charge_F11='Original Paper (Model Hu)';

T30_5_charge_Me='Proposed Model+CPSO';
T40_5_charge_Me='Proposed Model+CPSO';
T40_10_charge_Me='Proposed Model+CPSO';

T30_5_charge_JREE='Model Zarei+GA';
T40_5_charge_JREE='Model Zarei+GA';
T40_10_charge_JREE='Model Zarei+GA';

Violationbound30_5_charge='Violation Bound';
Violationbound40_5_charge='Violation Bound';
Violationbound40_10_charge='Violation Bound';

Title30_5_charge=['Tempature 25 C' char(176)];
Title40_5_charge=['Tempature 35 C' char(176)];
Title40_10_charge=['Tempature 45 C' char(176)];

T30_5_discharge_Exp='Experimental Values';
T40_5_discharge_Exp='Experimental Values';
T40_10_discharge_Exp='Experimental Values';

T30_5_discharge_F11='Original Paper (Model Hu)';
T40_5_discharge_F11='Original Paper (Model Hu)';
T40_10_discharge_F11='Original Paper (Model Hu)';

T30_5_discharge_Me='Proposed Model+CPSO';
T40_5_discharge_Me='Proposed Model+CPSO';
T40_10_discharge_Me='Proposed Model+CPSO';

T30_5_discharge_JREE='Model Zarei+GA';
T40_5_discharge_JREE='Model Zarei+GA';
T40_10_discharge_JREE='Model Zarei+GA';

Violationbound30_5_discharge='Violation bound';
Violationbound40_5_discharge='Violation bound';
Violationbound40_10_discharge='Violation bound';

Title30_5_discharge=['Tempature 25 C' char(176)];
Title40_5_discharge=['Tempature 35 C' char(176)];
Title40_10_discharge=['Tempature 45 C' char(176)];

xlabelText='Cycle number';
ylabelText='The capacity loss (%)';

LineWidth1=2;
LineWidth2=3;
MarkerSize1=6;
MarkerSize2=10;
TextColor='black';FontName='Times new Roman';FontWeight= 'bold';FontSize=20;
FontSizeText=14;

% Graycolor1=[0.2,0.2,0.2];GraycolorAlpha1=0.08;
% Graycolor2=[0.2,0.2,0.2];GraycolorAlpha2=0.2;
Graycolor1=[1, 1, 1];GraycolorAlpha1=0.08;
Graycolor2=[1, 1, 1];GraycolorAlpha2=0.2;


%% for paper
close all;
FontSize=20;
tl = tiledlayout(3,2,'TileSpacing','tight','Padding','tight');
nexttile
p1=plot(1:250,FR_5charge30_Exp,'*b','MarkerSize',MarkerSize1);hold on;title(['Charge in 5C and 30 C' char(176)]);ax = gca;ax.TitleHorizontalAlignment = 'right';
p2=plot(1:250,Predictionbuffer_5charge30,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5charge30_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5charge30_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5charge30_Exp+Errmax;
Lowerbound=max(FR_5charge30_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
% legend(T30_5_charge_Exp,T30_5_charge_Me,T30_5_charge_F11,T30_5_charge_JREE,Violationbound30_5_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');
% xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[6.5, [min(Upperbound),Upperbound,6.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 6.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T30_5_charge_Exp,T30_5_charge_Me,T30_5_charge_F11,T30_5_charge_JREE,Violationbound30_5_charge,'Location','best','NumColumns',1,'Box','on','Color',[1 1 1]);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
%-----------------------------------------------------------
nexttile
p1=plot(1:250,FR_5discharge30_Exp,'*b','MarkerSize',MarkerSize1);hold on;title(['Discharge in 5C and 30 C' char(176)]);
p2=plot(1:250,Predictionbuffer_5discharge30,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5discharge30_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5discharge30_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5discharge30_Exp+Errmax;
Lowerbound=max(FR_5discharge30_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
% legend(T30_5_discharge_Exp,T30_5_discharge_Me,T30_5_discharge_F11,T30_5_discharge_JREE,Violationbound30_5_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off');
% xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[6.5, [min(Upperbound),Upperbound,6.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 6.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
% [BL,BLicons] =legend([p1,p2,p3,p4,p5],T30_5_discharge_Exp,T30_5_discharge_Me,T30_5_discharge_F11,T30_5_discharge_JREE,Violationbound30_5_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);
% PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
%--------------------------------------------------------------
nexttile
p1=plot(1:250,FR_5charge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title(['Charge in 5C and 40 C' char(176)]);
p2=plot(1:250,Predictionbuffer_5charge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5charge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5charge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5charge40_Exp+Errmax;
Lowerbound=max(FR_5charge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
% legend(T40_5_charge_Exp,T40_5_charge_Me,T40_5_charge_F11,T40_5_charge_JREE,Violationbound40_5_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');
% xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[6.5, [min(Upperbound),Upperbound,6.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 6.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
% [BL,BLicons] =legend([p1,p2,p3,p4,p5],T40_5_charge_Exp,T40_5_charge_Me,T40_5_charge_F11,T40_5_charge_JREE,Violationbound40_5_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);
% PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
%--------------------------------------------------------------
nexttile
p1=plot(1:250,FR_5discharge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title(['Discharge in 5C and 40 C' char(176)]);
p2=plot(1:250,Predictionbuffer_5discharge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5discharge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5discharge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5discharge40_Exp+Errmax;
Lowerbound=max(FR_5discharge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
% legend(T40_5_discharge_Exp,T40_5_discharge_Me,T40_5_discharge_F11,T40_5_discharge_JREE,Violationbound40_5_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off');
% xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[6.5, [min(Upperbound),Upperbound,6.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 6.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
% [BL,BLicons] =legend([p1,p2,p3,p4,p5],T40_5_discharge_Exp,T40_5_discharge_Me,T40_5_discharge_F11,T40_5_discharge_JREE,Violationbound40_5_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);
% PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
%--------------------------------------------------------------
nexttile
p1=plot(1:250,FR_10charge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title(['Charge in 10C and 40 C' char(176)]);
p2=plot(1:250,Predictionbuffer_10charge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_10charge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_10charge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_10charge40_Exp+Errmax;
Lowerbound=max(FR_10charge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
% legend(T40_10_charge_Exp,T40_10_charge_Me,T40_10_charge_F11,T40_10_charge_JREE,Violationbound40_10_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');
% xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[10.5, [min(Upperbound),Upperbound,10.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 10.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
% [BL,BLicons] =legend([p1,p2,p3,p4,p5],T40_10_charge_Exp,T40_10_charge_Me,T40_10_charge_F11,T40_10_charge_JREE,Violationbound40_10_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);
% PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
%--------------------------------------------------------------
nexttile
p1=plot(1:250,FR_10discharge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title(['Discharge in 10C and 40 C' char(176)]);
p2=plot(1:250,Predictionbuffer_10discharge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_10discharge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_10discharge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_10discharge40_Exp+Errmax;
Lowerbound=max(FR_10discharge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
% legend(T40_10_discharge_Exp,T40_10_discharge_Me,T40_10_discharge_F11,T40_10_discharge_JREE,Violationbound40_10_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off');
% xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[10.5, [min(Upperbound),Upperbound,10.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 10.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
% [BL,BLicons] =legend([p1,p2,p3,p4,p5],T40_10_discharge_Exp,T40_10_discharge_Me,T40_10_discharge_F11,T40_10_discharge_JREE,Violationbound40_10_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);
% PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
%--------------------------------------------------------------
xlabel(tl,xlabelText,'FontName',FontName,'FontSize',FontSize,'FontWeight',FontWeight);
ylabel(tl,ylabelText,'FontName',FontName,'FontSize',FontSize,'FontWeight',FontWeight);

% BL.Layout.Tile = 4;

%% for paper old version
figure(3051);
subplot(1,2,1)
p1=plot(1:250,FR_5charge30_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Charge');
p2=plot(1:250,Predictionbuffer_5charge30,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5charge30_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5charge30_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5charge30_Exp+Errmax;
Lowerbound=max(FR_5charge30_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);xlim([0 250]);ylim([0 6.5]);
legend(T30_5_charge_Exp,T30_5_charge_Me,T30_5_charge_F11,T30_5_charge_JREE,Violationbound30_5_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
subplot(1,2,2)
p1=plot(1:250,FR_5discharge30_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Discharge');
p2=plot(1:250,Predictionbuffer_5discharge30,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5discharge30_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5discharge30_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5discharge30_Exp+Errmax;
Lowerbound=max(FR_5discharge30_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);xlim([0 250]);ylim([0 6.5]);
legend(T30_5_discharge_Exp,T30_5_discharge_Me,T30_5_discharge_F11,T30_5_discharge_JREE,Violationbound30_5_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
%--------------------------------------------------------------
figure(4051);
subplot(1,2,1)
p1=plot(1:250,FR_5charge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Charge');
p2=plot(1:250,Predictionbuffer_5charge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5charge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5charge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5charge40_Exp+Errmax;
Lowerbound=max(FR_5charge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);xlim([0 250]);ylim([0 6.5]);
legend(T40_5_charge_Exp,T40_5_charge_Me,T40_5_charge_F11,T40_5_charge_JREE,Violationbound40_5_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
subplot(1,2,2)
p1=plot(1:250,FR_5discharge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Discharge');
p2=plot(1:250,Predictionbuffer_5discharge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5discharge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5discharge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5discharge40_Exp+Errmax;
Lowerbound=max(FR_5discharge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);xlim([0 250]);ylim([0 6.5]);
legend(T40_5_discharge_Exp,T40_5_discharge_Me,T40_5_discharge_F11,T40_5_discharge_JREE,Violationbound40_5_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
%--------------------------------------------------------------
figure(40101);
subplot(1,2,1)
p1=plot(1:250,FR_10charge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Charge');
p2=plot(1:250,Predictionbuffer_10charge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_10charge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_10charge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_10charge40_Exp+Errmax;
Lowerbound=max(FR_10charge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);xlim([0 250]);ylim([0 10.5]);
legend(T40_10_charge_Exp,T40_10_charge_Me,T40_10_charge_F11,T40_10_charge_JREE,Violationbound40_10_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
subplot(1,2,2)
p1=plot(1:250,FR_10discharge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Discharge');
p2=plot(1:250,Predictionbuffer_10discharge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_10discharge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_10discharge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_10discharge40_Exp+Errmax;
Lowerbound=max(FR_10discharge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);xlim([0 250]);ylim([0 10.5]);
legend(T40_10_discharge_Exp,T40_10_discharge_Me,T40_10_discharge_F11,T40_10_discharge_JREE,Violationbound40_10_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
%--------------------------------------------------------------
figure(3052);
subplot(1,2,1)
p1=plot(1:250,FR_5charge30_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Charge');
p2=plot(1:250,Predictionbuffer_5charge30,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5charge30_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5charge30_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5charge30_Exp+Errmax;
Lowerbound=max(FR_5charge30_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
legend(T30_5_charge_Exp,T30_5_charge_Me,T30_5_charge_F11,T30_5_charge_JREE,Violationbound30_5_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[6.5, [min(Upperbound),Upperbound,6.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 6.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T30_5_charge_Exp,T30_5_charge_Me,T30_5_charge_F11,T30_5_charge_JREE,Violationbound30_5_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);xlabel(xlabelText);ylabel(ylabelText);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
subplot(1,2,2)
p1=plot(1:250,FR_5discharge30_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Discharge');
p2=plot(1:250,Predictionbuffer_5discharge30,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5discharge30_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5discharge30_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5discharge30_Exp+Errmax;
Lowerbound=max(FR_5discharge30_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
legend(T30_5_discharge_Exp,T30_5_discharge_Me,T30_5_discharge_F11,T30_5_discharge_JREE,Violationbound30_5_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[6.5, [min(Upperbound),Upperbound,6.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 6.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T30_5_discharge_Exp,T30_5_discharge_Me,T30_5_discharge_F11,T30_5_discharge_JREE,Violationbound30_5_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);xlabel(xlabelText);ylabel(ylabelText);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
%--------------------------------------------------------------
figure(4052);
subplot(1,2,1)
p1=plot(1:250,FR_5charge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Charge');
p2=plot(1:250,Predictionbuffer_5charge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5charge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5charge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5charge40_Exp+Errmax;
Lowerbound=max(FR_5charge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
legend(T40_5_charge_Exp,T40_5_charge_Me,T40_5_charge_F11,T40_5_charge_JREE,Violationbound40_5_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[6.5, [min(Upperbound),Upperbound,6.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 6.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T40_5_charge_Exp,T40_5_charge_Me,T40_5_charge_F11,T40_5_charge_JREE,Violationbound40_5_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);xlabel(xlabelText);ylabel(ylabelText);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
subplot(1,2,2)
p1=plot(1:250,FR_5discharge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Discharge');
p2=plot(1:250,Predictionbuffer_5discharge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_5discharge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_5discharge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_5discharge40_Exp+Errmax;
Lowerbound=max(FR_5discharge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
legend(T40_5_discharge_Exp,T40_5_discharge_Me,T40_5_discharge_F11,T40_5_discharge_JREE,Violationbound40_5_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[6.5, [min(Upperbound),Upperbound,6.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 6.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T40_5_discharge_Exp,T40_5_discharge_Me,T40_5_discharge_F11,T40_5_discharge_JREE,Violationbound40_5_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);xlabel(xlabelText);ylabel(ylabelText);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
%--------------------------------------------------------------
figure(40102);
subplot(1,2,1)
p1=plot(1:250,FR_10charge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Charge');
p2=plot(1:250,Predictionbuffer_10charge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_10charge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_10charge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_10charge40_Exp+Errmax;
Lowerbound=max(FR_10charge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
legend(T40_10_charge_Exp,T40_10_charge_Me,T40_10_charge_F11,T40_10_charge_JREE,Violationbound40_10_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[10.5, [min(Upperbound),Upperbound,10.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 10.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T40_10_charge_Exp,T40_10_charge_Me,T40_10_charge_F11,T40_10_charge_JREE,Violationbound40_10_charge,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);xlabel(xlabelText);ylabel(ylabelText);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
subplot(1,2,2)
p1=plot(1:250,FR_10discharge40_Exp,'*b','MarkerSize',MarkerSize1);hold on;title('Discharge');
p2=plot(1:250,Predictionbuffer_10discharge40,'-g','LineWidth',LineWidth1);
p3=plot(1:250,FR_10discharge40_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:250,Predictionbuffer_10discharge40_ga,'-.c','LineWidth',LineWidth1);
Upperbound=FR_10discharge40_Exp+Errmax;
Lowerbound=max(FR_10discharge40_Exp-Errmax,0);
p5=plot(1:250,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:250,Lowerbound,':k','LineWidth',LineWidth1);
legend(T40_10_discharge_Exp,T40_10_discharge_Me,T40_10_discharge_F11,T40_10_discharge_JREE,Violationbound40_10_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 0;
y0 = max(Upperbound);
x1 = 250;
y1 = min(Lowerbound);
fill([0, [0:251]],[10.5, [min(Upperbound),Upperbound,10.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 250]);ylim([0 10.5]);
fill([x1, [1:250]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T40_10_discharge_Exp,T40_10_discharge_Me,T40_10_discharge_F11,T40_10_discharge_JREE,Violationbound40_10_discharge,'Position',[0.62 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);xlabel(xlabelText);ylabel(ylabelText);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);

%% for analysis
figure;
plot(1:1500,absErrF11,'b');title('Differencess');hold on;
% xticks(1:1:250);xlim([0 251]);ylim([0 4]);
plot(1:1500,absErrJREE,'r');
plot(1:1500,absErrMe,'g');legend('absErr F11','absErrJREE','absErrMe');

xlabel('N cyc');ylabel('Absolute Error');
ErrF11 = sum(absErrF11)
ErrMe = sum(absErrMe)
ErrJREE = sum(absErrJREE)

figure;
plot(1:250,FR_5charge30_Exp,'*b');title('5charge30');hold on;
plot(1:250,FR_5charge30_F11,'*r');
plot(1:250,Predictionbuffer_5charge30,'*g');
plot(1:250,Predictionbuffer_5charge30_ga,'*c');
plot(1:250,ChargingPro_5charge30,'-.k');
plot(1:250,TopCost_5charge30,'--m');
legend('5charge30 Exp','5charge30 F11','5charge30 Me','5charge30 JREE','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_5charge40_Exp,'*b');title('5charge40');hold on;
plot(1:250,FR_5charge40_F11,'*r');
plot(1:250,Predictionbuffer_5charge40,'*g');
plot(1:250,Predictionbuffer_5charge40_ga,'*c');
plot(1:250,ChargingPro_5charge40,'-.k');
plot(1:250,TopCost_5charge40,'--m');
legend('5charge40 Exp','5charge40 F11','5charge40 Me','5charge40 JREE','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_10charge40_Exp,'*b');title('10charge40');hold on;
plot(1:250,FR_10charge40_F11,'*r');
plot(1:250,Predictionbuffer_10charge40,'*g');
plot(1:250,Predictionbuffer_10charge40_ga,'*c');
plot(1:250,ChargingPro_10charge40,'-.k');
plot(1:250,TopCost_10charge40,'--m');
legend('10charge40 Exp','10charge40 F11','10charge40 Me','10charge40 JREE','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_5discharge30_Exp,'*b');title('5discharge30');hold on;
plot(1:250,FR_5discharge30_F11,'*r');
plot(1:250,Predictionbuffer_5discharge30,'*g');
plot(1:250,Predictionbuffer_5discharge30_ga,'*c');
plot(1:250,ChargingPro_5discharge30,'-.k');
plot(1:250,TopCost_5discharge30,'--m');
legend('5discharge30 Exp','5discharge30 F11','5discharge30 Me','5discharge30 JREE','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_5discharge40_Exp,'*b');title('5discharge40');hold on;
plot(1:250,FR_5discharge40_F11,'*r');
plot(1:250,Predictionbuffer_5discharge40,'*g');
plot(1:250,Predictionbuffer_5discharge40_ga,'*c');
plot(1:250,ChargingPro_5discharge40,'-.k');
plot(1:250,TopCost_5discharge40,'--m');
legend('5discharge40 Exp','5discharge40 F11','5discharge40 Me','5discharge40 JREE','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:250,FR_10discharge40_Exp,'*b');title('10discharge40');hold on;
plot(1:250,FR_10discharge40_F11,'*r');
plot(1:250,Predictionbuffer_10discharge40,'*g');
plot(1:250,Predictionbuffer_10discharge40_ga,'*c');
plot(1:250,ChargingPro_10discharge40,'-.k');
plot(1:250,TopCost_10discharge40,'--m');
legend('10discharge40 Exp','10discharge40 F11','10discharge40 Me','10discharge40 JREE','ChargingPro','TopCost');xlabel('N cyc');ylabel('Fading Rate %');

% figure;
% u=zeros(8,1);u(1)=0.016568;u(2)=0.3428;u(3)=0.1905;u(4)=942.76;u(5)=14.2335;u(6)=0.1595;u(7)=0.0257;u(8)=-1059.5988;  
% 
% subplot(1,2,1);
% bar(1:8,u,'r');title('Decision Variables');legend('F 11');xlabel('Decition');ylabel('Amount');
% subplot(1,2,2);
% bar(1:11,x,'b');title('Decision Variables');legend('My Sol');xlabel('Decition');ylabel('Amount');
% 
% FinalResultx=InternalBestSol.Sol.x
% FinalResult=InternalBestSol.Sol