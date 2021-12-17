clear
FileName = 'E:\Study materials__file\DSP\DSP_Library\readio\��������ѧ.wav';
[x,Fs]=audioread(FileName);
%sound(x,Fs)    %ԭ��Ƶ
X=fft(x);
T=1/Fs;                              %�������
n=length(x);                         %������
K=0:n-1;
t=K*T;
f=K/n*Fs;                            %Ƶ�������

XF = abs(X);
XF = XF(1:length(XF)/2);
df_a = Fs/length(X);  %�������߼��
Xff = 0:df_a:(Fs/2-df_a); %Ƶ�׷�Χ����ȥǰ���

fp = 8000;
fs = 8900;
noise1_f = 8000;
noise2_f = 9000;
A1 = 0.04;
A2 = 0.02;
tt=0:1/Fs:(length(x)-1)/Fs;%�����������źŵĵ�����������ԭʼ�ź���ͬ;
noise1 = A1*cos(2*pi*noise1_f*tt);
noise2 = A2*cos(2*pi*noise2_f*tt);
x = x + noise1' + noise2';

%   �˲����������ò���
% fp = 3700;
% fs = 4000;
wp=2*pi*fp/Fs;  %ģ���Ƶ��ת���ֽ�Ƶ��
ws=2*pi*fs/Fs;
Rp=1;
As=30;
[N,wc]=buttord(wp,ws,Rp,As,'s');    %������˹�˲���
[B,A]=butter(N,wc,'s'); %���ؾ��й�һ����ֹƵ�ʵ��Ľ׵�ͨ���ְ�����˹�˲����Ĵ��ݺ���ϵ��
[Bz,Az]=bilinear(B,A,0.89); %˫���Ա任Ŀ�Ľ�ģ���˲������ֻ�(�α�6.7)

[H,W]=freqz(Bz,Az);
figure(2),plot(W*4+0.1,abs(H));
title('��ͨ�˲�����Ƶ��Ӧʾ��ͼ');xlabel('f/kHz'),ylabel('|H(e^j^w)|');
y=filter(Bz,Az,x);                 %�˲�
sound(y,Fs)         %�˲�����Ƶ
figure(1)
Y=fft(y);
plot(t,y)
title('�˲���ʱ����'),xlabel('t/s'),ylabel('����')
grid

YF = abs(Y);
YF = YF(1:length(YF)/2);
df_b = Fs/length(X);  %�������߼��
Yff = 0:df_b:(Fs/2-df_b); %Ƶ�׷�Χ����ȥǰ���
figure(3)
plot(Yff,YF)
title('�˲���Ƶ��'),xlabel('f/Hz'),ylabel('����')
axis([0 10000 0 1000]);
grid