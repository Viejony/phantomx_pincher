function [output] = get_pose(q)
% Devuelve la pose del robot para el vector de valores articulares q,
% expresada en coordenadas generalizadas [x y z R P Y]
global Robot;
l1 = 0.137;
Tb0 = [[1 0 0 0]; [0 1 0 0]; [0 0 1 l1]; [0 0 0 1]];
fk = Tb0*Robot.fkine(q);
rpy = tr2rpy(fk, 'zyx');
output = [fk(1,4) fk(2,4) fk(3,4) rpy(1) rpy(2) rpy(3)];
end