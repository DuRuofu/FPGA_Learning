clc;                    %�������������
clear all;              %�������������,�ͷ��ڴ�ռ�
F1=1;                   %�ź�Ƶ��
Fs=2^12;                %����Ƶ��
P1=0;                   %�źų�ʼ��λ
N=2^12;                 %��������
t=[0:1/Fs:(N-1)/Fs];    %����ʱ��
ADC=2^9 - 1;            %ֱ������
A=2^9;                  %�źŷ���
s1=A*sin(2*pi*F1*t + pi*P1/180) + ADC;          %���Ҳ��ź�
s2=A*square(2*pi*F1*t + pi*P1/180) + ADC;       %�����ź�
s3=A*sawtooth(2*pi*F1*t + pi*P1/180,0.5) + ADC; %���ǲ��ź�
s4=A*sawtooth(2*pi*F1*t + pi*P1/180) + ADC;     %��ݲ��ź�
%����coe�ļ�
fild = fopen('wave_16384x10.coe','wt');
%д��coe�ļ�ͷ
fprintf(fild, '%s\n','MEMORY_INITIALIZATION_RADIX=10;'); %10������
fprintf(fild, '%s\n','MEMORY_INITIALIZATION_VECTOR=');
for j = 1:4
    for i = 1:N
        if j == 1       %��ӡ�����ź�����
            s0(i) = round(s1(i));    %��С������������ȡ��
        end

        if j == 2       %��ӡ�����ź�����
            s0(i) = round(s2(i));    %��С������������ȡ��
        end

        if j == 3       %��ӡ���ǲ��ź�����
            s0(i) = round(s3(i));    %��С������������ȡ��
        end

        if j == 4       %��ӡ��ݲ��ź�����
            s0(i) = round(s4(i));    %��С������������ȡ��
        end

        if s0(i) <0             %��1ǿ������
            s0(i) = 0
        end
        
        if j == 4 && i == N
            fprintf(fild, '%d',s0(i));      %����д��
            fprintf(fild, '%s',';');        %���һ����ʹ�÷ֺŽ���
        else
            fprintf(fild, '%d',s0(i));      %����д��
            fprintf(fild, '%s\n',',');      %���ţ�����
        end
    end
end
fclose(fild);