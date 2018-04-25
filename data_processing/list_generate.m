clc;
ParentFolder='E:\��ҵ���\Dateset\Vaihingen_Potsdam\dataset\'; %matlab�ڱ������ݿ�����list����·���Ƿ�б��
ParentPath = dir(ParentFolder);
train= fopen('train.txt','wt');
test = fopen('test.txt','wt');

Parent_data_Folder=[ParentFolder,ParentPath(3).name]; %��һ��Ϊ���ݼ�
Parent_data_Path = dir(Parent_data_Folder);
Num_data_Folders = length(Parent_data_Path);

Parent_label_Folder=[ParentFolder,ParentPath(4).name]; %�ڶ���Ϊ��ע��
Parent_label_Path = dir(Parent_label_Folder);
Num_label_Folders = length(Parent_label_Path);

if Num_data_Folders~=Num_label_Folders
    disp(['label and data do not match!']);
else
    NumFolders=Num_data_Folders;
end

for i = 3:NumFolders
    
    % label=num2str(i-3);
    
    %label
    Folder_label_Path = [Parent_label_Folder,'\',Parent_label_Path(i).name];  %���ν���label��ÿһ���ļ�
    labelName=dir(Folder_label_Path);   
    %data
    Folder_data_Path = [Parent_data_Folder,'\',Parent_data_Path(i).name];  %���ν���data��ÿһ���ļ�,��label��Ӧ
    imageName=dir(Folder_data_Path);    
    numPic=length(imageName);
    
    count=1;
    index = randperm(length(imageName)-2); % ����һ�а�����1��n��������
    for k = 1:4 %�����Ĵ�
        index = randperm(size(index,2));
    end 
    
    for j=3:numPic
        src=['./' ,ParentPath(3).name,'/',Parent_data_Path(i).name ,'/' ,imageName(index(count)+2).name]; %Ubuntuϵͳ�¶�ȡlist��·����б��
        label=['./',ParentPath(4).name,'/',Parent_label_Path(i).name ,'/', labelName(index(count)+2).name]
%         if count<=15
%             fprintf(train,'%s %s\n',src,label);
%         else
%             fprintf(test,'%s %s\n',src,label);
%         end
       if i<floor(0.8*NumFolders)
           fprintf(train,'%s %s\n',src,label);
       else
            fprintf(test,'%s %s\n',src,label);%��󼸸��ļ�������
       end
        count=count+1;
     end
end
fclose(train);
fclose(test);