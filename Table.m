%% Function relating all the equations from Robinson's paper used
% for generating the tables
% tl = t/l, dwW = dw/W, wiW = wi/W, tli = t/li 
function func = Table(n,tl,alpha,fy,a)
i = 1:n ;
E = 206000 ;
f = fy/E ;
dwW = 1/n ;
wiW =  dwW.*(0.5+(i-1));
tli = (tl).*(1./wiW) ;
lamda0 = 0.2*pi*sqrt(E/fy) ;
lamdai = sqrt(12)./(tli) ;
eta = 0.001*a.*(lamdai-lamda0) ;
fei = ((pi*pi)/12).*(tli).^2 ;
f2i = (f + (eta+1).*fei)./2 ;
fbi = f2i - sqrt(((f2i).^2)-(f.*fei)) ;

func = sum(fbi.*tl.*wiW.*dwW) - alpha ;
end