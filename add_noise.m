FileName = 'E:\Study materials__file\DSP\DSP_Library\readio\河南理工大学.wav';
[x,Fs]=audioread(FileName);
noise1_f = 8000;
noise2_f = 9000;
T=1/Fs;                              %采样间隔
n=length(x);                         %采样点
K=0:n-1;
%t=0:1/Fs:(length(x)-1)/Fs
t=K*T;
f=K/n*Fs
A1 = 0.04;
A2 = 0.02;
tt=0:1/Fs:(length(x)-1)/Fs;%将所加噪声信号的点数调整到与原始信号相同;
noise1 = A1*cos(2*pi*noise1_f*tt);
noise2 = A2*cos(2*pi*noise2_f*tt);
x = x + noise1' + noise2';
% axes(handles.addaxes1);
figure
plot(t,x);
title('加噪信号的时域谱')
xlabel('t/s');
axis([0 3 -1.5 1.5]);
grid

X = fft(x);
XF = abs(X);
XF = XF(1:length(XF)/2);
df_a = Fs/length(X);  %计算谱线间隔
Xff = 0:df_a:(Fs/2-df_a); %频谱范围，减去前半段
% axes(handles.addaxes2);
figure
plot(Xff,XF)
title('加噪信号频谱'),
xlabel('f/Hz'),ylabel('幅度')
axis([0 10000 0 1000]);
grid
% x_sound = x;    %传递