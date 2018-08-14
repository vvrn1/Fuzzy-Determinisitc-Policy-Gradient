function [dUdSigma, dUdMu, dUdK] = u_grad2(State,sigma, mu , output)
ee = 0.001;
l1 = length(sigma);
l2 = length(mu);

l3 = length(output);
for i  =1 : l1
    temp = zeros(l1,1);
    temp(i) = 1;
    u1(i,1) = GetAction ( State , sigma+ee.*temp , mu , output );
    u1(i,2) = GetAction ( State , sigma-ee.*temp , mu , output );
end
for i  =1 : l2
    temp = zeros(l2,1);
    temp(i) = 1;
    u2(i,1) = GetAction ( State , sigma, mu+ee.*temp  , output );
    u2(i,2) = GetAction ( State , sigma , mu-ee.*temp , output );
end
for i  =1 : l3
    temp = zeros(l3,1);
    temp(i) = 1;
    u3(i,1) = GetAction ( State , sigma , mu , output+ee.*temp );
    u3(i,2) = GetAction ( State , sigma , mu , output-ee.*temp );
end

dUdSigma = (u1(:,1)-u1(:,2))/(2*ee);
dUdMu = (u2(:,1)-u2(:,2))/(2*ee);
dUdK = (u3(:,1)-u3(:,2))/(2*ee);