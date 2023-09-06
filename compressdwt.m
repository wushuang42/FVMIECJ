function [ outimg,key ] = compressdwt( img,Kmat,cr,ts )

[h,w,d]=size(img);
I=double(img);
%Discrete Wavelet Transform
[LL,LH,HL,HH]=dwt2(I,'haar');

%save the LL component
core=LL;
[hc,wc]=size(LL);

if cr*h*w>hc^2
    
    K=[Kmat(:,1); Kmat(:,2);Kmat(:,3)];
    %compose the matrix CP
    cpmat=[LH;HL;HH];
    crh=floor(cr*h*2)-hc;
    ls=reshape(abs(cpmat),3*hc*wc,1);
    ls=sort(ls);
    th=ls(3*hc*wc-floor(crh*wc*ts));
    cpmat(abs(cpmat)<=th)=0;
    K1=K(1:crh*3*hc);
    R=reshape(K1,crh,3*hc);
    sq=K(crh*3*hc+1:end);
    sq=sq(1:3*hc*wc);
    [sq,index]=sort(sq);

    cpmat=reshape(cpmat(index),3*hc,wc);
    %compression result matrix cmat
    cmat=[core;R*cpmat];
else
     cmat=core;
end

%quantification
maxx=max(max(cmat));
minn=min(min(cmat));
outimg=uint8(floor((255*(cmat-minn))/(maxx-minn)));
key=[num2hex(maxx) num2hex(minn)];

end

