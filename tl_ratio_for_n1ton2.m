%% Plot ratio of t/l(for n=2) to t/l(for n=1)
clear; clc; close all

E = 206000 ;
alpha = [(0.25:0.25:0.75),(1:1:3),(4:2:16),(20:5:25),(30:10:60),(80:20:160)]*1e-6 ; 
fy = 180:20:400 ;

% t/l for n = 1
n1result=zeros(length(alpha),length(fy)+2) ;
for j = 2:length(fy)+1
    for i = 1:length(alpha)
        fun1 = @(tl) Table(1,tl,alpha(i),fy(j-1),5.5) ;
        n1result(i,j) = fzero(fun1, 0.5);
    end
end
n1result = round(n1result*1000,2) ;
n1result(:,1) = alpha'*1000000 ;
n1result(:,length(fy)+2) = round((alpha*E)',3) ;

% t/l for n = 2
n2result=zeros(length(alpha),length(fy)+2) ;
for j = 2:length(fy)+1
    for i = 1:length(alpha)
        fun1 = @(tl) Table(2,tl,alpha(i),fy(j-1),5.5) ;
        n2result(i,j) = fzero(fun1, 0.5);
    end
end
n2result = round(n2result*1000,2) ;
n2result(:,1) = alpha'*1000000 ;
n2result(:,length(fy)+2) = round((alpha*E)',3) ;

%%
% Ratio of t/l for n = 1 to t/l for n = 2 for results of column 1 & 14
plot(alpha,n2result(:,2)./n1result(:,2),'r-x','linewidth',1.5)
hold on
plot(alpha,n2result(:,13)./n1result(:,13),'b-x','linewidth',1.5)
legend('f_y=180N/mm^2','f_y=400N/mm^2', 'FontName','Times New Roman')
xlabel('$\frac {P_u s}{lW^2E}$','Interpreter','latex','FontName','Times New Roman','FontSize',16)
ylabel('$\frac {t/l\:(for\;n=2)}{t/l\:(for\;n=1)}$','Interpreter','latex','FontName','Times New Roman','FontSize',16)
ax=gca; ax.XAxis.Exponent = -6 ;