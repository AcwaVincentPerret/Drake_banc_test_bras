%% Machine Parameters (à revoir)
p    = 4;        % Number of pole pairs
Rs   = 0.1;      % Stator resistance per phase           [Ohm]
Ls   = 8e-5;     % Stator self-inductance per phase, Ls  [H]
Ms   = 1e-5;     % Stator mutual inductance, Ms          [H]
psim= 0.0175;   % Maximum permanent magnet flux linkage [Wb]
Jm   = 0.00069;   % Rotor inertia                         [Kg*m^2]
Vdc  = 24;       % DC link voltage                       [V]
Ld = 0.664 ; % stator d-axis inductance [mH] 
Lq = 0.664 ; % stator q-axis inductance [mH] 
r_bras = 196 ; % Rapport de réduction moteur bras 
r_verin = 30 ; % Rapport de réduction moteur vérin + rotation     
%%test bruchless
rpm__max = 60000 ; % vitesse de rotation max [tr/min]
Vref = 12 ; %tension de reférence [V]

Un = 9 ; % tension nominal [V]
C_ref = 37e-3; 

e= 0.03 ; 


%% ASSERV version 1



Km_master1 = ( 15*10 ) ; % gain de l'asserv de tangence du master tiré
Ks_master1 = ( 15*10 ) ; % gain de l'asserv de centrage du master tiré
Km_slave1  = ( 10*10 ) ; % gain de l'asserv de centrage du slave poussé
Ks_slave1  = ( 10*10 ) ; % gain de l'asserv de tangence du slave poussé
Kra_master =    100    ; % gain de l'asserv de la rotaion axiale master

%% ASSERV version 2
Km_master2 = ( 500 ) ; % gain de l'asserv de tangence du master tiré
Ks_master2 = ( 500 ) ; % gain de l'asserv de centrage du master tiré
Km_slave2  = ( 1000 ); % gain de l'asserv de centrage du slave poussé
Ks_slave2  = ( 2000 ); % gain de l'asserv de tangence du slave poussé
%% Control Parameters
Ts  = 1e-5;  % Fundamental sample time            [s]
Tsc = 1e-4;  % Sample time for inner control loop [s]

Kpv = 50 ; % Proportional gain voltage controller
Kiv = 1.5 ; % Integrator gain voltage controller
Kpi = 1000;  % Proportional gain current controller
Kii = 0.01;  % Integrator gain current controller
Kpw = 50;   % Proportional gain speed controller
Kiw = 10;    % Integrator gain speed controller
Kpp = 10;   % Proportional gain position controller
Kip = 0.01;   % Integrator gain position controller
V_vide = 6040*pi/30 ; %vitesse à vide du moteur 

%% Vérin élec

pas= 0.012 ; % pas d'un seul filet [mm]
fliet = 4 ; % nb de filet 
f_vis_ecrou = 0.4; % coeff de frottement statique/dynamique dans le vérin


%% MCC vérin / rotation (à revoir)

Rv=0.46; % [ohm]
Lv=0.191 ; % [mH]
Jv=18.3 ; % [g.cm²]
Kev= 0.003125; % constante de force électromotrice [V/(tr/min)]
f = 6e-6 ; % coeff de frottement dynamique [N.m.s/rad]

%% densité pièces :
%Al6061T6
%{bras coudés cassette bras ; vérin extèrne ; vérin interne ; petite biellette cassette ; couvercle compartiment moteur vérin}
rho_Al6061 = 2.7 ; %[g/cm3]

%Acier inox 
%{axe support satellite ; manchon bras ; satéllite bras
rho_inox = 7.830 ; % [g/cm3]

%Fortal HR
%{boitier pivot longi ; chapeau couronne pivot longi ; liaison avec vérin ; glissière vérin ; bras bout de vérin}
rho_fortal = 2.81 ;% [g/cm3]

%POM-C 
%{support patin ; pignon libre cassette bras ; couronne longi vertèbre ;satéllite longi vertèbre ; grande biellette cassette bras}
rho_pom = 1.41 ; %[g/cm3]

%Al 7075 
%{manchon rotation axiale ; manchon moteur vérin ; support moteur vérin}
rho_Al7075 = 2.81 ; %[g/cm3]

%aluminium EN AW 6082
%{vis vérin}
rho_6082 = 2.71 ; %[g/cm3] 


%Iglidur J 
%{patin glissière}
rho_J = 1.49 ; %[g/cm3]

%Iglidur J350
%{écrou vérin}
rho_J350 = 1.44 ; %[g/cm3]

%AlSi7MgO6
%{compartiment moteur vérin ; cartouche avant (batie slave/master)}
rho_AlSi = 2.6 ; %[g/cm3]

%Ployéthylène chloré (CPE)
%{support batterie}
rho_CPE = 1.16 ; %[g/cm3]

%PVC
%{mousse vetèbre  ; pied flotteur (patin) ; mousse slave/master ; mousse module rotation (partie du batie slave/master)}
rho_PVC = 1.3 ; %[g/cm3]

%Ploypropène (PP-20FV)
%{fourreau}
rho_pp= 1.12 ;%[g/cm3]


%% Frottements dans les liaisons 

% variable déterminé : OK
% variable à déterminer : X


% Liaison palier/vérin extérieur [pve] :

Bff_pve = 20 ; % breakaway friction force/force seuil de décollement [N] | X
Bfv_pve = 0.1 ; % breakaway friction velocity/vitesse seuil de décollement [m/s] | X
Cff_pve = 15 ; % Coulomb friction force/ force de Coulomb [N] | X
f_pve = 200 ; % Coeff de frottement visqeux [N*s/m] | X

% Liaison glissière vérin/rotation axiale [gvr]

Bff_gvr = 200 ; % breakaway friction force/force seuil de décollement [N] | X
Bfv_gvr = 0.1 ; % breakaway friction velocity/vitesse seuil de décollement [m/s] | X
Cff_gvr = 140 ; % Coulomb friction force/ force de Coulomb [N] | X
f_gvr = 200 ; % Coeff de frottement visqeux [N*s/m] | X

% Liaison vérin intérieur/vérin extérieur [vive] :

Bff_vive = 1 ; % breakaway friction force/force seuil de décollement [N] | X
Bfv_vive = 0.01 ; % breakaway friction velocity/vitesse seuil de décollement [m/s] | X
Cff_vive = 1 ; % Coulomb friction force/ force de Coulomb [N] | X
f_vive = 5 ; % Coeff de frottement visqeux [N*s/m] | X

% Liaison slave/vertèbre [sv] :

Bft_sv = 5 ; % breakaway friction torque/couple seuil de décollement [Nm] | X
Bfv_sv = 0.1 ; % breakaway friction velocity/vitesse seuil de décollement [rd/s] | X
Cft_sv = 5 ; % Coulomb friction torque/ couple de Coulomb [Nm] | X
f_sv = 0.05 ; % Coeff de frottement visqeux [N*s/rad] | X

% Laison pivot longitudinal vérin vertèbre [pl] :

Bft_pl = 2 ; % breakaway friction torque/couple seuil de décollement [Nm] | X
Bfv_pl = 0.1 ; % breakaway friction velocity/vitesse seuil de décollement [rd/s] | X
Cft_pl = 1.5 ; % Coulomb friction torque/ couple de Coulomb [Nm] | X
f_pl = 0.001 ; % Coeff de frottement visqeux [N*s/rad] | X

% Liaison manchon fourreau [mf] :

Bft_mf = 5 ; % breakaway friction torque/couple seuil de décollement [Nm] | X
Bfv_mf = 0.1 ; % breakaway friction velocity/vitesse seuil de décollement [rd/s] | X
Cft_mf = 5 ; % Coulomb friction torque/ couple de Coulomb [Nm] | X
f_mf = 0.001 ; % Coeff de frottement visqeux [N*s/rad] | X

% Liaison bras

f_bras=0.005 ; %[N.m.s/rad]
k_bras = 0.01 ; %[N*m/(deg)]
k_verin = 1 ; %[N*m/(deg)]


%Paramètre contact cana/bras
cana_fs = 0.7;
cana_fd = 0.5;
damp =1e3 ; %frottement fluide contact avec cana [N.m/(deg/s)]
stiff = 10000 ; %raideur contact avec cana [N.m/deg]
trw =0.05 ; %transition region width [mm]

%Paramètre contact cana/scc
scc_fs = 0.3;
scc_fd = 0.2;
damp_scc =0.5 ; %frottement fluide contact avec cana [N.m/(deg/s)]
stiff_scc = 10000 ; %raideur contact avec cana [N.m/deg]
%% train épi bras

distance_couronne_fond = -16.80;
entraxe_couronne = -distance_couronne_fond+20.4;
angle_0=220.7; %deg
angle_couronne=84.12; %deg
angle_tot= angle_0-angle_couronne;


%% Canalisation

% Paramètres du cylindre
%diametre = 0.25; % diamètre en mètres
%longueur = 2; % longueur en mètres
%N = 10000; % nombre de points

% Générer des coordonnées cylindriques aléatoires
%theta = 2*pi*rand(N,1); % angle aléatoire
%z = linspace(-longueur/2,longueur/2,N)'; % hauteur aléatoire

% Rayon pour un cylindre
%r = diametre/2;

% Créer la matrice N par 3 représentant uniquement la surface latérale
%x = r .* cos(theta);
%y = r .* sin(theta);

% Créer la matrice N par 3 pour la surface latérale
%Matrice_cylindre = [x, y, z];

%L_cana = 1.5; % [m]


%filepath = fullfile(fileparts(mfilename('fullpath')), 'canalisation_data.mat');
cana = load('canalisation_data.mat');
 % Vérifiez que les données sont bien chargées
pipeline = cana.tableCana ; 
R_cana = 0.125 ;
L_module = 200 ;
assignin('base', 'pipeline', pipeline);
[N,~]=size(pipeline);
liste_norm_AB = zeros(N,1);
AB = pipeline(:,5:7)-pipeline(:,8:10);
for i=1: N
    liste_norm_AB(i) = norm(AB(i,:));
end 
longueur_cana=max(liste_norm_AB);%[m]
%longueur_cana =24 ;
assignin('base', 'longueur_cana', longueur_cana);
dim_cana = [0.125/tan(pi/3) 0.01 longueur_cana];
assignin('base', 'dim_cana', dim_cana);
dim_cana_v =[0.125/tan(pi/3) 0.01 0.32];

% Vitese fluide dans canalisation
Vf = 0.3 ; 


