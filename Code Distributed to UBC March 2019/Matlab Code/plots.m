function [dR,dL,haxes] = plots(x,f)
%   This function is in charge of plotting calculations desired by the
%   user. It takes inputs Left and Right to determine whether the left and
%   right side of the bat are in the animation. It takes in t which
%   represents the number of timesteps. x represents the amount of subplots the user wants to
%   plot. W is the amount of coordinates tracked. header represents the
%   array with the names of all the points. Its outputs are the arrays with
%   the calculations, both for the left and right sides, and the reference
%   for the subplots.
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

    
    % initialize variables
    global xData
    global yData
    global zData
    global Ux
    global Uy
    global Uz
    global Ax
    global Ay
    global Az
    global fRate
    global thetaData
    global phiData
    global xBasisData
    global yBasisData
    global zBasisData
    global UxBasis
    global UyBasis
    global UzBasis
    global AxBasis
    global AyBasis
    global AzBasis
    global Omegax
    global Omegay
    global Omegaz
    global Alphax
    global Alphay
    global Alphaz
    global H
    global W
    global Left
    global Right
    global Uxc
    global Uyc
    global Uzc
    global Axc
    global Ayc
    global Azc
    global Omegaxc
    global Omegayc
    global Omegazc
    global Alphaxc
    global Alphayc
    global Alphazc
    global M

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

    dR = [];
    dL = [];
    
    [FL,FR] = AreaFaces();
    
    % loops for every timestep
    for i=1:+1:H   
        % makes calculations if that side of the bat is being animated
        
        if Right == 0
            % Left Side Calculations
            dL(i,1) = sqrt((xBasisData(i,shdL) - xBasisData(i,t3L))^2 + (yBasisData(i,shdL) - yBasisData(i,t3L))^2 ...
                + (zBasisData(i,shdL) - zBasisData(i,t3L))^2); % Calculation #1 at ith timestep
            %[xc,yc,zc] = centerOfMass(i,xBasisData,yBasisData,zBasisData);
            I = Inertia(i);
            dL(i,2) = I(3,3); % Calculation #2 at ith timestep
            % Wing Area Calculation
            A = 0;
            for j=1:size(FL,1)
                A = A + area(FL(j,1),FL(j,2),FL(j,3),i);
            end
             
            dL(i,3) = NaN;%AoAttack(shdL,wstL,t5L,i); % Wing Area calculation
        end
        
        if Left == 0
            % Right Side Calculations
            dR(i,1) = sqrt((xData(i,shdR) - xData(i,t3R))^2 + (yData(i,shdR) - yData(i,t3R))^2 ...
                + (zData(i,shdR) - zData(i,t3R))^2); % Calculation #1 at ith timestep
            [xc,yc,zc] = centerOfMass(i,xBasisData,yBasisData,zBasisData);
            I = Inertia(i);
            dR(i,2) = I(2,2); % Calculation #2 at ith timestep; % Calculation #2 at ith timestep
            % Wing Area Calculation
            A = 0;
            for j=1:size(FR,1)
                A = A + area(FR(j,1),FR(j,2),FR(j,3),i);
            end
            
            dR(i,3) = I(1,1);%AoAttack(shdR,wstR,t5R,i); % Wing Area calculation
        end
    end
    
    % makes x subplots and stores the references in haxes. All the axes
    % have x-axis limit of t.
    haxes = xsubplots(x,H);
    
    
    
    % plots calculations in corresponding plots
    
    xd = (1:1:H)/fRate;
    
    % plots first calculation
    % plots if left side is being animated
    if Right == 0
    plot(haxes(1),xd,dL(:,1),  'b');
    end
    
    
    set(haxes(1),'Nextplot','add'); % sets first axes as current axes
    ylabel(haxes(1),'Shoulder-Wing Tip'); % sets y-label to "plot 1"
    
    % plots if right side is being animated
    if Left == 0
    plot(haxes(1),xd, dR(:,1),  'r');
    end
    xlim([0,H])
    
    % plots second calculation
    if Right == 0
    plot(haxes(2),xd,dL(:,2),  'b');
    end
    
    set(haxes(2),'Nextplot','add');
    ylabel(haxes(2),'Inertia');
    if Left == 0 
    plot(haxes(2),xd, dR(:,2),  'r');
    
    end
    xlim([0,H])
    
    % plots third calculation
    if Right == 0
    plot(haxes(3),xd,dL(:,3),  'b');
    end
    
    set(haxes(3),'Nextplot','add');
    ylabel(haxes(3),'Wing Area');
    if Left == 0
    plot(haxes(3),xd, dR(:,3),  'r');
    end
    xlim([0,H])
    
    for i=1:x
        grid(haxes(i),'on')
        %haxes(i).XMinorGrid = 'on';
        %hax = haxes(i);
        set(f,'currentaxes',haxes(i))
        grid minor
    end
end

