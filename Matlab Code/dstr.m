function [array] = extend(vector,int)
%UNTITLED Summary of this function goes here
%  
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

array = zeros(3,int);
for i=1:+1:int
    array(1,i) = vector(1,1);
    array(2,i) = vector(1,2);
    array(3,i) = vector(1,3);

end

