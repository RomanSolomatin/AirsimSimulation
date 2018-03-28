clc
% clear

ip='192.168.1.102'; 
port=8085;


%% ���ڳ�ʼ��
% figure('toolbar','none','menubar','none','Name','Flying','NumberTitle','off');
figure('menubar','none','Name','Flying','NumberTitle','off');
%set(gcf,'Position',[1000 0 920 1080]); %�ұ�
set(gcf,'Position',[0 10 920 1040]); %���½�

%��ʾ����·�� 2D
fonts=15;
subplot(3,2,1) 
hold on;grid on;
xlabel('y');
ylabel('x');
title('The flying path of 2D');
%��ʾ����·�� 3D
subplot(3,2,2) 
view(3)
xlabel('y(m)');ylabel('x(m)');zlabel('z(m)');
title('The flying path of 3D');
hold on;grid on;
%��ʾ������̬ roll
subplot(3,2,[3,4]) 
xlabel('t(s)');ylabel('rad');
title('The flying attitude');
hold on;grid on;
%��ʾyaw
subplot(3,2,[5,6]) 
xlabel('t(s)');ylabel('yaw(rad)');
title('The flying attitude of yaw');
hold on;grid on;
%��Ҫ��ͣһ�²��ܻ�ͼ
pause(0.001);

%% �������� ��ʼ��
% Data ���ڴ洢���е�����
Data.AngV=[];% x y z
Data.LinV=[];
Data.Atti=[];
Data.Posi=[];
Data.Acce=[];
Data.AccN=[];
Data.t=[];
Data.times=0; %���մ���


%% UDP���ղ�����
data_all=[];%���ڴ洢���е�����
u = udp(ip, port, 'Timeout', 100,'InputBufferSize',10240);%�������ip������˿ڵ�UDP��������60�볬ʱ�������С1024
fopen(u);
fwrite(u,-15.6,'float');    %����һ�����ݸ�udp����������������֪��matlab��ip�Ͷ˿�

t=1;
recLen=1;
tc=0.5; %ʱ��任ϵ��
while(1)
    %����
    receive = fread(u,recLen,'float');
    receive=receive';
    %whos receive  
 
    %���ݽ���
    data.Point=receive(1); %������
    data.AngV=receive(2:4);       Data.AngV=[Data.AngV;data.AngV];  %���ٶ� 
    data.LinV=receive(5:7);       Data.LinV=[Data.LinV;data.LinV];  %���ٶ�
    data.Atti=receive(8:10);      Data.Atti=[Data.Atti;data.Atti];  %�Ƕ�
    data.Posi=receive(11:13);     Data.Posi=[Data.Posi;data.Posi];  %λ��
    data.Acce=receive(14:16);     Data.Acce=[Data.Acce;data.Acce];  %���ٶ�
    data.AccN=receive(17:19);     Data.AccN=[Data.AccN;data.AccN];  %���ٶ� ����ֵ  
   %����ʱ��
    Data.t=[Data.t;Data.times*tc];
    Data.times=(Data.times+1);  %���մ���
   
 
    %��ʾ����·�� 2D
    subplot(3,2,1)
    %·��
    load('Trajectory','trajectory')
    xp=trajectory(:,1);   yp=trajectory(:,2);
    plot(yp,xp,'b-*')
    grid on; hold on
    xlabel('y'); ylabel('x');  
    %·��
    x=Data.Posi(:,1);   y=Data.Posi(:,2);   z=Data.Posi(:,3);
    plot(y,x,'-r','linewidth',2)
    legend('trajectory','real path')
    
    %��ʾ����·�� 3D
    subplot(3,2,2) 
    plot3(y,x,z,'-r')
    %��ʾ������̬
    subplot(3,2,[3,4]) 
    plot(Data.t,Data.Atti(:,1),'-r',Data.t,Data.Atti(:,2),'-g')
    %��������
    ylabel('Attitude (rad)')
    h=legend('\phi','\theta','Interpreter','latex')
    set(h,'Location','northwest','Orientation','vertical');

    legend('roll','pitch')
    %��ʾ����ƫ����
    subplot(3,2,[5,6])
    plot(Data.t,Data.Atti(:,3),'-b')
    %��������
    ylabel('$\psi (rad)$','Interpreter','latex')
    h=legend('yaw')
    set(h,'Location','northwest','Orientation','horizontal');

    %��ͣһ����ʾ
    pause(0.001); 
    %����
    fwrite(u,-1,'float');
    t=t+1
    save('Data','Data')
end

fclose(u);
delete(u);
