%Ajouter les sous-dossiers quand on lance le fichier Simulink
if ~(ismcc || isdeployed)
    addpath(".\Sous-systèmes communs\");
    addpath(".\Sous-systèmes version lourde\");
    addpath(".\Code cana\");
    addpath(".\Images\");

    
    % Lancer les programmes contenant les paramètres 
    run('Parametre.m');

end 