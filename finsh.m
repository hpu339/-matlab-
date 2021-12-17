clear
FileName = 'E:\mixed.wav';
[x,Fs]=audioread(FileName);
%sound(x,Fs)    %ԭ��Ƶ
X=fft(x);
T=1/Fs;                              %�������
n=length(x);                         %������
K=0:n-1;
t=K*T;
f=K/n*Fs;                            %Ƶ�������

figure %����1
subplot(221);plot(t,x)
title('ԭ�ź�ʱ����'),xlabel('t/s'),ylabel('����')
grid

XF = abs(X);
XF = XF(1:length(XF)/2);
df_a = Fs/length(X);  %�������߼��
Xff = 0:df_a:(Fs/2-df_a); %Ƶ�׷�Χ����ȥǰ���

subplot(222);plot(Xff,XF)
title('ԭ�ź�Ƶ��'),xlabel('f/Hz'),ylabel('����')
axis([0 6000 0 1000]);

%   �˲����������ò���
fp = 3700;
fs = 4000;
wp=2*pi*fp/Fs;  %ģ���Ƶ��ת���ֽ�Ƶ��
ws=2*pi*fs/Fs;
Rp=1;
As=30;
[N,wc]=buttord(wp,ws,Rp,As,'s');    %������˹�˲���
[B,A]=butter(N,wc,'s'); %���ؾ��й�һ����ֹƵ�ʵ��Ľ׵�ͨ���ְ�����˹�˲����Ĵ��ݺ���ϵ��
[Bz,Az]=bilinear(B,A,0.89); %˫���Ա任Ŀ�Ľ�ģ���˲������ֻ�(�α�6.7)

[H,W]=freqz(Bz,Az);
figure(2),plot(W,abs(H));
title('��ͨ�˲�����Ƶ��Ӧʾ��ͼ');xlabel('f/10kHz'),ylabel('|H(e^j^w)|');
y=filter(Bz,Az,x);                 %�˲�
sound(y,Fs)         %�˲�����Ƶ
figure(1)
Y=fft(y);
subplot(223);plot(t,y)
title('�˲���ʱ����'),xlabel('t/s'),ylabel('����')

YF = abs(Y);
YF = YF(1:length(YF)/2);
df_b = Fs/length(X);  %�������߼��
Yff = 0:df_b:(Fs/2-df_b); %Ƶ�׷�Χ����ȥǰ���
subplot(224);plot(Yff,YF)
title('�˲���Ƶ��'),xlabel('f/Hz'),ylabel('����')
axis([0 6000 0 1000]);