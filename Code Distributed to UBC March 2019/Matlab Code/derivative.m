function [f] = derivative(F,numPoints,degree)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

    H = size(F,1);
    f = NaN(size(F,1),size(F,2));
    X = NaN(size(F,1),size(F,2));
    
    for i=1:size(F,2)

        n = 0;
        h = numPoints;
        while n <= H
            if n+h > H
                h = H-n;
            end
            
            n = n+h;
            xd = n-h+1:n;
            maxt = F(xd,i);
            length = (xd)';
            idx = isnan(maxt);
            [p, S, mu] = polyfit(length(~idx),maxt(~idx),degree+1);
            Xn = polyval(p,length(~idx),S,mu);
            X(length(~idx),i) = Xn;
            
            if h > degree+1
                p = polyfit(length(~idx),Xn,degree+1);
            else
                p = polyfit(length(~idx),Xn,h-1);
            end      
            
            q = polyder(p);
            f(length(~idx),i) = polyval(q,length(~idx));
            
            if n == H
            n = n+1;
            end
        end
    end
end

