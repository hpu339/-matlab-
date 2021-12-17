FileName = 'E:\Study materials__file\DSP\DSP_Library\readio\��������ѧ.wav';
[x,Fs]=audioread(FileName);
FFs = 8000;
fp = 7400;
fs = 7700;
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

wp=2*pi*fp/FFs;ws=2*pi*fs/FFs;
deltaw=ws-wp;

N0=ceil(6.6*pi/deltaw);  % ceil���ش��ڻ��ߵ���ָ�����ʽ����С����
N = N0+mod(N0+1,2) %Ϊʵ��FIR����1ż�Գ��˲�����Ӧȷ��NΪ����, mod��������ֵ���ʽ����������������
windows=(hamming(N))';
wc=(ws+wp)/2/pi;%����Ƶ��
hd=ideal_lp(wc,N);
b=hd.*windows;    %windowsΪ��������ʱ��˻��൱�ڽض�
c = conv(b,x);  % ������ע�ⳤ�Ȼᷢ���仯
YY = fft(c);
YYf = abs(YY);
YF_end = YYf(1:length(YYf)/2);
tt = (0:length(c)-1)/FFs;
dff = Fs/length(YY);  %�������߼��
f_end = 0:dff:(Fs/2-dff); %Ƶ�׷�Χ����ȥǰ���
%     axes(handles.axes9);
figure(1)
plot(tt,c);
title('�˲����ʱ����');
xlabel('ʱ��');ylabel('����');
grid
%     axes(handles.axes10);
figure(2)
plot(f_end,YF_end);
title('�˲����Ƶ��');
xlabel('f/Hz');ylabel('����');
axis([0 10000 0 1000]);
grid
    
% % axes(handles.addaxes1);
% figure
% plot(t,x);
% title('�����źŵ�ʱ����')
% xlabel('t/s');
% axis([0 3 -1.5 1.5]);
% grid
% 
% X = fft(x);
% XF = abs(X);
% XF = XF(1:length(XF)/2);
% df_a = Fs/length(X);  %�������߼��
% Xff = 0:df_a:(Fs/2-df_a); %Ƶ�׷�Χ����ȥǰ���
% % axes(handles.addaxes2);
% figure
% plot(Xff,XF)
% title('�����ź�Ƶ��'),
% xlabel('f/Hz'),ylabel('����')
% axis([0 10000 0 1000]);
% grid
% % x_sound = x;    %����