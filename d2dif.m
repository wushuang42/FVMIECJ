function output = d2dif(img,K)


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


%add first row
C=zeros(h+1,ww);
T=zeros(ww,1);
T(:)=12;
C(1,:)=T;
C(2:end,:)=double(input);
%Generate row scrambling order
temp_order=order_K(1:h,1);
[temp_order,index]=sort(temp_order);
order=[1;index+1];
%Generate first round substitution matrix M1
M1=M(:,1)';

%first round row diffusion and scrambling
for j=2:h+1
     C1=C(order(j),:);
     C2=C(order(j-1),:)+1;
     K=lambda_K(order(j)-1,:,1);
     C1=C1+bitxor(M1(C2),K);
     C(order(j),:)=mod(C1,256);
end   
C(1,:)=C(order(end),:);

%second round row diffusion and scrambling
TC=C;
M2=M(:,2)';
for j=2:h+1
     C1=TC(order(j),:);
     C2=C(j-1,:)+1;
     K=lambda_K(j-1,:,2);
     C1=C1+bitxor(M2(C2),K);
     C(j,:)=mod(C1,256);
end     

C=C(2:end,:);

%add first column
D=zeros(h,w*d+1);
T=zeros(h,1);
T(:)=23;
D(:,1)=T;
D(:,2:end)=C;

%Generate column scrambling order

temp_order=order_K(1:w*d,2);
[temp_order,index]=sort(temp_order);
order=[1;index+1];
%Generate substitution matrix M3
M3=M(:,3);
%first round column diffusion and scrambling
for j=2:w*d+1
     D1=D(:,order(j));
     D2=D(:,order(j-1))+1;
     K=lambda_K(:,order(j)-1,3);
     D1=D1+bitxor(M3(D2),K);
     D(:,order(j))=mod(D1,256);
end   
D(:,1)=D(:,order(end));

%second round column diffusion and scrambling
TD=D;
M4=M(:,4);
for j=2:w*d+1
     D1=TD(:,order(j));
     D2=D(:,j-1)+1; 
     K=lambda_K(:,j-1,4);
     D1=D1+bitxor(M4(D2),K);
     D(:,j)=mod(D1,256);
end     
D=D(:,2:end);

%reshape output image
output=reshape(D,h,w,d);

end

