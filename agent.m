function [output,outkey ] = agent(img,Carr,cr,t,ts)


[h,w,d]=size(img);

key=hash(img,'SHA-256');
%generate initial values array
key_array=generate_init(key,t);

%generate hyper-chaotic sequences
times=ceil(cr*h^2+8*cr*h/7);
[t,K]=rossler([0:0.001:(times+5000-1)*0.001],1e-5,1e-5,key_array);
K(1:5000,:)=[];
K=K*10000-floor(K*10000);

%Image compression
[cimg,outkey]=compressdwt(img,K(1:ceil(cr*h^2),1:3),cr,ts);

%Joint diffusion and scrambling encryption
simg=d2dif(cimg,K);
outkey=[key outkey];

%Matrix embedding
output=uint8(hiding(Carr,simg));

end

