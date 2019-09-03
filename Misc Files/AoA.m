function [ thetaL, thetaR, phiL, phiR ] = AoA( GCSdata )
%UNTITLED2 Summary of this function goes here
%   Theta is the angle of attack
%   Phi is the angle between the plane vectors (wst-->shd) and (wst-->t5)

%% 3D Data Legend:
% Point #   Landmark   Columns
%    1        shdL       1:3
%    2        shdR       4:6
%    3        wstL       7:9
%    4        wstR      10:12
%    5        elbL      13:15
%    6        elbR      16:18
%    7         t3L      19:21
%    8         t3R      22:24
%    9         t4L      25:27
%    10        t4R      28:30
%    11        t5L      31:33
%    12        t5R      34:36
%    13       mcp3L     37:39
%    14       mcp3R     40:42
%    15       mcp4L     43:45
%    16       mcp4R     46:48
%    17       mcp5L     49:51
%    18       mcp5R     52:54
%    19       ankL      55:57
%    20       ankR      58:60
%    21       lmb       61:63
%    22       str       64:66

%% Practice Data
% clear, close all
% PYc001 = load ('/Users/davidboerma/Google Drive/Gust Response/Analysis/Control Trials/PYc001.mat');
% 
% GCSdata = PYc001.d;


%% Function
%% Left Wing
d = GCSdata;
v1L = d(:,1:3) - d(:,7:9); % shdL - wstL
v2L = d(:,31:33) - d(:,7:9); % t5L - wstL
wristL  = d(:,7:9);

% Calculate wrist velocity
wsmL    = NaN(size(wristL));
wvL = NaN(size(wristL));
waL     = NaN(size(wristL));
for i=1:3
    [ wsmL(:,i), wvL(:,i), waL(:,i) ] = smooth_data(wristL(:,i),2,5,800);
end

phiL = NaN(size(v1L,1),1);
thetaL = NaN(size(v1L,1),1);
for i=1:size(v1L,1)
    % the angle between the two plane vecors
    phiL(i) = acos(dot(v1L(i,:),v2L(i,:))/(norm(v1L(i,:))*norm(v2L(i,:))));
    
    % The angle between the v2/v1 plane and the wst velocity vector (i.e. approximate air velocity vector)
    % cross(v2,v1) for left wing to ensure that normal vector points dorsal
    thetaL(i) = acos( dot(cross(v2L(i,:),v1L(i,:)),wvL(i,:)) ./ (norm(v1L(i,:))*norm(v2L(i,:))*norm(wvL(i,:))*sin(phiL(i))) ) - pi/2;
end


%% Right Wing
v1R = d(:,4:6) - d(:,10:12); % shdR - wstR
v2R = d(:,34:36) - d(:,10:12); % t5R - wstR
wristR  = d(:,10:12);

% Calculate wrist velocity
wsmR    = NaN(size(wristR));
wvR = NaN(size(wristR));
waR     = NaN(size(wristR));
for i=1:3
    [ wsmR(:,i), wvR(:,i), waR(:,i) ] = smooth_data(wristR(:,i),2,5,800);
end

phiR = NaN(size(v1R,1),1);
thetaR = NaN(size(v1R,1),1);
for i=1:size(v1R,1)
    % the angle between the two plane vecors
    phiR(i) = acos(dot(v1R(i,:),v2R(i,:))/(norm(v1R(i,:))*norm(v2R(i,:))));
    
    % The angle between the v2/v1 plane and the wst velocity vector (i.e. approximate air velocity vector)
    % cross(v1,v2) for right wing to ensure that normal vector points dorsal
    thetaR(i) = acos( dot(cross(v1R(i,:),v2R(i,:)),wvR(i,:)) ./ (norm(v1R(i,:))*norm(v2R(i,:))*norm(wvR(i,:))*sin(phiR(i))) ) - pi/2;
end



%% Plot AoA
figure
plot(rad2deg(thetaL),'b','linewidth',2),hold on,plot(rad2deg(thetaR),'r','linewidth',2)
legend('Left','Right')
title('Angle of Attack')

%%
% k=PYc001.Kinematics;
% n=2;
% figure
% subplot(n,1,1)
% plot(k(:,3),'b','linewidth',2),hold on,plot(k(:,4),'r','linewidth',2)
% 
% subplot(n,1,2)
% plot(rad2deg(thetaL),'b','linewidth',2),hold on,plot(rad2deg(thetaR),'r','linewidth',2)
% 
% %% Plotting to visualize the wing, the vector normal to the plane, and the wrist velocity vector for Left and Right wings
% clear f p1 p2
% 
% f = 90; %frame to plot
% 
% %%%%%%%%%%%%%
% % Left Wing %
% %%%%%%%%%%%%%
% %Set origin to wstL
% dwstL = d - repmat(d(:,7:9),1,size(d,2)/3);
% pv1L = dwstL(:,1:3) - dwstL(:,7:9); % shdL - wstL
% pv2L = dwstL(:,31:33) - dwstL(:,7:9); % t5L - wstL
% 
% % Plot points on bat
% figure,hold on,grid on, axis equal
% for i=1:size(dwstL,2)/3
%     scatter3(dwstL(f,i*3-2),dwstL(f,i*3-1),dwstL(f,i*3),'k','filled')
% end
% 
% % Draw lines between points to indicate bones
% %Left Humerus
% p1=dwstL(f,1:3); %shdL
% p2=dwstL(f,13:15); %elbL
% plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'b','linewidth',2)
% clear p1 p2
% 
% %Left Radius
% p1=dwstL(f,13:15); %elbL
% p2=dwstL(f,7:9); %wstL
% plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'b','linewidth',2)
% clear p1 p2
% 
% %Left d5
% p1=dwstL(f,7:9); %wstL
% p2=dwstL(f,31:33); %t5L
% plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'b','linewidth',2)
% clear p1 p2
% 
% % Draw normal vector to plane
% for i=1:size(pv1L,1)
%     % the angle between the two plane vecors
%     p_phiL(i) = acos(dot(pv1L(i,:),pv2L(i,:))/(norm(pv1L(i,:))*norm(pv2L(i,:))));
% end
% p1=dwstL(f,7:9); %wstL
% p2=cross(pv2L(f,:),pv1L(f,:)) / (norm(pv1L(i,:))*norm(pv2L(i,:))*sin(p_phiL(i)));
% plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'g','linewidth',2)
% clear p1 p2
% 
% % Draw wst velocity vector
% for i=1:3
%     [ pwsmL(:,i), pwvL(:,i), pwaL(:,i) ] = smooth_data(wristL(:,i),2,5,800);
% end
% p1=dwstL(f,7:9); %wstL
% p2=(pwvL(f,:)-dwstL(f,7:9))/100;
% plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'k','linewidth',2)
% clear p1 p2
% 
% 
% %%%%%%%%%%%%%%
% % Right Wing %
% %%%%%%%%%%%%%%
% %Set origin to wstR
% dwstR = d - repmat(d(:,10:12),1,size(d,2)/3);
% pv1R = dwstR(:,4:6) - dwstR(:,10:12); % shdR - wstR
% pv2R = dwstR(:,34:36) - dwstR(:,10:12); % t5R - wstR
% 
% % Plot points on bat
% figure,hold on,grid on, axis equal
% for i=1:size(dwstR,2)/3
%     scatter3(dwstR(f,i*3-2),dwstR(f,i*3-1),dwstR(f,i*3),'k','filled')
% end
% 
% % Draw lines between points to indicate bones
% %Left Humerus
% % p1=dwstR(f,4:6); %shdR
% % p2=dwstR(f,16:18); %elbR
% % plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'r','linewidth',2)
% % clear p1 p2
% 
% %Left Radius
% p1=dwstR(f,4:6); %elbR
% p2=dwstR(f,10:12); %wstR
% plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'r','linewidth',2)
% clear p1 p2
% 
% %Left d5
% p1=dwstR(f,10:12); %wstR
% p2=dwstR(f,34:36); %t5R
% plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'r','linewidth',2)
% clear p1 p2
% 
% % Draw normal vector to plane
% for i=1:size(pv1R,1)
%     % the angle between the two plane vecors
%     p_phiR(i) = acos(dot(pv1R(i,:),pv2R(i,:))/(norm(pv1R(i,:))*norm(pv2R(i,:))));
% end
% p1=dwstR(f,10:12); %wstR
% p2=cross(v1R(f,:),v2R(f,:)) / (norm(v1R(i,:))*norm(v2R(i,:))*sin(p_phiR(i)));
% plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'g','linewidth',2)
% clear p1 p2
% 
% % Draw wst velocity vector
% for i=1:3
%     [ pwsmR(:,i), pwvR(:,i), pwaR(:,i) ] = smooth_data(wristR(:,i),2,5,800);
% end
% p1=dwstR(f,10:12); %wstL
% p2=(pwvR(f,:)-dwstR(f,10:12))/100;
% plot3([p1(1) p2(1)], [p1(2) p2(2)], [p1(3) p2(3)],'k','linewidth',2)
% clear p1 p2


end

