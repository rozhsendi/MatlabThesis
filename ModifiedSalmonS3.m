clear; clc; close all

fy = 378 ;
t = 4 ;

% Series 3 results from Robinson
Lexp = [100 200 200 300 400 400 500 500] ;
Pexp = [65 88.5 95 79.3 66.4 69.2 80.0 78.2] ;

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's experiments
figure
subplot(2,2,1)
a = fplot(@(L) ModifiedAppBeam(t,L,L,L/2,fy), [0.01 500],'linewidth',1.5);
a.Color = "#EDB120"	;
hold on
fplot(@(L) ModifiedWorkStress(t,L,L,fy), [0.01 500],'b','linewidth',1.5)
hold on
fplot(@(L) ModifiedPlasticStrength(t,L,L,L/2,fy), [0.01 500],'k:','linewidth',1.8)
hold on
scatter(Lexp,Pexp,"black","x");
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
    P_app(i) = ModifiedAppBeam(t,Lexp(i),Hexp(i),sexp(i),fy) ;
    P_workstress(i) = ModifiedWorkStress(t,Lexp(i),Hexp(i),fy) ;
    P_plastic(i) = ModifiedPlasticStrength(t,Lexp(i),Hexp(i),sexp(i),fy) ;
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

%%
function P = ModifiedAppBeam(t,L,H,s,fy)
% Perry Robertson:
V = sqrt((L.^2)+(H.^2)) ; % Free edge
W = (L.*H)./V ; % Perpendicular distance from internal angle to free edge
l = W/2 ; % Effective length
fp = PerryRobertson(t,fy,l,11) ;

fi = atan(H/L) ;
a = (6*s/L)-2 ;
P = t*L*fp*sin(fi)*sin(fi)/a/1000 ;
end

function P = ModifiedWorkStress(t,L,H,fy)
% Perry Robertson:
V = sqrt((L.^2)+(H.^2)) ; % Free edge
W = (L.*H)./V ; % Perpendicular distance from internal angle to free edge
l = W/2 ; % Effective length
fp = PerryRobertson(t,fy,l,11) ;

LH = L/H ;
k = 1.39-(2.2*LH)+(1.27*LH*LH)-(0.25*LH*LH*LH) ;
P = k*fp*L*t/1000 ;
end

function Pu = ModifiedPlasticStrength(t,L,H,s,fy)
% Perry Robertson:
V = sqrt((L.^2)+(H.^2)) ; % Free edge
W = (L.*H)./V ; % Perpendicular distance from internal angle to free edge
l = W/2 ; % Effective length
fp = PerryRobertson(t,fy,l,11) ;

es = s - (0.5*L) ;
fi = atan(H/L) ;
Pu = fp*t*sin(fi)*sin(fi)*((sqrt(4*(es^2)+(L^2)))-(2*es))/1000 ;
end