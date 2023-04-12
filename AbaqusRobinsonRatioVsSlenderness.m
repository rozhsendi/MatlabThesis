%% Relationship BETWEEN ratio of experimental result to Abaqus model for
% Robinson AND slenderness ratio
clear; clc; close all

% Ratio of experiment to Abaqus data:
Ratio = [1.52 1.23 1.00 0.92 1.13 2.62 1.93 1.59 1.21 1.26 1.14 0.95 0.94 ...
    0.84 1.19 1.08 0.89 0.83 0.84 1.23 1.15...
    1.39 2.21 1.69 1.71 3.29 2.66 3.07] ;
% Slenderness ratio data
Slenderness = [61.2 122.5 183.7 244.9 306.2 42.0 77.5 103.9 122.5 135.3 ...
    144.1 154.9	160.8 164.3	183.7 183.7	183.7 183.7	183.7 183.7	141.6 ...
    104.5 80.9 65.8	56.4 48.3 56.7 48.9] ;

scatter(Slenderness,Ratio,"x",'r','LineWidth', 1.5)
xlabel('Slenderness ratio','Interpreter','latex')
ylabel('Ratio of experimental result to ABAQUS result','Interpreter','latex')
grid on
grid minor