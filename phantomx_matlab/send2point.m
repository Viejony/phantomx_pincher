function [output] = send2point(p, delta, gripper)

% Obtiene la cinemática inversa
q = get_ik(p, delta);
q = [q, gripper];

% Envía un mensaje a ROS con los valores articulares y el valor del gripper
sendROSmsg(q);

% Devuelve el vector de valores articulares q
output = q;

end