function [t,y] = rossler(tspan,reltol,abstol,x0)

options = odeset('RelTol',reltol,'AbsTol',abstol);
[t,y] = ode45(@rosslerFunction,tspan,x0,options);

    function k = rosslerFunction(t,y)
        a=10;b=8/3;c=28;d=2;h=9.9;r=1;p=1;q=2;kk=13.5;
        k=zeros(7,1);
        k(1)=a*(y(2)-y(1))+y(4)+r*y(6)-y(7);
        k(2)=c*y(1)-y(2)-y(1)*y(3)+y(5);
        k(3)=-b*y(3)+y(1)*y(2);
        k(4)=d*y(4)-y(1)*y(3);
        k(5)=-h*y(2)+y(6);
        k(6)=p*y(1)+q*y(2);
        k(7)=y(1)*y(2)-kk*y(7);   
    end
end

