function varargout = CII(varargin)
% CII MATLAB code for CII.fig
%      CII, by itself, creates a new CII or raises the existing
%      singleton*.
%
%      H = CII returns the handle to a new CII or the handle to
%      the existing singleton*.
%
%      CII('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CII.M with the given input arguments.
%
%      CII('Property','Value',...) creates a new CII or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CII_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CII_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CII

% Last Modified by GUIDE v2.5 24-Nov-2018 18:11:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @CII_OpeningFcn, ...
    'gui_OutputFcn',  @CII_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

global CC
my_s=struct('frame_rate',10,'image_format','Y16 (2448x2048)','strobe_control','Enable','log_mode','disk&memory');

CC=struct('my_settings',my_s);

CC.dev_info=imaqhwinfo('tisimaq_r2013_64',1);
CC.vid=videoinput('tisimaq_r2013_64',1,'Y16 (2448x2048)');
CC.src=getselectedsource(CC.vid);

% For synchnization data log

CC.syc.s = daq.createSession('ni');
CC.syc.s.IsContinuous = true;
CC.syc.s.Rate=1000;
addAnalogInputChannel(CC.syc.s,'Dev1','ai0','Voltage');
addAnalogInputChannel(CC.syc.s,'Dev1','ai1','Voltage');




if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT
end

% --- Executes just before CII is made visible.
function CII_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CII (see VARARGIN)

[y,m,d]=ymd(datetime);
wp=['F:\' num2str(y) num2str(m) num2str(d) '\1'];
mkdir(wp);
cd(wp);
fp=pwd;
global CC
CC.my_settings.filepath=fp;
set(handles.Filepath,'string',fp);
guidata(hObject, handles);
% Choose default command line output for CII
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CII wait for user response (see UIRESUME)
% uiwait(handles.figure1);

end
% --- Outputs from this function are returned to the command line.
function varargout = CII_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
end

% --- Executes on selection change in supported_formats.
function supported_formats_Callback(hObject, eventdata, handles)
% hObject    handle to supported_formats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns supported_formats contents as cell array
%        contents{get(hObject,'Value')} returns selected item from supported_formats
end

% --- Executes during object creation, after setting all properties.
function supported_formats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to supported_formats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes during object creation, after setting all properties.
function img1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to img1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate img1
end

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes during object creation, after setting all properties.
function text7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end


function Filepath_Callback(hObject, eventdata, handles)
% hObject    handle to Filepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Filepath as text
%        str2double(get(hObject,'String')) returns contents of Filepath as a double
end

% --- Executes during object creation, after setting all properties.
function Filepath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Filepath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

end
% --- Executes on button press in uigetf.
function uigetf_Callback(hObject, eventdata, handles)
% hObject    handle to uigetf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fp=uigetdir('F:\','Choose a directory to save data.');
global CC
CC.my_settings.filepath=fp;
set(handles.Filepath,'string',fp)
guidata(hObject, handles);
end

% --- Executes on selection change in framerate.
function framerate_Callback(hObject, eventdata, handles)
% hObject    handle to framerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns framerate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from framerate
end

% --- Executes during object creation, after setting all properties.
function framerate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to framerate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in expomode.
function expomode_Callback(hObject, eventdata, handles)
% hObject    handle to expomode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns expomode contents as cell array
%        contents{get(hObject,'Value')} returns selected item from expomode
end

% --- Executes during object creation, after setting all properties.
function expomode_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expomode (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on selection change in imageformat.
function imageformat_Callback(hObject, eventdata, handles)
% hObject    handle to imageformat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns imageformat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from imageformat
end


% --- Executes during object creation, after setting all properties.
function imageformat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to imageformat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global CC
% set(hObject,'String',CC.dev_info.SupportedFormats');

hObject.String=CC.dev_info.SupportedFormats';
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in startprevious.
function startprevious_Callback(hObject, eventdata, handles)
% hObject    handle to startprevious (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CC

axes(handles.img1);

CC.hImage=image(zeros(367,501),'Parent',handles.img1);
if strcmp(get(hObject,'String'),'Preview')
    
    preview(CC.vid,CC.hImage);
    set(hObject,'String','Stop prev');
    %     guidata(hObject, handles);
elseif strcmp(get(hObject,'String'),'Stop prev')
    stoppreview(CC.vid);
    set(hObject,'String','Preview');
    set(handles.img1,'XTick',[],'YTick',[]);
    %     guidata(hObject, handles);
end
end


% --- Executes on button press in startacquire.
function startacquire_Callback(hObject, eventdata, handles)
% hObject    handle to startacquire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CC

% Get current user settings from GUI
CC.my_settings.image_format=popvalue(handles.imageformat);
CC.my_settings.frame_rate=popvalue(handles.framerate);
CC.my_settings.expo_mode=popvalue(handles.expomode);
CC.my_settings.strobe_control=popvalue(handles.strobecontrol);

% Update current settings to Vid

if isequal(CC.my_settings.image_format,'Y16 (2448x2048)')
    CC.src.Exposure=1/11;
    CC.src.ExposureAuto=CC.my_settings.expo_mode;
    CC.src.FrameRate=10;
    %     CC.vid.LoggingMode = CC.my_settings.log_mode;
else
    CC.vid=videoinput('tisimaq_r2013_64',1,CC.my_settings.image_format);
    CC.src=getselectedsource(CC.vid);
    CC.src.Exposure=1/11;
    CC.src.ExposureAuto=CC.my_settings.expo_mode;
    CC.src.FrameRate=10;
    %     CC.vid.LoggingMode = CC.my_settings.log_mode;
end

filename1=handles.trialname.String;
filename2=handles.trialno.String;
pathname=handles.Filepath.String;
savename=strcat(pathname,'\',filename1,filename2);

CC.my_settings.savepath=savename;

% Initialize the syc data log
CC.syc.s.UserData.Data = [];
CC.syc.s.UserData.TimeStamps = [];
CC.syc.s.UserData.StartTime = [];
lh1 = addlistener(CC.syc.s, 'DataAvailable', @recordData);
lh2 = addlistener(CC.syc.s, 'ErrorOccurred', @(~,eventData) disp(getReport(eventData.Error)));


% Save the image as built-in data logger
% diskLogger = VideoWriter(savename, 'Motion JPEG 2000');
% diskLogger.MJ2BitDepth = 16;
% diskLogger.LosslessCompression = true;
% CC.vid.DiskLogger = diskLogger;
CC.vid.TriggerRepeat=Inf;
CC.vid.FramesPerTrigger = Inf;
CC.vid.FramesAcquiredFcnCount = 40;
CC.vid.FramesAcquiredFcn = {@basic_saveImageData, savename};

if strcmp('Enable',CC.my_settings.strobe_control)
    handles.status.String='Running';
    CC.src.StrobePolarity='high';
    startBackground(CC.syc.s);
    pause(2);
    
    hImg = preview(CC.vid);
    hFig = ancestor(hImg, 'figure');
    CC.src.Strobe='Enable';
    start(CC.vid);
    
    uiwait(hFig);
    CC.src.Strobe='Disable';
    stop(CC.vid);
    delete(CC.vid);
    stop(CC.syc.s);
    
    ai0 = CC.syc.s.UserData.Data(:,1);
    ai1 = CC.syc.s.UserData.Data(:,2);
    DAQ = timetable(seconds(CC.syc.s.UserData.TimeStamps),ai0,ai1);
    fullsycname=[savename '.mat'];
    save(fullsycname, 'DAQ');
    
    delete(lh1)
    delete(lh2)
    clear lh1 lh2
        
    newno=str2double(handles.trialno.String)+1;
    handles.trialno.String=num2str(newno);
    handles.status.String='Idle';
    exp1=['mkdir ' pathname(1:end-1) ' ' num2str(newno)]; % Automatically change to next dirctory
    eval(exp1);
    exp2=['cd ' pathname(1:end-1) num2str(newno)];
    eval(exp2);
    CC.my_settings.filepath=pwd;
    set(handles.Filepath,'string',pwd)
    guidata(hObject,handles);
else
    CC.src.Strobe='Disable';
    start(CC.vid);
end


end

% --- Executes on button press in stopacquire.
function stopacquire_Callback(hObject, eventdata, handles)
% hObject    handle to stopacquire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.status.String='Idle';
global CC
CC.src.Strobe='Disable';
stop(CC.vid);
delete(CC.vid);
stop(CC.syc.s);


save

newno=str2double(handles.trialno.String)+1;
handles.trialno.String=num2str(newno);
guidata(hObject,handles);

end

% --- Executes on selection change in strobecontrol.
function strobecontrol_Callback(hObject, eventdata, handles)
% hObject    handle to strobecontrol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns strobecontrol contents as cell array
%        contents{get(hObject,'Value')} returns selected item from strobecontrol
end

% --- Executes during object creation, after setting all properties.
function strobecontrol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to strobecontrol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% --- Executes on button press in updatesetting.
function updatesetting_Callback(hObject, eventdata, handles)
% hObject    handle to updatesetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get user setting from GUI and save in CC struct
% global CC
%
% CC.my_settings.image_format=popvalue(handles.imageformat);
% CC.my_settings.frame_rate=popvalue(handles.framerate);
% CC.my_settings.expo_mode=popvalue(handles.expomode);
% CC.my_settings.strobe_control=popvalue(handles.strobecontrol);
%
% % Update the user settings to camera
% if isequal(CC.my_settings.image_format,'Y16 (1920x1080)')
%     CC.src.Exposure=1/str2double(CC.my_settings.frame_rate);
%     CC.src.ExposureAuto=CC.my_settings.expo_mode;
%     CC.vid.LoggingMode = CC.my_settings.log_mode;
% else
%     CC.vid=videoinput('tisimaq_r2013',1,CC.my_settings.image_format);
%     CC.src=getselectedsource(CC.vid);
%     CC.src.Exposure=1/str2double(CC.my_settings.frame_rate);
%     CC.src.ExposureAuto=CC.my_settings.expo_mode;
%     CC.vid.LoggingMode = CC.my_settings.log_mode;
% end
end

% --- Executes on button press in resetting.
function resetting_Callback(hObject, eventdata, handles)
% hObject    handle to resetting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.imageformat,'Value',50);
set(handles.autogain,'Value',1);
set(handles.framerate,'Value',1);
set(handles.expomode,'Value',1);
set(handles.strobecontrol,'Value',1);
guidata(hObject,handles);
end

function popout=popvalue(pophandle)
str=get(pophandle,'String');
val=get(pophandle,'Value');
popout=str(val);
popout=cell2mat(popout);
end



function trialname_Callback(hObject, eventdata, handles)
% hObject    handle to trialname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trialname as text
%        str2double(get(hObject,'String')) returns contents of trialname as a double

end

% --- Executes during object creation, after setting all properties.
function trialname_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trialname (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


function trialno_Callback(hObject, eventdata, handles)
% hObject    handle to trialno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trialno as text
%        str2double(get(hObject,'String')) returns contents of trialno as a double
end

% --- Executes during object creation, after setting all properties.
function trialno_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trialno (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end


% --- Executes during object creation, after setting all properties.
function stopprevious_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopprevious (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end


% --- Executes during object creation, after setting all properties.
function startprevious_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startprevious (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end


% --- Executes during object creation, after setting all properties.
function startacquire_CreateFcn(hObject, eventdata, handles)
% hObject    handle to startacquire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end


% --- Executes during object creation, after setting all properties.
function stopacquire_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stopacquire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end


% --- Executes during object creation, after setting all properties.
function uigetf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uigetf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
end



function gainvalue_Callback(hObject, eventdata, handles)
% hObject    handle to gainvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of gainvalue as text
%        str2double(get(hObject,'String')) returns contents of gainvalue as a double
end

% --- Executes during object creation, after setting all properties.
function gainvalue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gainvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global CC

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

hObject.String=CC.src.Gain;

end


% --- Executes on selection change in autogain.
function autogain_Callback(hObject, eventdata, handles)
% hObject    handle to autogain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns autogain contents as cell array
%        contents{get(hObject,'Value')} returns selected item from autogain
contents = cellstr(get(hObject,'String'));

if strcmp(contents{get(hObject,'Value')},'on')
    set(handles.gainvalue)
    
end
end

% --- Executes during object creation, after setting all properties.
function autogain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to autogain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end



% Function for data log
function recordData(src, eventData)
% RECORDDATA(SRC, EVENTDATA) records the acquired data, timestamps and
% trigger time. You can also use this function for plotting the
% acquired data live.

% SRC       - Source object      i.e. Session object
% EVENTDATA - Event data object  i.e. 'DataAvailable' event data object

% Record the data and timestamps to the UserData property of the session.
src.UserData.Data = [src.UserData.Data; eventData.Data];
src.UserData.TimeStamps = [src.UserData.TimeStamps; eventData.TimeStamps];

% Record the starttime from the first execution of this callback function.
if isempty(src.UserData.StartTime)
    src.UserData.StartTime = eventData.TriggerTime;
end

% Uncomment the following lines to enable live plotting.
% plot(eventData.TimeStamps, eventData.Data)
% xlabel('Time (s)')
% ylabel('Amplitude (V)')
% legend('ai0','ai1')
end


% --- Executes on button press in rollback.
function rollback_Callback(hObject, eventdata, handles)
% hObject    handle to rollback (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cwd=get(handles.Filepath,'string');
newno=str2num(get(handles.trialno,'String'));
cd([cwd(1:end-1) num2str(newno-1)]);
delete *.*
handles.trialno.String=num2str(newno-1);
set(handles.Filepath,'string',pwd)
end
