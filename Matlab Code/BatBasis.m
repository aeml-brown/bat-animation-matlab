function [xBasisData,yBasisData,zBasisData] = BatBasis(newO,xData,yData,zData)
%   This function converts the input coordinates into local bat coordinats
%   where the x-axis is along the back the back of the bat, the y-axis is
%   across the body, and the z-axis is perpindicular to the back. This
%   change of coordinates is used to calculate moments of inertia along of
%   axes that relate to the bat.
%   Detailed explanation goes here
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%


    global H
    global Left
    global W
    global xBasis
    global yBasis
    global zBasis
    
    
    % assign number values stored as the names of the points so that they can
    % be easily referenced as column indexes in the 3xW Bat array
    [Le01L, Le01R, Le02L, Le02R, Le03L, Le03R, Mf01L, Mf01R, Mf02L, Mf02R, Mf03L, Mf03R, ...
        Mi01L, Mi01R, Mi02L, Mi02R, Mi03L, Mi03R, Mi04L, Mi04R, Mi05L, Mi05R, Mi06L, Mi06R, Mi07L, Mi07R, ...
        Mi08L, Mi08R, Mi09L, Mi09R, Mm01L, Mm01R, Mm02L, Mm02R, Mm03L, Mm03R, Mo01L, Mo01R, Mo02L, Mo02R, ...
        Mo03L, Mo03R, shdL, shdR, elbL, elbR, wstL, wstR, t3L, t3R, t4L, t4R, t5L, t5R, mcp3L, mcp3R, ...
        mcp4L, mcp4R, mcp5L, mcp5R, ip3L, ip3R, ip4L, ip4R, ip5L, ip5R, hipL, hipR, kneeL, kneeR, ...
        ankL, ankR, lmb, str, Sj18L, Sj18R, Sj19L, Sj19R, Sj20L, Sj20R, Sj21L, Sj21R, Te01L, Te01R, ...
        Te02L, Te02R, Te03L, Te03R, Te04L, Te04R, Te05L, Te05R, Te06L, Te06R, Te07L, Te07R, Te08L, Te08R, ...
        Te09L, Te09R, Sn01L, Sn01R, Sn02L, Sn02R, Sn03L, Sn03R, Sn04L, Sn04R, Sn05L, Sn05R, Sn06L, Sn06R] ...
        = Points2Numbers();
    
    % initialize variables
    xLocData = NaN(H,W/3);
    yLocData = NaN(H,W/3);
    zLocData = NaN(H,W/3);
    xBasis = NaN(3,H);
    yBasis = NaN(3,H);
    zBasis = NaN(3,H);
    xBasisData = NaN(H,W/3);
    yBasisData = NaN(H,W/3);
    zBasisData = NaN(H,W/3);
    
    % shift data to be centered at the new origin
    for j=1:+1:W/3
        for i=1:+1:H
            xLocData(i,j) = xData(i,j)-newO(i,1); % contains all x-coordinate data
            yLocData(i,j) = yData(i,j)-newO(i,2); % contains all y-coordinate data
            zLocData(i,j) = zData(i,j)-newO(i,3); % contains all y-coordinate data

        end
    end

    for i=1:+1:H
        % x-basis is the the line from the origin to the lumbar
        xBasis(:,i) = -[xLocData(i,lmb);yLocData(i,lmb);zLocData(i,lmb)];
        
        % z-basis is perpindicular to the back so make it the cross product
        % between the the x-basis and one of the shoulders, which are
        % approximately on the back
        if Left == 0
        zBasis(:,i) = cross(xBasis(:,i),[xLocData(i,shdR);yLocData(i,shdR);zLocData(i,shdR)]);
        elseif Left == 1
            zBasis(:,i) = cross(xBasis(:,i),[xLocData(i,shdL);yLocData(i,shdL);zLocData(i,shdL)]);
        end
        % y-basis then the cross product between the z and x bases so that
        % it is on the back and perpindicular to the x-basis so that it
        % is the direction of the wingtip
        yBasis(:,i) = cross(xBasis(:,i),zBasis(:,i));
    end
    
    % normalizes the basis vectors
    for i=1:H
        xBasis(:,i) = xBasis(:,i)/norm(xBasis(:,i));
        yBasis(:,i) = yBasis(:,i)/norm(yBasis(:,i));
        zBasis(:,i) = zBasis(:,i)/norm(zBasis(:,i));
    end

    for i=1:H
        for j=1:W/3
            % inverts matrix composed of basis vectors and multiplies by
            % the point vectors to get the transformed points in the basis
            T = [xBasis(:,i),yBasis(:,i),zBasis(:,i)]\[xLocData(i,j);yLocData(i,j);zLocData(i,j)];
            xBasisData(i,j) = T(1);
            yBasisData(i,j) = T(2);
            zBasisData(i,j) = T(3);
        end
    end
end

