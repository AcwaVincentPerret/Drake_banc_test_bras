function rho = loi_ES(alpha)

R=40.4/1000;
agrandissement = 1.4;
L1=agrandissement*30/1000;
L2=agrandissement*28/1000;
L3 = 24.5/1000;
d = 12/1000;
alpha_0 = 42*pi/180;
gamma = 155*pi/180;
alpha_1 = acos((R/L1)*sin(alpha));
alpha_2 = gamma - pi + acos((R/L1)*sin(alpha));
alpha_3 = acos((1/L3)*(L2*cos(gamma-pi+acos((R/L1)*sin(alpha)))-d/2));
alpha_10 = acos((R/L1)*sin(alpha_0));
alpha_20 = gamma - pi + acos((R/L1)*sin(alpha_0));
alpha_30 = acos((1/L3)*(L2*cos(gamma-pi+acos((R/L1)*sin(alpha_0)))-d/2));

rho_0=R*cos(alpha_0) + L1*sin(alpha_10) + L2*sin(alpha_20) + L3*sin(alpha_30);


rho = R*cos(alpha) + L1*sin(alpha_1) + L2*sin(alpha_2) + L3*sin(alpha_3);
end 

