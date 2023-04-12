%% Buckling stress curve for Single Strut model
clear; clc; close all

fplot(@(lamdabar) ReductionFactor(275,lamdabar, 11), [0.2 3],'red','LineWidth', 1.2) ; hold on
lamdalim = 0:0.001:0.2 ;
lim = 1 + zeros(length(lamdalim)) ;
plot(lamdalim,lim,'red','LineWidth', 1.2)
ylim([0,1.1])
grid on
grid minor

xlabel('Normalized slenderness, $\bar{\lambda}$','Interpreter','latex')
ylabel('Reduction factor, $\chi$', 'Interpreter','latex')

function xai = ReductionFactor(fy,lamdabar,a)

E = 210000 ;
lamda0 = 0.2*pi*sqrt(E/fy) ;
eta = 0.001*a*(5*lamdabar*lamda0-lamda0) ;
fe = (pi*pi.*E./((5*lamdabar*lamda0).^2)) ;
f2 = 0.5*(fy+fe.*(eta+1)) ;
fb = f2 - sqrt((f2.^2)-fy.*fe) ;
xai = fb/fy ;
end