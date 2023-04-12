%% Codes for Series 4 of Robinson's experiments. The first graph compares
%  Robinson's own theory with experiments (a=1 and a=8), while the second 
%  compares Robinson's method (a=5.5), the author's and Martin's two
%  methods. The slenderness limitations are calculated using seperate
%  functions

clear; clc;

fy = 378 ;
L = 200 ;
t = 4 ;
a = [1 8] ;
s = L/2 ;

% Series 4 results from Robinson
Hexp = [50 50 100 100 150 150 200 200 250 250 300 300 400 400 500 500 600 600] ;
Pexp = [21.5 22.4 57.5 55 85 85 92.5 87.5 120 107.5 110 122 111.5 110 117.5 120 105 117.5] ;

% Slenderness limitation calculation for H
LimHeight = @(H) slenderness(L,H,4,160) ;
LimHeight = fzero(LimHeight,200) ;

% Robinson's method for a = 1 and a = 8, and Series 4 of his experiments
fplot(@(H) robinson(t,L,H,s,a(1),fy), [0.01 600],'blue','linewidth',1.5)
hold on
fplot(@(H) robinson(t,L,H,s,a(2),fy), [0.01 600],'red','linewidth',1.5)
hold on
scatter(Hexp,Pexp,"black","x")
xl=xline(LimHeight,'black --',{'$\lambda>160$'},'Interpreter','Latex','LineWidth',1.5);...
     xl.LabelVerticalAlignment = 'bottom'; grid on
 
ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter','Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Plate height H (mm)','Interpreter','Latex')
xticks([0 100 200 300 400 500 600])
legend('Theoretical curve with a = 1','Theoretical curve with a = 8',...
    "Robinson's S4 Experiment",'Interpreter','Latex')
title('Series 4', 'Interpreter','Latex')

% Comparison of Robinson's method, Series 4 of his experiments, Martin and Single
% Strut model (a=11)
figure
subplot(2,2,2)
fplot(@(H) SingleStrut(11,t,L,H,fy,s),[0 600],'red','linewidth',1.5)
hold on
fplot(@(H) robinson(t,L,H,s,5.5,fy), [0.01 600],'blue','linewidth',1.5)
hold on
fplot(@(H) MartinModel1(t,L,H,s,fy), [0 600],'black','linewidth',1.5)
hold on
fplot(@(H) MartinModel2(t,L,H,s,fy), [0 600],'k:','linewidth',1.5)
hold on
scatter(Hexp,Pexp,"black","x"); grid on
xl=xline(LimHeight,'black --',{'$\lambda>160$'},'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelVerticalAlignment = 'bottom'; grid on

ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter','Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Plate height H (mm)','Interpreter','Latex')
xticks([0 100 200 300 400 500 600])
legend('Proposed method','Robinson a = 5.5',"Martin's 1st method",...
    "Martin's 2nd method","Robinson's S4 expt.",'Interpreter','Latex')
title('Series 4', 'Interpreter','Latex')

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's experiments
figure
fplot(@(H) AppBeam(t,L,H,s,fy), [0.01 600],'r','linewidth',1.5)
hold on
fplot(@(H) WorkStress(t,L,H,fy), [0 600],'b','linewidth',1.5)
hold on
fplot(@(H) PlasticStrength(t,L,H,s,fy), [0.01 600],'k','linewidth',1.5)
hold on
scatter(Hexp,Pexp,"black","x"); grid on
xl=xline(LimHeight,'black --',{'$\lambda>160$'},'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelVerticalAlignment = 'bottom'; grid on

ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter','Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Plate height H (mm)','Interpreter','Latex')
xticks([0 100 200 300 400 500 600])
legend('Approximate beam method','Working stress method','Plastic strength method',...
    "Robinson's S4 Experiment",'Interpreter','Latex')