function pose = get_actual_pose()
% Obtiene las pose del robot en coordenadas generalizadas, usando los
% valores aticulares reportados por ROS
qs = get_actual_joints_values();
pose = get_pose(qs(1:4));
end