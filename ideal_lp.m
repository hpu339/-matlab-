function hd=ideal_lp(wc,N) %��0��N-1֮�������������Ӧ
%wc=��ֹƵ�ʣ����ȣ�
%N=�����˲����ĳ���
tao=(N-1)/2;
n=[0:(N-1)];
m=n-tao+eps; %��һ��С���Ա���0������
hd=sin(wc*m)./(pi*m);