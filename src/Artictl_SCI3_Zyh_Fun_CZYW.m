%% ����ͷ
function [retImg]=Zyh_Fun_CZYW(A,fn,fm)
r=3;
c=3;
% rr_Value = rr_temp;
[m,n,z]=size(A);
%% ����ͼƬ�Ƿ�Ϊ�Ҷ�ͼƬ����ת��
if(z>1)
    A=rgb2gray(A);
end
%% 1����ͼ�����ĸ�������ݶ�ֵ
for i=1:m
    for j=1:n
         if(j==1)
             B1(i,j)=A(i,j)-A(i,j);
         else
             B1(i,j)=abs(A(i,j)-A(i,j-1));
         end
    end
end

%�������ݶ�
for i=1:m
    for j=1:n
         if(j==n)
             B2(i,j)=A(i,j)-A(i,j);
         else
             B2(i,j)=abs(A(i,j)-A(i,j+1));
         end
    end
end

%�������ݶ�
for i=1:m
    for j=1:n
         if(i==1)
             B3(i,j)=A(i,j)-A(i,j);
         else
             B3(i,j)=abs(A(i,j)-A(i-1,j));
         end
    end
end

%�������ݶ�
for i=1:m
    for j=1:n
         if(i==m)
             B4(i,j)=A(i,j)-A(i,j);
         else
             B4(i,j)=abs(A(i,j)-A(i+1,j));
         end
    end
end

%% 2����ͼ����ݶ��ںϾ���
BB=B1/4+B2/4+B3/4+B4/4;

%% 3��ȥ��ͼ����������
BQZ = BB;
ave = 30;

for i=1:m
    for j=1:n
        if(BQZ(i,j) < ave*1.1)
            BQZ(i,j)=0;
        end
    end
end


%% 4�����ڽ�����ͼ������������������ͼ�����Ҫ����������չ����
T1 = BQZ;
for i=1:m
    for j=1:n
        if(i>=2 && i<m-1 && j>=2 && j<n-1)
            Temp1=0;
            TempSum=0;
            for(ti=i-1:i+1)
                for(tj=j-1:j+1)
                    
                    if(BQZ(ti,tj)>0)
                        Temp1 = Temp1+1;
                        TempSum = TempSum + BQZ(ti,tj);
                    end
                end
            end
            if(Temp1>=3)
                for(ti=i-1:i+1)
                    for(tj=j-1:j+1)
                        if(BQZ(ti,tj)<=0)
                            T1(ti,tj) = uint8(TempSum/Temp1);
                        end
                    end
                end
            end
        end
    end
end

%% ͼ�����������ķ���ֵ
retImg = (A + T1*fn + BB*fm);                   %��0.2,0.4��

