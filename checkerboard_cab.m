clear all;clc;

Arsize = 20;

for j = 1:2
for i= 1:Arsize  %����۲����ݸ���   
% ����۲�����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

Ep(:,:,i,j) = points;

end
end