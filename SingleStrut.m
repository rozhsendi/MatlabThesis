%% Function for finding ultimate load using author's model (labeled single
%  strut model) given t.
function Pu = SingleStrut(a,t,L,H,fy,s)

V = sqrt((L.^2)+(H.^2)) ; % Free edge
W = (L.*H)./V ; % Perpendicular distance from internal angle to free edge
l = W/2 ; % Effective length

fb = PerryRobertson(t,fy,l,a) ; % Perry-Robertson stress

Pu = fb.*W.*t.*l./s/1000 ; % Plate capacity in kN

end