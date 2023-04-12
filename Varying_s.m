%% Codes for Series 5 of Robinson's experiments. The first graph compares
%  Robinson's own theory with experiments (a=1 and a=8), while the second 
%  compares Robinson's method (a=5.5), the author's and Martin's two
%  methods. The slenderness limitations are calculated using seperate
%  functions

clear; clc;

fy = 378 ;
L = 300 ;
H = L ;
t = 4 ;
a = [1 8] ;

% Series 5 results from Robinson
sexp = [75 100 150 150 200 250 300 300 300] ;
Pexp = [135 110 70 71.3 50 39.2 29.9 28 31] ;

% Robinson's method for a = 1 and a = 8, and Series 5 of his experiments
subplot(2,2,3)
fplot(@(s) robinson(t,L,H,s,a(1),fy), [0.01 300],'blue','linewidth',1.5)
hold on
fplot(@(s) robinson(t,L,H,s,a(2),fy), [0.01 300],'red','linewidth',1.5)
hold on
scatter(sexp,Pexp,"black","x"); 
txt={'λ>160'};
text(100,50,txt) ; grid on
 
ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter', 'Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Eccentricity s (mm)','Interpreter', 'Latex')
xticks([0 50 100 150 200 250 300])
legend('Theoretical curve with a = 1','Theoretical curve with a = 8',...
    "Robinson's S5 Experiment",'Interpreter','Latex')
title('Series 5', 'Interpreter','Latex')

% Comparison of Robinson's method, Series 5 of his experiments and Single
% Strut model (a=11)
figure
fplot(@(s) SingleStrut(16,t,L,H,fy,s),[0.01 300],'red','linewidth',1.5)
hold on
fplot(@(s) robinson(t,L,H,s,5.5,fy), [0.01 300],'blue','linewidth',1.5)
hold on
fplot(@(s) MartinModel1(t,L,H,s,fy), [0.01 300],'black','linewidth',1.5)
hold on
fplot(@(s) MartinModel2(t,L,H,s,fy), [0.01 300],'k:','linewidth',1.5)
hold on
scatter(sexp,Pexp,"black","x"); grid on
txt={'λ>160'};
text(100,50,txt)

ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter', 'Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Eccentricity s (mm)','Interpreter', 'Latex')
xticks([0 50 100 150 200 250 300])
legend('Proposed method','Robinson a = 5.5',"Martin's 1st method",...
    "Martin's 2nd method","Robinson's S5 expt.",'Interpreter','Latex')
title('Series 5', 'Interpreter','Latex')

Comparison of approximate beam method, plastic
strength method and Robinson's experiments
figure
fplot(@(s) AppBeam(t,L,H,s,fy), [0.01 300],'r','linewidth',1.5)
hold on
fplot(@(s) PlasticStrength(t,L,H,s,fy), [0.01 300],'k','linewidth',1.5)
hold on
scatter(sexp,Pexp,"black","x"); grid on
txt={'λ>160'};
text(100,50,txt)

ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter', 'Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Eccentricity s (mm)','Interpreter', 'Latex')
xticks([0 50 100 150 200 250 300])
legend('Approximate beam method','Plastic strength method',...
    "Robinson's S5 Experiment",'Interpreter','Latex')