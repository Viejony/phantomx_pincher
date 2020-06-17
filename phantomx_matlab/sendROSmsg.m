function sendROSmsg(q, secs, nsecs)
% Publica un mensaje a ROS con los valores articulares contenidos en el
% vector q: 4 articulaciones de posicionamiento y una articulación para el
% gripper.

% Obtiene las variables para enviar mensajes a ROS
global pose_publisher;
global pose_msg;
global joint_send

% Configurando el mensaje
pose_msg.JointNames = [
    {'shoulder_joint'}; 
    {'lower_arm_joint'};
    {'upper_arm_joint'};
    {'wrist_joint'};
    {'finger_1_joint'};
    {'finger_2_joint'}];
joint_send.Positions = [q(1), q(2), q(3), q(4), q(5)/2, q(5)/2];
joint_send.Velocities = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
pose_msg.Points = joint_send;
joint_send.TimeFromStart.Sec = int64(secs);
joint_send.TimeFromStart.Nsec = int64(nsecs);

% Envio del mensaje a ROS
send(pose_publisher, pose_msg);

end