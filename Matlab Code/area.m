function [A] = area(P1,P2,P3,i)
%	calculates area between three points, P1, P2, and P3, using Heron's formula.
%   Used to calculate wing area
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%


    % initialize variables
    global xData
    global yData
    global zData
  
            a2 = (xData(i,P1) - xData(i,P2))^2 + (yData(i,P1) - yData(i,P2))^2 ...
                + (zData(i,P1) - zData(i,P2))^2; % Length #1 squared
            
            b2 = (xData(i,P1) - xData(i,P3))^2 + (yData(i,P1) - yData(i,P3))^2 ...
                + (zData(i,P1) - zData(i,P3))^2; % Length #2 squared
            
            c2 = (xData(i,P2) - xData(i,P3))^2 + (yData(i,P2) - yData(i,P3))^2 ...
                + (zData(i,P2) - zData(i,P3))^2; % Length #3 squared
            
            A = (1/4)*sqrt(4*(a2*b2+a2*c2+b2*c2)-(a2+b2+c2)^2); % Herons formula
        
        
        
    %end
end

