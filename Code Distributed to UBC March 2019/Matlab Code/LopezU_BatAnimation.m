%% Initialize Variables
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

global Left
global Right
global Fr
global x
global D
global stat
global trans
global camRot
global camIntr
global Root
global dataFile
global videoFile
global H
global N 
global xData
global yData
global zData
global DLT
global fRate
global U
global Ux
global Uy
global Uz
global Ax
global Ay
global Az
global k
global Mouse
global paused
global az
global el
global xl
global yl
global zl
global xBasisData
global yBasisData
global zBasisData
global thetaData
global phiData
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
global Points
global W
global Mass
global xBasis
global yBasis
global zBasis
global xcData
global ycData
global zcData
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

Directory

%% Open and Read Data File

% Reading Data File
formatspec = '%s%s';
filename = sprintf(formatspec,Root,dataFile); 
fileID = fopen(filename);
dataArray = importdata(filename);

% Initializing Data array
Data = dataArray.data;
% Initializing Points array which contains one row of all the point names
Points = dataArray.textdata;
Points = strtrim(Points);
  


H = size(Data,1); % number of timesteps
W = size(Data,2); % number of points tracked

% Separate variable manipulated to pause and play the animation

N = H;




% Organize data

% redefine W as coordinates tracked in new Data array. Necessary if
% original points are taken out


[Points2] = organize(Points,W);
% this deletes any empty cells in Points2 
%Points2(cellfun('isempty',Points2)) = [];

% redefines Points as the newly organized Points2
Points = Points2;


warning off;
%% Open and Read Video File

% Only reads video file if the option to view the video is chosen and if
% the entire video has not been read in already. This second part is useful
% since reading the video file is time consuming

if exist('s', 'var') == 0
    s = [0 0];
end
if (D == 2 || D == 3)

    % Reads video file
    vidObj = VideoReader(sprintf(formatspec,Root,videoFile)); 

    % checks whether current video stored is the new one being read in
    if size(s,2) ~= round(vidObj.Duration * vidObj.FrameRate)

        % Determine the height and width of the frames.
        vidHeight = vidObj.Height;
        vidWidth = vidObj.Width;

        % Create a movie structure array, s.
        s = struct('cdata',zeros(vidHeight,vidWidth,1,'uint8'),...
            'colormap',gray);

        % adds video frames to s until there are not any more frames to add
        j = 1;
        while hasFrame(vidObj)
            s(j).cdata = readFrame(vidObj);
            j = j+1;
        end



        Frames = size(s,2);

    end
end




%% Initial Position
% The main purpose of this section is to define an initial position which
% is to be stationary throughout the animation

Bat = zeros(3,W/3); % create an array of points

%loop through array to add points to every position
for i=1:+1:W/3
    Bat(1,i) = Data(Fr,3*i -2);% add x-position to ith column in the array
    Bat(3,i) = -Data(Fr,3*i -1); % add negative y-position to ith column
    Bat(2,i) = Data(Fr,3*i); % add z-position to ith column
end

% finds the position in the Points array which equals "str" and sets str
% equal to that column number so that the sternum can be easily referenced
for i=1:+1:W/3
    switch Points{1,i}
        case  'str'
            str = i;
        case 'lmb'
            lmb = i;
        case 'shdR'
            shdR = i;
        case 'shdL'
            shdL = i;
    end
end


% sturm1 represents the position of the sternum at the initial frame. This
% is used when the user wants the sternum to be stationary throughout the
% animation
sturm1 = [Bat(1,str), Bat(2,str), Bat(3,str)];
%% determining velocity arrays and axis limits
% purpose of section is to determine axes limits based on the min and max
% of the x, y, and z coordinates and to calculate the velocity for all the
% points at all timesteps


% initializes arrays of zeros

xData = zeros(H,W/3);
yData = zeros(H,W/3);
zData = zeros(H,W/3);

for j=1:+1:W/3
    for i=1:+1:H
        xData(i,j) = Data(i,3*j -2); % contains all x-coordinate data
        zData(i,j) = -Data(i,3*j -1); % contains all y-coordinate data
        yData(i,j) = Data(i,3*j); % contains all y-coordinate data
    end
end




% calculates x, y, and z velocities of all the points at all timesteps

Ux = derivative(xData,5,2);
Uy = derivative(yData,5,2);
Uz = derivative(zData,5,2);

% calculates x, y, and z accelerations of all the points at all timesteps
Ax = derivative(Ux,3,2);
Ay = derivative(Uy,3,2);
Az = derivative(Uz,3,2);




U = sqrt(Ux.^2+Uy.^2+Uz.^2);


global minX
global maxX
global minY
global maxY
global minZ
global maxZ



% calculates min and max of x, y, and z data 
%if C == 1
    minX = min(min(xData));
    maxX = max(max(xData));
    minY = min(min(yData));
    maxY = max(max(yData));
    minZ = min(min(zData));
    maxZ = max(max(zData));
% also considers camera position if requested
%{
elseif C == 0
    minX = min(min(min(xData)),trans(1));
    maxX = max(max(max(xData)),trans(1));
    minY = min(min(min(yData)),-trans(3));
    maxY = max(max(max(yData)),-trans(3));
    minZ = min(min(min(zData)),trans(2));
    maxZ = max(max(max(zData)),trans(2));
end
%}

%% Translating to spherical coordinates

xSphData = NaN(H,W/3);
ySphData = NaN(H,W/3);
zSphData = NaN(H,W/3);

Origin = NaN(H,3);


if Left == 0 && Right == 0
    for i=1:H
        Origin(i,:) = .5*[xData(i,shdR)+xData(i,shdL),yData(i,shdR)+yData(i,shdL),zData(i,shdR)+zData(i,shdL)];
        %Origin(i,:) = [xData(i+5,lmb),yData(i+5,lmb),zData(i+5,lmb)];
    end
    %Origin(H,:) = [xData(H-1,lmb),yData(H-1,lmb),zData(H-1,lmb)];
end

if Left == 1 || Right == 1

    for i=1:H-5
        Origin(i,:) = [xData(i+5,lmb),yData(i+5,lmb),zData(i+5,lmb)];
    end

    Origin(H,:) = [xData(H-1,lmb),yData(H-1,lmb),zData(H-1,lmb)];
    
end

[xBasisData, yBasisData, zBasisData] = BatBasis(Origin,xData,yData,zData);



if Left ~= 1 || Right ~= 1

    Origin = [xBasisData(:,shdR),zeros(H,1),zBasisData(:,shdR)];

    [xBasisData, yBasisData, zBasisData] = BatBasis(Origin,xBasisData,yBasisData,zBasisData);
end

% calculates x, y, and z velocities in the new basis of all the points at all timesteps

UxBasis = derivative(xBasisData,5,2);
UyBasis = derivative(yBasisData,5,2);
UzBasis = derivative(zBasisData,5,2);

% calculates x, y, and z accelerations in the new basis of all the points at all timesteps
AxBasis = derivative(UxBasis,3,2);
AyBasis = derivative(UyBasis,3,2);
AzBasis = derivative(UzBasis,3,2);


UBat = sqrt(UxBasis.^2+UyBasis.^2+UzBasis.^2);
ABat = sqrt(AxBasis.^2+AyBasis.^2+AzBasis.^2);

% angular velocities
Omegax = NaN(H,W/3);
Omegay = NaN(H,W/3);
Omegaz = NaN(H,W/3);

for j=1:W/3
    for i=1:H
        r = [xBasisData(i,j),yBasisData(i,j),zBasisData(i,j)];
        v = [UxBasis(i,j),UyBasis(i,j),UzBasis(i,j)];
        Omega = cross(r,v)/(r(1)^2+r(2)^2+r(3)^2);
        Omegax(i,j) = Omega(1);
        Omegay(i,j) = Omega(2);
        Omegaz(i,j) = Omega(3);
                    
                    
    end
end

% angular accelerations
Alphax = derivative(Omegax,3,2);
Alphay = derivative(Omegay,3,2);
Alphaz = derivative(Omegaz,3,2);

% calculates x, y, and z accelerations in the bat basis of all the points at all timesteps
for j=1:W/3
    for i=1:H
        r = [xBasisData(i,j),yBasisData(i,j),zBasisData(i,j)];
        alpha = [Alphax(i,j),Alphay(i,j),Alphaz(i,j)];
        a = cross(alpha,r);
        accx(i,j) = a(1);
        accy(i,j) = a(2);
        accz(i,j) = a(3);
                    
                    
    end
end


% azimuthal angle
thetaData = NaN(H,W/3);
% polar angle
phiData = NaN(H,W/3);

for i=1:H
    for j=1:W/3
        phiData(i,j) = acos(zBasisData(i,j)/sqrt(((xBasisData(i,j))^2 ...
                              +yBasisData(i,j))^2+(zBasisData(i,j))^2));
        thetaData(i,j) = atan2(yBasisData(i,j),xBasisData(i,j));
        if thetaData(i,j) < 0
            thetaData(i,j) = thetaData(i,j) + 2*pi;
        end
        
        
    end
end

xcData = NaN(H,1);
ycData = NaN(H,1);
zcData = NaN(H,1);

for i=1:H
    [xc1, yc1, zc1] = centerOfMass(i,xBasisData,yBasisData,zBasisData);
    xcData(i) = xc1;
    ycData(i) = yc1;
    zcData(i) = zc1;
end

Uxc = derivative(xcData,5,2);
Uyc = derivative(ycData,5,2);
Uzc = derivative(zcData,5,2);

Axc = derivative(Uxc,3,2);
Ayc = derivative(Uyc,3,2);
Azc = derivative(Uzc,3,2);

Omegaxc = NaN(H,1);
Omegayc = NaN(H,1);
Omegazc = NaN(H,1);

for i=1:H
    r = [xcData(i),ycData(i),zcData(i)];
    v = [Uxc(i),Uyc(i),Uzc(i)];
    Omegac = cross(r,v)/(r(1)^2+r(2)^2+r(3)^2);
    Omegaxc(i) = Omegac(1);
    Omegayc(i) = Omegac(2);
    Omegazc(i) = Omegac(3);                                    
end

Alphaxc = derivative(Omegaxc,3,2);
Alphayc = derivative(Omegayc,3,2);
Alphazc = derivative(Omegazc,3,2);
                        
accxc = NaN(H,1);
accyc = NaN(H,1);
acczc = NaN(H,1);

Fx = NaN(H,1);
Fy = NaN(H,1);
Fz = NaN(H,1);

torquex = NaN(H,1);
torquey = NaN(H,1);
torquez = NaN(H,1);
torquex2 = NaN(H,1);
torquey2 = NaN(H,1);
torquez2 = NaN(H,1);

M = sum(Mass);

for i=1:H
     
     r2 = [xBasisData(i,18),yBasisData(i,18),zBasisData(i,18)];
     alpha2 = [Alphax(i,18),Alphay(i,18),Alphaz(i,18)];
     a2 = cross(alpha2,r2);
     accRxc(i) = a2(1);
     accRyc(i) = a2(2);
     accRzc(i) = a2(3);
     FRx(i) = 6*a2(1);
     FRy(i) = 6*a2(2);
     FRz(i) = 6*a2(3);
     FR = [FRx(i), FRy(i), FRz(i)];
     tR = cross(r2,FR);
     torqueRx(i) = tR(1);
     torqueRy(i) = tR(2);
     torqueRz(i) = tR(3);
     r3 = [xBasisData(i,17),yBasisData(i,17),zBasisData(i,17)];
     alpha3 = [Alphax(i,17),Alphay(i,17),Alphaz(i,17)];
     a3 = cross(alpha3,r3);
     accLxc(i) = a3(1);
     accLyc(i) = a3(2);
     accLzc(i) = a3(3);
     FLx(i) = 6*a3(1);
     FLy(i) = 6*a3(2);
     FLz(i) = 6*a3(3);
     FL = [FLx(i), FLy(i), FLz(i)];
     tL = cross(r3,FL);
     torqueLx(i) = tL(1);
     torqueLy(i) = tL(2);
     torqueLz(i) = tL(3);
     
     torqeNx(i) = torqueRx(i) + torqueLx(i);
     torqeNy(i) = torqueRy(i) + torqueLy(i);
     torqeNz(i) = torqueRz(i) + torqueLz(i);
     
     
     r = [xcData(i),ycData(i),zcData(i)];
     alpha = [Alphaxc(i),Alphayc(i),Alphazc(i)];
     a = cross(alpha,r);
     accxc(i) = a(1);
     accyc(i) = a(2);
     acczc(i) = a(3);
     
     Fx(i) = M*a(1);
     Fy(i) = M*a(2);
     Fz(i) = M*a(3);
     
     F = [Fx(i),Fy(i),Fz(i)];
     t = cross(r,F);
     
     torquex(i) = t(1);
     torquey(i) = t(2);
     torquez(i) = t(3);
     
     I = Inertia(i);
     
     t2 = I*alpha' + cross([Omegaxc(i);Omegayc(i);Omegazc(i)],I*[Omegaxc(i);Omegayc(i);Omegazc(i)]);
     
     torquex2(i) = t2(1);
     torquey2(i) = t2(2);
     torquez2(i) = t2(3);
     
                    
end



%% Plot side by side
% This is where the animation takes place. This section is only called if
% the user either just wants the animation or wants a side-by-side of the
% animation and the video. Before the animation, the desired calculation
% are plotted. There are two separte figures: one for the plots and one for
% the animation. The figures are positioned. The axes of the animation plot
% are set and the axes limits are stored in variables xl, yl, and zl. The
% while-loop is based while the variable k, the frame number, is less than 
% N, the total number of frames. During each loop, the Bat array is updated
% to contain the points to be plotted in the current frame. The viewpoint
% for the animation is then set. The animation is then plotted by calling
% animation. The current viewpoint and axes limits are found and then set
% again so that if the user zooms in or out or rotates during animation,
% then those changes are preserved. If the user has chosen to have a
% side-by-side with the video, then that will happen during the
% while-loop. The logic of using the mouse input is then taken care of.
% Then the line that denotes where the current frame is on the calculation
% plots. 

% only executes this section if user wants either just the animation or a
% side-by-side of the animation and the video
if D == 1 || D == 2
close all


% creates figure for the plots
fig = figure;

% creates the plots
[dR, dL, haxes] = plots(x,fig);

% sets the position of the figure for the plots and turns on the figure's
% ability to accept key inputs. Only key that is used on this figure is
% 'Tab' in order to activate the mouse to choose the frame.
set(gcf,'Name','Plots', 'Position', [50 300 560 420], 'KeyPressFcn', @key_pressed_fcn);


% creates figure for the animation
fig2 = figure(2);
% sets the position of the figure for the animation and turns on the figure's
% ability to accept key inputs.
set(gcf,'Name','Animation', 'Position', [640 300 560 420],'KeyPressFcn', @key_pressed_fcn);

% instantiates the variables



% sets axes limits according to minimum and maximum values
xlim([minX,maxX])
ylim([minY,maxY])
zlim([minZ,maxZ])
% stores axes limits in variables
xl = xlim;
yl = ylim;
zl = zlim;




trans = [trans(1), -trans(3), trans(2)];






% sets initial values for paused and Mouse variables so that at the
% beginnining of the animation, the program knows that it is not paused and
% that the mouse option is turn off.

paused =0;

Mouse = 0;


% initializes variable k, which will represent the frame number

k = Fr;

% This is the while-loop where all the logic for the animation takes
% place. In order to pause the animation, the variables k and N are changed
% by key commands such that N = k + 1. So that the while-loop doesn't end,
% there is an if-statement such that if N = k + 1, then k is not increased.
while k <= N %for j=1:+1:N
  
    %update data for kth frame
    for i=1:+1:W/3
        
        Bat(1,i) = Data(k, 3*i -2);
        Bat(3,i) = -Data(k, 3*i -1);
        Bat(2,i) = Data(k, 3*i);
        
        
        
    end
    
    % current position vector sternum
    sturm2 = [Bat(1,str), Bat(2,str), Bat(3,str)];
    
    % determines the translation of each point
    % if the user wants the animation to move freely, then there is no
    % tranlation
    if stat == 0
    ds = zeros(3,W/3);
    % if the user wants the sternum to stay in place, then the translation
    % if the difference between the position of the sternum in the initial
    % frame and the current frame
    elseif stat == 1
    ds = sturm2 - sturm1;
    end
    hold off
    
   
    
    % sets cfig equal to the current figure, which is the plot figure,
    % for future reference
    cfig = gcf;
    % sets the animation figure as the current figure
    set(0,'CurrentFigure',fig2)
    % creates a subplot for the animation if the user wants a side-by-side
    if D == 2
        hax = subplot(1,2,1); % creates reference for animation axes
    else 
        hax = gca; % creates refeence for animation axes
    end    
    
    % sets plot figure as current figure. Bug if this line is after the
    % animation is plotted
    set(0,'CurrentFigure',cfig)
    
    
    
    
    % sets the initial viewpoint and camera rotation  
    if k==Fr
        
      %  A = [transpose(trans);1];
       % B = Tr*A;
        %trans = [B(1),B(2),B(3)]
        % sets initial viewpoint
        
        view(hax,trans)
        
        
        
        [az,el] = view;
       
        %restoreView
        
        
    end
    
   
    
    
    % this calls the animation function with inputs referencing the
    % animation axes, the Bat array, the sternum translation, the number of
    % coordinates tracked, the header array, the animation figure, the Left
    % and Right integers, which determine which wings are plotted, and the
    % current viewpoint.
    animation(hax,Bat,ds,fig2,az, el);
    
    xc = 0;
    yc = 0;
    zc = 0;
    xcL = 0;
    ycL = 0;
    zcL = 0;
    xcR = 0;
    ycR = 0;
    zcR = 0;
    
    
    if Left == 0 && Right == 0
        [xc, yc, zc] = centerOfMass(k,xData,yData,zData);
        
        Left = 1;
        [xcL, ycL, zcL] = centerOfMass(k,xData,yData,zData);
        Left = 0;
        Right = 1;
        [xcR, ycR, zcR] = centerOfMass(k,xData,yData,zData);
        Right = 0;
        
    end
    
    
    if Left == 1
        [xcL, ycL, zcL] = centerOfMass(k,xData,yData,zData);
    end
    
    if Right == 1
        [xcR, ycR, zcR] = centerOfMass(k,xData,yData,zData);
    end

    xcL = 2*xcL;
    ycL = 2*ycL;
    zcL = 2*zcL;
    xcR = 2*xcR;
    ycR = 2*ycR;
    zcR = 2*zcR;
        
    
    quiver3([xc;yc;zc],[xc;yc;zc],[xc;yc;zc],110*[xBasis(1,k);yBasis(1,k);zBasis(1,k)], ...
        [xBasis(2,k);yBasis(2,k);zBasis(2,k)],[xBasis(3,k);yBasis(3,k);zBasis(3,k)]);
    
    
    plot3(hax,xc-ds(1),yc-ds(2),zc-ds(3), 'ro','MarkerSize',5,'MarkerFaceColor','w')
    plot3(hax,xcL-ds(1),ycL-ds(2),zcL-ds(3), 'ro','MarkerSize',5,'MarkerFaceColor','w')
    plot3(hax,xcR-ds(1),ycR-ds(2),zcR-ds(3), 'ro','MarkerSize',5,'MarkerFaceColor','w')
    
    % creates light right and up from the camera position
    camlight;
    % sets axes labels
    xlabel('x','FontSize',14);
    ylabel('y','FontSize',14);
    zlabel('z','FontSize',14);
    
    % sets new axes limits. This is important so that if new axes limits
    % are created in the previous iteration of the loop, then they are used
    % to set the new axes limits. This is used when the user zooms in or
    % out during the animation.
    xlim(xl);
    ylim(yl);
    zlim(zl);
    
    hold off
    
    %updates the figure during the loop
    drawnow
    
    
    
    
    % determines new viewpoint and axes limits. This is storing the
    % viewpoint and axes limits that the user changes while zooming or
    % rotating the animation
    [az, el] = view; 
    xl = xlim;
    yl = ylim;
    zl = zlim;
    
    %cfig = gcf;
    %set(0,'CurrentFigure',fig2)
    
    % executes only if user wants a side-by-side
    if D == 2
        hax2 = subplot(1,2,2); % creates a subplot for the video
    
        addVideo(s,k); % adds video to current axes with frame number as title
    end
    
    % sets plot figure as current figure, so that the mouse input only
    % works on that figure
    set(0,'CurrentFigure',fig)
    % only executes when the "Tab" key has been pressed which changes Mouse
    % to 1
    if Mouse == 1
       % stores where the mouse has clicked
       frame = ginput;
       % rounds the x-position of frame and sets it equal to k
       k = round(frame(1,1)); % sets frame number
       N = k + 1; % pauses the animation after the frame number has changed
       % turns off the mouse
       Mouse = 0;
       
    end
   
   % sets plot figure as current figure for the frame marker logic
   set(0,'CurrentFigure',fig);
   % loops for each plot
   for i=1:+1:x
        
       % stores the lines in the ith axes
       children = get(haxes(i), 'children');
       if Right == 1 || Left == 1
           if size(children,1) == 2
              % deletes the most recently create line which is the frame marker
              delete(children(1));
           end 
       else
           if size(children,1) == 3
              % deletes the most recently create line which is the frame marker
              delete(children(1));
           end 
       end
        
       %h = max(dR(:,i),dL(:,i))
       % determines the vertical minimum and maximum of the lines in the ith plot
       if Left == 0 && Right == 0
           Min = min(min(dR(:,i),dL(:,i)));
           Max = max(max(dR(:,i),dL(:,i)));
       elseif Left == 1
           Min = min(dL(:,i));
           Max = max(dL(:,i));
       elseif Right == 1
           Min = min(dR(:,i));
           Max = max(dR(:,i));
       end
       % determines range of lines in plot
       range = Max-Min;
       % sets vertical min and max of marker
       newMax = Max+range/10;
       newMin = Min-range/10;
       % plots marker at the current frame
       plot(haxes(i),[k,k]/fRate, [newMin,newMax], 'k');
       xlim(haxes(i),[0,H]/fRate)
        
        

    end
    
    % increments k if it is less than k. k is not incremented to be greater
    % than N so that the loop doesn't end unless requested
    if k < N
    k = k+1;
    
    end
   
  
   
end


end


%% plot superimposed
% This is where the superimposed animation takes place. The
% while-loop is based while the variable k, the frame number, is less than 
% N, the total number of frames. During each loop, the Bat array is updated
% to contain the points to be plotted in the current frame. The Bat coordinates
% are then transformed to pixel coordinates according to the information
% that the user has. The user can either have the DLT coefficients the camera
% rotation matrix, translation vector, and intrinsic parameters.

% only executes this section if user wants the animation superimposed on
% the video
if D == 3
close all




% defines tranformation matrix. Concactenates rotation matrix and
% translation vector
trans = transpose(trans);
M = [camRot, trans];


% Initializes variables
k = Fr;
paused = 0;
Mouse = 0;


% sets the position of the figure for the animation and turns on the figure's
% ability to accept key inputs.
set(gcf,'Name','Animation','KeyPressFcn', @key_pressed_fcn);

while k <= N %for j=1:+1:N
    
    %update data
    for i=1:+1:W/3
        Bat(1,i) = Data(k, 3*i -2); % x-coordinates for k-th frame
        Bat(2,i) = Data(k, 3*i -1); % y-coordinates for k-th frame
        Bat(3,i) = Data(k, 3*i); % z-coordinates for k-th fram
        if DLT == 0
            Bat(4,i) = 1; % for homogoneous coordinates
        end
    end
    
    
    hold off
    % executes if user is using transformation matrices and camera
    % intrinsic parameters
    if DLT == 0
        Bat = M*Bat; % transform from global coordinates to camera coordinates
        
        % normalize the homogoneous coordinates
        for i=1:+1:W/3
            z = Bat(3,i);
            Bat(1,i) = Bat(1,i)/z;
            Bat(2,i) = Bat(2,i)/z;
            Bat(3,i) = 1;

        end
        % multiplies camera coordinates by intrinsic parameters to convert
        % to pixel coordinates
        Bat = camIntr*Bat;
        % negates y-coordinates since pixel coordinates start in top-left
        Bat(2,:) = -Bat(2,:);
    end
    
    % executes if user is using DLT coefficients
    if DLT == 1
        for i=1:+1:W/3
            a = Bat(1,i);
            b = Bat(2,i);
            c = Bat(3,i);
            % DLT equations to convert from global coordinates to pixel
            % coordinates
            Bat(1,i) = (L(1)*a+L(2)*b+L(3)*c+L(4)) ...
                / (L(9)*a+L(10)*b+L(11)*c+1);
            Bat(2,i) = (L(5)*a+L(6)*b+L(7)*c+L(8)) ...
                / (L(9)*a+L(10)*b+L(11)*c+1);
        end       
    end
    % add video
    colormap bone
    image(gca,s(k).cdata);   
 
    % Make the video axes invisibles
    set(gca,'handlevisibility','off', ...
            'visible','off')
    
    % this calls the two-dimensional animation function with inputs
    % referencing the animation axes, the Bat array, the number of
    % coordinates tracked, the header array, and the Left
    % and Right integers, which determine which wings are plotted.
    TwoDAnimation(gca,Bat);
    
    % removes all the background colors of the animation axes so that the
    % video can be viewed
    set(gca, 'Color', 'none','visible','on','units','pixels'...
        ,'XColor','none','YColor','none')
        
    ax = gca;
    % sets the animation axes above the video axes
    h = uistack(ax, 'top');
    
    % sets axes title
    title(['Frame' num2str(k)]);
    
    % sets new axes limits
    xlim([0,vidWidth]);
    if DLT == 1
        ylim([0,vidHeight]);
    elseif DLT == 0
        ylim([-vidHeight,0]);
    end
    
    % updates axes
    drawnow
    
    
    if Mouse == 1
       frame = ginput;
       
       k = round(frame(1,1));
       N = k + 1;
       
       Mouse = 0;
       
    end
    
    
    
    % increments k if it is less than k. k is not incremented to be greater
    % than N so that the loop doesn't end unless requested
    if k < N
    k = k+1;
    
    end
    % delete the axes so that the program runs smoothly
    delete(h(10));
    delete(h(11));
    
   
end
end
 



%% key functions


function Key = key_pressed_fcn(fig_obj, eventDat)
    %get(fig_obj, 'CurrentKey')
    Key = eventDat.Key;
    
    
    global paused
    
    switch Key
        case 'leftarrow'
               rewind
        case 'rightarrow'
               fastforward
        case 'p'
               if paused == 0
                pause
               elseif paused == 1
                play  
               end
        case 'escape'
               quits
        case 'space'
               framebyframe
        case 'v'
               restoreView
        case 'tab'
               activateMouse
    end
    
    
end


function [] = rewind
    global k
    global N
    global paused
    k = k-6;
    if k<7
        k=1;
    end
    if paused == 1
        N = k + 1;
    end
    
end

function [] = fastforward
    global k
    global N
    global paused
    k = k+4;
    if paused == 1
        N = k + 1;
    end
end

function [] = activateMouse
    
    global Mouse
    Mouse = 1;
    pause
end

function [] = pause
    global k
    global N
    global paused
    
    paused = 1;
    N = k +1;
end

function [] = play
    global N
    global paused
    global H
    
    N = H-1;
   
    paused = 0;
end

function [] = quits
    global N
    global k
    N = k-1;
end

function [] = framebyframe
    global paused
    global N
    global k
    N = k + 1;
    paused = 1;
end


function [] = restoreView
    global trans
    global az
    global el
    global minX
    global maxX
    global minY
    global maxY
    global minZ
    global maxZ
    global xl
    global yl
    global zl
    
    
    xlim([minX,maxX])
    ylim([minY,maxY])
    zlim([minZ,maxZ])
    xl = xlim;
    yl = ylim;
    zl = zlim;
    
    
    view(trans)
    
    [az, el] = view;
   
    
end







