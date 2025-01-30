%Ajouter les sous-dossiers quand on lance le fichier Simulink
if ~(ismcc || isdeployed)
    addpath(".\Sous-systèmes communs\");
    addpath(".\Sous-systèmes version légère\");
    addpath(".\Sous-systèmes version lourde\");
    addpath(".\Code cana\");
    addpath(".\Données IMU");
    addpath(".\Codes Méca flux\");
    addpath(".\Images\");
    addpath(".\App\")
    addpath(".\App\Fonctions et apps annexes\")
    
    % Lancer les programmes contenant les paramètres 
    run('Codes Méca flux\TROIS_CYLINDRES_TRAINEE_FRICTION.m');
    run('Parametre.m');
    %run('cana_scp.m');
end 