function send2home()
global handles;
global default_delay;
set_running_mode_GUI(handles);
q = [0 0 0 0 0.03];
sendROSmsg(q, default_delay/2, 0);
pause(default_delay);
set_waiting_mode_GUI(handles);
end