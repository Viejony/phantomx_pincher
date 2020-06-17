function update_gui_fields()
% Actualiza las etiquetas de la interfaz gráfica, leyendo los valores
% articulares del robot

% Obtiene el handles
global handles;

% Obtiene los valores articulares del robot de Gazebo y los guarda en la
% variable qs
qs = get_actual_joints_values();

% Obtiene la pose del robot
pose = get_actual_pose();

% Actualiza los campos del panel Pose
set(handles.pose_x, 'String', sprintf('x: %0.2f mm', pose(1)*1000));
set(handles.pose_y, 'String', sprintf('y: %0.2f mm', pose(2)*1000));
set(handles.pose_z, 'String', sprintf('z: %0.2f mm', pose(3)*1000));
set(handles.pose_alpha, 'String', sprintf('R: %0.2f rad', pose(4)));
set(handles.pose_beta, 'String', sprintf('P: %0.2f rad', pose(5)));
set(handles.pose_gamma, 'String', sprintf('Y: %0.2f rad', pose(6)));

% Actualiza los campos del panel Joints
set(handles.joints_q1, 'String', sprintf('q1: %0.2f rad', qs(1)));
set(handles.joints_q2, 'String', sprintf('q2: %0.2f rad', qs(2)));
set(handles.joints_q3, 'String', sprintf('q3: %0.2f rad', qs(3)));
set(handles.joints_q4, 'String', sprintf('q4: %0.2f rad', qs(4)));
set(handles.joints_gripper, 'String', sprintf('grip: %0.1f mm', qs(5)*2000));

%disp("GUI Updated");

end