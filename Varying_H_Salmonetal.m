%% Codes for Series 4 of Robinson's experiments. The first graph compares
%  Robinson's own theory with experiments (a=1 and a=8), while the second 
%  compares Robinson's method (a=5.5), the author's and Martin's two
%  methods. The slenderness limitations are calculated using seperate
%  functions

clear; clc; 

fy = 378 ;
L = 200 ;
t = 4 ;
s = L/2 ;

% Series 4 results from Robinson
Hexp = [50 50 100 100 150 150 200 200 250 250 300 300 400 400 500 500 600 600] ;
Pexp = [21.5 22.4 57.5 55 85 85 92.5 87.5 120 107.5 110 122 111.5 110 117.5 120 105 117.5] ;

% Buckling stability limitation calculation for L
LimLengthWK = t*656/sqrt(378) ;
LimLengthPL = LimLengthWK/2 ;

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's experiments
subplot(2,2,2)
fplot(@(H) SingleStrut(11,t,L,H,fy,s),[0 600],'red','linewidth',1.5)
hold on
a = fplot(@(H) AppBeam(t,L,H,s,fy), [0.01 600],'linewidth',1.5) ;
a.Color = "#EDB120"	;
hold on
fplot(@(H) WorkStress(t,L,H,fy), [0.1 600],'b','linewidth',1.5)
hold on
fplot(@(H) PlasticStrength(t,L,H,s,fy), [0.01 600],'k:','linewidth',1.8)
hold on
scatter(Hexp,Pexp,"black","x"); hold on
xl=xline(LimLengthWK,'black --',{'$L/t>\frac{656(L/H)}{\sqrt{f_y}}$'},'FontSize',12,'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelHorizontalAlignment = 'right'; hold on 
xl=xline(LimLengthPL,'black --',{'$L/t>\frac{328(L/H)}{\sqrt{f_y}}$'},'FontSize',12,'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelHorizontalAlignment = 'right'; 
grid on
ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter','Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Plate height H (mm)','Interpreter','Latex')
xticks([0 100 200 300 400 500 600])
% legend('Approximate beam method','Working stress method','Plastic strength method',...
%     "Robinson's S4 Experiment",'Interpreter','Latex')
title('Series 4', 'Interpreter','Latex')

%% Tabular results
Lexp = 200 ; sexp = Lexp/2;
for i = 1:length(Hexp)
    lambda(i) = 2*sqrt(3)*Lexp/(t*sqrt(((Lexp/Hexp(i))^2)+1)) ;
    P_app(i) = AppBeam(t,Lexp,Hexp(i),sexp,fy) ;
    P_workstress(i) = WorkStress(t,Lexp,Hexp(i),fy) ;
    P_plastic(i) = PlasticStrength(t,Lexp,Hexp(i),sexp,fy) ;
    P_strut(i) = SingleStrut(11,t,Lexp,Hexp(i),fy,sexp) ;
end

T = table(Hexp',lambda',Pexp',P_app',P_workstress',P_plastic',P_strut') ;
T.Properties.VariableNames = {'H' 'Slenderness ratio' 'Exp. result' 'Approximate Beam' 'Working Stress'...
    'Plastic Strength' 'Single Strut'};
display(T)

% T_ratio = table(Hexp',lambda',Pexp',(Pexp./P_app)',(Pexp./P_workstress)',(Pexp./P_plastic)',(Pexp./P_strut)') ;
% T_ratio.Properties.VariableNames = {'H' 'Slenderness ratio' 'Exp. result' 'Exp./App. Beam' 'Exp./Work. Str.'...
%     'Exp./Plas. Stren.' 'Exp./Single Strut'};
% display(T_ratio)
% 
% ratios = [(Pexp./P_app);(Pexp./P_workstress);(Pexp./P_plastic);(Pexp./P_strut)]' ;
% for i = 1:4
%     Mean(i) = mean(ratios(:,i)) ;
%     CV(i) = std(ratios(:,i))/mean(ratios(:,i)) ;
% end
% 
% filename = 'TabularResults2.xlsx';
% writetable(T,filename,'Sheet',2,'Range','B2')
% writetable(T_ratio,filename,'Sheet',2,'Range','B25')