function [ himg ] = hiding( Carr,simg )


[h,w,d]=size(Carr);
[sh,sw,sd]=size(simg);

num=sh*sw*8/h/w;

sinter=dec2bin(simg);
sinter=reshape(sinter,sh*sw*8/num,num);
sinter=bin2dec(sinter);

sinter=reshape(sinter,h,w);

modd=ceil(double(Carr).*(255-2^num+1)/255);

himg=uint8(modd+sinter);


end

