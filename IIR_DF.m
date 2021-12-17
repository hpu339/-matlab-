clear
FileName = 'E:\Study materials__file\DSP\DSP_Library\readio\河南理工大学.wav';
[x,Fs]=audioread(FileName);
%sound(x,Fs)    %原音频
X=fft(x);
T=1/Fs;                              %采样间隔
n=length(x);                         %采样点
K=0:n-1;
t=K*T;
f=K/n*Fs;                            %频域横坐标

XF = abs(X);
XF = XF(1:length(XF)/2);
df_a = Fs/length(X);  %计算谱线间隔
Xff = 0:df_a:(Fs/2-df_a); %频谱范围，减去前半段

fp = 8000;
fs = 8900;
noise1_f = 8000;
noise2_f = 9000;
A1 = 0.04;
A2 = 0.02;
tt=0:1/Fs:(length(x)-1)/Fs;%将所加噪声信号的点数调整到与原始信号相同;
noise1 = A1*cos(2*pi*noise1_f*tt);
noise2 = A2*cos(2*pi*noise2_f*tt);
x = x + noise1' + noise2';

%   滤波器参数设置部分
% fp = 3700;
% fs = 4000;
wp=2*pi*fp/Fs;  %模拟角频率转数字角频率
ws=2*pi*fs/Fs;
Rp=1;
As=30;
[N,wc]=buttord(wp,ws,Rp,As,'s');    %巴特沃斯滤波器
[B,A]=butter(N,wc,'s'); %返回具有归一化截止频率的四阶低通数字巴特沃斯滤波器的传递函数系数
[Bz,Az]=bilinear(B,A,0.89); %双线性变换目的将模拟滤波器数字化(课本6.7)

[H,W]=freqz(Bz,Az);
figure(2),plot(W*4+0.1,abs(H));
title('低通滤波器幅频响应示意图');xlabel('f/kHz'),ylabel('|H(e^j^w)|');
y=filter(Bz,Az,x);                 %滤波
sound(y,Fs)         %滤波后音频
figure(1)
Y=fft(y);
plot(t,y)
title('滤波后时域谱'),xlabel('t/s'),ylabel('幅度')
grid

YF = abs(Y);
YF = YF(1:length(YF)/2);
df_b = Fs/length(X);  %计算谱线间隔
Yff = 0:df_b:(Fs/2-df_b); %频谱范围，减去前半段
figure(3)
plot(Yff,YF)
title('滤波后频谱'),xlabel('f/Hz'),ylabel('幅度')
axis([0 10000 0 1000]);
grid