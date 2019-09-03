function [theta] = angleV(V1,V2)
%   calculates the angle between the vectors V1 and V2
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%


    theta = acos(dot(V1,V2)/(norm(V1)*norm(V2)));
end

