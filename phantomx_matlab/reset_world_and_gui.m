function reset_world_and_gui()

global task_status;
task_status = 'stopped';

global actual_block;
actual_block = 1;

global n_blocks;
n_blocks = 6;

global ocuppied_outputs;
ocuppied_outputs = [0,0,0];

client = rossvcclient('/gazebo/reset_world');
call(client);
end