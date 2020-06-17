function qs = get_actual_joints_values()
% Obtiene los valores articulares del robot de Gazebo
global state_subs;
qq = state_subs.LatestMessage.Actual.Positions;
qs = qq';
end