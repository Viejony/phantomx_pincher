%% Inicia la comunicación con ROS
rosshutdown;
%rosinit;
rosinit('10.0.0.2', 'NodeHost','10.0.0.3','NodeName','/matlab_global_node')

% Creando el publisher y el mensaje para el control de las articulaciones
global pose_publisher;
global pose_msg;
global joint_send;
pose_publisher = rospublisher('/arm_controller/command', 'trajectory_msgs/JointTrajectory');
pose_msg = rosmessage('trajectory_msgs/JointTrajectory');
pose_msg.JointNames = {'shoulder_joint', 'lower_arm_joint', ...
    'upper_arm_joint', 'wrist_joint', 'finger_1_joint','finger_2_joint'};
joint_send = rosmessage('trajectory_msgs/JointTrajectoryPoint');

% Creación del subscriber para los joints
global state_subs;
state_subs = rossubscriber('/arm_controller/state');

% Creación del subscriber para el Joypad
global joy_subs;
joy_subs = 0;
try
    joy_subs = rossubscriber('/joy');
catch ME
    disp("No fue posible subscribrise al topic /joy. El modo manual no va a funcionar.")
end

% Creación del subscriber para la imagen de la cámara
global camera_subs;
camera_subs = rossubscriber('/camera1/image/compressed');

% Creación del modelo del robot Phantom con SerialLink. Este modelo es
% utilizado para comprobar la cinemática inversa y para graficar el robot.
syms real;

% Valores de las longitudes
l1 = 0.137;
l2 = 0.105;
l3 = 0.105;
l4 = 0.110;

% Tabla de parámetros: [alpha a d theta]
params = [[    0   0  0  0];
          [ pi/2   0  0  0];
          [    0  l2  0  0];
          [    0  l3  0  0];
 ];
params = fliplr(params);  % Voltea elementos: [alpha a d theta] -> [theta d a alpha]
params = [params, [0 0 0 0]'];  % Añade sigmas: RPPR
params = [params, [0 pi/2 0 0]'];  % Añade offsets

% Link: [theta d a alpha sigma mdh offset [qmin qmax]]
L(1) = Link(params(1,1:6), 'modified');
L(2) = Link(params(2,1:6), 'modified');
L(3) = Link(params(3,1:6), 'modified');
L(4) = Link(params(4,1:6), 'modified');

% Límites de las articulaciones
L(1).qlim = deg2rad(150)*[-1 1];
L(2).qlim = deg2rad(150)*[-1 1];
L(3).qlim = deg2rad(150)*[-1 1];
L(4).qlim = deg2rad(150)*[-1 1];

% Workspace
ws = [-0.6 0.6 -0.6 0.6 -l1 0.6];
plot_options = {'workspace',ws};

% Contruye el robot
global Robot;
Robot = SerialLink(L, 'name', 'PhantomX', 'plotopt', plot_options);

% MTH del tcp
Robot.tool = [[0 0 1 0.110]; [0 -1 0 0]; [1 0 0 0]; [0 0 0 1]];

% Variables globales
global operation_mode
operation_mode = "automatic";
global task_status;
task_status = 'stopped';
global actual_block;
actual_block = 1;
global n_blocks;
n_blocks = 6;
global actual_pose;
actual_pose = [0,0,0,0];  %[x,y,z,delta]
global min_joints;
min_joints = [-deg2rad(150), -deg2rad(150), -deg2rad(150), -deg2rad(150), 0.0];
global max_joints;
max_joints = [deg2rad(150), deg2rad(150), deg2rad(150), deg2rad(150), 0.030];

% Inicialización de las matrices de puntos de las zonas de entrada y salida
global input_points;   %[x, y, z, t]
global output1_points;
global output2_points;
global output3_points;
global ocuppied_outputs;
global n_points_output;
input_points = [[-0.106 -0.13 0.002];
                [   0.0 -0.13 0.002];
                [ 0.106 -0.13 0.002];
                [-0.106 -0.17 0.002];
                [   0.0 -0.17 0.002];
                [ 0.106 -0.17 0.002]];
output1_points = [[-0.135 0.13 0.002];
                  [-0.085 0.13 0.002];
                  [-0.110 0.17 0.002]];
output2_points = [[-0.025 0.13 0.002];
                  [ 0.025 0.13 0.002];
                  [-0.000 0.17 0.002]];
output3_points = [[ 0.085 0.13 0.002];
                  [ 0.135 0.13 0.002];
                  [ 0.110 0.17 0.002]];
ocuppied_outputs = [0,0,0];
n_points_output = 3;

% Inicia la interfaz gráfica y crea el objeto para poder modificarla
global H;
global handles;
H = Control_GUI;
handles = guidata(H);
set_automatic_mode(handles);

% Timer para actualizar los campos de la interfaz
handles.t1 = timer('StartDelay', 0, 'Period', 0.25, 'ExecutionMode', 'fixedRate');
handles.t1.TimerFcn = @(~,~)update_gui_fields;
start(handles.t1);

% Timer para publicar los mensajes del joypad
handles.t2 = timer('StartDelay', 0, 'Period', 0.1, 'ExecutionMode', 'fixedRate');
handles.t2.TimerFcn = @(~,~)joy2joints_msgs;
start(handles.t2);

% Timer para actualizar la imagen de la cámara
handles.t3 = timer('StartDelay', 0, 'Period', 0.1, 'ExecutionMode', 'fixedRate');
handles.t3.TimerFcn = @(~,~)update_camera_image;
start(handles.t3);

global default_delay;
default_delay = 5;

