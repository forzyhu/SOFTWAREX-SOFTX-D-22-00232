clc
clear

%% 系统参数设置
load('../data/YALE_Data.mat');
mx = 80;
ny = 80;

train_img=[];
train_lab=[]; 

rols=6;
cols=6;

Man_num=15;
Fig_num=11;


%*****训练样本参数设置*******
Train_num=8;  %***训练样本数量***

Train_num_start=1;
Train_num_end=Train_num;

Fig_num_start=Train_num+1;
Fig_num_end=11;

%% 一、处理图片训练+识别集
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


%% 二、分离训练集train_Img、train_Lab  和验证集（测试集）test_Img、test_Lab
train_Img=[];     
train_Lab=[];  
test_Img=[];      
test_Lab=[];  

for i=1:Man_num
    for j=1:Fig_num
        (i-1)*Fig_num + j;
        if(j>=Train_num_start &j<=Train_num_end)
            %提取训练集
            train_Img=[train_Img;train_img((i-1)*Fig_num + j,:)];
            train_Lab=[train_Lab;train_lab((i-1)*Fig_num + j,:)];
        end
        if(j>=Fig_num_start &j<=Fig_num_end)
            %提取模拟仿真集
            test_Img=[test_Img;train_img((i-1)*Fig_num + j,:)];
            test_Lab=[test_Lab;train_lab((i-1)*Fig_num + j,:)];
        end
    end 
end

%% 三、使用PCA对数据进行将维处理
 [S train_Img test_Img] = PCA(train_Img,test_Img);
     
%% 四、SVM向量机训练 
cmd='-s 0 -t 2 -c 16 -g 0.0068  '  %参数设置
%% 4.1开始训练并获得结果模型model
model = libsvmtrain(train_Lab,train_Img,cmd);

%% 五、对SVM进行模拟仿真测试
[py,accuracy,decision_values] = libsvmpredict(test_Lab,test_Img,model);
py;
accuracy(1);
