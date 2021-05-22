clear all;clc;
load('ams1-2.txt');

    [filename, pathname] = uigetfile('*.txt', '����۲�����');
    if isequal(filename,0)||isequal(pathname,0)
        return;
    end
    filePath = [pathname,filename]; % �ļ�·��

    try
        points = load(filePath);
    catch
        errordlg('���ݸ�ʽ����','����');
        return;
    end

Arsize = 52;
hc = ones(Arsize,4);
hc(:,1:3) = points;
point = ones(Arsize,4);
%ת�������
for i=1:Arsize
%     point(i,:) = ams_1 * ams_2 * hc(i,:)';
%     point(i,:) = ams_1 * hc(i,:)';
%     point(i,:) = ams_4 * ams_3 * ams_2 * hc(i,:)';
    point(i,:) =  ams1_2 \ hc(i,:)';
    
end

%������װ
data = zeros(Arsize,3);
for k =1:Arsize
    data = point(:,1:3);
end
n = 8;
str = ['C2_1_',num2str(n),'.txt'];
dlmwrite(str,data,'delimiter',',','precision','%.6f');

