function [theta] = angleP(A,B,C,i)
%   Calculates angle at B between A and C
%
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

    global xData
    global yData
    global zData
    
    AB = [xData(i,B)-xData(i,A);yData(i,B)-yData(i,A);zData(i,B)-zData(i,A)];
    BC = [xData(i,C)-xData(i,B);yData(i,C)-yData(i,B);zData(i,C)-zData(i,B)];
    
    theta = acos(dot(AB,BC)/(norm(AB)*norm(BC)));
    
    
    
end

