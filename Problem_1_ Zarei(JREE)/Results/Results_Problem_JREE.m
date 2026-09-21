%% Results
format compact;
clc;clear;
close all;

load('BatteryData_JREE.mat');
load('Result_JREE_Me_cpso.mat');
load('Result_JREE_F11_cpso.mat');

ErrJREE
ErrMe
ErrF11
%-------------------------------------------
T25Exp='Experimental Values';
T35Exp='Experimental Values';
T45Exp='Experimental Values';

T25F11='Model Hu+CPSO';
T35F11='Model Hu+CPSO';
T45F11='Model Hu+CPSO';

T25Me='Proposed Model+CPSO';
T35Me='Proposed Model+CPSO';
T45Me='Proposed Model+CPSO';

T25JREE='Original Paper(Model Zarei)';
T35JREE='Original Paper(Model Zarei)';
T45JREE='Original Paper(Model Zarei)';

Violationbound25='Violation bound';
Violationbound35='Violation Bound';
Violationbound45='Violation Bound';

Title25=['Tempature 25 C' char(176)];
Title35=['Tempature 35 C' char(176)];
Title45=['Tempature 45 C' char(176)];

xlabelText='Cycle number';
ylabelText='The capacity loss (%)';

LineWidth1=2;
LineWidth2=3;
MarkerSize1=6;
MarkerSize2=10;
TextColor='black';FontName='Times new Roman';FontWeight= 'bold';
FontSizeText=14;

FontName='times new roman';FontSize=12;FontWeight='bold';LineWidth=2;
MarkerEdgeColor0=[0.15 ,0.15  ,0.15];MarkerFaceColor0=[0.1 ,0.1 ,0.1];
MarkerEdgeColor1=[1 ,0.5 ,0.5];MarkerFaceColor1=[1 ,0.2 ,0];
MarkerEdgeColor2=[0.5 ,1 ,0.5];MarkerFaceColor2=[0 ,1 ,0.2];
MarkerEdgeColor3=[0.5 ,0.5 ,1];MarkerFaceColor3=[0 ,0.2 ,1];
MarkerSize=12;scatterMarkerSize = pi * (MarkerSize/2)^2;
Position=[2 2 18 24];
% Graycolor1=[0.2,0.2,0.2];GraycolorAlpha1=0.08;
% Graycolor2=[0.2,0.2,0.2];GraycolorAlpha2=0.2;
Graycolor1=[1, 1, 1];GraycolorAlpha1=0.08;
Graycolor2=[1, 1, 1];GraycolorAlpha2=0.2;

figure(1);
p1=plot(1:60,FadingRate25_Exp,'*b','MarkerSize',MarkerSize1);hold on;%title(Title25);
p2=plot(1:60,Predictionbuffer_25,'-g','LineWidth',LineWidth1);
p3=plot(1:60,Predictionbuffer_25_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:60,FadingRateEQ_25,'-.c','LineWidth',LineWidth1);
Upperbound=FadingRate25_Exp+Errmax;
Lowerbound=max(FadingRate25_Exp-Errmax,0);
p5=plot(1:60,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:60,Lowerbound,':k','LineWidth',LineWidth1);
legend(T25Exp,T25Me,T25F11,T25JREE,Violationbound25,'Position',[0.18 0.67 0.2 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';

%% for paper with grayscale bounds
close all;
FontSize=18;
tl = tiledlayout(3,1,'TileSpacing','tight','Units','centimeters','Position',[2 2 15 22],'Padding','tight');
nexttile
p1=plot(1:60,FadingRate25_Exp,'*b','MarkerSize',MarkerSize1);hold on;
title(Title25);
p2=plot(1:60,Predictionbuffer_25,'-g','LineWidth',LineWidth1);
p3=plot(1:60,Predictionbuffer_25_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:60,FadingRateEQ_25,'-.c','LineWidth',LineWidth1);
Upperbound=FadingRate25_Exp+Errmax;
Lowerbound=max(FadingRate25_Exp-Errmax,0);
p5=plot(1:60,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:60,Lowerbound,':k','LineWidth',LineWidth1);
% legend(T25Exp,T25Me,T25F11,T25JREE,Violationbound25,'Position',[0.18 0.67 0.2 0.2],'NumColumns',1,'Box','off');
% xlabel(xlabelText);
% ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 1;
y0 = max(Upperbound);
x1 = 60;
y1 = min(Lowerbound);
fill([0, [0:61]],[4, [min(Upperbound),Upperbound,4]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 60]);ylim([0 4]);
fill([x1, [1:60]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T45Exp,T45Me,T45F11,T45JREE,Violationbound45,'Location','northeastoutside','NumColumns',1,'Box','on','Color',Graycolor1);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);

nexttile
p1=plot(1:60,FadingRate35_Exp,'*b','MarkerSize',MarkerSize1);hold on;
title(Title35);
p2=plot(1:60,Predictionbuffer_35,'-g','LineWidth',LineWidth1);
p3=plot(1:60,Predictionbuffer_35_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:60,FadingRateEQ_35,'-.c','LineWidth',LineWidth1);
Upperbound=FadingRate35_Exp+Errmax;
Lowerbound=max(FadingRate35_Exp-Errmax,0);
p5=plot(1:60,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:60,Lowerbound,':k','LineWidth',LineWidth1);
% legend(T35Exp,T35Me,T35F11,T35JREE,Violationbound35,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');
% xlabel(xlabelText);
% ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 1;
y0 = max(Upperbound);
x1 = 60;
y1 = min(Lowerbound);
fill([0, [0:61]],[4, [min(Upperbound),Upperbound,4]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 60]);ylim([0 4]);
fill([x1, [1:60]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T45Exp,T45Me,T45F11,T45JREE,Violationbound45,'Location','northeastoutside','NumColumns',1,'Box','on','Color',Graycolor1);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);

nexttile
p1=plot(1:60,FadingRate45_Exp,'*b','MarkerSize',MarkerSize1);hold on;
title(Title45);
p2=plot(1:60,Predictionbuffer_45,'-g','LineWidth',LineWidth1);
p3=plot(1:60,Predictionbuffer_45_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:60,FadingRateEQ_45,'-.c','LineWidth',LineWidth1);
Upperbound=FadingRate45_Exp+Errmax;
Lowerbound=max(FadingRate45_Exp-Errmax,0);
p5=plot(1:60,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:60,Lowerbound,':k','LineWidth',LineWidth1);
% legend(T45Exp,T45Me,T45F11,T45JREE,Violationbound45,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');
% xlabel(xlabelText);
% ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 1;
y0 = max(Upperbound);
x1 = 60;
y1 = min(Lowerbound);
fill([0, [0:61]],[4.5, [min(Upperbound),Upperbound,4.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 60]);ylim([0 4.5]);
fill([x1, [1:60]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T45Exp,T45Me,T45F11,T45JREE,Violationbound45,'Location','northeastoutside','NumColumns',1,'Box','on','Color',Graycolor1);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
% xlabel(xlabelText);
% ylabel(ylabelText);

xlabel(tl,xlabelText,'FontName',FontName,'FontSize',FontSize,'FontWeight',FontWeight);
ylabel(tl,ylabelText,'FontName',FontName,'FontSize',FontSize,'FontWeight',FontWeight);
% BL.Layout.Tile = 4;

%% for analysis
close all;
LineWidth1=3;
LineWidth2=3;
MarkerSize1=12;
MarkerSize2=10;
TextColor='black';FontName='Times new Roman';FontWeight= 'bold';FontSize=14;
FontSizeText=24;

figure(251);
p1=plot(1:60,FadingRate25_Exp,'*b','MarkerSize',MarkerSize1);hold on;%title(Title25);
p2=plot(1:60,Predictionbuffer_25,'-g','LineWidth',LineWidth1);
p3=plot(1:60,Predictionbuffer_25_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:60,FadingRateEQ_25,'-.c','LineWidth',LineWidth1);
Upperbound=FadingRate25_Exp+Errmax;
Lowerbound=max(FadingRate25_Exp-Errmax,0);
p5=plot(1:60,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:60,Lowerbound,':k','LineWidth',LineWidth1);
legend(T25Exp,T25Me,T25F11,T25JREE,Violationbound25,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
%--------------------------------------------------------------
figure(351);
p1=plot(1:60,FadingRate35_Exp,'*b','MarkerSize',MarkerSize1);hold on;%title(Title35);
p2=plot(1:60,Predictionbuffer_35,'-g','LineWidth',LineWidth1);
p3=plot(1:60,Predictionbuffer_35_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:60,FadingRateEQ_35,'-.c','LineWidth',LineWidth1);
Upperbound=FadingRate35_Exp+Errmax;
Lowerbound=max(FadingRate35_Exp-Errmax,0);
p5=plot(1:60,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:60,Lowerbound,':k','LineWidth',LineWidth1);
legend(T35Exp,T35Me,T35F11,T35JREE,Violationbound35,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
%--------------------------------------------------------------
figure(451);
p1=plot(1:60,FadingRate45_Exp,'*b','MarkerSize',MarkerSize1);hold on;%title(Title45);
p2=plot(1:60,Predictionbuffer_45,'-g','LineWidth',LineWidth1);
p3=plot(1:60,Predictionbuffer_45_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:60,FadingRateEQ_45,'-.c','LineWidth',LineWidth1);
Upperbound=FadingRate45_Exp+Errmax;
Lowerbound=max(FadingRate45_Exp-Errmax,0);
p5=plot(1:60,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:60,Lowerbound,':k','LineWidth',LineWidth1);
legend(T45Exp,T45Me,T45F11,T45JREE,Violationbound45,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
%--------------------------------------------------------------
figure(252);
p1=plot(1:60,FadingRate25_Exp,'*b','MarkerSize',MarkerSize1);hold on;%title(Title25);
p2=plot(1:60,Predictionbuffer_25,'-g','LineWidth',LineWidth1);
p3=plot(1:60,Predictionbuffer_25_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:60,FadingRateEQ_25,'-.c','LineWidth',LineWidth1);
Upperbound=FadingRate25_Exp+Errmax;
Lowerbound=max(FadingRate25_Exp-Errmax,0);
p5=plot(1:60,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:60,Lowerbound,':k','LineWidth',LineWidth1);
legend(T25Exp,T25Me,T25F11,T25JREE,Violationbound25,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel({xlabelText, '(a)'});ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 1;
y0 = max(Upperbound);
x1 = 60;
y1 = min(Lowerbound);
fill([0, [0:61]],[4, [min(Upperbound),Upperbound,4]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 60]);ylim([0 4]);
fill([x1, [1:60]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T25Exp,T25Me,T25F11,T25JREE,Violationbound25,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);xlabel(xlabelText);ylabel(ylabelText);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
%--------------------------------------------------------------
figure(352);
p1=plot(1:60,FadingRate35_Exp,'*b','MarkerSize',MarkerSize1);hold on;%title(Title35);
p2=plot(1:60,Predictionbuffer_35,'-g','LineWidth',LineWidth1);
p3=plot(1:60,Predictionbuffer_35_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:60,FadingRateEQ_35,'-.c','LineWidth',LineWidth1);
Upperbound=FadingRate35_Exp+Errmax;
Lowerbound=max(FadingRate35_Exp-Errmax,0);
p5=plot(1:60,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:60,Lowerbound,':k','LineWidth',LineWidth1);
legend(T35Exp,T35Me,T35F11,T35JREE,Violationbound35,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel({xlabelText, '(a)'});ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 1;
y0 = max(Upperbound);
x1 = 60;
y1 = min(Lowerbound);
fill([0, [0:61]],[4, [min(Upperbound),Upperbound,4]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 60]);ylim([0 4]);
fill([x1, [1:60]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T35Exp,T35Me,T35F11,T35JREE,Violationbound35,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);xlabel(xlabelText);ylabel(ylabelText);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);
%--------------------------------------------------------------
figure(452);
p1=plot(1:60,FadingRate45_Exp,'*b','MarkerSize',MarkerSize1);hold on;%title(Title45);
p2=plot(1:60,Predictionbuffer_45,'-g','LineWidth',LineWidth1);
p3=plot(1:60,Predictionbuffer_45_F11,'--r','LineWidth',LineWidth1);
p4=plot(1:60,FadingRateEQ_45,'-.c','LineWidth',LineWidth1);
Upperbound=FadingRate45_Exp+Errmax;
Lowerbound=max(FadingRate45_Exp-Errmax,0);
p5=plot(1:60,Upperbound,':k','LineWidth',LineWidth1);
p6=plot(1:60,Lowerbound,':k','LineWidth',LineWidth1);
legend(T45Exp,T45Me,T45F11,T45JREE,Violationbound45,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off');xlabel(xlabelText);ylabel(ylabelText);
ax = gca;ax.FontName = FontName;ax.FontWeight= FontWeight;ax.FontSize= FontSize;ax.GridColor= [0.25 0.25 0.25];ax.GridAlpha= 0.25;ax.GridLineStyle= '-.';ax.XGrid= 'off';ax.YGrid= 'off';
x0 = 1;
y0 = max(Upperbound);
x1 = 60;
y1 = min(Lowerbound);
fill([0, [0:61]],[4.5, [min(Upperbound),Upperbound,4.5]],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');xlim([0 60]);ylim([0 4.5]);
fill([x1, [1:60]],[y1, Lowerbound],Graycolor1,'FaceAlpha',GraycolorAlpha1,'LineStyle','none');
[BL,BLicons] =legend([p1,p2,p3,p4,p5],T45Exp,T45Me,T45F11,T45JREE,Violationbound45,'Position',[0.18 0.7 0.1 0.2],'NumColumns',1,'Box','off','Color',Graycolor1);xlabel(xlabelText);ylabel(ylabelText);
PatchInLegend = findobj(BLicons, 'type', 'patch');set(PatchInLegend, 'facea', GraycolorAlpha1);

%% for analysis
figure;
plot(1:60,FadingRate35_Exp,'*b');title('T35');hold on;
plot(1:60,Predictionbuffer_35_F11,'*r');
plot(1:60,Predictionbuffer_35,'*g');
plot(1:60,FadingRateEQ_35,'*c');
plot(1:60,ChargingPro_35,'-.k');
plot(1:60,TopCost_35,'--m');
legend('T35 Exp','T35 F11','T35 Me','T35 JREE','ChargingPro 35','TopCost 35');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:60,FadingRate45_Exp,'*b');title('T45');hold on;
plot(1:60,Predictionbuffer_45_F11,'*r');
plot(1:60,Predictionbuffer_45,'*g');
plot(1:60,FadingRateEQ_45,'*c');
plot(1:60,ChargingPro_45,'-.k');
plot(1:60,TopCost_45,'--m');
legend('T45 Exp','T45 F11','T45 Me','T45 JREE','ChargingPro 45','TopCost 45');xlabel('N cyc');ylabel('Fading Rate %');

%% temporary and for analysis
figure;
plot(1:180,absErr_F11,'b');title('Differencess JREE');hold on;
plot(1:180,absErrJREE,'r');
% xticks(1:1:250);xlim([0 251]);ylim([0 4]);
plot(1:180,absErrMe,'g');

legend('absErr F11','absErr JREE','absErrMe');
xlabel('N cyc');ylabel('Absolute Error');



figure;
plot(1:60,FadingRate25_Exp,'*b');title('T25');hold on;
plot(1:60,Predictionbuffer_25_F11,'*r');
plot(1:60,Predictionbuffer_25,'*g');
plot(1:60,FadingRateEQ_25,'*c');
plot(1:60,ChargingPro_25,'-.k');
plot(1:60,TopCost_25,'--m');
legend('T25 Exp','T25 F11','T25 Me','T25 JREE','ChargingPro 25','TopCost 25');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:60,FadingRate35_Exp,'*b');title('T35');hold on;
plot(1:60,Predictionbuffer_35_F11,'*r');
plot(1:60,Predictionbuffer_35,'*g');
plot(1:60,FadingRateEQ_35,'*c');
plot(1:60,ChargingPro_35,'-.k');
plot(1:60,TopCost_35,'--m');
legend('T35 Exp','T35 F11','T35 Me','T35 JREE','ChargingPro 35','TopCost 35');xlabel('N cyc');ylabel('Fading Rate %');

figure;
plot(1:60,FadingRate45_Exp,'*b');title('T45');hold on;
plot(1:60,Predictionbuffer_45_F11,'*r');
plot(1:60,Predictionbuffer_45,'*g');
plot(1:60,FadingRateEQ_45,'*c');
plot(1:60,ChargingPro_45,'-.k');
plot(1:60,TopCost_45,'--m');
legend('T45 Exp','T45 F11','T45 Me','T45 JREE','ChargingPro 45','TopCost 45');xlabel('N cyc');ylabel('Fading Rate %');

figure;
u=zeros(8,1);u(1)=0.016568;u(2)=0.3428;u(3)=0.1905;u(4)=942.76;u(5)=14.2335;u(6)=0.1595;u(7)=0.0257;u(8)=-1059.5988;  
subplot(1,2,1);
bar(1:11,FinalResultx_F11,'r');title('Decision Variables');legend('F 11');xlabel('Decition');ylabel('Amount');
subplot(1,2,2);
bar(1:11,FinalResultx,'b');title('Decision Variables');legend('My Sol');xlabel('Decition');ylabel('Amount');
