function set_manual_mode(handles)
global operation_mode;
operation_mode = 'manual';
set(handles.mode_field, 'BackgroundColor', [0.6 0.07 0.64]);
set(handles.mode_field, 'String', 'Manual');
set(handles.send2home_button, 'Enable', 'off');
set(handles.start_task_button, 'Enable', 'off');
set(handles.stop_task_button, 'Enable', 'off');

end