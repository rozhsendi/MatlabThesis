%% Function for finding L or H for given slenderness limitation or 
%  vice versa
function  lamdasolver = slenderness(L,H,t,lamda)
r = L/H ;
lamdasolver = 2*sqrt(3)*L/(t*sqrt((r^2)+1)) - lamda ;
end