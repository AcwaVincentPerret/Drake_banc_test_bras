% f=@loi_ES;
% 
% x0 = [0 0.7];
% 
% x = fzero(f,x0);

x= -pi/2:pi/100:pi/2;
y = loi_ES(x); 
plot(x,y);