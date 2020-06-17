function joy2joints_msgs()
% Lee los mensajes del topic joy, calcula los deltas del movimiento,
% calcula la cinemática inversa y envia los valores articulares a ROS

global operation_mode;
if strcmp(operation_mode, 'automatic')
    return
end


end