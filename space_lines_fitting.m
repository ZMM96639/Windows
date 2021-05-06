clear all;clc;
line_point = load('data_original.txt');
num = length(line_point(:,1));
Transf = [line_point(:,3)';ones(1,num)];
B = [line_point(:,1)';line_point(:,2)'] * Transf';
A = B / (Transf * Transf');

z = 1040:1050;%����ֱ��z�ķ�Χ
x = A(1,1) * z + A(1,2);%�ռ�ֱ���ӷ���1��x=a*z+b
y = A(2,1) * z + A(2,2);%�ռ�ֱ���ӷ���2��y=c*z+d

%ֱ��������
% p1(x,y,z)
p1.z = 1040;
p1.x =  A(1,1) * p1.z + A(1,2);
p1.y = A(2,1) * p1.z + A(2,2);
% p2(x,y,z)
p2.z = 1050;
p2.x =  A(1,1) * p2.z + A(1,2);
p2.y = A(2,1) * p2.z + A(2,2);

P1 = [p1.x p1.y p1.z];
P2 =  [p2.x p2.y p2.z];

Arsize = size(line_point,2);
error_line = 0;
for i = 1 : Arsize
    temp = norm(cross((line_point(i,:) - P1),(line_point(i,:) - P2))) / norm( P2 - P1);
    error_line = error_line + temp;
end
fprintf(['�ռ�ֱ���������',num2str(error_line),' mm\n']);

%���ݿ��ӻ�
figure_handle = figure(1);
set(figure_handle,'name','�ռ�ֱ�����','Numbertitle','off'); % ���ô�������
plot3(line_point(:,1),line_point(:,2),line_point(:,3),'ro');
hold on;
plot3(x,y,z,'r');
axis([-40,150,-40,150,950,1140]);
xlabel('X/mm'),ylabel('Y/mm'),zlabel('Z/mm'),grid;
