clear
FileName = 'E:\mixed.wav';
[x,Fs]=audioread(FileName);
%sound(x,Fs)    %原音频
X=fft(x);
T=1/Fs;                              %采样间隔
n=length(x);                         %采样点
K=0:n-1;
t=K*T;
f=K/n*Fs;                            %频域横坐标

figure %窗口1
subplot(221);plot(t,x)
title('原信号时域谱'),xlabel('t/s'),ylabel('幅度')
grid

XF = abs(X);
XF = XF(1:length(XF)/2);
df_a = Fs/length(X);  %计算谱线间隔
Xff = 0:df_a:(Fs/2-df_a); %频谱范围，减去前半段

subplot(222);plot(Xff,XF)
title('原信号频谱'),xlabel('f/Hz'),ylabel('幅度')
axis([0 6000 0 1000]);

%   滤波器参数设置部分
fp = 3700;
fs = 4000;
wp=2*pi*fp/Fs;  %模拟角频率转数字角频率
ws=2*pi*fs/Fs;
Rp=1;
As=30;
[N,wc]=buttord(wp,ws,Rp,As,'s');    %巴特沃斯滤波器
[B,A]=butter(N,wc,'s'); %返回具有归一化截止频率的四阶低通数字巴特沃斯滤波器的传递函数系数
[Bz,Az]=bilinear(B,A,0.89); %双线性变换目的将模拟滤波器数字化(课本6.7)

[H,W]=freqz(Bz,Az);
figure(2),plot(W,abs(H));
title('低通滤波器幅频响应示意图');xlabel('f/10kHz'),ylabel('|H(e^j^w)|');
y=filter(Bz,Az,x);                 %滤波
sound(y,Fs)         %滤波后音频
figure(1)
Y=fft(y);
subplot(223);plot(t,y)
title('滤波后时域谱'),xlabel('t/s'),ylabel('幅度')

YF = abs(Y);
YF = YF(1:length(YF)/2);
df_b = Fs/length(X);  %计算谱线间隔
Yff = 0:df_b:(Fs/2-df_b); %频谱范围，减去前半段
subplot(224);plot(Yff,YF)
title('滤波后频谱'),xlabel('f/Hz'),ylabel('幅度')
axis([0 6000 0 1000]);