function [output] = ext(Carr,cimg,outkey,cr,t)

[h,w,d]=size(Carr);
key=outkey(1:32);
outkey(1:32)=[];
%generate initial values array
key_array=generate_init(key,t);
times=ceil(cr*h^2+8*cr*h/7);
%generate hyper-chaotic sequences
[t,K]=rossler([0:0.001:(times+5000-1)*0.001],1e-5,1e-5,key_array);
K(1:5000,:)=[];
K=K*10000-floor(K*10000);

%Image extraction
rimg=repare(cimg,Carr,cr);

%Matrix decryption
d_img=d2dedif(rimg,K);

%Image reconstruction
dimg = depressdwt(d_img,outkey,K(1:ceil(cr*h^2),1:3));

output=dimg;
end

