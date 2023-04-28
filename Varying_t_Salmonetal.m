%% Codes for Series 12 of Robinson's experiments compared with methods 
% from Salmon et al

clear; clc;

fy = 263 ;
L = 300 ;
H = L ;
s = L/2 ;

% Buckling stability limitation calculation for t
Lim_tWK = L*sqrt(fy)/656 ;
Lim_tPL = Lim_tWK*2 ;

% Series 12 results from Robinson
texp = [5.19 7.03 9.08 11.17 13.04 15.22 12.96 15.04] ;
Pexp = [119.5 215.0 450.0 425.0 500.0 1125.0 775.0 1037.5] ;

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's experiments using Perry Robertson
subplot(2,2,4)
fplot(@(t) SingleStrut(11,t,L,H,fy,s),[0.01 16],'red','linewidth',1.5)
hold on
a = fplot(@(t) AppBeam(t,L,H,s,fy), [0.01 16],'linewidth',1.5) ;
a.Color = "#EDB120"	;
hold on
fplot(@(t) WorkStress(t,L,H,fy), [0.01 16],'b','linewidth',1.5)
hold on
fplot(@(t) PlasticStrength(t,L,H,s,fy), [0.01 16],'k:','linewidth',1.8)
hold on
scatter(texp,Pexp,"black","x"); hold on
xl=xline(Lim_tWK,'black --',{'$L/t>\frac{656}{\sqrt{f_y}}$'},'FontSize',12,'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelHorizontalAlignment = 'right'; hold on 
xl=xline(Lim_tPL,'black --',{'$L/t>328/\sqrt{f_y}$'},'FontSize',10,'Interpreter','Latex','LineWidth',1.5);...
    xl.LabelHorizontalAlignment = 'right'; xl.LabelVerticalAlignment = 'middle'; 
grid on

ylim([0 1200])
ylabel('Ultimate Load (kN)','Interpreter','Latex')
yticks([0 200 400 600 800 1000 1200])
xlabel('Plate thickness t (mm)','Interpreter','Latex')
xticks([0 2 4 6 8 10 12 14 16])
lgd = legend('Single Strut a=11','Approximate beam method','Working stress method', ...
    'Plastic strength method',"Robinson's experimental result",'Interpreter','Latex') ;
lgd.Orientation = 'horizontal';
lgd.Position(1) = 0.5 - lgd.Position(3)/2 ;
lgd.Position(2) = 0.005 ;
lgd.Position(3) = lgd.Position(3);
lgd.Position(4) = lgd.Position(4) ;
title('Series 12', 'Interpreter','Latex')

%% Tabular results
for i = 1:length(texp)
    lambda(i) = 2*sqrt(3)*L/(texp(i)*sqrt(((L/H)^2)+1)) ;
    P_app(i) = AppBeam(texp(i),L,H,s,263) ;
    P_workstress(i) = WorkStress(texp(i),L,H,263) ;
    P_plastic(i) = PlasticStrength(texp(i),L,H,s,263) ;
    P_strut(i) = SingleStrut(11,texp(i),L,H,263,s) ;
end

T = table(texp',lambda',Pexp',P_app',P_workstress',P_plastic',P_strut') ;
T.Properties.VariableNames = {'Thickness t' 'Slenderness ratio' 'Experimental result' 'Approximate Beam' 'Working Stress'...
    'Plastic Strength' 'Single Strut'};
display(T)

% T_ratio = table(texp',lambda',Pexp',(Pexp./P_app)',(Pexp./P_workstress)',(Pexp./P_plastic)',(Pexp./P_strut)') ;
% T_ratio.Properties.VariableNames = {'Thickness t' 'Slenderness ratio' 'Exp. result' 'Exp./App. Beam' 'Exp./Work. Str.'...
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
% writetable(T,filename,'Sheet',4,'Range','B2')
% writetable(T_ratio,filename,'Sheet',4,'Range','B15')