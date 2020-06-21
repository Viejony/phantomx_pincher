function start_task()
% Inicia la tarea: se mueve entre distintos puntos y cambia los estados del
% griper. Tiene en cuenta la cantida de bloques en la zona de entrada y las
% cantidades de bloques en las zonas de salida.
global handles;

% Se lee el campo de 'Zona de salida'
exit_zone = get(handles.exit_zone_field, 'String');
exit_zone = str2num(exit_zone);

% Verifica si el valor para zona de salida es correcto
if length(exit_zone) < 1 || exit_zone > 3
    set_waiting_mode_GUI(handles);
    error('El valor asignado para "Zona de Salida" es incorrecto');
end

% Se verifica que existan elementos en la zona de entrada
global n_blocks;
global actual_block;
if actual_block > n_blocks
    error('No hay bloques en la Zona de salida');
end

% Se verifica que las zona de salida no esté llena
global ocuppied_outputs;
global n_points_output;
if ocuppied_outputs(exit_zone) >= n_points_output
    error('La zona de salida seleccionada se encuentra llena');
end

% Se obtienen los puntos de entrada y desde las variables globales
global input_points;
global output1_points;
global output2_points;
global output3_points;
input_point = input_points(actual_block, :);
all_output_points = [output1_points, output2_points, output3_points];
output_point = all_output_points(ocuppied_outputs(exit_zone)+1, ((exit_zone-1)*3+1):((exit_zone-1)*3+1+2));

% Variables fijas de elvación, orientación apertura y cierre del gripper
elevation = 0.05;
orientation = -pi/2;
open_gripper = 0.03;
closed_gripper = 0.0185;

% Arreglo con las distintas poses para cada punto
poses = zeros(8, 5);

% Obtiene las cinemáticas inversas para cada punto
% Punto de aproximación
poses(1,:) = [get_ik([input_point(1), input_point(2), input_point(3) + elevation], orientation, true), open_gripper];
% Punto de recogida
poses(2,:) = [get_ik([input_point(1), input_point(2), input_point(3)], orientation, true), open_gripper];
poses(3,:) = [get_ik([input_point(1), input_point(2), input_point(3)], orientation, true), closed_gripper];
% Punto de elevación
poses(4,:) = [get_ik([input_point(1), input_point(2), input_point(3) + elevation], orientation, true), closed_gripper];
% Punto de desplazamiento
poses(5,:) = [get_ik([output_point(1), output_point(2), output_point(3) + elevation], orientation, true), closed_gripper];
% Punto de entrega
poses(6,:) = [get_ik([output_point(1), output_point(2), output_point(3)], orientation, true), closed_gripper];
poses(7,:) = [get_ik([output_point(1), output_point(2), output_point(3)], orientation, true), open_gripper];
poses(8,:) = [get_ik([output_point(1), output_point(2), output_point(3) + elevation], orientation, true), open_gripper];

% Cambia color del indicador a rojo y cambia el estado de la tarea
set_running_mode_GUI(handles);
global task_status;
task_status = 'running';

% Inicia la función de movimiento entre las cinco poses.
global default_delay;
for i=1:1:8
    if strcmp(task_status, 'running')
        p = poses(i,1:5);
        sendROSmsg(p, default_delay, 0);
        pause(default_delay);
    else
        % Cambia color del indicador a verde
        set_waiting_mode_GUI(handles);
        return
    end
    %fprintf("Moviendo al punto %0.0f\n", i);
end

% Actualiza los valores de bloque actual y zona de salida ocupada
actual_block = actual_block + 1;
ocuppied_outputs(exit_zone) = ocuppied_outputs(exit_zone) + 1;

% Cambia color del indicador a verde
set_waiting_mode_GUI(handles);

end
