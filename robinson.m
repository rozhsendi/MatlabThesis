%% Function for finding ultimate load Pu using Robinson's method
%  without using any tables (same as Table function listed above)
function Pu = robinson(t,L,H,s,a,fy)
n = 1000 ;
i = 1:n ;

E = 206000 ;
V = sqrt((L.^2)+(H.^2)) ;
W = (L.*H)./V ;
l = W ;

Beta = s./(l.*W.*W.*E) ;

lamda0 = 0.2*pi*sqrt(E/fy) ;
dwW = 1/n ;
wiW =  dwW.*(0.5+(i-1));
tli = (t./l).*(1./wiW) ;
lamdai = sqrt(12)./(tli) ;
eta = 0.001*a.*(lamdai-lamda0) ;
fei = ((pi*pi)/12).*(tli).^2 ;
f = fy./E ;
f2i = (f + (eta+1).*fei)./2 ;
fbi = f2i - sqrt(((f2i).^2)-(f.*fei)) ;

Pu = (sum(fbi.*(t./l).*wiW.*dwW))./Beta/1000 ;

end