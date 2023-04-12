clear; clc; close all

E = 206000 ; % Young's modulus
% alpha =  Pu s / lW^2E
alpha = [(0.25:0.25:0.75),(1:1:3),(4:2:16),...
    (20:5:25),(30:10:60),(80:20:160)]*1e-6 ; 
fy = 180:20:400 ; % Yield stress

% Generates Robinson's table using given equations for n = 1000 
% (call it result_1000)
result_1000=zeros(length(alpha),length(fy)+2) ;
for j = 2:length(fy)+1
    for i = 1:length(alpha)
        fun1 = @(tl) Table(1000,tl,alpha(i),fy(j-1),5.5) ;
        result_1000(i,j) = fzero(fun1, 0.5);
    end
end
result_1000 = round(result_1000*1000,2) ;
result_1000(:,1) = alpha'*1000000 ;
result_1000(:,length(fy)+2) = round((alpha*E)',3) ;

% Generates Robinson's table using given equations for n = 15
% (call it result_15)
result_15=zeros(length(alpha),length(fy)+2) ;
for j = 2:length(fy)+1
    for i = 1:length(alpha)
        fun1 = @(tl) Table(15,tl,alpha(i),fy(j-1),5.5) ;
        result_15(i,j) = fzero(fun1, 0.5);
    end
end
result_15 = round(result_15*1000,2) ;
result_15(:,1) = alpha'*1000000 ;
result_15(:,length(fy)+2) = round((alpha*E)',3) ;

% Generates Robinson's table using given equations for n = 1
% (call it result_1)
result_1=zeros(length(alpha),length(fy)+2) ;
for j = 2:length(fy)+1
    for i = 1:length(alpha)
        fun1 = @(tl) Table(16,tl,alpha(i),fy(j-1),5.5) ;
        result_1(i,j) = fzero(fun1, 0.5);
    end
end
result_1 = round(result_1*1000,2) ;
result_1(:,1) = alpha'*1000000 ;
result_1(:,length(fy)+2) = round((alpha*E)',3) ;

% Comparison of n = 1000, 15, and 1
result_n1000 = [result_1000(1,2) result_1000(1,13) result_1000(24,2) result_1000(24,13)] ;
result_n15 = [result_15(1,2) result_15(1,13) result_15(24,2) result_15(24,13)] ;
result_n1 = [result_1(1,2) result_1(1,13) result_1(24,2) result_1(24,13)] ;

figure
n_1000 = [1000; 1000; 1000; 1000] ;
n_15 = [15; 15; 15; 15] ;
n_1 = [1; 1; 1 ;1];
scatter(n_1000,result_n1000,"black","x"); hold on
scatter(n_15,result_n15,"red","x"); hold on
scatter(n_1,result_n1, "blue","x")
xlabel('n','FontName','Times New Roman')
ylabel('t/{\itl} (x10^-^3)','FontName','Times New Roman')
legend('n=1000','n=15','n=1','FontName','Times New Roman')

%% Robinson's tables from his PhD paper
OGTable = readtable("OriginalRobinsonTables.xlsx") ;
OGTable = table2array(OGTable) ;