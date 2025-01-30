
% C=stlread("STEP/cana_scp.stl").Points;
% X=C(:,1)/1000;
% Y=C(:,2)/1000;
% Z=C(:,3)/1000;
% display(C);



%% Circle sections
R = 0.5;
r = 0.125;
e = 0.01;
N_circle = 49;
torus = torus_section(N_circle, R, r, e);
circle = simple_section(N_circle, r, e);

%% Pipes definition
% Straight 1 :
length1 = 24; % m
A1 = [0 0 0];
B1 = [0 0 length1];
O1 = [0 0 length1/2];
a1 = [0 0 1];
b1 = a1;
% Curved 2 :
rho2 = R;
angle2 = 11.25; % deg
A2 = B1;
a2 = b1;
O2 = A2 - [R 0 0];
B2 = R * ((A2 - O2) * cos(angle2 * pi / 180) / norm(A2 - O2) + sin(angle2 * pi / 180) * a2) + O2;
b2 = +cos(angle2 * pi / 180) * a2 - sin(angle2 * pi / 180) * (A2 - O2) / norm(A2 - O2);
% Straight 3 :
length3 = 6;
A3 = B2;
a3 = b2;
B3 = A3 + length3 * a3;
b3 = a3;
O3 = A3 + (length3 / 2) * a3;
% Curved 4 :
rho4 = R;
angle4 = 22.5 ;
A4=B3;
a4=b3; 
O4 = A4 + cross([0 1 0], a4)/norm(cross([0 1 0], a4))*R;
B4 = R * ((A4 - O4) * cos(angle4 * pi / 180) / norm(A4 - O4) + sin(angle4 * pi / 180) * a4) + O4;
b4 =cos(angle4 * pi / 180) * a4 - sin(angle4 * pi / 180) * (A4 - O4) / norm(A4 - O4);


% Straight 5 :
lenght5=6 ;
A5 = B4;
a5 = b4;
B5 = A5 + lenght5 * a5;
b5 = a5;
O5 = A5 + (lenght5 / 2) * a5;

% Curved 6
rho6 = R;
angle6 = 11.5 ;
A6=B5;
a6=b5; 
O6 = A6 + cross([0 -1 0], a6)/norm(cross([0 -1 0], a6))*R;
B6 = R * ((A6 - O6) * cos(angle6 * pi / 180) / norm(A6 - O6) + sin(angle6 * pi / 180) * a6) + O6;
b6 =cos(angle6 * pi / 180) * a6 - sin(angle6 * pi / 180) * (A6 - O6) / norm(A6 - O6);

% Straight 7
lenght7=12 ;
A7 = B6;
a7 = [0 0 1];
B7 = A7 + lenght7 * a7;
b7 = a7;
O7= A7 + (lenght7 / 2) * a7;

%% New pipeline spline
points_per_straight = 2;
points_per_curved = 20;

new_spline = zeros(4 * points_per_straight + 3*points_per_curved, 3);

% Straight 1
new_spline(1, :) = A1;
new_spline(2, :) = B1;

% Curved 2
OA2 = (A2 - O2) / norm(A2 - O2);
dTheta = angle2 * pi / (180 * (points_per_curved + 1));
for i=1:points_per_curved
    ang = i * dTheta;
    new_spline(points_per_straight + i, :) = O2 + R * (cos(ang) * OA2 + sin(ang) * a2);
end

% Straight 3
new_spline(points_per_straight + points_per_curved + 1, :) = A3;
new_spline(points_per_straight + points_per_curved + 2, :) = B3;

% Curved 4
OA4 = (A4 - O4) / norm(A4 - O4);
dTheta = angle4 * pi / (180 * (points_per_curved + 1));
for i=1:points_per_curved
    ang = i * dTheta;
    new_spline(2*points_per_straight + points_per_curved + i, :) = O4 + rho4 * (cos(ang) * OA4 + sin(ang) * a4);
end

% Straight 5
new_spline(2*points_per_straight + 2*points_per_curved + 1, :) = A5;
new_spline(2*points_per_straight + 2*points_per_curved + 2, :) = B5;

% Curved 6
OA6 = (A6 - O6) / norm(A6 - O6);
dTheta = angle6 * pi / (180 * (points_per_curved + 1));
for i=1:points_per_curved
    ang = i * dTheta;
    new_spline(3*points_per_straight + 2*points_per_curved + i, :) = O6 + rho6 * (cos(ang) * OA6 + sin(ang) * a6);
end

% Straight 7
new_spline(3*points_per_straight + 3*points_per_curved + 1, :) = A5;
new_spline(3*points_per_straight + 3*points_per_curved + 2, :) = B5;
%% Pipeline table

% One row per pipe element
% For each pipe element, 4 entities, 1 int and 3 points/vectors, so 10
% floats total.

pipeline = zeros(7, 16);

% Pipe 1
pipeline(1, 1) = 1; % pipe type 1 = straight
pipeline(1, 2:4) = O1;
pipeline(1, 5:7) = A1;
pipeline(1, 8:10) = B1;
pipeline(1, 11:13) = a1;
pipeline(1, 14:16) = b1;

% Pipe 2
pipeline(2, 1) = 2; % pipe type 2 = curved
pipeline(2, 2:4) = O2;
pipeline(2, 5:7) = A2;
pipeline(2, 8:10) = B2;
pipeline(2, 11:13) = a2;
pipeline(2, 14:16) = b2;

% Pipe 3
pipeline(3, 1) = 1;
pipeline(3, 2:4) = O3;
pipeline(3, 5:7) = A3;
pipeline(3, 8:10) = B3;
pipeline(3, 11:13) = a3;
pipeline(3, 14:16) = b3;

% Pipe 4
pipeline(4, 1) = 2; %curved 90
pipeline(4, 2:4) = O4;
pipeline(4, 5:7) = A4;
pipeline(4, 8:10) = B4;
pipeline(4, 11:13) = a4;
pipeline(4, 14:16) = b4;

% Pipe 5
pipeline(5, 1) = 1; %straight
pipeline(5, 2:4) = O5;
pipeline(5, 5:7) = A5;
pipeline(5, 8:10) = B5;
pipeline(5, 11:13) = a5;
pipeline(5, 14:16) = b5;

% Pipe 6
pipeline(6, 1) = 2; %curve
pipeline(6, 2:4) = O6;
pipeline(6, 5:7) = A6;
pipeline(6, 8:10) = B6;
pipeline(6, 11:13) = a6;
pipeline(6, 14:16) = b6;


% Pipe 7
pipeline(7, 1) = 1; %straight
pipeline(7, 2:4) = O7;
pipeline(7, 5:7) = A7;
pipeline(7, 8:10) = B7;
pipeline(7, 11:13) = a7;
pipeline(7, 14:16) = b7;

%% Test

probe1 = [0 0 2.1];
index = findPipeIndex(probe1, pipeline, 3);

u = findPipeTangent(probe1, pipeline(index, :));
% 
% plot3(X,Y,Z,A1(1),A1(2),A1(3),'o',B1(1),B1(2),B1(3),'x',B2(1),B2(2),B2(3),'x',O2(1),O2(2),O2(3),'o');
% axis equal
% 
% %,B4(1),B4(2),B4(3),'o',B5(1),B5(2),B5(3),'o'