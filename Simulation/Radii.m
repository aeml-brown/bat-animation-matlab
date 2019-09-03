function [RR RL] = Radii(Data,t)
%   Creates a vector of coordinates corresponding to the positions of where
%   the mass is distributed. This vector is then used to calculate the
%   center of mass of the bat. The mass distribution vector has the masses
%   of different segments on the bat and the radii vector has the
%   correspoinding positions of those segments
%   

    global Left
    global Right
    
    % assign number values stored as the names of the points so that they can
    % be easily referenced as column indexes in the Data array
    [Le01L, Le01R, Le02L, Le02R, Le03L, Le03R, Mf01L, Mf01R, Mf02L, Mf02R, Mf03L, Mf03R, ...
    Mi01L, Mi01R, Mi02L, Mi02R, Mi03L, Mi03R, Mi04L, Mi04R, Mi05L, Mi05R, Mi06L, Mi06R, Mi07L, Mi07R, ...
    Mi08L, Mi08R, Mi09L, Mi09R, Mm01L, Mm01R, Mm02L, Mm02R, Mm03L, Mm03R, Mo01L, Mo01R, Mo02L, Mo02R, ...
    Mo03L, Mo03R, shdL, shdR, elbL, elbR, wstL, wstR, t3L, t3R, t4L, t4R, t5L, t5R, mcp3L, mcp3R, ...
    mcp4L, mcp4R, mcp5L, mcp5R, ip3L, ip3R, ip4L, ip4R, ip5L, ip5R, hipL, hipR, kneeL, kneeR, ...
    ankL, ankR, lmb, str, Sj18L, Sj18R, Sj19L, Sj19R, Sj20L, Sj20R, Sj21L, Sj21R, Te01L, Te01R, ...
    Te02L, Te02R, Te03L, Te03R, Te04L, Te04R, Te05L, Te05R, Te06L, Te06R, Te07L, Te07R, Te08L, Te08R, ...
    Te09L, Te09R, Sn01L, Sn01R, Sn02L, Sn02R, Sn03L, Sn03R, Sn04L, Sn04R, Sn05L, Sn05R, Sn06L, Sn06R] ...
    = Points2Numbers();
    
    D = 1/100:1/100:99/100;
    
    % radii array to calculate center of mass of the entire bad
    if Right == 0 && Left == 0
        R = [.5*(Data(t,shdR)+Data(t,elbR)), .5*(Data(t,shdL)+Data(t,elbL)); ...   % R1
            .5*(Data(t,elbR)+Data(t,wstR)), .5*(Data(t,elbL)+Data(t,wstL)); ...   % R2
            Data(t,wstR), Data(t,wstL); ...                         % R3
            .5*(Data(t,wstR)+Data(t,mcp3R)), .5*(Data(t,wstL)+Data(t,mcp3L)); ... % R4
            .5*(Data(t,mcp3R)+Data(t,t3R)), .5*(Data(t,mcp3L)+Data(t,t3L)); ...   % R5
            .5*(Data(t,mcp3R)+Data(t,t3R)), .5*(Data(t,mcp3L)+Data(t,t3L)); ...   % R6
            .5*(Data(t,wstR)+Data(t,mcp4R)), .5*(Data(t,wstL)+Data(t,mcp4L)); ... % R7
            .5*(Data(t,mcp4R)+Data(t,t4R)), .5*(Data(t,mcp4L)+Data(t,t4L)); ...   % R8
            .5*(Data(t,wstR)+Data(t,mcp5R)), .5*(Data(t,wstL)+Data(t,mcp5L)); ... % R9
            .5*(Data(t,mcp5R)+Data(t,t5R)), .5*(Data(t,mcp5L)+Data(t,t5L)); ...   % R10
            .5*(Data(t,lmb)+Data(t,ankR)), .5*(Data(t,lmb)+Data(t,ankL)); ...     % R11
            Data(t,lmb)+Data(t,str), 0];          % R12
        
        L = [(Data(t,shdR)-Data(t,elbR)), (Data(t,shdL)-Data(t,elbL)); ...   % R1
            (Data(t,elbR)-Data(t,wstR)), (Data(t,elbL)-Data(t,wstL)); ...   % R2
            0, 0; ...                                                       % R3
            (Data(t,wstR)-Data(t,mcp3R)), (Data(t,wstL)-Data(t,mcp3L)); ... % R4
            (Data(t,mcp3R)-Data(t,t3R)), (Data(t,mcp3L)-Data(t,t3L)); ...   % R5
            (Data(t,mcp3R)-Data(t,t3R)), (Data(t,mcp3L)-Data(t,t3L)); ...   % R6
            (Data(t,wstR)-Data(t,mcp4R)), (Data(t,wstL)-Data(t,mcp4L)); ... % R7
            (Data(t,mcp4R)-Data(t,t4R)), (Data(t,mcp4L)-Data(t,t4L)); ...   % R8
            (Data(t,wstR)-Data(t,mcp5R)), (Data(t,wstL)-Data(t,mcp5L)); ... % R9
            (Data(t,mcp5R)-Data(t,t5R)), (Data(t,mcp5L)-Data(t,t5L)); ...   % R10
            (Data(t,lmb)-Data(t,ankR)), (Data(t,lmb)-Data(t,ankL)); ...     % R11
            Data(t,lmb)-Data(t,str), 0];
        
        L = [(Data(t,shdR)-Data(t,wstR)), (Data(t,shdL)-Data(t,wstL));%(Data(t,shdR)-Data(t,elbR)), (Data(t,shdL)-Data(t,elbL)); ...   % R1
            2*(Data(t,mcp5R)-Data(t,mcp4R)), 2*(Data(t,mcp5L)-Data(t,mcp4L));%(Data(t,elbR)-Data(t,wstR)), (Data(t,elbL)-Data(t,wstL)); ...   % R2
            (Data(t,shdR)-Data(t,ankR)), (Data(t,shdL)-Data(t,ankL));%0, 0; ...                                                       % R3
            2*(Data(t,mcp5R)-Data(t,mcp4R)), 2*(Data(t,mcp5L)-Data(t,mcp4L));%(Data(t,wstR)-Data(t,mcp3R)), (Data(t,wstL)-Data(t,mcp3L)); ... % R4
            (Data(t,wstR)-Data(t,t3R)), (Data(t,wstL)-Data(t,t3L));%(Data(t,mcp3R)-Data(t,t3R)), (Data(t,mcp3L)-Data(t,t3L)); ...   % R5
            (Data(t,wstR)-Data(t,t3R)), (Data(t,wstL)-Data(t,t3L));%(Data(t,mcp3R)-Data(t,t3R)), (Data(t,mcp3L)-Data(t,t3L)); ...   % R6
            (Data(t,t5R)-Data(t,t4R)), (Data(t,t5L)-Data(t,t4L));%(Data(t,wstR)-Data(t,mcp4R)), (Data(t,wstL)-Data(t,mcp4L)); ... % R7
            (Data(t,t5R)-Data(t,t4R)), (Data(t,t5L)-Data(t,t4L));%(Data(t,mcp4R)-Data(t,t4R)), (Data(t,mcp4L)-Data(t,t4L)); ...   % R8
            (Data(t,wstR)-Data(t,mcp5R)), (Data(t,wstL)-Data(t,mcp5L)); ... % R9
            (Data(t,mcp5R)-Data(t,t5R)), (Data(t,mcp5L)-Data(t,t5L)); ...   % R10
            (Data(t,t5R)-Data(t,ankR)), (Data(t,t5L)-Data(t,ankL));%(Data(t,lmb)-Data(t,ankR)), (Data(t,lmb)-Data(t,ankL)); ...     % R11
            (Data(t,t3R)-Data(t,t4R)), (Data(t,t3L)-Data(t,t4L)); ...
            Data(t,lmb)-Data(t,str), 0];
        
        RR(1,:) = D*L(1,1)+Data(t,elbR);
        RR(2,:) = D*L(2,1)+Data(t,wstR);
        RR(3,:) = D*L(3,1)+Data(t,wstR);
        RR(4,:) = D*L(4,1)+Data(t,mcp3R);
        RR(5,:) = D*L(5,1)+Data(t,t3R);
        RR(6,:) = D*L(6,1)+Data(t,t3R);
        RR(7,:) = D*L(7,1)+Data(t,mcp4R);
        RR(8,:) = D*L(8,1)+Data(t,t4R);
        RR(9,:) = D*L(9,1)+Data(t,mcp5R);
        RR(10,:) = D*L(10,1)+Data(t,t5R);
        RR(11,:) = D*L(11,1)+Data(t,ankR);
        RR(12,:) = D*L(12,1)+Data(t,str);
        
        RR(1,:) = D*L(1,1)+Data(t,wstR);%Data(t,elbR);
        RR(2,:) = D*L(2,1)+Data(t,mcp5R);%Data(t,wstR);
        RR(3,:) = D*L(3,1)+Data(t,ankR)/2+Data(t,t5R)/2;
        RR(4,:) = D*L(4,1)+Data(t,mcp4R);%Data(t,mcp3R);
        RR(5,:) = D*L(5,1)+Data(t,t3R);
        RR(6,:) = D*L(6,1)+Data(t,t3R);
        RR(7,:) = D*L(7,1)+Data(t,t4R);%Data(t,mcp4R);
        RR(8,:) = D*L(8,1)+Data(t,t4R);
        RR(9,:) = D*L(9,1)+Data(t,mcp5R);
        RR(10,:) = D*L(10,1)+Data(t,t5R);
        RR(11,:) = D*L(11,1)+Data(t,ankR);
        RR(12,:) = D*L(12,1)+Data(t,t4R)/2+Data(t,t5R)/2;
        RR(13,:) = D*L(13,1)+Data(t,str);
        
        
        RL(1,:) = D*L(1,2)+Data(t,elbL);
        RL(2,:) = D*L(2,2)+Data(t,wstL);
        RL(3,:) = D*L(3,2)+Data(t,wstL);
        RL(4,:) = D*L(4,2)+Data(t,mcp3L);
        RL(5,:) = D*L(5,2)+Data(t,t3L);
        RL(6,:) = D*L(6,2)+Data(t,t3L);
        RL(7,:) = D*L(7,2)+Data(t,mcp4L);
        RL(8,:) = D*L(8,2)+Data(t,t4L);
        RL(9,:) = D*L(9,2)+Data(t,mcp5L);
        RL(10,:) = D*L(10,2)+Data(t,t5L);
        RL(11,:) = D*L(11,2)+Data(t,ankL);
        RL(12,:) = D*L(12,2)+0;
        
        RL(1,:) = D*L(1,2)+Data(t,wstL);%Data(t,elbL);
        RL(2,:) = D*L(2,2)+Data(t,mcp5L);%Data(t,wstL);
        RL(3,:) = D*L(3,2)+Data(t,ankL)/2+Data(t,t5L)/2;
        RL(4,:) = D*L(4,2)+Data(t,mcp4L);%Data(t,mcp3L);
        RL(5,:) = D*L(5,2)+Data(t,t3L);
        RL(6,:) = D*L(6,2)+Data(t,t3L);
        RL(7,:) = D*L(7,2)+Data(t,t4L);%Data(t,mcp4L);
        RL(8,:) = D*L(8,2)+Data(t,t4L);
        RL(9,:) = D*L(9,2)+Data(t,mcp5L);
        RL(10,:) = D*L(10,2)+Data(t,t5L);
        RL(11,:) = D*L(11,2)+Data(t,ankL);
        RL(12,:) = D*L(12,2)+Data(t,t4L)/2+Data(t,t5L)/2;
        RL(13,:) = D*L(13,2)+0;
        
        
    end
    
    % radii array to calculate the center of mass of the right wing
    if Right == 1
        R = .5*[Data(t,shdR)+Data(t,elbR), 0; ...   % R1
            Data(t,elbR)+Data(t,wstR), 0; ...   % R2
            2*Data(t,wstR), 0; ...                         % R3
            Data(t,wstR)+Data(t,mcp3R), 0; ... % R4
            Data(t,mcp3R)+Data(t,t3R), 0; ...   % R5
            Data(t,mcp3R)+Data(t,t3R), 0; ...   % R6
            Data(t,wstR)+Data(t,mcp4R), 0; ... % R7
            Data(t,mcp4R)+Data(t,t4R), 0; ...   % R8
            Data(t,wstR)+Data(t,mcp5R), 0; ... % R9
            Data(t,mcp5R)+Data(t,t5R), 0; ...   % R10
            Data(t,lmb)+Data(t,ankR), 0];
        L = [(Data(t,shdR)-Data(t,elbR)), 0; ...   % R1
            (Data(t,elbR)-Data(t,wstR)), 0; ...   % R2
            0, 0; ...                                                       % R3
            (Data(t,wstR)-Data(t,mcp3R)), 0; ... % R4
            (Data(t,mcp3R)-Data(t,t3R)), 0; ...   % R5
            (Data(t,mcp3R)-Data(t,t3R)), 0; ...   % R6
            (Data(t,wstR)-Data(t,mcp4R)), 0; ... % R7
            (Data(t,mcp4R)-Data(t,t4R)), 0; ...   % R8
            (Data(t,wstR)-Data(t,mcp5R)), 0; ... % R9
            (Data(t,mcp5R)-Data(t,t5R)), 0; ...   % R10
            (Data(t,lmb)-Data(t,ankR)), 0]; ...     % R11
            
        
        RR(1,:) = D*L(1,1)+Data(t,elbR);
        RR(2,:) = D*L(2,1)+Data(t,wstR);
        RR(3,:) = D*L(3,1)+Data(t,wstR);
        RR(4,:) = D*L(4,1)+Data(t,mcp3R);
        RR(5,:) = D*L(5,1)+Data(t,t3R);
        RR(6,:) = D*L(6,1)+Data(t,t3R);
        RR(7,:) = D*L(7,1)+Data(t,mcp4R);
        RR(8,:) = D*L(8,1)+Data(t,t4R);
        RR(9,:) = D*L(9,1)+Data(t,mcp5R);
        RR(10,:) = D*L(10,1)+Data(t,t5R);
        RR(11,:) = D*L(11,1)+Data(t,ankR);
        
        
        RL(1,:) = D*L(1,2)+0;
        RL(2,:) = D*L(2,2)+0;
        RL(3,:) = D*L(3,2)+0;
        RL(4,:) = D*L(4,2)+0;
        RL(5,:) = D*L(5,2)+0;
        RL(6,:) = D*L(6,2)+0;
        RL(7,:) = D*L(7,2)+0;
        RL(8,:) = D*L(8,2)+0;
        RL(9,:) = D*L(9,2)+0;
        RL(10,:) = D*L(10,2)+0;
        RL(11,:) = D*L(11,2)+0;
        
            
    
    end
    % radii array to calculate the center of mass of the left wing
    if Left == 1
        R = [0, .5*(Data(t,shdL)+Data(t,elbL)); ...   % R1
             0, .5*(Data(t,elbL)+Data(t,wstL)); ...   % R2
             0, Data(t,wstL); ...                         % R3
             0, .5*(Data(t,wstL)+Data(t,mcp3L)); ... % R4
             0, .5*(Data(t,mcp3L)+Data(t,t3L)); ...   % R5
             0, .5*(Data(t,mcp3L)+Data(t,t3L)); ...   % R6
             0, .5*(Data(t,wstL)+Data(t,mcp4L)); ... % R7
             0, .5*(Data(t,mcp4L)+Data(t,t4L)); ...   % R8
             0, .5*(Data(t,wstL)+Data(t,mcp5L)); ... % R9
             0, .5*(Data(t,mcp5L)+Data(t,t5L)); ...   % R10
             0, .5*(Data(t,lmb)+Data(t,ankL))];
         
         L = [0, (Data(t,shdL)-Data(t,elbL)); ...   % R1
            0, (Data(t,elbL)-Data(t,wstL)); ...   % R2
            0, 0; ...                                                       % R3
            0, (Data(t,wstL)-Data(t,mcp3L)); ... % R4
            0, (Data(t,mcp3L)-Data(t,t3L)); ...   % R5
            0, (Data(t,mcp3L)-Data(t,t3L)); ...   % R6
            0, (Data(t,wstL)-Data(t,mcp4L)); ... % R7
            0, (Data(t,mcp4L)-Data(t,t4L)); ...   % R8
            0, (Data(t,wstL)-Data(t,mcp5L)); ... % R9
            0, (Data(t,mcp5L)-Data(t,t5L)); ...   % R10
            0, (Data(t,lmb)-Data(t,ankL))]; ...     % R11
            
        RR(1,:) = D*L(1,1)+0;
        RR(2,:) = D*L(2,1)+0;
        RR(3,:) = D*L(3,1)+0;
        RR(4,:) = D*L(4,1)+0;
        RR(5,:) = D*L(5,1)+0;
        RR(6,:) = D*L(6,1)+0;
        RR(7,:) = D*L(7,1)+0;
        RR(8,:) = D*L(8,1)+0;
        RR(9,:) = D*L(9,1)+0;
        RR(10,:) = D*L(10,1)+0;
        RR(11,:) = D*L(11,1)+0;
        
        
        RL(1,:) = D*L(1,2)+Data(t,elbL);
        RL(2,:) = D*L(2,2)+Data(t,wstL);
        RL(3,:) = D*L(3,2)+Data(t,wstL);
        RL(4,:) = D*L(4,2)+Data(t,mcp3L);
        RL(5,:) = D*L(5,2)+Data(t,t3L);
        RL(6,:) = D*L(6,2)+Data(t,t3L);
        RL(7,:) = D*L(7,2)+Data(t,mcp4L);
        RL(8,:) = D*L(8,2)+Data(t,t4L);
        RL(9,:) = D*L(9,2)+Data(t,mcp5L);
        RL(10,:) = D*L(10,2)+Data(t,t5L);
        RL(11,:) = D*L(11,2)+Data(t,ankL);
        
            
    end
end

