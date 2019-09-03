function [x,y,z] = centerOfMass(t,xData,yData,zData)
%   Calculates the center of mass in the coordinate inputs
%   
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

    global Mass
    
    % creates vectors of the x,y, and z coordinates of the different
    % segments with corresponding mass
    [RxR, RxL] = Radii(xData,t);
    [RyR, RyL] = Radii(yData,t);
    [RzR, RzL] = Radii(zData,t);
    
    x = 0;
    y = 0;
    z = 0;
    M = 0;
    
    % calculates x-value of the center of mass
    for i=1:size(RxR,1)
        for j=1:size(RxR,2)
            % first column of radii data corresponds to right side of bat and
            % second column corresponds to left side. Mass distribution is
            % symmetrical so can multiply both coordinates by same mass
            if i~=size(Mass,1)
                x = x + (Mass(i)*(RxR(i,j)+RxL(i,j)))/(2*size(RxR,2));
            else
                x = x + (Mass(i)*(RxR(i,j)+RxL(i,j)))/(size(RxR,2));
            end
            
        end
        % keeps track of total mass
        M = M + Mass(i);
    end
    
    x = 1/(M)*x;
    % calculates y-value of the center of mass
    for i=1:size(RyR,1)
        for j=1:size(RyR,2)
            if i~=size(Mass,1)
                y = y + (Mass(i)*(RyR(i,j)+RyL(i,j)))/(2*size(RyR,2));
            else
                y = y + (Mass(i)*(RyR(i,j)+RyL(i,j)))/(size(RyR,2));
            end
        end
    end     
    y = 1/(M)*y;
    % calculates z-value of the center of mass
    for i=1:size(RzR,1)
        for j=1:size(RzR,2)
             if i~=size(Mass,1)
                z = z + (Mass(i)*(RzR(i,j)+RzL(i,j)))/(2*size(RzR,2));
             else
                z = z + (Mass(i)*(RzR(i,j)+RzL(i,j)))/(size(RzR,2));
            end
        end
    end  
    z = 1/(M)*z;
   
end

