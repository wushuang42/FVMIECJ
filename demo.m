clc
clear
path1='..\testimage\512size\Barbara.tif';
path2='..\testimage\512size\Girl.tiff';
%img:plaintext image
%Carr: carrier image
img=imread(path1);
Carr=imread(path2);
[h,w,d]=size(img);
t=[1,1,2,2,3,3,4];

% agent: Encryption part program
%simg: secret image
[ simg,outkey ] = agent(img,Carr,0.25,t,0.3);


% ext: Decryption part program
% out: reconstructed image
[out]=ext(Carr,simg,outkey,0.25,t);

