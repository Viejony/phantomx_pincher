function stop_task()
global task_status;
global handles;
task_status = 'stopped';

q = get_actual_joints_values();
q(5) = q(5)*2;
sendROSmsg(q, 0, 100000);
pause(0.1);
set_waiting_mode_GUI(handles);

end