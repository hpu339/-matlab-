function varargout = untitled2(varargin)
% UNTITLED2 MATLAB code for untitled2.fig
%      UNTITLED2, by itself, creates a new UNTITLED2 or raises the existing
%      singleton*.
%
%      H = UNTITLED2 returns the handle to a new UNTITLED2 or the handle to
%      the existing singleton*.
%
%      UNTITLED2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED2.M with the given input arguments.
%
%      UNTITLED2('Property','Value',...) creates a new UNTITLED2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled2

% Last Modified by GUIDE v2.5 12-Dec-2021 15:40:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled2_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled2_OutputFcn, ...
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



% --- Executes just before untitled2 is made visible.
function untitled2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled2 (see VARARGIN)

% Choose default command line output for untitled2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%%%%%%·····原信号·····
% --- Executes on button press in OpenFile.
function OpenFile_Callback(hObject, eventdata, handles)
% hObject    handle to OpenFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename;    %全局变量
global Fs;  % 采样间隔
global n;   % 采样点
global t;   % 时间长度
global x;

[Fnameh,Pnameh]=uigetfile('*.wav', '选择音频文件');%Fnameh显示的文件名称，Pnameh显示的文件路径
filename=[Pnameh,Fnameh];%存储文件的路径及名称
set(handles.pFileName,'String',Fnameh);%将strh的值传递给静态文本
[x,Fs]=audioread(filename);
X=fft(x);
T=1/Fs;        %采样间隔
n=length(x);   %采样点
K=0:n-1;
t=K*T;
f=K/n*Fs;      %频域横坐标
axes(handles.axes1)
plot(t,x);
%title('原信号时域谱')
xlabel('t/s'),ylabel('幅度')
XF = abs(X);
XF = XF(1:length(XF)/2);
df_a = Fs/length(X);  %计算谱线间隔
Xff = 0:df_a:(Fs/2-df_a); %频谱范围，减去前半段
axes(handles.axes2)
plot(Xff,XF)
%title('原信号频谱'),
xlabel('f/Hz'),ylabel('幅度')
axis([0 10000 0 1000]);




function pFileName_Callback(hObject, eventdata, handles)
% hObject    handle to pFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pFileName as text
%        str2double(get(hObject,'String')) returns contents of pFileName as a double


% --- Executes during object creation, after setting all properties.
function pFileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pFileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in sound_1.
function sound_1_Callback(hObject, eventdata, handles)
% hObject    handle to sound_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename;
[x,Fs]=audioread(filename);
sound(x,Fs)

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over sound_1.
function sound_1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to sound_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function noise2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to noise2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noise2_edit as text
%        str2double(get(hObject,'String')) returns contents of noise2_edit as a double


% --- Executes during object creation, after setting all properties.
function noise2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function noise1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to noise1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noise1_edit as text
%        str2double(get(hObject,'String')) returns contents of noise1_edit as a double

% --- Executes during object creation, after setting all properties.
function noise1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_noise1.
function add_noise1_Callback(hObject, eventdata, handles)
% hObject    handle to add_noise1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global noise1_f;
global A1;
noise1_f = get(handles.noise1_edit,'string');
if (noise1_f == "") || (noise1_f == "0")   %判空
    noise1_f = str2double("0");
    A1 = 0;
else
    noise1_f = str2double(noise1_f);    % 转换类型
    fs = noise1_f * 20;  % 采样频率
    N = 1024;
    A1 = 0.02;   %噪声幅度
    i = 0:N-1;
    tt = i/fs
    noise1 = A1*cos(2*pi*noise1_f*tt);
    axes(handles.s1axes1);
    plot(tt,noise1);
    %title('噪声时域谱')
    xlabel('t/s'),ylabel('幅度');
    axis([0 1/noise1_f*5 -A1*1.1 A1*1.1]);
    grid
    noise1_Ft = fft(noise1,N);
    noise1_mag = abs(noise1_Ft);
    f = (0:N-1)*fs/N;
    axes(handles.s1axes2);
    plot(f,noise1_mag);
    %title('噪声频谱')
    xlabel('f/Hz'),ylabel('幅值');
    axis([0 noise1_f*2 0 80])
    grid
end



% --- Executes on button press in add_noise2.
function add_noise2_Callback(hObject, eventdata, handles)
% hObject    handle to add_noise2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global noise2;
global noise2_f;
global A2;
noise2_f = get(handles.noise2_edit,'string');
if (noise2_f == "") || (noise2_f == "0")
    noise2_f = str2double("0");
    A2 = 0;
else
    noise2_f = str2double(noise2_f);    % 转换类型
    fs = noise2_f * 20;  % 采样频率
    N = 1024;
    A2 = 0.07;   %噪声幅度
    i = 0:N-1;
    tt = i/fs
    noise2 = A2*cos(2*pi*noise2_f*tt);
    axes(handles.s2axes1);
    plot(tt,noise2);
    %title('噪声时域谱')
    xlabel('t/s'),ylabel('幅度');
    axis([0 1/noise2_f*5 -A2*1.1 A2*1.1]);
    grid
    noise2_Ft = fft(noise2,N);
    noise2_mag = abs(noise2_Ft);
    f = (0:N-1)*fs/N;
    axes(handles.s2axes2);
    plot(f,noise2_mag);
    %title('噪声频谱')
    xlabel('f/Hz'),ylabel('幅值');
    axis([0 noise2_f*2 0 80])
    grid
end



% --- Executes on button press in add.
function add_Callback(hObject, eventdata, handles)
% hObject    handle to add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global x;
global t;
global A1;
global A2;
global noise1_f;
global noise2_f;
global x_sound;
tt=0:1/Fs:(length(x)-1)/Fs;%将所加噪声信号的点数调整到与原始信号相同;
noise1 = A1*cos(2*pi*noise1_f*tt);
noise2 = A2*cos(2*pi*noise2_f*tt);
x = x + noise1' + noise2';
axes(handles.addaxes1);
plot(t,x);
%title('加噪处理')
xlabel('t/s');
X = fft(x);
XF = abs(X);
XF = XF(1:length(XF)/2);
df_a = Fs/length(X);  %计算谱线间隔
Xff = 0:df_a:(Fs/2-df_a); %频谱范围，减去前半段
axes(handles.addaxes2);
plot(Xff,XF)
%title('原信号频谱'),
xlabel('f/Hz'),ylabel('幅度')
axis([0 10000 0 1000]);
x_sound = x;    %传递

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x_sound;
global Fs;
sound(x_sound,Fs);


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Fs;
global c;
sound(c,Fs);


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'value',1); % 默认为FIR滤波器



% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
set(hObject,'value',1); %默认为矩形窗



function fp_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fp_edit as text
%        str2double(get(hObject,'String')) returns contents of fp_edit as a double


% --- Executes during object creation, after setting all properties.
function fp_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fs_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fs_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fs_edit as text
%        str2double(get(hObject,'String')) returns contents of fs_edit as a double


% --- Executes during object creation, after setting all properties.
function fs_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fs_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok_button.
function ok_button_Callback(hObject, eventdata, handles)
% hObject    handle to ok_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% A = [1.8,6.2,6.6,11,10];    % 第一个数为A(1)
global Fs;
global x;
global t;
global c;   %滤波后的
X = x;
filter = get(handles.popupmenu2, 'value')
window = get(handles.popupmenu3, 'value')
fp = get(handles.fp_edit,'string');
fp = str2double(fp);
fs = get(handles.fs_edit,'string');
fs = str2double(fs);
FFs = 8000;
%1为FIR滤波器
%2为IRI滤波器
if filter == 1
    wp=2*pi*fp/FFs;ws=2*pi*fs/FFs;
    deltaw=ws-wp;
    switch(window)
        case 1
            N0=ceil(1.8*pi/deltaw);  % ceil返回大于或者等于指定表达式的最小整数
            N = N0+mod(N0+1,2) %为实现FIR类型1偶对称滤波器，应确保N为奇数, mod是两个数值表达式作除法运算后的余数
            windows=(boxcar(N))';
        case 2
            N0=ceil(6.2*pi/deltaw);  % ceil返回大于或者等于指定表达式的最小整数
            N = N0+mod(N0+1,2) %为实现FIR类型1偶对称滤波器，应确保N为奇数, mod是两个数值表达式作除法运算后的余数
            windows=(hanning(N))';
        case 3
            N0=ceil(6.6*pi/deltaw);  % ceil返回大于或者等于指定表达式的最小整数
            N = N0+mod(N0+1,2) %为实现FIR类型1偶对称滤波器，应确保N为奇数, mod是两个数值表达式作除法运算后的余数
            windows=(hamming(N))';
        case 4
            N0=ceil(11*pi/deltaw);  % ceil返回大于或者等于指定表达式的最小整数
            N = N0+mod(N0+1,2) %为实现FIR类型1偶对称滤波器，应确保N为奇数, mod是两个数值表达式作除法运算后的余数
            windows=(blackman(N))';
    end
    wc=(ws+wp)/2/pi;%中心频率
    hd=ideal_lp(wc,N);
    b=hd.*windows;    %windows为海明窗，时域乘积相当于截断
    c = conv(b,X);  % 卷积完后注意长度会发生变化
    YY = fft(c);
    YYf = abs(YY);
    YF_end = YYf(1:length(YYf)/2);
    tt = (0:length(c)-1)/FFs;
    dff = Fs/length(YY);  %计算谱线间隔
    f_end = 0:dff:(Fs/2-dff); %频谱范围，减去前半段
    axes(handles.axes9);
    plot(tt,c);
    %title('滤波后的时域谱');
    xlabel('时间');ylabel('幅度');
    axes(handles.axes10);
    plot(f_end,YF_end);
    %title('滤波后的频谱');
    xlabel('f/Hz');ylabel('幅度');
    axis([0 10000 0 1000]);
else
    wp=2*pi*fp/Fs;ws=2*pi*fs/Fs;
    Rp=1;
    As=30;
    [N,wc]=buttord(wp,ws,Rp,As,'s');    %巴特沃斯滤波器
    [B,A]=butter(N,wc,'s'); %返回具有归一化截止频率的四阶低通数字巴特沃斯滤波器的传递函数系数
    [Bz,Az]=bilinear(B,A,0.89); %双线性变换目的将模拟滤波器数字化(课本6.7)
    m = filter_hpu(Bz,Az,X);
    Y = fft(m);
    YF = abs(Y);
    YF_end = YF(1:length(YF)/2);
    df_b = Fs/length(fft(X));  %计算谱线间隔
    f_end = 0:df_b:(Fs/2-df_b); %频谱范围，减去前半段
%     plot(f_end,YF_end);
%     %title('滤波后频谱'),
%     xlabel('f/Hz'),ylabel('幅度')
%     axis([0 10000 0 1000]);
    axes(handles.axes9);
    plot(t,m);
    %title('滤波后的时域谱');
    xlabel('t/s');ylabel('幅度');
    axes(handles.axes10);
    plot(f_end,YF_end);
    %title('滤波后的频谱');
    xlabel('f/Hz');ylabel('幅度');
    axis([0 10000 0 1000]);
    
end
% axes(handles.axes9);
% plot(t,m);
% %title('滤波后的时域谱');
% xlabel('t/s');ylabel('幅度');
% axes(handles.axes10);
% plot(f_end,YF_end);
% %title('滤波后的频谱');
% xlabel('f/Hz');ylabel('幅度');
% axis([0 10000 0 1000]);
    

     
            
      
            
        
