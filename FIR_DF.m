FileName = 'E:\Study materials__file\DSP\DSP_Library\readio\河南理工大学.wav';
[x,Fs]=audioread(FileName);
FFs = 8000;
fp = 7400;
fs = 7700;
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

wp=2*pi*fp/FFs;ws=2*pi*fs/FFs;
deltaw=ws-wp;

N0=ceil(6.6*pi/deltaw);  % ceil返回大于或者等于指定表达式的最小整数
N = N0+mod(N0+1,2) %为实现FIR类型1偶对称滤波器，应确保N为奇数, mod是两个数值表达式作除法运算后的余数
windows=(hamming(N))';
wc=(ws+wp)/2/pi;%中心频率
hd=ideal_lp(wc,N);
b=hd.*windows;    %windows为海明窗，时域乘积相当于截断
c = conv(b,x);  % 卷积完后注意长度会发生变化
YY = fft(c);
YYf = abs(YY);
YF_end = YYf(1:length(YYf)/2);
tt = (0:length(c)-1)/FFs;
dff = Fs/length(YY);  %计算谱线间隔
f_end = 0:dff:(Fs/2-dff); %频谱范围，减去前半段
%     axes(handles.axes9);
figure(1)
plot(tt,c);
title('滤波后的时域谱');
xlabel('时间');ylabel('幅度');
grid
%     axes(handles.axes10);
figure(2)
plot(f_end,YF_end);
title('滤波后的频谱');
xlabel('f/Hz');ylabel('幅度');
axis([0 10000 0 1000]);
grid
    
% % axes(handles.addaxes1);
% figure
% plot(t,x);
% title('加噪信号的时域谱')
% xlabel('t/s');
% axis([0 3 -1.5 1.5]);
% grid
% 
% X = fft(x);
% XF = abs(X);
% XF = XF(1:length(XF)/2);
% df_a = Fs/length(X);  %计算谱线间隔
% Xff = 0:df_a:(Fs/2-df_a); %频谱范围，减去前半段
% % axes(handles.addaxes2);
% figure
% plot(Xff,XF)
% title('加噪信号频谱'),
% xlabel('f/Hz'),ylabel('幅度')
% axis([0 10000 0 1000]);
% grid
% % x_sound = x;    %传递