%% 将一张图片置换成一行，然后在将其还原

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
    
  %% 将图片A放在一行
    for i=1:1:m
        C = A(i,:);
        AA = [AA,C];
    end
    
   %% 将图片AA还原
   T1=[];   
   for i=1:1:m
       C = AA(1,(i-1)*n+1:i*n);
       T1 = [T1;C];
   end
   size(T1);
   imshow(T1);