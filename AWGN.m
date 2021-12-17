FileName = 'E:\Study materials__file\DSP\DSP_Library\readio\河南理工大学.wav';
[x,Fs]=audioread(FileName);
x = awgn(x,20)  %加入高斯噪声，awgn(x,snr),snr为信噪比
%上面和下面的一样
%gao = wgn(60642,1,-20);
%x = x + gao
yy = flipdim(x, 1)  %倒放
X=fft(x);
T=1/Fs;                              %采样间隔
n=length(x);                         %采样点
K=0:n-1;
%t=0:1/Fs:(length(x)-1)/Fs
t=K*T;
f=K/n*Fs;                            %频域横坐标


figure %窗口1
%subplot(221);
% plot(t,x)
% title('AWGN信号时域谱'),xlabel('t/s'),ylabel('幅度')
% grid
% sound(x,Fs);

XF = abs(X);
XF = XF(1:length(XF)/2);
df_a = Fs/length(X);  %计算谱线间隔
Xff = 0:df_a:(Fs/2-df_a); %频谱范围，减去前半段

%subplot(222);
plot(Xff,XF)
title('AWGN信号频谱'),xlabel('f/Hz'),ylabel('幅度')
axis([0 10000 0 500]);
grid