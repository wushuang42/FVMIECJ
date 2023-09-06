function [dimg] = repare(cimg,rimg,cr)


[h,w,d]=size(rimg);

sh=cr*h*2;
sw=w/2;

num=sh*sw*8/h/w;

modd=ceil(double(rimg).*(255-2^num+1)/255);

inter=mod(uint8(double(cimg)-modd),2^num);

inter=reshape(inter,sh*sw*8/num,1);
inter=dec2bin(inter);
inter=reshape(inter,sh*sw,8);
inter=bin2dec(inter);
dimg=reshape(inter,sh,sw);




end

