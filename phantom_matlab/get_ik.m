function [q] = get_ik(p, delta)
% Función que devuelve la cinemática inversa del brazo. Produce un error si
% la posición y orientación están fuera del alcance del robot.

% Asignación de valores constantes y cálculo de valores intermedios (geometría)
l1 = 0.137;
l2 = 0.105;
l3 = 0.105;
l4 = 0.110;
px = p(1);
py = p(2);
pz = p(3);
pz1 = pz - l1 - l4*sin(delta);
d1 = sqrt(px^2 + py^2);
d2 = d1-l4*cos(delta);
d3 = sqrt(d2^2 + pz1^2);
phi = atan2(pz1, d2);
alpha = acos((d3^2 + l2^2 -l3^2)/(2*d3*l2));
beta = acos((d3^2 + l2^2 -l2^2)/(2*d3*l3));

% Verifica si los valores encontrados se encuentran en el espacio de
% trabajo del robot, comparando la distancia d2 con el valor máximo posible
% para esta distancia
if d3 > (l2+l3)
    error('Posición fuera del alcance del robot: [%0.3f, %0.3f, %0.3f]', p(1), p(2), p(3));
end

% Obtiene los valores articulares para el punto dado
q1 = atan2(py, px);
q2 = -(pi/2 -phi -alpha);
q3 = -alpha - beta;
q4 = beta - phi + delta;

% Asigna los valores los valores al vector de valores articulares
[q] = [q1 q2 q3 q4];

end