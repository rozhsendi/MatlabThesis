clear; clc; 

fy = 378 ;
L = 200 ;
t = 4 ;
s = L/2 ;

% Series 4 results from Robinson
Hexp = [50 50 100 100 150 150 200 200 250 250 300 300 400 400 500 500 600 600] ;
Pexp = [21.5 22.4 57.5 55 85 85 92.5 87.5 120 107.5 110 122 111.5 110 117.5 120 105 117.5] ;

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's experiments
subplot(2,2,2)
fplot(@(H) SingleStrut(11,t,L,H,fy,s),[0 600],'red','linewidth',1.5)
hold on
a = fplot(@(H) ModifiedAppBeam(t,L,H,s,fy), [0.01 600],'linewidth',1.5) ;
a.Color = "#EDB120"	;
hold on
fplot(@(H) ModifiedWorkStress(t,L,H,fy), [0.1 600],'b','linewidth',1.5)
hold on
fplot(@(H) ModifiedPlasticStrength(t,L,H,s,fy), [0.01 600],'k:','linewidth',1.8)
hold on
scatter(Hexp,Pexp,"black","x"); hold on
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
    P_app(i) = ModifiedAppBeam(t,Lexp,Hexp(i),sexp,fy) ;
    P_workstress(i) = ModifiedWorkStress(t,Lexp,Hexp(i),fy) ;
    P_plastic(i) = ModifiedPlasticStrength(t,Lexp,Hexp(i),sexp,fy) ;
    P_strut(i) = SingleStrut(11,t,Lexp,Hexp(i),fy,sexp) ;
end

T = table(Hexp',lambda',Pexp',P_app',P_workstress',P_plastic',P_strut') ;
T.Properties.VariableNames = {'H' 'Slenderness ratio' 'Exp. result' 'Approximate Beam' 'Working Stress'...
    'Plastic Strength' 'Single Strut'};
display(T)

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