function [ LCSdata ] = global2Local( GCSdata )
%global2local is a function that expresses global 3D coordinates in a local coordinate system defined by the shoulder and lumbar markers on a bat 
%   This script is for use with data for my proposed chapter, "Wings as inertial appendages: how
%   bats recover from aerial stumbles"

%% 2. Define body coordinate system axes
d = GCSdata;

% Make shdmid the origin
shdmid = (d(:,1:3) + d(:,4:6)) / 2; % midpoint between shoulders in global coordinate system
shdorig = d - repmat(shdmid,1,22);

%         % Plot new points to check origin
%         figure
% %         f=175;
%         for i=1:22
%             scatter3(shdorig(f,i*3-2),shdorig(f,i*3-1),shdorig(f,i*3),20,'filled')
%             hold on
%         end
%         hold on
%         plot3([shdorig(f,1) shdorig(f,4)],[shdorig(f,2) shdorig(f,5)],[shdorig(f,3) shdorig(f,6)],'k')
%         plot3([shdorig(f,4) shdorig(f,61)],[shdorig(f,5),shdorig(f,62)],[shdorig(f,6),shdorig(f,63)],'k')
%         plot3([shdorig(f,61),shdorig(f,1)],[shdorig(f,62) shdorig(f,2)],[shdorig(f,63) shdorig(f,3)],'k')
%         axis equal
%         xlabel('X axis')
%         ylabel('Y axis')
%         zlabel('Z axis')

% Define local axes using shdL, shdR, and lmb
for i=1:length(shdorig)
    mid(i,:)  = (shdorig(i,1:3) + shdorig(i,4:6)) / 2; % midpoint between shoulders in local coordinate system (Origin in local coordinate system)
    Y(i,:)    = shdorig(i,1:3) - shdorig(i,4:6); % vector from shdR to shdL (shdL-shdR)
    newX(i,:) = mid(i,:) - shdorig(i,61:63); % cranio-caudal axis (from lumbar to midpoint b/t shoulders; shd.mid- - lmb)
    newZ(i,:) = cross(newX(i,:),Y(i,:));% dorso-ventral axis orthogonal to CCaxis and shoulder vector, pointing dorsally
    newY(i,:) = cross(newZ(i,:),newX(i,:));
end

for i=1:length(newX)
    Xl(i,:) = newX(i,:)/norm(newX(i,:));
    Yl(i,:) = newY(i,:)/norm(newY(i,:));
    Zl(i,:) = newZ(i,:)/norm(newZ(i,:));
end


%         % Show global and local axes for current frame
%         figure(2), hold on
%         s=10; %scalar for making unit-length axes longer for plotting
% 
%             %Global axes
%         plot3([0 s*1],[0 0],[0 0],'r','linewidth',4), hold on
%         plot3([0 0],[0 s*1],[0 0],'g','linewidth',4)
%         plot3([0 0],[0 0],[0 s*1],'b','linewidth',4)
% 
%             %Local axes
%         plot3([0 s*Xl(f,1)],[0 s*Xl(f,2)],[0 s*Xl(f,3)],'r','linewidth',1)
%         plot3([0 s*Yl(f,1)],[0 s*Yl(f,2)],[0 s*Yl(f,3)],'g','linewidth',1)
%         plot3([0 s*Zl(f,1)],[0 s*Zl(f,2)],[0 s*Zl(f,3)],'b','linewidth',1)
%         grid on, axis equal


%% 3. Use dot products to express points in local coordinate system (for mathematical explanation, see Parent, Rick. Computer Animation: Algorithms and Techniques. p422, Figure B.7
for i=1:length(shdorig)
   for k=1:22
       Dl(i,k*3-2:k*3) = [dot(shdorig(i,k*3-2:k*3),Xl(i,:)), dot(shdorig(i,k*3-2:k*3),Yl(i,:)), dot(shdorig(i,k*3-2:k*3),Zl(i,:))];
   end
end

LCSdata = Dl;

%% 4. Check points in local coordinate system by plotting

%         figure, hold on
%         % f=14;
%         for i=1:22
%             scatter3(Dl(f,i*3-2),Dl(f,i*3-1),Dl(f,i*3),20,'filled')
%             hold on
%         end
%         hold on
%         plot3([Dl(f,1) Dl(f,4)],[Dl(f,2) Dl(f,5)],[Dl(f,3) Dl(f,6)],'k')
%         plot3([Dl(f,4) Dl(f,61)],[Dl(f,5),Dl(f,62)],[Dl(f,6),Dl(f,63)],'k')
%         plot3([Dl(f,61),Dl(f,1)],[Dl(f,62) Dl(f,2)],[Dl(f,63) Dl(f,3)],'k')
%         axis equal
%         xlabel('X axis')
%         ylabel('Y axis')
%         zlabel('Z axis')
% 
%         % calculate new local axes in local coordinate system (should align with new "global" axes)
%         for i=1:length(Dl)
%             m(i,:)  = (Dl(i,1:3) + Dl(i,4:6)) / 2; % midpoint between shoulders in local coordinate system (Origin in local coordinate system)
%             y(i,:)    = Dl(i,1:3) - Dl(i,4:6); % vector from shdR to shdL (shdL-shdR)
%             newx(i,:) = m(i,:) - Dl(i,61:63); % cranio-caudal axis (from lumbar to midpoint b/t shoulders; shd.mid- - lmb)
%             newz(i,:) = cross(newx(i,:),y(i,:));% dorso-ventral axis orthogonal to CCaxis and shoulder vector, pointing dorsally
%             newy(i,:) = cross(newz(i,:),newx(i,:));
%         end
% 
%         for i=1:length(newx)
%             xl(i,:) = newx(i,:)/norm(newx(i,:));
%             yl(i,:) = newy(i,:)/norm(newy(i,:));
%             zl(i,:) = newz(i,:)/norm(newz(i,:));
%         end
% 
%         %Plot the axes
%             %Global axes
%         plot3([0 s*1],[0 0],[0 0],'r','linewidth',4), hold on
%         plot3([0 0],[0 s*1],[0 0],'g','linewidth',4)
%         plot3([0 0],[0 0],[0 s*1],'b','linewidth',4)
% 
%             %Local axes
%             s=13;
%         plot3([0 s*xl(f,1)],[0 s*xl(f,2)],[0 s*xl(f,3)],'r','linewidth',1)
%         plot3([0 s*yl(f,1)],[0 s*yl(f,2)],[0 s*yl(f,3)],'g','linewidth',1)
%         plot3([0 s*zl(f,1)],[0 s*zl(f,2)],[0 s*zl(f,3)],'b','linewidth',1)
%         grid on, axis equal

end

