function [cent] = centroid(P1,P2,P3,Data,t)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

    cent = (Data(t,P1)+Data(t,P2)+Data(t,P3))/3;
end


