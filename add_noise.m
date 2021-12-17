FileName = 'E:\Study materials__file\DSP\DSP_Library\readio\��������ѧ.wav';
[x,Fs]=audioread(FileName);
noise1_f = 8000;
noise2_f = 9000;
T=1/Fs;                              %�������
n=length(x);                         %������
K=0:n-1;
%t=0:1/Fs:(length(x)-1)/Fs
t=K*T;
f=K/n*Fs
A1 = 0.04;
A2 = 0.02;
tt=0:1/Fs:(length(x)-1)/Fs;%�����������źŵĵ�����������ԭʼ�ź���ͬ;
noise1 = A1*cos(2*pi*noise1_f*tt);
noise2 = A2*cos(2*pi*noise2_f*tt);
x = x + noise1' + noise2';
% axes(handles.addaxes1);
figure
plot(t,x);
title('�����źŵ�ʱ����')
xlabel('t/s');
axis([0 3 -1.5 1.5]);
grid

X = fft(x);
XF = abs(X);
XF = XF(1:length(XF)/2);
df_a = Fs/length(X);  %�������߼��
Xff = 0:df_a:(Fs/2-df_a); %Ƶ�׷�Χ����ȥǰ���
% axes(handles.addaxes2);
figure
plot(Xff,XF)
title('�����ź�Ƶ��'),
xlabel('f/Hz'),ylabel('����')
axis([0 10000 0 1000]);
grid
% x_sound = x;    %����