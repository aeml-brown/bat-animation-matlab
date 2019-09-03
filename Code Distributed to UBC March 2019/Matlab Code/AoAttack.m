function [theta] = AoAttack(shd,wst,t5,t)
%	Calculates angle of attack of a wing. To denote which wing to calculte
%	the angle of attack for the user should add "L" or "R" after the joint
%	inputs.
%   
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

    global xData
    global yData
    global zData
    global Ux
    global Uy
    global Uz

    V1 = [xData(t,shd)-xData(t,wst);yData(t,shd)-yData(t,wst);zData(t,shd)-zData(t,wst)]; % shd - wst
    V2 = [xData(t,t5)-xData(t,wst);yData(t,t5)-yData(t,wst);zData(t,t5)-zData(t,wst)]; % t5 - wst
    
    wv = [Ux(t,wst),Uy(t,wst),Uz(t,wst)]; % wrist velocity
    
    % the angle between the two plane vecors
    phi = acos(dot(V1,V2)/(norm(V1)*norm(V2)));
    
    % The angle between the v2/v1 plane and the wst velocity vector (i.e. approximate air velocity vector)
    % cross(v1,v2) for right wing to ensure that normal vector points dorsal
    theta = (180/pi)*(acos( dot(cross(V1,V2),wv) / (norm(V1)*norm(V2)*norm(wv)*sin(phi)) ) - pi/2);
    
    
end

