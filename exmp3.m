clear;
clc;
close all
%%
m=30;
Kyy=0.5e7;
Kzz=0.7e7;
Kyz=0;
Kzy=0;
Cyy=6e3;
Czz=6e3;
Cyz=0;
Czy=0;
g=10;
%%
M=[m,0;0,m];
C1=[Cyy,Cyz;Czy,Czz];
G=[0,g;-g,0];
K=[Kyy,Kyz;Kzy,Kzz];
Omega=10;
Cnew=C1+Omega.*G;
%%
ts=0;
tf=.1;
t=ts:0.0001:tf;
u=ones(2,numel(t));
%%
A=[zeros(size(M,1)),eye(size(M,1));-pinv(M)*K,-pinv(M)*Cnew];
B=[zeros(size(M,1));pinv(M)];
C=ones(2*size(M,1));
D=zeros(2*size(M,1),size(B,2));
sys=ss(A,B,C,D);
[~,~,x]=lsim(sys,u,t);
%%
figure
subplot(221)
plot(t,x(:,1))
grid minor
xlabel('time - sec')
ylabel('x')
title('X - Vibration')
subplot(222)
plot(t,x(:,3))
grid minor
xlabel('time - sec')
ylabel('y')
title('Y - Vibration')
subplot(223)
plot(x(:,1),x(:,3))
grid minor
xlabel('x')
ylabel('xdot')
title('X - Limit Cycle')
subplot(224)
plot(x(:,2),x(:,4))
grid minor
xlabel('y')
title('Y - Limit Cycle')
ylabel('ydot')
%%
omega=[10,20,30,40,50,60,70,80,90,100];
for i=1:10
Cnew=C1+omega(i).*G;
A=[zeros(size(M,1)),eye(size(M,1));-pinv(M)*K,-pinv(M)*Cnew];
B=[zeros(size(M,1));pinv(M)];
C=ones(2*size(M,1));
D=zeros(2*size(M,1),size(B,2));
sys=ss(A,B,C,D);
[~,~,x1]=lsim(sys,u,t);
RPM(:,i)=x1(:,4);
end
%%
figure
plot(t,RPM(:,1))
hold on
plot(RPM(:,2))
hold on
plot(RPM(:,3))
hold on
plot(RPM(:,4))
hold on
plot(RPM(:,5))
hold on
plot(RPM(:,6))
hold on
plot(RPM(:,7))
hold on
plot(RPM(:,8))
hold on
plot(RPM(:,9))
hold on
plot(RPM(:,10))
ylabel('Angular Velocity - rad/sec')
xlabel('time - sec')
legend(['\omega=',num2str(omega(1))],['\omega=',num2str(omega(2))],['\omega=',num2str(omega(3))],['\omega=',num2str(omega(4))],['\omega=',num2str(omega(5))],['\omega=',num2str(omega(6))],['\omega=',num2str(omega(7))],['\omega=',num2str(omega(8))],['\omega=',num2str(omega(9))],['\omega=',num2str(omega(10))],'location','southeast')
grid minor
