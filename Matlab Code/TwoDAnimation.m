function [] = TwoDAnimation(axes,Bat)
% This function is where all of the logic of the animation is handled. For
% each basic structure of the bat, a basic configuration of connecting
% points is created to represent the structure. Depending on whether
% other points are being tracked, then those other points are added to the
% configuration of the structure. The function takes in axes which
% represents the axes where the animation is to be plotted. The input Bat
% represents the Bat array which contains the coordinates of all of the
% points in the current timestep. dstr represents the sternum displacement
% from the current timestep to the first timestep. col represents the
% amount coordinated being tracked. header represents the row-vector of
% point names. figure represents the figure where the animation will be
% plotted. Left and Right are the integers chosen by the user which
% determine which side of the bat is in the animation, if not both. az and
% el represent the camera rotation. 
%   
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

    global W
    global Left
    global Right

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

    
    
    %Sturm-Pelvis
    strlmb = [Bat(1,str),Bat(1,lmb);Bat(2,str),Bat(2,lmb)];
    
    A = strlmb(1,:);
    B = strlmb(2,:);
    
    plot(axes,strlmb(1,:),strlmb(2,:),'g','LineWidth',5)
    hold on
    set(axes,'Nextplot','add');
  
    
    
    %Leg R
    if Left == 0
        % basic configuration
        legR = [Bat(1,lmb),Bat(1,ankR);Bat(2,lmb),Bat(2,ankR)];
        size = 2;
        % if the right knee is tracked then it's added to the configuration
        if isfinite(kneeR) == 1
            legR = [legR(:,1) [Bat(1,kneeR);Bat(2,kneeR)] legR(:,size)];
            size = size + 1;
        end
        % if the right hip is tracked then it's added to the configuration
        if isfinite(hipR) == 1
            legR = [legR(:,1) [Bat(1,hipR);Bat(2,hipR)] legR(:,2:size)];
            
        end
        
        plot(axes,legR(1,:),legR(2,:),'r','LineWidth',5)
    
        
    end
    %end
    
    if Right == 0
    %Leg L
        % basic configuration
        legL = [Bat(1,lmb),Bat(1,ankL);Bat(2,lmb),Bat(2,ankL)];
        size = 2;
        % if the left knee is tracked then it's added to the configuration
        if isfinite(kneeL) == 1
            legL = [legL(:,1) [Bat(1,kneeL);Bat(2,kneeL)] legL(:,size)];
            size = size + 1;
        end
        % if the left hip is tracked then it's added to the configuration
        if isfinite(hipL) == 1
            legL = [legL(:,1) [Bat(1,hipL);Bat(2,hipL)] legL(:,2:size)];
            
        end
      
     
        plot(axes,legL(1,:),legL(2,:),'r','LineWidth',5)
    
        
    end
    
    % Mark the "head" (in front of the sternum)
    plot(axes,Bat(1,str),Bat(2,str), 'ro','MarkerSize',15,'MarkerFaceColor',[.5,.5,.5]) 
    
    
    if Left == 0
        % Arm-Third Finger R
        
        % basic configuration
        armR = [Bat(1,shdR),Bat(1,elbR),Bat(1,wstR),Bat(1,t3R); ...
            Bat(2,shdR),Bat(2,elbR),Bat(2,wstR),Bat(2,t3R)];

        size = 4; %number of columns
        % if ip3R is tracked then it's added to the configuration
        if isfinite(ip3R) == 1
            armR = [armR(:,1:3) [Bat(1,ip3R); Bat(2,ip3R)] armR(:,size)];
            size = size + 1;
        end
         % if mcp3R is tracked then it's added to the configuration
        if isfinite(mcp3R) == 1
            armR = [armR(:,1:3) [Bat(1,mcp3R); Bat(2,mcp3R)] armR(:,4:size)];
            size = size + 1;
        end
        % if Sn06R is tracked then it's added to the configuration
        if isfinite(Sn06R) == 1
            armR = [armR(:,1:3) [Bat(1,Sn06R); Bat(2,Sn06R)] armR(:,4:size)];
            size = size + 1;
        end
        % if Sn03R is tracked then it's added to the configuration
        if isfinite(Sn03R) == 1
            armR = [armR(:,1:2) [Bat(1,Sn03R); Bat(2,Sn03R)] armR(:,3:size)];
            size = size + 1;
        end
        % if Sn02R is tracked then it's added to the configuration
        if isfinite(Sn02R) == 1
            armR = [armR(:,1:1) [Bat(1,Sn02R); Bat(2,Sn02R)] armR(:,2:size)];
           
        end

    

        plot(axes,armR(1,:),armR(2,:),'r','LineWidth',5)
    end
    
    if Right == 0
        % Arm-Third Finger L
        
        % basic configuration
        armL = [Bat(1,shdL),Bat(1,elbL),Bat(1,wstL),Bat(1,t3L); ...
            Bat(2,shdL),Bat(2,elbL),Bat(2,wstL),Bat(2,t3L)];

        size = 4; % number of columns
        % if ip3L is tracked then it's added to the configuration
        if isfinite(ip3L) == 1
            armL = [armL(:,1:3) [Bat(1,ip3L); Bat(2,ip3L)] armL(:,size)];
            size = size + 1;
        end
         % if mcp3L is tracked then it's added to the configuration
        if isfinite(mcp3L) == 1
            armL = [armL(:,1:3) [Bat(1,mcp3L); Bat(2,mcp3L)] armL(:,4:size)];
            size = size + 1;
        end
        % if Sn06L is tracked then it's added to the configuration
        if isfinite(Sn06L) == 1
            armL = [armL(:,1:3) [Bat(1,Sn06L); Bat(2,Sn06L)] armL(:,4:size)];
            size = size + 1;
        end
        % if Sn03L is tracked then it's added to the configuration
        if isfinite(Sn03L) == 1
            armL = [armL(:,1:2) [Bat(1,Sn03L); Bat(2,Sn03L)] armL(:,3:size)];
            size = size + 1;
        end
        % if Sn02L is tracked then it's added to the configuration
        if isfinite(Sn02L) == 1
            armL = [armL(:,1:1) [Bat(1,Sn02L); Bat(2,Sn02L)] armL(:,2:size)];
           
        end

      

        plot(axes,armL(1,:),armL(2,:),'r','LineWidth',5)
    end
    
     
    if Left ==0
        %4th Finger R
        
        % basic configuration
        fng4R = [Bat(1,wstR),Bat(1,t4R);Bat(2,wstR),Bat(2,t4R)];
        size = 2;
        % if ip4R is tracked then it's added to the configuration
        if isfinite(ip4R) == 1
            fng4R = [fng4R(:,1) [Bat(1,ip4R); Bat(2,ip4R)] fng4R(:,size)];
            size = size + 1;
        end
        % if mcp4R is tracked then it's added to the configuration
        if isfinite(mcp4R) == 1
            fng4R = [fng4R(:,1) [Bat(1,mcp4R); Bat(2,mcp4R)] fng4R(:,2:size)];
            size = size + 1;
        end
        % if Sn05R is tracked then it's added to the configuration
        if isfinite(Sn05R) == 1
            fng4R = [fng4R(:,1) [Bat(1,Sn05R); Bat(2,Sn05R)] fng4R(:,2:size)];
          
        end
     
        
        plot(axes,fng4R(1,:),fng4R(2,:), 'r','LineWidth',5)
    
    end
    
    if Right == 0
        
    %4th Finger L
        % basic configuration
        fng4L = [Bat(1,wstL),Bat(1,t4L);Bat(2,wstL),Bat(2,t4L)];
        size = 2;
        % if ip4L is tracked then it's added to the configuration
        if isfinite(ip4L) == 1
            fng4L = [fng4L(:,1) [Bat(1,ip4L); Bat(2,ip4L)] fng4L(:,size)];
            size = size + 1;
        end
        % if mcp4L is tracked then it's added to the configuration
        if isfinite(mcp4L) == 1
            fng4L = [fng4L(:,1) [Bat(1,mcp4L); Bat(2,mcp4L)] fng4L(:,2:size)];
            size = size + 1;
        end
        % if Sn05L is tracked then it's added to the configuration
        if isfinite(Sn05L) == 1
            fng4L = [fng4L(:,1) [Bat(1,Sn05L); Bat(2,Sn05L)] fng4L(:,2:size)];
          
        end
        
        
        plot(axes,fng4L(1,:),fng4L(2,:), 'r','LineWidth',5)
    
    end
    
    if Left == 0
        %5th Finger R
        % basic configuration
        fng5R = [Bat(1,wstR),Bat(1,t5R);Bat(2,wstR),Bat(2,t5R)];
        size = 2;
        % if ip5R is tracked then it's added to the configuration
        if isfinite(ip5R) == 1
            fng5R = [fng5R(:,1) [Bat(1,ip5R); Bat(2,ip5R)] fng5R(:,size)];
            size = size + 1;
        end
        % if mcp5R is tracked then it's added to the configuration
        if isfinite(mcp5R) == 1
            fng5R = [fng5R(:,1) [Bat(1,mcp5R); Bat(2,mcp5R)] fng5R(:,2:size)];
            size = size + 1;
        end
        % if Sn04R is tracked then it's added to the configuration
        if isfinite(Sn04R) == 1
            fng5R = [fng5R(:,1) [Bat(1,Sn04R); Bat(2,Sn04R)] fng5R(:,2:size)];
            
        end
       
        
        plot(axes,fng5R(1,:),fng5R(2,:), 'r','LineWidth',5)
    
    end
    

    if Right == 0
        
    %5th Finger L
        % basic configuration
        fng5L = [Bat(1,wstL),Bat(1,t5L);Bat(2,wstL),Bat(2,t5L)];
        size = 2;
        % if ip5L is tracked then it's added to the configuration
        if isfinite(ip5L) == 1
            fng5L = [fng5L(:,1) [Bat(1,ip5L); Bat(2,ip5L)] fng5L(:,size)];
            size = size + 1;
        end
        % if mcp5L is tracked then it's added to the configuration
        if isfinite(mcp5L) == 1
            fng5L = [fng5L(:,1) [Bat(1,mcp5L); Bat(2,mcp5L)] fng5L(:,2:size)];
            size = size + 1;
        end
        % if Sn04L is tracked then it's added to the configuration
        if isfinite(Sn04L) == 1
            fng5L = [fng5L(:,1) [Bat(1,Sn04L); Bat(2,Sn04L)] fng5L(:,2:size)];
           
        end
    
        
        plot(axes,fng5L(1,:),fng5L(2,:), 'r','LineWidth',5)
    
    end
    
    if Left == 0
    
        %Trailing Edge R
        
        % basic configuration
        teR = [Bat(1,ankR),Bat(1,t5R),Bat(1,t4R),Bat(1,t3R);Bat(2,ankR),Bat(2,t5R),Bat(2,t4R),Bat(2,t3R)];
        size = 4;
        % if Te09R is tracked then it's added to the configuration
        if isfinite(Te09R) == 1
            teR = [teR(:,1:3) [Bat(1,Te09R); Bat(2,Te09R)] teR(:,4)];
            size = size + 1;
        end
        % if Te08R is tracked then it's added to the configuration
        if isfinite(Te08R) == 1
            teR = [teR(:,1:3) [Bat(1,Te08R); Bat(2,Te08R)] teR(:,4:size)];
            size = size + 1;
        end
        % if Te07R is tracked then it's added to the configuration
        if isfinite(Te07R) == 1
            teR = [teR(:,1:3) [Bat(1,Te07R); Bat(2,Te07R)] teR(:,4:size)];
            size = size + 1;
        end
        % if Te06R is tracked then it's added to the configuration
        if isfinite(Te06R) == 1
            teR = [teR(:,1:2) [Bat(1,Te06R); Bat(2,Te06R)] teR(:,3:size)];
            size = size + 1;
        end
        % if Te05R is tracked then it's added to the configuration
        if isfinite(Te05R) == 1
            teR = [teR(:,1:2) [Bat(1,Te05R); Bat(2,Te05R)] teR(:,3:size)];
            size = size + 1;
        end
        % if Te04R is tracked then it's added to the configuration
        if isfinite(Te04R) == 1
            teR = [teR(:,1:2) [Bat(1,Te04R); Bat(2,Te04R)] teR(:,3:size)];
            size = size + 1;
        end
        % if Te03R is tracked then it's added to the configuration
        if isfinite(Te03R) == 1
            teR = [teR(:,1) [Bat(1,Te03R); Bat(2,Te03R)] teR(:,2:size)];
            size = size + 1;
        end
        % if Te02R is tracked then it's added to the configuration
        if isfinite(Te02R) == 1
            teR = [teR(:,1) [Bat(1,Te02R); Bat(2,Te02R)] teR(:,2:size)];
            size = size + 1;
        end
        % if Te01R is tracked then it's added to the configuration
        if isfinite(Te01R) == 1
            teR = [teR(:,1) [Bat(1,Te01R); Bat(2,Te01R)] teR(:,2:size)];
            
        end
        
     
        
        plot(axes,teR(1,:),teR(2,:), 'g','LineWidth',3)
    
    end  
    
    if Right == 0
    
        %Trailing Edge L
        
        % basic configuration
        teL = [Bat(1,ankL),Bat(1,t5L),Bat(1,t4L),Bat(1,t3L);Bat(2,ankL),Bat(2,t5L),Bat(2,t4L),Bat(2,t3L)];
        size = 4;
        % if Te09L is tracked then it's added to the configuration
        if isfinite(Te09L) == 1
            teL = [teL(:,1:3) [Bat(1,Te09L); Bat(2,Te09L)] teL(:,4)];
            size = size + 1;
        end
        % if Te08L is tracked then it's added to the configuration
        if isfinite(Te08L) == 1
            teL = [teL(:,1:3) [Bat(1,Te08L); Bat(2,Te08L)] teL(:,4:size)];
            size = size + 1;
        end
        % if Te07L is tracked then it's added to the configuration
        if isfinite(Te07L) == 1
            teL = [teL(:,1:3) [Bat(1,Te07L); Bat(2,Te07L)] teL(:,4:size)];
            size = size + 1;
        end
        % if Te06L is tracked then it's added to the configuration
        if isfinite(Te06L) == 1
            teL = [teL(:,1:2) [Bat(1,Te06L); Bat(2,Te06L)] teL(:,3:size)];
            size = size + 1;
        end
        % if Te05L is tracked then it's added to the configuration
        if isfinite(Te05L) == 1
            teL = [teL(:,1:2) [Bat(1,Te05L); Bat(2,Te05L)] teL(:,3:size)];
            size = size + 1;
        end
        % if Te04L is tracked then it's added to the configuration
        if isfinite(Te04L) == 1
            teL = [teL(:,1:2) [Bat(1,Te04L); Bat(2,Te04L)] teL(:,3:size)];
            size = size + 1;
        end
        % if Te03L is tracked then it's added to the configuration
        if isfinite(Te03L) == 1
            teL = [teL(:,1) [Bat(1,Te03L); Bat(2,Te03L)] teL(:,2:size)];
            size = size + 1;
        end
        % if Te02L is tracked then it's added to the configuration
        if isfinite(Te02L) == 1
            teL = [teL(:,1) [Bat(1,Te02L); Bat(2,Te02L)] teL(:,2:size)];
            size = size + 1;
        end
        % if Te01L is tracked then it's added to the configuration
        if isfinite(Te01L) == 1
            teL = [teL(:,1) [Bat(1,Te01L); Bat(2,Te01L)] teL(:,2:size)];
            
        end
        
    
        
        plot(axes,teL(1,:),teL(2,:), 'g','LineWidth',3)
    
    end  
    
    if Left == 0
    sj = 0;
        %Leading Edge R
        
        % basic configuration
        leR = [Bat(1,shdR),Bat(1,wstR),Bat(1,t3R);Bat(2,shdR),Bat(2,wstR),Bat(2,t3R)];
        size = 3;
        % if Sj21R is tracked then it's added to the configuration
        if isfinite(Sj21R) == 1
            leR = [leR(:,1:2) [Bat(1,Sj21R); Bat(2,Sj21R)] leR(:,size)];
            size = size + 1;  
        end
        % if ip3R is tracked then it's added to the configuration
        if isfinite(ip3R) == 1
            leR = [leR(:,1:2) [Bat(1,ip3R); Bat(2,ip3R)] leR(:,3:size)];
            size = size + 1;
        end
        % if mcp3R is tracked then it's added to the configuration
        if isfinite(mcp3R) == 1
            leR = [leR(:,1:2) [Bat(1,mcp3R); Bat(2,mcp3R)] leR(:,3:size)];
            size = size + 1;
        end
        % if Sj20R is tracked then it replaces mcp3R in the configuration
        if isfinite(Sj20R) == 1
            leR(:,2) = [Bat(1,Sj20R); Bat(2,Sj20R)];            
        end
        % if Sn06R is tracked then it's added to the configuration
        if isfinite(Sn06R) == 1
            leR = [leR(:,1:2) [Bat(1,Sn06R); Bat(2,Sn06R)] leR(:,3:size)];
            size = size + 1;
        end
        % if Sj19R is tracked then it replaces wstR in the configuration
        if isfinite(Sj19R) == 1
            leR(:,2) = [Bat(1,Sj19R); Bat(2,Sj19R)];
            sj = 1; % to keep track if Sj19R is tracked
        end
        % if Sj18R is tracked then it's added to the configuration
        if isfinite(Sj18R) == 1
            % if Sj19R is not tracked then it replaces wstR in the
            % configuration
            if sj == 0
                leR(:,2) = [Bat(1,Sj18R); Bat(2,Sj18R)];
            % if sj19 is tracked then it is added to the configuration
            elseif sj == 1
                leR = [leR(:,1) [Bat(1,Sj18R); Bat(2,Sj18R)] leR(:,2:size)];
                size = size + 1;
            end
        end
        % if Le03R is tracked then it's added to the configuration
        if isfinite(Le03R) == 1
            leR = [leR(:,1) [Bat(1,Le03R); Bat(2,Le03R)] leR(:,2:size)];
            size = size + 1;
        end
        % if Le02R is tracked then it's added to the configuration
        if isfinite(Le02R) == 1
            leR = [leR(:,1) [Bat(1,Le02R); Bat(2,Le02R)] leR(:,2:size)];
            size = size + 1;
        end
        % if Le01R is tracked then it's added to the configuration
        if isfinite(Le01R) == 1
            leR = [leR(:,1) [Bat(1,Le01R); Bat(2,Le01R)] leR(:,2:size)];
           
        end
        
      
        
        plot(axes,leR(1,:),leR(2,:), 'y','LineWidth',3)
    
    end  
    
    if Right == 0
    
        %Leading Edge L
        
        % basic configuration
        leL = [Bat(1,shdL),Bat(1,wstL),Bat(1,t3L);Bat(2,shdL),Bat(2,wstL),Bat(2,t3L)];
        size = 3;
        % if Sj21L is tracked then it's added to the configuration
        if isfinite(Sj21L) == 1
            leL = [leL(:,1:2) [Bat(1,Sj21L); Bat(2,Sj21L)] leL(:,size)];
            size = size + 1;  
        end
        % if ip3L is tracked then it's added to the configuration
        if isfinite(ip3L) == 1
            leL = [leL(:,1:2) [Bat(1,ip3L); Bat(2,ip3L)] leL(:,3:size)];
            size = size + 1;
        end
        % if mcp3L is tracked then it's added to the configuration
        if isfinite(mcp3L) == 1
            leL = [leL(:,1:2) [Bat(1,mcp3L); Bat(2,mcp3L)] leL(:,3:size)];
            size = size + 1;
        end
        % if Sn06L is tracked then it's added to the configuration
        if isfinite(Sn06L) == 1
            leL = [leL(:,1:2) [Bat(1,Sn06L); Bat(2,Sn06L)] leL(:,3:size)];
            size = size + 1;
        end
        % if Sj19L is tracked then it replaces wstL in the configuration
        if isfinite(Sj19L) == 1
            leL(:,2) = [Bat(1,Sj19L); Bat(2,Sj19L)];
            sj = 1; % to keep track if Sj19L is tracked
        end
        % if Sj18L is tracked then it's added to the configuration
        if isfinite(Sj18L) == 1
            % if Sj19L is not tracked then it replaces wstR in the
            % configuration
            if sj == 0
                leL(:,2) = [Bat(1,Sj18L); Bat(2,Sj18L)];
            % if sj19 is tracked then it is added to the configuration
            elseif sj == 1
                leL = [leL(:,1) [Bat(1,Sj18L); Bat(2,Sj18L)] leL(:,2:size)];
                size = size + 1;
            end
        end
        % if Le03L is tracked then it's added to the configuration
        if isfinite(Le03L) == 1
            leL = [leL(:,1) [Bat(1,Le03L); Bat(2,Le03L)] leL(:,2:size)];
            size = size + 1;
        end
        % if Le02L is tracked then it's added to the configuration
        if isfinite(Le02L) == 1
            leL = [leL(:,1) [Bat(1,Le02L); Bat(2,Le02L)] leL(:,2:size)];
            size = size + 1;
        end
        % if Le01L is tracked then it's added to the configuration
        if isfinite(Le01L) == 1
            leL = [leL(:,1) [Bat(1,Le01L); Bat(2,Le01L)] leL(:,2:size)];
            
        end
        
      
        
        plot(axes,leL(1,:),leL(2,:), 'y','LineWidth',3)
    
    end  
          
    % All the vertices
    
    V = zeros(W/3,2);
    
    for i=1:+1:W/3
        V(i,:) = [Bat(1,i),Bat(2,i)];
            
    end
    
    
 
    % calls the Faces function to have an array of faces
    F = Faces();     
    
    % creates the faces
    patch('Faces', F, 'Vertices', V, 'FaceColor', 'Blue', 'EdgeColor', 'Red');
    % sets the camera rotation
    
    %view([az,el])
end