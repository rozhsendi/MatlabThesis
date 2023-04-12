clear; clc;

E = 210000 ;

% Euler
fplot(@(sl) pi*pi./(sl.^2), [0 1],'blue', 'LineWidth', 1.5) ;
hold on

% Rankine Gordon
k = 275/(pi*pi) ;
fplot(@(sl) 275/(1+(k*sl*sl)), [0 1],'r','LineWidth', 1.5)
ylim([0 550])

% Yeiled stress
x = 0:0.01:0.19 ;
fy = 275 + zeros(length(x)) ;
plot(x,fy,'black--', 'LineWidth', 1.2)
hold on

xlabel('Slenderness ratio $\emph{l}$/r','Interpreter','Latex')
ylabel('Stress f','Interpreter','Latex')
set(gca,'xticklabel',[])
yticks([0 137.5 275 412.5 550])

yticklabels({'','','fy'})
grid on

legend('Euler stress','Rankine-Gordon stress','Interpreter','Latex')