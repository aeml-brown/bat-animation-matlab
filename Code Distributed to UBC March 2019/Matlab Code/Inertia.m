function [I] = Inertia(t)
%   This function returns the inertia matrix of the bat using the bat basis
%   coordinates
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

    
    global xBasisData
    global yBasisData
    global zBasisData
    global Mass
    global Left
    global Right
    
    % creates vectors of the x,y, and z bat coordinates of the different
    % segments with corresponding mass
    [RxR, RxL] = Radii(xBasisData,t);
    [RyR, RyL] = Radii(yBasisData,t);
    [RzR, RzL] = Radii(zBasisData,t);
    
    % calculates the center of mass in the bat coordinates
    [xc,yc,zc] = centerOfMass(t,xBasisData,yBasisData,zBasisData);
    
    if Right == 1 || Left == 1
        xc = 2*xc;
        yc = 2*yc;
        zc = 2*zc;
        
    end
    
    Ixx = 0;
    Iyy = 0;
    Izz = 0;
    Ixy = 0;
    Ixz = 0;
    Iyz = 0;
    
    % calculates the different components of the inertia matrix
    for i=1:size(RyR,1) 
        for j=1:size(RyR,2)
            if i~=13%size(Mass,1)
                Ixx = Ixx + Mass(i)*((RyR(i,j)-yc)^2+(RzR(i,j)-zc)^2 + ...
                     (RyL(i,j)-yc)^2+(RzL(i,j)-zc)^2)/(2*size(RyR,2));
                Iyy = Iyy + Mass(i)*((RxR(i,j)-xc)^2+(RzR(i,j)-zc)^2 + ...
                      (RxL(i,j)-xc)^2+(RzL(i,j)-zc)^2)/(2*size(RyR,2));
                Izz = Izz + Mass(i)*((RxR(i,j)-xc)^2+(RyR(i,j)-yc)^2 + ...
                      (RxL(i,j)-xc)^2+(RyL(i,j)-yc)^2)/(2*size(RyR,2));
                Ixy = Ixy + Mass(i)*((RxR(i,j)-xc)*(RyR(i,j)-yc) + ...
                      (RxL(i,j)-xc)*(RyL(i,j)-yc))/(2*size(RyR,2));
                Ixz = Ixz + Mass(i)*((RxR(i,j)-xc)*(RzR(i,j)-zc) + ...
                      (RxL(i,j)-xc)*(RzL(i,j)-zc))/(2*size(RyR,2));
                Iyz = Iyz + Mass(i)*((RyR(i,j)-yc)*(RzR(i,j)-zc) + ...
                      (RyL(i,j)-yc)*(RzL(i,j)-zc))/(2*size(RyR,2));
            else
                
                Ixx = Ixx + Mass(i)*((RyR(i,j)-yc)^2+(RzR(i,j)-zc)^2) /(size(RyR,2));
                Iyy = Iyy + Mass(i)*((RxR(i,j)-xc)^2+(RzR(i,j)-zc)^2) /(size(RyR,2));
                Izz = Izz + Mass(i)*((RxR(i,j)-xc)^2+(RyR(i,j)-yc)^2) /(size(RyR,2));
                Ixy = Ixy + Mass(i)*((RxR(i,j)-xc)*(RyR(i,j)-yc) + ...
                      (RxL(i,j)-xc)*(RyL(i,j)-yc))/(size(RyR,2));
                Ixz = Ixz + Mass(i)*((RxR(i,j)-xc)*(RzR(i,j)-zc) + ...
                      (RxL(i,j)-xc)*(RzL(i,j)-zc))/(size(RyR,2));
                Iyz = Iyz + Mass(i)*((RyR(i,j)-yc)*(RzR(i,j)-zc) + ...
                      (RyL(i,j)-yc)*(RzL(i,j)-zc))/(size(RyR,2));
            end
        end
    end
    
    % Inertia Matrix
    I = [Ixx,-Ixy,-Ixz; ...
         -Ixy,Iyy,-Iyz; ...
         -Ixz,-Iyz,Izz];
end

