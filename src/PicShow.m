%% ��һ��ͼƬ�û���һ�У�Ȼ���ڽ��仹ԭ

    pic='F:\mat\pic\zyh.jpg';
    img=imread(pic);
    [x,y,z]=size(img)
    if(z>1)
        A=rgb2gray(img);
    else
        A=img;
    end  
   
    [m,n,z] = size(A);
    AA = [];  
    
  %% ��ͼƬA����һ��
    for i=1:1:m
        C = A(i,:);
        AA = [AA,C];
    end
    
   %% ��ͼƬAA��ԭ
   T1=[];   
   for i=1:1:m
       C = AA(1,(i-1)*n+1:i*n);
       T1 = [T1;C];
   end
   size(T1);
   imshow(T1);