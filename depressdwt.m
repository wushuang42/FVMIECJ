function [output] = depressdwt(img,key,Kmat)


[hc,wc,dc]=size(img);
Dmat=double(img);


%inverse quantification
maxx=hex2num(key(1:16));
minn=hex2num(key(17:32));
Dmat=(Dmat*(maxx-minn))/255+minn;

core=Dmat(1:wc,:);

if hc>wc
    K=[Kmat(:,1); Kmat(:,2);Kmat(:,3)];
    crh=hc-wc;
    %Divide matrix
    dmat=Dmat(wc+1:end,:);
    K1=K(1:crh*3*wc);
    R=reshape(K1,crh,3*wc);
    sq=K(crh*3*wc+1:end);
    sq=sq(1:3*wc*wc);
    [sq,index]=sort(sq);
    %SL0 algorithm
    outmat=SL0(R, dmat, 0.00000001, 0.8, 1.5, 10);

    outmat(index)=outmat;
    LL=core;
    LH=outmat(1:wc,:);
    HL=outmat(wc+1:2*wc,:);
    HH=outmat(2*wc+1:end,:);
else
    LL=core;
    LH=zeros(wc,wc);
    HL=zeros(wc,wc);
    HH=zeros(wc,wc);
end

%inverse DWT operation
output=uint8(idwt2(LL,LH,HL,HH,'haar'));


end

