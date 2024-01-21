clc;                    %�������������
clear all;              %�������������,�ͷ��ڴ�ռ�
F1=1;                   %�ź�Ƶ��
Fs=2^12;                %����Ƶ��
P1=0;                   %�źų�ʼ��λ
N=2^12;                 %��������
t=[0:1/Fs:(N-1)/Fs];    %����ʱ��
ADC=2^9 - 1;            %ֱ������
A=2^9;                  %�źŷ���
%���ɷ����ź�
s=A*square(2*pi*F1*t + pi*P1/180) + ADC;
plot(s);                %����ͼ��
%����coe�ļ�
fild = fopen('squ_wave_4096x10.coe','wt');
%д��coe�ļ�ͷ
fprintf(fild, '%s\n','MEMORY_INITIALIZATION_RADIX=10;'); %10������
fprintf(fild, '%s\n','MEMORY_INITIALIZATION_VECTOR='); 
for i = 1:N
    s0(i) = round(s(i));    %��С������������ȡ��
    if s0(i) <0             %��1ǿ������
        s0(i) = 0
    end
    if i == N
            fprintf(fild, '%d',s0(i));      %����д��
            fprintf(fild, '%s',';');        %���һ������ʹ�÷ֺŽ���
    else
            fprintf(fild, '%d',s0(i));      %����д��
            fprintf(fild, '%s\n',',');      %���ţ�����
    end     
end
fclose(fild);