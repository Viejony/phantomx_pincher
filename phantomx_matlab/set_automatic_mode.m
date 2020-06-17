function set_automatic_mode(handles)
global operation_mode;
operation_mode = 'automatic';
set(handles.mode_field, 'BackgroundColor', [1.0 0.78125 0.0]);
set(handles.mode_field, 'String', 'Automático');
set(handles.send2home_button, 'Enable', 'on');
set(handles.start_task_button, 'Enable', 'on');
set(handles.stop_task_button, 'Enable', 'on');
end