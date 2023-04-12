%% Calculate t/l for n iterations variation
clear; clc; close all

alpha = [(0.25:0.25:0.75),(1:1:3),(4:2:16),(20:5:25),(30:10:60),(80:20:160)]*1e-6 ; 
fy = [180 220 240 280 320 360 400];
n = 1:16 ;
for j = 1:length(alpha)
    for i = 1:16 %length(n)
    fun2 = @(tl) Table(n(i),tl,alpha(j),180,5.5) ;
    n_variation180(j,i) = fzero(fun2,0.5) ;
    fun3 = @(tl) Table(n(i),tl,alpha(j),400,5.5) ;
    n_variation400(j,i) = fzero(fun3,1.5) ;
    end
end


% Show convergence with varying iterations via graph for fy=180
figure
g = tiledlayout(3,2,"TileSpacing","compact") ;
nexttile
plot(n,n_variation180(1,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
nexttile
plot(n,n_variation180(2,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
nexttile
plot(n,n_variation180(3,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
nexttile
plot(n,n_variation180(4,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
nexttile
plot(n,n_variation180(5,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
nexttile
plot(n,n_variation180(6,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
xlabel(g,'Number of summations n','Interpreter','Latex')
ylabel(g,'t/$\emph{l}$','Interpreter','Latex')
ay=gca; ay.YAxis.Exponent = -3 ;

% Show convergence with varying iterations via graph for fy=400
figure
g = tiledlayout(3,2,"TileSpacing","compact") ;
nexttile
plot(n,n_variation400(1,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
nexttile
plot(n,n_variation400(2,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
nexttile
plot(n,n_variation400(3,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
nexttile
plot(n,n_variation400(4,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
nexttile
plot(n,n_variation400(5,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
nexttile
plot(n,n_variation400(6,:),'red','linewidth',1.5); grid on; xticks((0:4:16));
ay=gca; ay.YAxis.Exponent = -3 ;
xlabel(g,'Number of summations n','Interpreter','Latex')
ylabel(g,'t/$\emph{l}$','Interpreter','Latex')
ay=gca; ay.YAxis.Exponent = -3 ;