function varargout = Control_GUI(varargin)
% CONTROL_GUI MATLAB code for Control_GUI.fig
%      CONTROL_GUI, by itself, creates a new CONTROL_GUI or raises the existing
%      singleton*.
%
%      H = CONTROL_GUI returns the handle to a new CONTROL_GUI or the handle to
%      the existing singleton*.
%
%      CONTROL_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTROL_GUI.M with the given input arguments.
%
%      CONTROL_GUI('Property','Value',...) creates a new CONTROL_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Control_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Control_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Control_GUI

% Last Modified by GUIDE v2.5 15-Jun-2020 17:06:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Control_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @Control_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Control_GUI is made visible.
function Control_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Control_GUI (see VARARGIN)

% Choose default command line output for Control_GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Control_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Control_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in manual_radiobutton.
function manual_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to manual_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of manual_radiobutton


% --- Executes on button press in automatic_radiobutton.
function automatic_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to automatic_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of automatic_radiobutton



function exit_zone_field_Callback(hObject, eventdata, handles)
% hObject    handle to exit_zone_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exit_zone_field as text
%        str2double(get(hObject,'String')) returns contents of exit_zone_field as a double


% --- Executes during object creation, after setting all properties.
function exit_zone_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exit_zone_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in send2home_button.
function send2home_button_Callback(hObject, eventdata, handles)
% hObject    handle to send2home_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
send2home();


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: delete(hObject) closes the figure
stop_timers();
delete(hObject);


% --- Executes when selected object is changed in mode_radiobuttongoup.
function mode_radiobuttongoup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in mode_radiobuttongoup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
manual_radiobutton = get(handles.manual_radiobutton, 'Value');
automatic_radiobutton = get(handles.automatic_radiobutton, 'Value');
if manual_radiobutton
    set_manual_mode(handles);
end
if automatic_radiobutton
    set_automatic_mode(handles);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over manual_radiobutton.
function manual_radiobutton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to manual_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over automatic_radiobutton.
function automatic_radiobutton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to automatic_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in start_task_button.
function start_task_button_Callback(hObject, eventdata, handles)
% hObject    handle to start_task_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
start_task();


% --- Executes on button press in stop_task_button.
function stop_task_button_Callback(hObject, eventdata, handles)
% hObject    handle to stop_task_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
stop_task();
