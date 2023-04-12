%% Codes for Series 3 of Robinson's experiments. The first graph compares
%  Robinson's own theory with experiments (a=1 and a=8), while the second 
%  compares Robinson's method (a=5.5), the author's and Martin's two
%  methods. The slenderness limitations are calculated using seperate
%  functions

clear; clc; close all

fy = 378 ;
t = 4 ;
a = [1 8] ;

% Series 3 results from Robinson
Lexp = [100 200 200 300 400 400 500 500] ;
Pexp = [65 88.5 95 79.3 66.4 69.2 80.0 78.2] ;

% Slenderness limitation calculation for L
LimLength = @(L) slenderness(L,L,t,160) ;
LimLength = fzero(LimLength,200) ;
% Slenderness limitation calculation for L for Martin
MartinLim = @(L) slenderness(L,L,t,185) ;
MartinLim = fzero(MartinLim,200) ;

% Robinson's method for a = 1 and a = 8
% and Series 3 of his experiments
figure
fplot(@(L) robinson(t,L,L,L/2,a(1),fy), [0.01 500],'blue','linewidth',1.5)
hold on
fplot(@(L) robinson(t,L,L,L/2,a(2),fy), [0.01 500],'red','linewidth',1.5)
hold on
scatter(Lexp,Pexp,"black","x"); hold on ;
xl=xline(LimLength,'black --',{'$\lambda>160$'},'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelHorizontalAlignment = 'left'; grid on
  
ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter','Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Plate size L=H (mm)','Interpreter','Latex')
xticks([0 100 200 300 400 500])
legend('Theoretical curve with a = 1','Theoretical curve with a = 8',...
    "Robinson's S3 Experiment",'Interpreter','Latex')
title('Series 3', 'Interpreter','Latex')

% Comparison of Robinson's method, Series 3 of his experiments 
% Martin's method and Single Strut model
figure
fplot(@(L) SingleStrut(11,t,L,L,fy,(L/2)),[0 500],'red','linewidth',1.5)
hold on
fplot(@(L) robinson(t,L,L,L/2,5.5,fy), [0.01 500],'blue','linewidth',1.5)
hold on
fplot(@(L) MartinModel1(t,L,L,L/2,fy), [0 500],'black','linewidth',1.5)
hold on
fplot(@(L) MartinModel2(t,L,L,L/2,fy), [0 MartinLim],'k:','linewidth',1.5)
hold on
scatter(Lexp,Pexp,"black","x") ; hold on ;
xl=xline(LimLength,'black --',{'$\lambda>160$'},'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelHorizontalAlignment = 'left'; hold on;
xl=xline(MartinLim,'black --',{'$\lambda>185$'},'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelHorizontalAlignment = 'left'; xl.LabelVerticalAlignment = 'top'; grid on

ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter','Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Plate size L=H (mm)','Interpreter','Latex')
xticks([0 100 200 300 400 500])
legend('Proposed method','Robinson a = 5.5',"Martin's 1st method",...
    "Martin's 2nd method","Robinson's S3 expt.",'Interpreter','Latex')
title('Series 3', 'Interpreter','Latex')

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's experiments
figure
fplot(@(L) AppBeam(t,L,L,L/2,fy), [0.01 500],'r','linewidth',1.5)
hold on
fplot(@(L) WorkStress(t,L,L,fy), [0.01 500],'b','linewidth',1.5)
hold on
fplot(@(L) PlasticStrength(t,L,L,L/2,fy), [0.01 500],'k','linewidth',1.5)
hold on
scatter(Lexp,Pexp,"black","x") ; hold on ;
xl=xline(LimLength,'black --',{'$\lambda>160$'},'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelHorizontalAlignment = 'left'; grid on

ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter','Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Plate size L=H (mm)','Interpreter','Latex')
xticks([0 100 200 300 400 500])
legend('Approximate beam method','Working stress method','Plastic strength method',...
    "Robinson's S3 Experiment",'Interpreter','Latex')