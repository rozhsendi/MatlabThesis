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
PWorkStress = ModifiedWorkStress(t,L,H,fy) ;
subplot(2,2,3)
hfp=fplot(@(s) ModifiedAppBeam(t,L,H,s,fy), [0.01 300],'r','linewidth',1.8);
hfp.ShowPoles = 'off';
hfp.Color = "#EDB120" ;
hold on
yline(PWorkStress,'blue','linewidth',1.5)
hold on
fplot(@(s) ModifiedPlasticStrength(t,L,H,s,fy), [0.01 300],'k:','linewidth',1.5)
hold on
scatter(sexp,Pexp,"black","x"); grid on
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
    P_app(i) = ModifiedAppBeam(t,L,H,sexp(i),fy) ;
    P_workstress(i) = ModifiedWorkStress(t,L,H,fy) ;
    P_plastic(i) = ModifiedPlasticStrength(t,L,H,sexp(i),fy) ;
    P_strut(i) = SingleStrut(11,t,L,H,fy,sexp(i)) ;
end

T = table(sexp',lambda',Pexp',P_app',P_workstress',P_plastic',P_strut') ;
T.Properties.VariableNames = {'Eccentricity s' 'Slenderness ratio' 'Exp. result' 'Approximate Beam' 'Working Stress'...
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