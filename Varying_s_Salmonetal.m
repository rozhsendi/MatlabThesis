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

% Series 5 results from Robinson
sexp = [75 100 150 150 200 250 300 300 300] ;
Pexp = [135 110 70 71.3 50 39.2 29.9 28 31] ;

% Comparison of approximate beam method, plastic
% strength method and Robinson's experiments
PWorkStress = WorkStress(t,L,H,fy) ;
subplot(2,2,3)
fplot(@(s) SingleStrut(11,t,L,H,fy,s),[0.01 300],'red','linewidth',1.5)
hold on
hfp=fplot(@(s) AppBeam(t,L,H,s,fy), [0.01 300],'r','linewidth',1.8);
hfp.ShowPoles = 'off';
hfp.Color = "#EDB120" ;
hold on
yline(PWorkStress,'blue','linewidth',1.5)
hold on
fplot(@(s) PlasticStrength(t,L,H,s,fy), [0.01 300],'k:','linewidth',1.5)
hold on
scatter(sexp,Pexp,"black","x"); grid on
text(50,25,'$\frac{L}{t}>\frac{328}{\sqrt{f_y}}$','FontSize',12,'Interpreter','latex')

ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter', 'Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Eccentricity s (mm)','Interpreter', 'Latex')
xticks([0 50 100 150 200 250 300])
% legend('Approximate beam method','Working stress method','Plastic strength method',...
%     "Robinson's S4 Experiment",'Interpreter','Latex')
title('Series 5', 'Interpreter','Latex')

%% Tabular results
for i = 1:length(sexp)
    lambda(i) = 2*sqrt(3)*L/(t*sqrt(((L/H)^2)+1)) ;
    P_app(i) = AppBeam(t,L,H,sexp(i),fy) ;
    P_workstress(i) = WorkStress(t,L,H,fy) ;
    P_plastic(i) = PlasticStrength(t,L,H,sexp(i),fy) ;
    P_strut(i) = SingleStrut(11,t,L,H,fy,sexp(i)) ;
end

T = table(sexp',lambda',Pexp',P_app',P_workstress',P_plastic',P_strut') ;
T.Properties.VariableNames = {'Eccentricity s' 'Slenderness ratio' 'Exp. result' 'Approximate Beam' 'Working Stress'...
    'Plastic Strength' 'Single Strut'};
display(T)

% T_ratio = table(sexp',lambda',Pexp',(Pexp./P_app)',(Pexp./P_workstress)',(Pexp./P_plastic)',(Pexp./P_strut)') ;
% T_ratio.Properties.VariableNames = {'Eccentricity s' 'Slenderness ratio' 'Exp. result' 'Exp./App. Beam' 'Exp./Work. Str.'...
%     'Exp./Plas. Stren.' 'Exp./Single Strut'};
% display(T_ratio)
% 
% filename = 'TabularResults2.xlsx';
% writetable(T,filename,'Sheet',3,'Range','B2')
% writetable(T_ratio,filename,'Sheet',3,'Range','B15')