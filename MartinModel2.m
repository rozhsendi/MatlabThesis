function P = MartinModel2(t,L,H,s,fy)
LH = L/H ;

P = ((fy*L*t)/((s/L)*((LH*LH)+1)))*(0.5-((sqrt(3)*(L/t))/(277.5*sqrt((LH*LH)+1))))/1000 ;
end