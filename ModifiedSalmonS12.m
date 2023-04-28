%% Codes for Series 12 of Robinson's experiments compared with methods 
% from Salmon et al

clear; clc;

fy = 263 ;
L = 300 ;
H = L ;
s = L/2 ;

% Series 12 results from Robinson
texp = [5.19 7.03 9.08 11.17 13.04 15.22 12.96 15.04] ;
Pexp = [119.5 215.0 450.0 425.0 500.0 1125.0 775.0 1037.5] ;

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's experiments using Perry Robertson
subplot(2,2,4)
a = fplot(@(t) ModifiedAppBeam(t,L,H,s,fy), [0.01 16],'linewidth',1.5) ;
a.Color = "#EDB120"	;
hold on
fplot(@(t) ModifiedWorkStress(t,L,H,fy), [0.01 16],'b','linewidth',1.5)
hold on
fplot(@(t) ModifiedPlasticStrength(t,L,H,s,fy), [0.01 16],'k:','linewidth',1.8)
hold on
scatter(texp,Pexp,"black","x"); hold on
grid on

ylim([0 1200])
ylabel('Ultimate Load (kN)','Interpreter','Latex')
yticks([0 200 400 600 800 1000 1200])
xlabel('Plate thickness t (mm)','Interpreter','Latex')
xticks([0 2 4 6 8 10 12 14 16])
lgd = legend('Approximate beam method','Working stress method', ...
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
    P_app(i) = ModifiedAppBeam(texp(i),L,H,s,263) ;
    P_workstress(i) = ModifiedWorkStress(texp(i),L,H,263) ;
    P_plastic(i) = ModifiedPlasticStrength(texp(i),L,H,s,263) ;
    P_strut(i) = SingleStrut(11,texp(i),L,H,263,s) ;
end

T = table(texp',lambda',Pexp',P_app',P_workstress',P_plastic',P_strut') ;
T.Properties.VariableNames = {'Thickness t' 'Slenderness ratio' 'Experimental result' 'Approximate Beam' 'Working Stress'...
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