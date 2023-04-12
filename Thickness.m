%% Function for finding the thickness of the plate using author's method
function t = Thickness(a,L,H,Pu,s,fy)
func = @(t) SingleStrutThickness(a,L,H,Pu,s,fy,t) ;
t = fzero(func,8);

function thickness = SingleStrutThickness(a,L,H,Pu,s,fy,t)

V = sqrt((L.^2)+(H.^2)) ; % Free edge
W = (L.*H)./V ; % Perpendicular distance from internal angle to free edge
l = W/2 ; % Effective length

fb = PerryRobertson(t,fy,l,a) ;

thickness = (fb.*W.*t.*l./s/1000) - Pu ; % Plate capacity in kN

end
end