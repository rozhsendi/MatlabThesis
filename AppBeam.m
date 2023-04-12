function P = AppBeam(t,L,H,s,fy)
fi = atan(H/L) ;
a = (6*s/L)-2 ;
P = t*L*0.6*fy*sin(fi)*sin(fi)/a/1000 ;
end