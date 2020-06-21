function [output] = get_pose(q)
% Devuelve la pose del robot para el vector de valores articulares q,
% expresada en coordenadas generalizadas [x y z R P Y delta]. El valor de
% delta corresponde al ángulo del eslabón 4 en el plano formado por el eje
% z y el vector [x y 0] (plano pp2)

% Se obtienen la cinemática directa del TCP desde la base del robot
global Robot;
l1 = 0.137;
Tb0 = [[1 0 0 0]; [0 1 0 0]; [0 0 1 l1]; [0 0 0 1]];
fk = Tb0*Robot.fkine(q);


% Orientación del TCP en forma RPY
rpy = tr2rpy(fk, 'zyx');

% Orientación del TCP en el plano pp2
% Puntos p1 (muñeca), p2 (TCP)
T_01 = Tb0*Robot.A(1, [q(1), q(2), q(3), q(4)]);
T_12 = Robot.A(2, [q(1), q(2), q(3), q(4)]);
T_23 = Robot.A(3, [q(1), q(2), q(3), q(4)]);
T_w = [[1 0 0 0.105]; [0 1 0 0]; [0 0 1 0]; [0 0 0 1]];
T_p1 = T_01 * T_12 * T_23 * T_w;
p1 = [T_p1(1,4) T_p1(2,4) T_p1(3,4), 1]';
p2 = [fk(1,4) fk(2,4) fk(3,4), 1]';

% Cambio del sistema coordenado al punto p1
M = [rotz(atan2(p1(2), p1(1))), p1(1:3); [0 0 0 1]];
p2 = (M^-1)*p2;
delta = atan2(p2(3), p2(1));

% Salida
output = [fk(1,4) fk(2,4) fk(3,4) rpy(1) rpy(2) rpy(3) delta];

end