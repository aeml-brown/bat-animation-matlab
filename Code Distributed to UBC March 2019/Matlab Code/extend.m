function [array] = extend(vector,int)
% This function takes in a column vector with three rows and copies it to
% have an array with int columns which are all equal to the original
% vector. This function is used to extend the vector that represents the
% sternum displacement. It is is used in the animation function when the
% displacement vector needs to be subtracted from an arrays of points of
% different sizes
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%


% creates zero-array of desired size
array = zeros(3,int);
for i=1:+1:int
    array(1,i) = vector(1,1);
    array(2,i) = vector(1,2);
    array(3,i) = vector(1,3);

end

