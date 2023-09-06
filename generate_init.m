function [array]=generate_init(key,t)

t1=t(1);t2=t(2);t3=t(3);t4=t(4);t5=t(5);t6=t(6);t7=t(7);
K=abs(key);
xor_value = K(1);
for i = 2:4
    xor_value = bitxor(xor_value, K(i));
end
h1 =double(xor_value)*t1/256;

xor_value = K(5);
for i = 6:8
    xor_value = bitxor(xor_value, K(i));
end
h2 =double(xor_value)*t2/256;

xor_value = K(9);
for i = 10:12
    xor_value = bitxor(xor_value, K(i));
end
h3 =double(xor_value)*t3/256;

xor_value = K(13);
for i = 14:16
    xor_value = bitxor(xor_value, K(i));
end
h4 =double(xor_value)*t4/256;

xor_value = K(17);
for i = 18:20
    xor_value = bitxor(xor_value, K(i));
end
h5 =double(xor_value)*t5/256;
xor_value = K(21);
for i = 22:24
    xor_value = bitxor(xor_value, K(i));
end
h6 =double(xor_value)*t6/256;
xor_value = K(25);
for i = 26:32
    xor_value = bitxor(xor_value, K(i));
end
h7 =double(xor_value)*t7/256;

array=[h1,h2,h3,h4,h5,h6,h7];
