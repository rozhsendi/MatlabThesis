%% Codes for Series 3 of Robinson's experiments. The first graph compares
%  Robinson's own theory with experiments (a=1 and a=8), while the second 
%  compares Robinson's method (a=5.5), the author's and Martin's two
%  methods. The slenderness limitations are calculated using seperate
%  functions

clear; clc; close all

fy = 378 ;
t = 4 ;

% Series 3 results from Robinson
Lexp = [100 200 200 300 400 400 500 500] ;
Pexp = [65 88.5 95 79.3 66.4 69.2 80.0 78.2] ;

% Buckling stability limitation calculation for L
LimLengthWK = t*656/sqrt(378) ;
LimLengthPL = LimLengthWK/2 ;

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's experiments
figure
subplot(2,2,1)
fplot(@(L) SingleStrut(11,t,L,L,fy,(L/2)),[0 500],'red','linewidth',1.5)
hold on
a = fplot(@(L) AppBeam(t,L,L,L/2,fy), [0.01 500],'linewidth',1.5);
a.Color = "#EDB120"	;
hold on
fplot(@(L) WorkStress(t,L,L,fy), [0.01 500],'b','linewidth',1.5)
hold on
fplot(@(L) PlasticStrength(t,L,L,L/2,fy), [0.01 500],'k:','linewidth',1.8)
hold on
scatter(Lexp,Pexp,"black","x") ; hold on 
xl=xline(LimLengthWK,'black --',{'$L/t>\frac{656}{\sqrt{f_y}}$'},'FontSize',12,'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelHorizontalAlignment = 'right'; hold on 
xl=xline(LimLengthPL,'black --',{'$L/t>\frac{328}{\sqrt{f_y}}$'},'FontSize',12,'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelHorizontalAlignment = 'right'; 
grid on
ylim([0 175])
ylabel('Ultimate load (kN)','Interpreter','Latex')
yticks([0 25 50 75 100 125 150 175])
xlabel('Plate size L=H (mm)','Interpreter','Latex')
xticks([0 100 200 300 400 500])
% legend('Approximate beam method','Working stress method','Plastic strength method',...
%     "Robinson's S3 Experiment",'Interpreter','Latex')
title('Series 3', 'Interpreter','Latex')

%% Tabular results
Hexp = Lexp ; sexp = Lexp/2 ;
for i = 1:length(Lexp)
    lambda(i) = 2*sqrt(3)*Lexp(i)/(t*sqrt(((Lexp(i)/Hexp(i))^2)+1)) ;
    P_app(i) = AppBeam(t,Lexp(i),Hexp(i),sexp(i),fy) ;
    P_workstress(i) = WorkStress(t,Lexp(i),Hexp(i),fy) ;
    P_plastic(i) = PlasticStrength(t,Lexp(i),Hexp(i),sexp(i),fy) ;
    P_strut(i) = SingleStrut(11,t,Lexp(i),Hexp(i),fy,sexp(i)) ;
end

T = table(Lexp',lambda',Pexp',P_app',P_workstress',P_plastic',P_strut') ;
T.Properties.VariableNames = {'L' 'Slenderness ratio' 'Exp. result' 'Approximate Beam' 'Working Stress'...
    'Plastic Strength' 'Single Strut'};
display(T)

% T_ratio = table(Lexp',lambda',Pexp',(Pexp./P_app)',(Pexp./P_workstress)',(Pexp./P_plastic)',(Pexp./P_strut)') ;
% T_ratio.Properties.VariableNames = {'L' 'Slenderness ratio' 'Exp. result' 'Exp./App. Beam' 'Exp./Work. Str.'...
%     'Exp./Plas. Stren.' 'Exp./Single Strut'};
% display(T_ratio)
% 
% ratios = [(Pexp./P_app);(Pexp./P_workstress);(Pexp./P_plastic);(Pexp./P_strut)]' ;
% for i = 1:4
%     Mean(i) = mean(ratios(:,i)) ;
%     CV(i) = std(ratios(:,i))/mean(ratios(:,i)) ;
% end

% MeanAPP = mean((Pexp./P_app)')
% cvAPP = std((Pexp./P_app)')/MeanAPP
% filename = 'TabularResults2.xlsx';
% writetable(T,filename,'Sheet',1,'Range','B2')
% writetable(T_ratio,filename,'Sheet',1,'Range','B14')