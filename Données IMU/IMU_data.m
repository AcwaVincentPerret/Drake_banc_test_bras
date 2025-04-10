columnTitles = {'t (s)', 'position x (m)', 'position y (m)', 'position z (m)', ...
                'acceleration x (m/s^2)', 'acceleration y (m/s^2)', 'acceleration z (m/s^2)', ...
                'omega x (rad/s)', 'omega y (rad/s)', 'omega z (rad/s)','theta x (rad)','theta y (rad)','theta z (rad)'};


%% IMU Master

positionMaster=load('IMU_master_pos.mat');
accelerationMaster=load('IMU_master_acc.mat');
omegaMaster=load('IMU_master_omega.mat');
thetaMaster=load('IMU_master_theta.mat');


outputFileMaster = 'Données IMU/IMU_Master.csv';
timeMaster = positionMaster.pos(1,:);
posValuesMaster = positionMaster.pos(2:end,:);
accValuesMaster = accelerationMaster.acc(2:end,:);
omegaValuesMaster = omegaMaster.omega(2:end,:);
thetaValuesMaster = thetaMaster.theta(2:end,:);

% Combiner les données avec une seule colonne de temps
combinedDataMaster = [timeMaster', posValuesMaster',  accValuesMaster', omegaValuesMaster', thetaValuesMaster'];
writecell(columnTitles,outputFileMaster);
writematrix(combinedDataMaster,outputFileMaster, 'WriteMode', 'append');


%% IMU Slave

positionSlave=load('IMU_slave_pos.mat');
accelerationSlave=load('IMU_slave_acc.mat');
omegaSlave=load('IMU_slave_omega.mat');
thetaSlave=load('IMU_slave_theta.mat');

outputFileSlave = 'Données IMU/IMU_Slave.csv';
timeSlave = positionSlave.pos(1,:);
posValuesSlave = positionSlave.pos(2:end,:);
accValuesSlave = accelerationSlave.acc(2:end,:);
omegaValuesSlave = omegaSlave.omega(2:end,:);
thetaValuesSlave = thetaSlave.theta(2:end,:);

% Combiner les données avec une seule colonne de temps
combinedDataSlave = [timeSlave', posValuesSlave',  accValuesSlave', omegaValuesSlave',thetaValuesSlave'];
writecell(columnTitles,outputFileSlave);
writematrix(combinedDataSlave,outputFileSlave, 'WriteMode', 'append');

% figure(1);
% plot3(posValuesMaster(:,1),posValuesMaster(:,2),posValuesMaster(:,3),'x')
% axis equal
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% title('Position IMU Master')
% 
% figure;
% plot3(posValuesSlave(:,1),posValuesSlave(:,2),posValuesSlave(:,3),'x')
% axis equal
% xlabel('X')
% ylabel('Y')
% zlabel('Z')
% title('Position IMU Slave')

%% Distance fil

distanceFil=load('Distance_fil.mat');
outputFileDistance = 'Données IMU/Distance_fil.csv';
timeDFil = distanceFil.D_fil.Time;
distanceFilValue = distanceFil.D_fil.Data;
writecell({'t (s)','Distance de fil (m)'},outputFileDistance);
writematrix([timeDFil,distanceFilValue],outputFileDistance, 'WriteMode', 'append');