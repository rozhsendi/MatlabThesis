%% Codes for Series 12 of Robinson's experiments. The first graph compares
%  Robinson's own theory with experiments (a=1 and a=8), while the second 
%  compares Robinson's method (a=5.5), the author's and Martin's two
%  methods. The slenderness limitations are calculated using seperate
%  functions

clear; clc;

fy = 263 ;
L = 300 ;
H = L ;
s = L/2 ;
a = [1 8] ;

% Series 12 results from Robinson
texp = [5.19 7.03 9.08 11.17 13.04 15.22 12.96 15.04] ;
Pexp = [119.5 215.0 450.0 425.0 500.0 1125.0 775.0 1037.5] ;

% Slenderness limitation calculation for t
LimThic = @(t) slenderness(L,H,t,160) ;
LimThic = fzero(LimThic,5) ;
% Slenderness limitation calculation for L for Martin
MartinLim = @(t) slenderness(L,H,t,185) ;
MartinLim = fzero(MartinLim,5) ;

%Robinson's method for a = 1 and a = 8
fplot(@(t) robinson(t,L,H,s,a(1),fy), [0.01 16],'blue','linewidth',1.5)
hold on
fplot(@(t) robinson(t,L,H,s,a(2),fy), [0.01 16],'red','linewidth',1.5)
hold on
scatter(texp,Pexp,"black","x")
xl=xline(LimThic,'black --',{'$\lambda>160$'},'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelVerticalAlignment = 'top'; grid on

ylim([0 1200])
ylabel('Ultimate Load (kN)','Interpreter','Latex')
yticks([0 200 400 600 800 1000 1200])
xlabel('Plate thickness t (mm)','Interpreter','Latex')
xticks([0 2 4 6 8 10 12 14 16])
legend('Theoretical curve with a = 1','Theoretical curve with a = 8',...
    "Robinson's S12 Experiment",'Interpreter','Latex')
title('Series 12', 'Interpreter','Latex')

% Comparison of Robinson's method and Single Strut model (a=11)
figure
fplot(@(t) SingleStrut(11,t,L,H,fy,s),[0.01 16],'red','linewidth',1.5)
hold on
fplot(@(t) robinson(t,L,H,s,5.5,fy), [0.01 16],'blue','linewidth',1.5)
hold on
fplot(@(t) MartinModel1(t,L,H,s,fy), [0.01 16],'black','linewidth',1.5)
hold on
fplot(@(t) MartinModel2(t,L,H,s,fy), [2.7 16],'k:','linewidth',1.5)
hold on
scatter(texp,Pexp,"black","x");
xl=xline(LimThic,'black --',{'$\lambda>160$'},'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelVerticalAlignment = 'top'; grid on
hold on
scatter(texp,Pexp,"black","x");
xl=xline(MartinLim,'black --',{'$\lambda>185$'},'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelVerticalAlignment = 'top'; xl.LabelHorizontalAlignment = 'left'; grid on

ylim([0 1200])
ylabel('Ultimate Load (kN)','Interpreter','Latex')
yticks([0 200 400 600 800 1000 1200])
xlabel('Plate thickness t (mm)','Interpreter','Latex')
xticks([0 2 4 6 8 10 12 14 16])
legend('Proposed method','Robinson a = 5.5',"Martin's 1st method",...
    "Martin's 2nd method","Robinson's S12 expt.",'Interpreter','Latex')
title('Series 12', 'Interpreter','Latex')

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's experiments
figure
fplot(@(t) AppBeam(t,L,H,s,fy), [0.01 16],'r','linewidth',1.5)
hold on
fplot(@(t) WorkStress(t,L,H,fy), [0.01 16],'b','linewidth',1.5)
hold on
fplot(@(t) PlasticStrength(t,L,H,s,fy), [0.01 16],'k','linewidth',1.5)
hold on
scatter(texp,Pexp,"black","x");
xl=xline(LimThic,'black --',{'$\lambda>160$'},'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelVerticalAlignment = 'top'; grid on

ylim([0 1200])
ylabel('Ultimate Load (kN)','Interpreter','Latex')
yticks([0 200 400 600 800 1000 1200])
xlabel('Plate thickness t (mm)','Interpreter','Latex')
xticks([0 2 4 6 8 10 12 14 16])
legend('Working stress method','Plastic strength method',...
    'Approximate beam method',"Robinson's S12 Experiment",'Interpreter','Latex')


