function Pu = PlasticStrength(t,L,H,s,fy)
es = s - (0.5*L) ;
fi = atan(H/L) ;
Pu = fy*t*sin(fi)*sin(fi)*((sqrt(((4*es)^2)+(L^2)))-(2*es))/1000/1.7 ;
end