clear all;clc;
line_point = load('data_to _fit_line.txt');

num = length(line_point(:,1));
Transf = [line_point(:,3)';ones(1,num)];
B = [line_point(:,1)';line_point(:,2)'] * Transf';
A = B / (Transf * Transf');

z = 1040:1050;%设置直线z的范围
x = A(1,1) * z + A(1,2);%空间直线子方程1：x=a*z+b
y = A(2,1) * z + A(2,2);%空间直线子方程2：y=c*z+d

%直线拟合误差
% p1(x,y,z)
p1.z = 1040;
p1.x =  A(1,1) * p1.z + A(1,2);
p1.y = A(2,1) * p1.z + A(2,2);
% p2(x,y,z)
p2.z = 1050;
p2.x =  A(1,1) * p2.z + A(1,2);
p2.y = A(2,1) * p2.z + A(2,2);

P1 = [p1.x p1.y p1.z];
P2 = [p2.x p2.y p2.z];

Arsize = size(line_point,2);

%求均值
average_point = sum(line_point) / Arsize;
fprintf('新坐标系原点：');
fprintf(['(',num2str(average_point(1)),'，',...
             num2str(average_point(2)),'，',...
             num2str(average_point(3)),')\n']);

%新坐标
Axis_z_o = [A(1,1)  A(2,1) 1]';
Axis_z = Sdt_th(Axis_z_o);

Axis_x_o = [A(2,1) -A(1,1) 0]';
Axis_x = Sdt_th(Axis_x_o);

Axis_y = cross(Axis_z,Axis_x);
Rotation = [Axis_x'; Axis_y'; Axis_z'];
 
fprintf('坐标轴方向向量：\n');
fprintf(['X：(',num2str(Axis_x(1)),',',num2str(Axis_x(2)),',',num2str(Axis_x(3)),')\n',...
         'Y：(',num2str(Axis_y(1)),',',num2str(Axis_y(2)),',',num2str(Axis_y(3)),')\n',...
         'Z：(',num2str(Axis_z(1)),',',num2str(Axis_z(2)),',',num2str(Axis_z(3)),')\n']);

%求误差
error_line = 0;
for i = 1 : Arsize
    temp = norm(cross((line_point(i,:) - P1),(line_point(i,:) - P2))) / norm( P2 - P1);
    error_line = error_line + temp;
end
fprintf(['空间直线拟合中误差：',num2str(error_line),' mm\n']);

%数据可视化
figure_handle = figure(1);
set(figure_handle,'name','空间直线拟合','Numbertitle','off'); % 设置窗口名称
plot3(line_point(:,1),line_point(:,2),line_point(:,3),'ro');
hold on;
plot3(x,y,z,'r');
axis([-40,150,-40,150,950,1140]);
xlabel('X/mm'),ylabel('Y/mm'),zlabel('Z/mm'),grid;

%计算转换矩阵
Transf = zeros(4,4);
b_1 = ones(4,1);
b_1(1:3,:) = average_point;
Transf(1:3,1:3) = Rotation;
Transf(:,4) =  b_1;
dlmwrite('TransfMatrix',Transf,'delimiter',',','precision','%6f');

