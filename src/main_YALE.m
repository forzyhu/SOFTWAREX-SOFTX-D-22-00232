clc
clear

%% ϵͳ��������
load('../data/YALE_Data.mat');
mx = 80;
ny = 80;

train_img=[];
train_lab=[]; 

rols=6;
cols=6;

Man_num=15;
Fig_num=11;


%*****ѵ��������������*******
Train_num=8;  %***ѵ����������***

Train_num_start=1;
Train_num_end=Train_num;

Fig_num_start=Train_num+1;
Fig_num_end=11;

%% һ������ͼƬѵ��+ʶ��
for Man_i=1:Man_num
    for Fig_j=1:Fig_num     
        num = (Man_i -1)*Fig_num + Fig_j;
        img = [];
        for i=1:1:mx
           C = Data_Set(num,(i-1)*ny+1:i*ny);
           img = [img;C];
        end       
        [img]=Artictl_SCI3_Zyh_Fun_CZYW(img,1.01,2.13);
        
        img2=Picture_to_small(img,rols,cols);
        
        train_img = cat(1,train_img,img2);
        train_lab = cat(1,train_lab,Man_i);
    end
end


%% ��������ѵ����train_Img��train_Lab  ����֤�������Լ���test_Img��test_Lab
train_Img=[];     
train_Lab=[];  
test_Img=[];      
test_Lab=[];  

for i=1:Man_num
    for j=1:Fig_num
        (i-1)*Fig_num + j;
        if(j>=Train_num_start &j<=Train_num_end)
            %��ȡѵ����
            train_Img=[train_Img;train_img((i-1)*Fig_num + j,:)];
            train_Lab=[train_Lab;train_lab((i-1)*Fig_num + j,:)];
        end
        if(j>=Fig_num_start &j<=Fig_num_end)
            %��ȡģ����漯
            test_Img=[test_Img;train_img((i-1)*Fig_num + j,:)];
            test_Lab=[test_Lab;train_lab((i-1)*Fig_num + j,:)];
        end
    end 
end

%% ����ʹ��PCA�����ݽ��н�ά����
 [S train_Img test_Img] = PCA(train_Img,test_Img);
     
%% �ġ�SVM������ѵ�� 
cmd='-s 0 -t 2 -c 16 -g 0.0068  '  %��������
%% 4.1��ʼѵ������ý��ģ��model
model = libsvmtrain(train_Lab,train_Img,cmd);

%% �塢��SVM����ģ��������
[py,accuracy,decision_values] = libsvmpredict(test_Lab,test_Img,model);
py;
accuracy(1);
