function [d_img] =d2dedif(img,K)

%Adjust the size of the original image and convert the three-channel image to a two-dimensional image
[h,w,d]=size(img);
ww=w*d;
input=reshape(img,h,ww);


%Generate chaotic diffusion matrices lambda_K
length_number=10000;
lambda_K=reshape(K(1:h*w*d,4:7),h,w*d,4);
lambda_K=mod(floor(lambda_K*length_number),256);


%Generate scrambling matrix
temp_l=h*d;
[KL,KW]=size(K);

orKsq=reshape(K(KL-ceil(4*h/7)+1:end,:),1,ceil(4*h/7)*7);
order_K=reshape(orKsq(1:temp_l*4),temp_l,4);

%Generate substitution matrix M

Mtable=reshape(K(temp_l*4+1:temp_l*4+1024,5),256,4);
M=zeros(256,4);

for i=1:4
    templ=Mtable(:,i);
    [templ,index]=sort(templ);
    M(:,i)=index-1;
end

D=double(input);
%Generate column scrambling order
temp_order=order_K(1:w*d,2);
[temp_order,index]=sort(temp_order);
order=index;

%second round column decryption
TD=D;
M4=M(:,4);
for j=w*d:-1:2
     K=lambda_K(:,j,4);
     TD(:,order(j))=mod(D(:,j)-bitxor(K,M4(D(:,j-1)+1))+256,256);
end
K=lambda_K(:,1,4);
TD(:,order(1))=mod(D(:,1)-bitxor(K,M4(TD(:,order(w*d))+1))+256,256);
D=TD; 

%first round column decryption 
M3=M(:,3);
for j=w*d:-1:2
     K=lambda_K(:,order(j),3);
     D(:,order(j))=mod(D(:,order(j))-bitxor(K,M3(D(:,order(j-1))+1))+256,256);
end
T=zeros(h,1);
T(:)=23;
K=lambda_K(:,order(1),3);
D(:,order(1))=mod(D(:,order(1))-bitxor(K,M3(T+1))+256,256);  
 
C=D;
%Generate row scrambling order
temp_order=order_K(1:h,1);
[temp_order,index]=sort(temp_order);
order=index;

%second round row decryption
TC=C;
M2=M(:,2)';
for j=h:-1:2
     K=lambda_K(j,:,2);
     TC(order(j),:)=mod(C(j,:)-bitxor(K,M2(C(j-1,:)+1))+256,256);
end
K=lambda_K(1,:,2);
TC(order(1),:)=mod(C(1,:)-bitxor(K,M2(TC(order(h),:)+1))+256,256);
C=TC;

%first round row decryption
M1=M(:,1)';  
for j=h:-1:2
    K=lambda_K(order(j),:,1);
    C(order(j),:)=mod(C(order(j),:)-bitxor(K,M1(C(order(j-1),:)+1))+256,256);
end
T=zeros(ww,1);
T(:)=12;
 K=lambda_K(order(1),:,1);
 C(order(1),:)=mod(C(order(1),:)-bitxor(K,M1(T+1))+256,256);  
 
%reshape output image
d_img=reshape(C,h,w,d);

end

