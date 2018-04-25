clear,clc;
[filename,filepath] = uigetfile('*.*','Select the image');  
if isequal(filename,0)||isequal(filepath,0)
    return;
% else
%    filefullpath=[filepath,filename];
end

fileFolder=fullfile(filepath); %�򿪸ոմ�ͼƬ���ڵ��ļ���
dirOutput=dir(fullfile(fileFolder,'*.tif'));%��ȡ����.tf
fileNames={dirOutput.name}'; %�������
%����ָ�
for i=1:length(fileNames)
    
% %�õ��ļ������Ա㽨��һ���ļ��б���ֿ�ͼ��
% [pathstr,name,ext] = fileparts(filename);
splitname=strsplit(fileNames{i},'.'); %����cell
name= splitname{1}; %ȥ����׺
filefullpath=[filepath,fileNames{i}];
%��tiff�ļ�
%Im=Tiff(filefullpath, 'r+');  

Im=imread(filefullpath); %����������Ϣ
% imshow(Im)
%��ɸ߶���Ϣ
[minI,index]=min(Im(:));
Im=Im-minI;
L = size(Im);
%�ֿ��С
height=128;
width=128;
%�ص�����
x=0.25;
h_val=height*(1-x);
w_val=width*(1-x);
max_row = (L(1)-height)/h_val+1;
max_col = (L(2)-width)/w_val+1;
% %�ж��ܷ������ֿ�
% if max_row==fix(max_row)%�ж��Ƿ��ܹ�����
%     max_row=max_row;
% else
%     max_row=fix(max_row+1);
% end
% if max_col==fix(max_col)%�ж��Ƿ��ܹ�����
%     max_col=max_col;
% else
%     max_col=fix(max_col+1);
% end

%ֻҪ��������
max_row=fix(max_row);
max_col=fix(max_col);
seg = cell(max_row,max_col);

for row = 1:max_row      
    for col = 1:max_col        
%         if ((width+(col-1)*w_val)>L(2)&&((row-1)*h_val+height)<=L(1))%�ж����ұ߲������Ĳ���
%     seg(row,col)= {Im((row-1)*h_val+1:height+(row-1)*h_val,(col-1)*w_val+1:L(2),:)};
%         elseif((height+(row-1)*h_val)>L(1)&&((col-1)*w_val+width)<=L(2))%�ж����±߲������Ĳ���
%     seg(row,col)= {Im((row-1)*h_val+1:L(1),(col-1)*w_val+1:width+(col-1)*w_val,:)}; 
%         elseif((width+(col-1)*w_val)>L(2)&&((row-1)*h_val+height)>L(1))%�ж����һ��
%     seg(row,col)={Im((row-1)*h_val+1:L(1),(col-1)*w_val+1:L(2),:)};       
%         else
     seg(row,col)= {Im((row-1)*h_val+1:height+(row-1)*h_val,(col-1)*w_val+1:width+(col-1)*w_val,:)}; %������������  
%         end
    end
end 
 imshow(Im);
 hold on
system(['mkdir ',name]);%������ͼƬ����ͬ���ļ���������ͼƬ
paths=[pwd,'\',name]; %��ȡָ���ļ���Ŀ¼
 %������ͼ
for i=1:max_row
    for j=1:max_col
%    imwrite(seg{i,j},[paths,'\',strcat('row',int2str(i),'_','col',int2str(j),'.bmp')]);   %�ѵ�i֡��ͼƬдΪ'mi.bmp'
     fid=fopen([paths,'\',strcat('row',int2str(i),'_','col',int2str(j),'.txt')],'w');%д��txt�ļ�
     fprintf(fid,'%f ',seg{i,j}'); %ע�����������������ת��һ��
     fclose(fid);
%  t = Tiff([paths,'\',strcat('row',int2str(i),'_','col',int2str(j),'.tif')], 'w');  
%  t.setTag( 'ImageWidth', size( imdata, 1));  
%  t.setTag( 'ImageHeight', size( imdata, 2));  
%  t.setTag;
%  t.write(seg{i,j});  
%  t.writeDirectory();  
    end
 end
end
