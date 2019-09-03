function [Le01L, Le01R, Le02L, Le02R, Le03L, Le03R, Mf01L, Mf01R, Mf02L, Mf02R, Mf03L, Mf03R, ...
    Mi01L, Mi01R, Mi02L, Mi02R, Mi03L, Mi03R, Mi04L, Mi04R, Mi05L, Mi05R, Mi06L, Mi06R, Mi07L, Mi07R, ...
    Mi08L, Mi08R, Mi09L, Mi09R, Mm01L, Mm01R, Mm02L, Mm02R, Mm03L, Mm03R, Mo01L, Mo01R, Mo02L, Mo02R, ...
    Mo03L, Mo03R, shdL, shdR, elbL, elbR, wstL, wstR, t3L, t3R, t4L, t4R, t5L, t5R, mcp3L, mcp3R, ...
    mcp4L, mcp4R, mcp5L, mcp5R, ip3L, ip3R, ip4L, ip4R, ip5L, ip5R, hipL, hipR, kneeL, kneeR, ...
    ankL, ankR, lmb, str, Sj18L, Sj18R, Sj19L, Sj19R, Sj20L, Sj20R, Sj21L, Sj21R, Te01L, Te01R, ...
    Te02L, Te02R, Te03L, Te03R, Te04L, Te04R, Te05L, Te05R, Te06L, Te06R, Te07L, Te07R, Te08L, Te08R, ...
    Te09L, Te09R, Sn01L, Sn01R, Sn02L, Sn02R, Sn03L, Sn03R, Sn04L, Sn04R, Sn05L, Sn05R, Sn06L, Sn06R] ...
    = Points2Numbers()
% This function attributes a number to each point which is then stored in a
% variable with the name of the point. This function is used whenever a
% point represents a column of an array, such as for the Bat array in the
% animation function or for the xData, yData, and zData arrays used for
% calculations in the plots function.
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%


    global Points
    global W
    global Left
    global Right

    % initial value of each point variable in case the point is not tracked
    
    Le01L = NaN;
    Le01R = NaN;
    Le02L = NaN;
    Le02R = NaN;
    Le03L = NaN;
    Le03R = NaN;
    Mf01L = NaN;
    Mf01R = NaN;
    Mf02L = NaN;
    Mf02R = NaN;
    Mf03L = NaN;
    Mf03R = NaN;
    Mi01L = NaN;
    Mi01R = NaN;
    Mi02L = NaN;
    Mi02R = NaN;
    Mi03L = NaN;
    Mi03R = NaN;
    Mi04L = NaN;
    Mi04R = NaN;
    Mi05L = NaN;
    Mi05R = NaN;
    Mi06L = NaN;
    Mi06R = NaN;
    Mi07L = NaN;
    Mi07R = NaN;
    Mi08L = NaN;
    Mi08R = NaN;
    Mi09L = NaN;
    Mi09R = NaN;
    Mm01L = NaN;
    Mm01R = NaN;
    Mm02L = NaN;
    Mm02R = NaN;
    Mm03L = NaN;
    Mm03R = NaN;
    Mo01L = NaN;
    Mo01R = NaN;
    Mo02L = NaN;
    Mo02R = NaN;
    Mo03L = NaN;
    Mo03R = NaN;
    shdL = NaN;
    shdR = NaN;
    elbL = NaN;
    elbR = NaN;
    wstL = NaN;
    wstR = NaN;
    t3L = NaN;
    t3R = NaN;
    t4L = NaN;
    t4R = NaN;
    t5L = NaN;
    t5R = NaN;
    mcp3L = NaN;
    mcp3R = NaN;
    mcp4R = NaN;
    mcp4L = NaN;
    mcp5L = NaN;
    mcp5R = NaN;
    ip3L = NaN;
    ip3R = NaN;
    ip4L = NaN;
    ip4R = NaN;
    ip5L = NaN;
    ip5R = NaN;
    hipL = NaN;
    hipR = NaN;
    kneeL = NaN;
    kneeR = NaN;
    ankL = NaN;
    ankR = NaN;
    Sj18L = NaN;
    Sj18R = NaN;
    Sj19L = NaN;
    Sj19R = NaN;
    Sj20L = NaN;
    Sj20R = NaN;
    Sj21L = NaN;
    Sj21R = NaN;
    Te01L = NaN;
    Te01R = NaN;
    Te02L = NaN;
    Te02R = NaN;
    Te03L = NaN;
    Te03R = NaN;
    Te04L = NaN;
    Te04R = NaN;
    Te05L = NaN;
    Te05R = NaN;
    Te06L = NaN;
    Te06R = NaN;
    Te07L = NaN;
    Te07R = NaN;
    Te08L = NaN;
    Te08R = NaN;
    Te09L = NaN;
    Te09R = NaN;
    Sn01L = NaN;
    Sn01R = NaN;
    Sn02L = NaN;
    Sn02R = NaN;
    Sn03L = NaN;
    Sn03R = NaN;
    Sn04L = NaN;
    Sn04R = NaN;
    Sn05L = NaN;
    Sn05R = NaN;
    Sn06L = NaN;
    Sn06R = NaN;
    
    % for-loop for every point. Switch statement on the ith point name in the
    % header array. When it matches one of the known points then the
    % variable with the name of that header is set to i
    for i=1:+1:W/3
        
        switch Points{1,i}
            case 'lmb'
                lmb=i;
            case 'str'
                str=i;
        end
        if Right == 0
        
        switch Points{1,i}
            case 'Le01L'
                Le01L = i;            
            case 'Le02L'
                Le02L = i;           
            case 'Le03L'
                Le03L = i;           
            case 'Mf01L'
                Mf01L = i;
            case 'Mf02L'
                Mf02L = i;
            case 'Mf03L'
                Mf03L = i;
            case 'Mi01L'
                Mi01L = i;
            case 'Mi02L'
                Mi02L = i;
            case 'Mi03L'
                Mi03L = i;
            case 'Mi04L'
                Mi04L = i;
            case 'Mi05L'
                Mi05L = i;
            case 'Mi06L'
                Mi06L = i;
            case 'Mi07L'
                Mi07L = i;
            case 'Mi08L'
                Mi08L = i;
            case 'Mi09L'
                Mi09L = i;
            case 'Mm01L'
                Mm01L = i;
            case 'Mm02L'
                Mm02L = i;
            case 'Mm03L'
                Mm03L = i;
            case 'Mo01L'
                Mo01L = i;    
            case 'Mo02L'
                Mo02L = i;    
            case 'Mo03L'
                Mo03L = i;    
            case 'shdL'
                shdL = i;
            case 'wstL'
                wstL = i;
            case 'elbL'
                elbL = i;
            case 't3L'
                t3L = i;
            case 't4L'
                t4L = i;
            case 't5L'
                t5L = i;
            case 'mcp3L'
                mcp3L = i;
            case 'mcp4L'
                mcp4L = i;
            case 'mcp5L'
                mcp5L = i;
            case 'ip3L'
                ip3L = i;
            case 'ip4L'
                ip4L = i;
            case 'ip5L'
                ip5L = i;
            case 'hipL'
                hipL = i;
            case 'kneeL'
                kneeL = i;
            case 'ankL'
                ankL = i;
            case 'Sj18L'
                Sj18L = i;
            case 'Sj19L'
                Sj19L = i;
            case 'Sj20L'
                Sj20L = i;
            case 'Sj21L'
                Sj21L = i;
            case 'Te01L'
                Te01L = i;
            case 'Te02L'
                Te02L = i;
            case 'Te03L'
                Te03L = i;
            case 'Te04L'
                Te04L = i;
            case 'Te05L'
                Te05L = i;
            case 'Te06L'
                Te06L = i;
            case 'Te07L'
                Te07L = i;
            case 'Te08L'
                Te08L = i;
            case 'Te09L'
                Te09L = i;
            case 'Sn01L'
                Sn01L = i;
            case 'Sn02L'
                Sn02L = i;
            case 'Sn03L'
                Sn03L = i;
            case 'Sn04L'
                Sn04L = i;
            case 'Sn05L'
                Sn05L = i;
            case 'Sn06L'
                Sn06L = i;
        end
        end
        
        if Left == 0
        switch Points{1,i}
            case 'Le01R'
                Le01R = i;    
            case 'Le02R'
                Le02R = i;
            case 'Le03R'
                Le03R = i;
            case 'Mf01R'
                Mf01R = i;
            case 'Mf02R'
                Mf02R = i;
            case 'Mf03R'
                Mf03R = i;
            case 'Mi01R'
                Mi01R = i;
            case 'Mi02R'
                Mi02R = i;
            case 'Mi03R'
                Mi03R = i;
            case 'Mi04R'
                Mi04R = i;
            case 'Mi05R'
                Mi05R = i;
            case 'Mi06R'
                Mi06R = i;
            case 'Mi07R'
                Mi07R = i;
            case 'Mi08R'
                Mi08R = i;
            case 'Mi09R'
                Mi09R = i;
            case 'Mm01R'
                Mm01R = i;
            case 'Mm02R'
                Mm02R = i;
            case 'Mm03R'
                Mm03R = i;
            case 'Mo01R'
                Mo01R = i;
            case 'Mo02R'
                Mo02R = i;
            case 'Mo03R'
                Mo03R = i;
            case 'shdR'
                shdR = i;
            case 'wstR'
                wstR = i;
            case 'elbR'
                elbR = i;
            case 't3R'
                t3R = i;
            case 't4R'
                t4R = i;
            case 't5R'
                t5R = i;
            case 'mcp3R'
                mcp3R = i;
            case 'mcp4R'
                mcp4R = i;
            case 'mcp5R'
                mcp5R = i;
            case 'ip3R'
                ip3R = i;
            case 'ip4R'
                ip4R = i;
            case 'ip5R'
                ip5R = i;
            case 'hipR'
                hipR = i;
            case 'kneeR'
                kneeR = i;
            case 'ankR'
                ankR = i;
            case 'Sj18R'
                Sj18R = i;
            case 'Sj19R'
                Sj19R = i;
            case 'Sj20R'
                Sj20R = i;
            case 'Sj21R'
                Sj21R = i;
            case 'Te01R'
                Te01R = i;
            case 'Te02R'
                Te02R = i;
            case 'Te03R'
                Te03R = i;
            case 'Te04R'
                Te04R = i;
            case 'Te05R'
                Te05R = i;
            case 'Te06R'
                Te06R = i;
            case 'Te07R'
                Te07R = i;
            case 'Te08R'
                Te08R = i;
            case 'Te09R'
                Te09R = i;
            case 'Sn01R'
                Sn01R = i;
            case 'Sn02R'
                Sn02R = i;
            case 'Sn03R'
                Sn03R = i;
            case 'Sn04R'
                Sn04R = i;
            case 'Sn05R'
                Sn05R = i;
            case 'Sn06R'
                Sn06R = i;
        end
        end
    end
end

