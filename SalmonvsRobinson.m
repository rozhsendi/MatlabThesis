clear; clc; close all
fmt = format("bank");
format(fmt)

fy = 378 ; t = 4 ;

% Series 3 results from Robinson
Lexp3 = [100 200 200 300 400 400 500 500] ;
Pexp3 = [65 88.5 95 79.3 66.4 69.2 80.0 78.2] ;

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's S3 experiments
L3 = Lexp3 ; H3 = L3 ; s3 = L3/2 ;

for i = 1:length(L3)
    lambda3(i) = 2*sqrt(3)*L3(i)/(t*sqrt(((L3(i)/H3(i))^2)+1)) ;
    P_app3(i) = AppBeam(t,L3(i),H3(i),s3(i),fy) ;
    P_workstress3(i) = WorkStress(t,L3(i),H3(i),fy) ;
    P_plastic3(i) = PlasticStrength(t,L3(i),H3(i),s3(i),fy) ;
    P_strut3(i) = SingleStrut(11,t,L3(i),H3(i),fy,s3(i)) ;
end

resultS3 = [Lexp3; lambda3 ; Pexp3; P_app3; P_workstress3; P_plastic3; P_strut3]' ;

% Series 4 results from Robinson
Hexp4 = [50 50 100 100 150 150 200 200 250 250 300 300 400 400 500 500 600 600] ;
Pexp4 = [21.5 22.4 57.5 55 85 85 92.5 87.5 120 107.5 110 122 111.5 110 117.5 120 105 117.5] ;

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's S4 experiments
L4 = 200; H4 = Hexp4 ; s4 = L4/2;

for i = 1:length(H4)
    lambda4(i) = 2*sqrt(3)*L4/(t*sqrt(((L4/H4(i))^2)+1)) ;
    P_app4(i) = AppBeam(t,L4,H4(i),s4,fy) ;
    P_workstress4(i) = WorkStress(t,L4,H4(i),fy) ;
    P_plastic4(i) = PlasticStrength(t,L4,H4(i),s4,fy) ;
    P_strut4(i) = SingleStrut(11,t,L4,H4(i),fy,s4) ;
end

resultS4 = [Hexp4; lambda4; Pexp4; P_app4; P_workstress4; P_plastic4; P_strut4]';

% Series 5 results from Robinson
sexp5 = [75 100 150 150 200 250 300 300 300] ;
Pexp5 = [135 110 70 71.3 50 39.2 29.9 28 31] ;

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's S5 experiments
L5 = 300 ; H5 = L5 ; s5 = sexp5 ;

for i = 1:length(sexp5)
    lambda5(i) = 2*sqrt(3)*L5/(t*sqrt(((L5/H5)^2)+1)) ;
    P_app5(i) = AppBeam(t,L5,H5,s5(i),fy) ;
    P_workstress5(i) = WorkStress(t,L5,H5,fy) ;
    P_plastic5(i) = PlasticStrength(t,L5,H5,s5(i),fy) ;
    P_strut5(i) = SingleStrut(11,t,L5,H5,fy,s5(i)) ;
    P_Rob5(i) = robinson(t,L5,H5,s5(i),5.5,fy) ;
end

resultS5 = [sexp5; lambda5; Pexp5; P_app5; P_workstress5; P_plastic5; P_strut5; P_Rob5]' ;

% Series 12 results from Robinson
texp = [5.19 7.03 9.08 11.17 13.04 15.22 12.96 15.04] ;
Pexp12 = [119.5 215.0 450.0 425.0 500.0 1125.0 775.0 1037.5] ;

% Comparison of approximate beam method, working stress method, plastic
% strength method and Robinson's S12 experiments
L12 = 300 ; H12 = L12 ; s12 = L12/2 ;

for i = 1:length(texp)
    lambda12(i) = 2*sqrt(3)*L12/(texp(i)*sqrt(((L12/H12)^2)+1)) ;
    P_app12(i) = AppBeam(texp(i),L12,H12,s12,263) ;
    P_workstress12(i) = WorkStress(texp(i),L12,H12,263) ;
    P_plastic12(i) = PlasticStrength(texp(i),L12,H12,s12,263) ;
    P_strut12(i) = SingleStrut(11,texp(i),L12,H12,263,s12) ;
end

resultS12 = [texp;  lambda12; Pexp12; P_app12; P_workstress12; P_plastic12; P_strut12]';

% Comparison of approximate beam method, working stress method, plastic
% strength method and Martin's experiments

Martin = [127.5 189.3 194.3 134.5 176.1 213.0] ;
tM = [6.10 6.54 6.47 6.46 6.46 6.44] ;
LM = [145 148 148 125 122 120] ;
HM = [145 295 299 125 377 372] ;
sM = [80 102 103 64 65 62.5] ;
fyM = [302.6 257.7 257.7 255.2 255.2 255.2] ;

for i = 1:length(Martin)
    lambdaM(i) = 2*sqrt(3)*LM(i)/(tM(i)*sqrt(((LM(i)/HM(i))^2)+1)) ;
    P_appM(i) = AppBeam(tM(i),LM(i),HM(i),sM(i),fyM(i)) ;
    P_workstressM(i) = WorkStress(tM(i),LM(i),HM(i),fyM(i)) ;
    P_plasticM(i) = PlasticStrength(tM(i),LM(i),HM(i),sM(i),fyM(i)) ;
    P_strutM(i) = SingleStrut(11,tM(i),LM(i),HM(i),fyM(i),sM(i)) ;
    P_RobM(i) = robinson(tM(i),LM(i),HM(i),sM(i),5.5,fyM(i)) ;
end

resultMartin = [Martin; lambdaM; P_appM; P_workstressM; P_plasticM; P_strutM; P_RobM]';
