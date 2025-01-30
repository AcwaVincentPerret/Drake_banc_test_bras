
C=stlread("STEP/surface_cana_chemin_3D_3.stl").Points;
X=C(:,1);
Y=C(:,2);
Z=C(:,3);
%display(C);

% %points d'entrée et sortie des éléments à automatiser !! 
% P0=[0 400 -1000];
% P1=[0 400  -666];
% P2=[0 400 -333];
% P3=[0 400 0];
% P4 = [0 400*cos(pi/8) 400*sin(pi/8)];
% P5=[0 400*sqrt(2)/2 400*sqrt(2)/2];
% 
% P6 = [0 400*cos(3*pi/8) 400*sin(3*pi/8)];
% P7=[0 0 400];
% P8=[0 -266.66 400];
% P9 = [0 -533.33 400];
% P10=[0 -800 400];
% P11=[600-600*cos(pi/8) -800-600*sin(pi/8)  400];
% P12=[600-600*sqrt(2)/2 -800-600*sqrt(2)/2  400];
% P13=[600-600*cos(3*pi/8) -800-600*sin(3*pi/8)  400];
% P14=[600 -(800+600)  400];
% P15=[(600+166.66) -1400 400];
% P16=[(600+333.33) -1400  400] ;
% P17=[1100 -1400 400] ;
% P18=[1100+400*sin(pi/4) -1400-(400-400*cos(pi/4)) 400 ];
% % points suplémentaires
% P19=[1100+400 -1400-400 400];
% P20=[1100+400 -1800-500 400];
% P21=[1100+700 -1800-1000 0];
% 
%points d'entrée et sortie des éléments à automatiser !! 
P0=[0 400 -1000];
P1=[0 400  -666];
P2=[0 400 -333];
P3=[0 400 0];
P4 = [0 400*cos(pi/8) 400*sin(pi/8)];
P5=[0 400*sqrt(2)/2 400*sqrt(2)/2];
yP6=0;
zP6=400*sqrt(2)/2+400*sqrt(2)/2;
P6 = [0 yP6 zP6];
yP7=400*sqrt(2)/2-800*sqrt(2)/2;
zP7=400*sqrt(2)/2+800*sqrt(2)/2;
P7=[0 yP7 zP7];
yP8=yP7-600*sin(pi/8)*sqrt(2)/2;
zP8=zP7+600*sin(pi/8)*sqrt(2)/2;
P8=[600-600*cos(pi/8) yP8 zP8];
yP9=yP7-600*sin(pi/4)*sqrt(2)/2;
zP9=zP7+600*sin(pi/4)*sqrt(2)/2;
P9 = [600-600*cos(pi/4) yP9 zP9];

P10=[(379.029+467.418)/2 -(712.546+803.139)/2 (1215.73+1431.32)/2];
P11=[(609.814+724.814)/2 -(964.481+911.84)/2 (1390.38+1605.65)/2];
P12=[(742.552+870.223)/2 -(1111.31+956.52)/2 (1722.48+1575.66)/2];



P13=[(828.156+798.018)/2 -(1283.29+1042.12)/2 (1951.47+2008.64)/2];
P14=[(810.593+663.67)/2 -(1146.81+1331.52)/2 (2352.68+2274.48)/2];
P15=[(554.221+706.69)/2 -(1400.28+1202.57)/2 (2640.25+2642.62)/2];

% P16=[-(600+333.33) -1400  400] ;
% P17=[-1100 -1400 400] ;
% P18=[-(1100+400*sin(pi/4)) -1400+(400-400*cos(pi/4)) 400 ];
% % points suplémentaires
% P19=[-(1100+400) -1400+400 400];
% P20=[-(1100+400) -1400+900 400];
% P21=[-(1100+700) 0 0];

points= [P0' P1' P2' P3' P4' P5' P6' P7' P8' P9' P10' P11' P12' P13' P14' P15']';

%yy= 

plot3(X,Y,Z,'.',points(:,1),points(:,2),points(:,3),'o')
axis equal
ligne_moyenne=cscvn(points');


hold on
fnplt(ligne_moyenne,'r',2)
hold off

matrice_ligne_moyenne=fnplt(ligne_moyenne,'r',2)/1000;
ligne_moyenne_max=cscvn(matrice_ligne_moyenne);

hold on
fnplt(ligne_moyenne_max,'r',2)
hold off

matrice_ligne_moyenne=fnplt(ligne_moyenne_max,'r',2);
% 
% longueur_cana=0.150;
% dim_cana = [0.125/tan(pi/3) 0.01 longueur_cana];

% Plus petit pas
Ts = 1e-5;

spline_cana = transpose(matrice_ligne_moyenne);

% Initialize an index to keep track of the unique points
unique_idx = 1;

% Preallocate the output matrix for better performance
tolerance = 1e-4;
cleaned_points = zeros(size(spline_cana));
cleaned_points(unique_idx, :) = spline_cana(1, :);

% Iterate over the points starting from the second one
for i = 2:size(spline_cana, 1)
    % Check if the current point is different from the previous one within the tolerance
    if any(abs(spline_cana(i, :) - spline_cana(i - 1, :)) > tolerance)
        unique_idx = unique_idx + 1;
        cleaned_points(unique_idx, :) = spline_cana(i, :);
    end
end

% Remove the unused preallocated rows
cleaned_points = cleaned_points(1:unique_idx, :);

%% Circle sections
R = 0.4;
r = 0.125;
e = 0.01;
N_circle = 49;
torus = torus_section(N_circle, R, r, e);
circle = simple_section(N_circle, r, e);

%% Pipes definition
length1 = 2; % m
A1 = [0 0 0];
B1 = [0 0 length1];
O1 = [0 0 length1/2];
a1 = [0 0 1];
b1 = a1;

rho2 = R;
angle2 = 45; % deg
A2 = B1;
a2 = b1;
O2 = A2 - [0 R 0];
B2 = R * ((A2 - O2) * cos(45 * pi / 180) / norm(A2 - O2) + sin(45 * pi / 180) * a2) + O2;
b2 = cos(45 * pi / 180) * a2 - sin(45 * pi / 180) * (A2 - O2) / norm(A2 - O2);

length3 = length1*2;
A3 = B2;
a3 = b2;
B3 = A3 + length3 * a3;
b3 = a3;
O3 = A3 + (length3 / 2) * a3;

rho4 = R+0.1;
angle4 = 90 ;
A4=B3;
a4=b3; 
O4 = A4 - [0 (sqrt(2)/2)*rho4 (sqrt(2)/2)*rho4];
B4 = A4 -[0 sqrt(2)*rho4 0];
b4 =cos(90 * pi / 180) * a2 - sin(90 * pi / 180) * (A4 - O4) / norm(A4 - O4);



lenght5=length1 /2 ;
A5 = B4;
a5 = b4;
B5 = A5 + lenght5 * a5;
b5 = a5;
O5 = A5 + (1 / 2) * a5;

%% New pipeline spline
points_per_straight = 2;
points_per_curved = 20;

new_spline = zeros(3 * points_per_straight + 2*points_per_curved, 3);

% Straight 1
new_spline(1, :) = A1;
new_spline(2, :) = B1;

% Curved 2
OA2 = (A2 - O2) / norm(A2 - O2);
dTheta = 45 * pi / (180 * (points_per_curved + 1));
for i=1:points_per_curved
    ang = i * dTheta;
    new_spline(points_per_straight + i, :) = O2 + R * (cos(ang) * OA2 + sin(ang) * a2);
end

% Straight 3
new_spline(points_per_straight + points_per_curved + 1, :) = A3;
new_spline(points_per_straight + points_per_curved + 2, :) = B3;

% Curved 4
OA4 = (A4 - O4) / norm(A4 - O4);
dTheta = 90 * pi / (180 * (points_per_curved + 1));
for i=1:points_per_curved
    ang = i * dTheta;
    new_spline(2*points_per_straight + points_per_curved + i, :) = O4 + rho4 * (cos(ang) * OA4 + sin(ang) * a4);
end

% Straight 5
new_spline(2*points_per_straight + 2*points_per_curved + 1, :) = A5;
new_spline(2*points_per_straight + 2*points_per_curved + 2, :) = B5;

%% Pipeline table

% One row per pipe element
% For each pipe element, 4 entities, 1 int and 3 points/vectors, so 10
% floats total.

pipeline = zeros(5, 16);

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

%% Test

probe1 = [0 0 2.1];
index = findPipeIndex(probe1, pipeline, 3);

u = findPipeTangent(probe1, pipeline(index, :));
