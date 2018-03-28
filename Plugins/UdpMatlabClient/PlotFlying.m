clc
% clear

load('Data','Data')

%% ��ʾ����·�� 2D
fonts=15;
t=Data.t;
len=length(t);
figure 
hold on;grid on;

% title('The flying path of 2D');
%�滮·��
load('Trajectory','trajectory')
xp=trajectory(:,1);   yp=trajectory(:,2);
plot(yp,xp,'b*-')
xlabel('y(m)'); ylabel('x(m)');  
%ʵ�ʷ���·��
x=Data.Posi(:,1);   y=Data.Posi(:,2);   z=Data.Posi(:,3);
plot(y,x,'-r','linewidth',2)

%% ��ʾ����·�� 3D
figure
view(3)
xlabel('y(m)');ylabel('x(m)');zlabel('z(m)');
% title('The flying path of 3D');
hold on;grid on;
plot3(y,x,z,'-r')


%% ��ʾ���и߶� z
figure
plot(Data.t,z,'-g')
xlabel('t');ylabel('z(m)');
% title('The flying attitude');
hold on;grid on;


%% ��ʾ������̬ roll pitch
figure
subplot(211)
t=Data.t;
Aphi=Data.Atti(:,1);
Atheta=Data.Atti(:,2);
Apsi=Data.Atti(:,3);
xlabel('t');
hold on;grid on;
plot(t,Aphi,'-r',t,Atheta,'-g')
%��������
ylabel('Attitude (rad)','fontsize',10)
h=legend('\phi','\theta','Interpreter','latex')
set(h,'Fontsize',fonts,'Location','southeast','Orientation','horizontal');

%% ��ʾ����ƫ���� yaw
subplot(212)
plot(t,Apsi,'-b')
xlabel('t');
legend('yaw')
hold on;grid on;
%��������
ylabel('$\psi (rad)$','Interpreter','latex','fontsize',fonts)
h=legend('\psi','Interpreter','latex')
set(h,'Fontsize',fonts,'Location','southeast','Orientation','horizontal');

