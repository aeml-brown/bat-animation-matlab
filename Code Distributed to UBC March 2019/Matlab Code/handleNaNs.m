function [] = handleNaNs(Data,H,W)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

for j=1:+1:W
    while (isnan(Data(1,j)))
        if (isnan(Data(1,j)))
            Data(1,:) = [];
            
            disp(j);
        end
    end
end

H = size(Data,1);
disp(H);
for j=1:+1:W
    while (isnan(Data(H,j)))
        if (isnan(Data(H,j)))
            Data(H,:) = [];
            H = size(Data,1);
            %disp(H);
        end
    end
end
end

