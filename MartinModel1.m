function P = MartinModel1(t,L,H,s,fy)
E = 206000 ;
LH = L/H ;

P = ((pi*pi*E*t.^3)/(24*s))*log(1+((12*fy*L*L)/(pi*pi*E*t*t*(LH*LH+1))))/1000 ;
end