FileName = 'E:\Study materials__file\DSP\DSP_Library\readio\��������ѧ.wav';
[x,Fs]=audioread(FileName);
x = awgn(x,20)  %�����˹������awgn(x,snr),snrΪ�����
%����������һ��
%gao = wgn(60642,1,-20);
%x = x + gao
yy = flipdim(x, 1)  %����
X=fft(x);
T=1/Fs;                              %�������
n=length(x);                         %������
K=0:n-1;
%t=0:1/Fs:(length(x)-1)/Fs
t=K*T;
f=K/n*Fs;                            %Ƶ�������


figure %����1
%subplot(221);
% plot(t,x)
% title('AWGN�ź�ʱ����'),xlabel('t/s'),ylabel('����')
% grid
% sound(x,Fs);

XF = abs(X);
XF = XF(1:length(XF)/2);
df_a = Fs/length(X);  %�������߼��
Xff = 0:df_a:(Fs/2-df_a); %Ƶ�׷�Χ����ȥǰ���

%subplot(222);
plot(Xff,XF)
title('AWGN�ź�Ƶ��'),xlabel('f/Hz'),ylabel('����')
axis([0 10000 0 500]);
grid