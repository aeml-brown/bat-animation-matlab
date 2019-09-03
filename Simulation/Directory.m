global Left
global Right
global Fr
global x
global D
global stat
global trans
global camRot
global camIntr
global L
global Root
global dataFile
global videoFile
global DLT
global fRate
global Mass

Left = 0; % change to 1 if only want to plot left wing
Right = 0; % change to 1 if only want to plot right wing

%initial frame
Fr = 1;

% number of plots
x = 3;

% Display  
D = 1; % 1 for just animation

% If sternum is stationary throughout
stat = 0; % 0 for moving sternum, 1 for stationary sternum. Make sure sternum is defined in initial frame for stationary sternum

% Camera Translation Vector
trans = [-24.9870971458, -16.889623348, 1727.840189];

DLT = 0; % 0 if user has rotation and intrinsic matrices, 1 if user has DLT coefficients 

% Camera Rotation Matrix
camRot = [0.963526771838,0.202427359863,0.175040920733;
-0.149470854952,0.949629359202,-0.275431558942;
-0.22197888069,0.239222164776,0.945250301459];

% Camera Intrinsic Parameters Matrix
camIntr = [4751.66322969,0,1136.62984575;
0,4929.48452763,572.097312986;
0,0,1];

% DLT Coefficients
L = [-1053.9; % L1
    -2240;    % L2
    -439.39;  % L3
    588.45;   % L4
    1812.7;   % L5
    -1365.2;  % L6
    1075.5;   % L7
    469.84;   % L8
    0.92638;  % L9
    -0.72379; % L10
    -1.1633]; % L11
% Mass Distribution
Mass = [2; % Humerus
        .5; % Radius/6/Ulna
        .5;  % Wrist Bones/digit 1
        .5;  % Metacarpal - digits 2/3
        1;  % Phalanx 1 - digit 3
        1;  % Phalanx 2 - digit 3
        1;  % Metacarpal - digit 4
        1;  % Phalanges - digit 4
        1;  % Metacarpal - digit 5
        1;  % Phalanges - digit 5
        2; % Femur, Tibia/Fibula,Ankle/Foot
        .5;
        1000]; % Head+Trunk
 

Root = 'C:\Users\Julian\Dropbox (Brown)\MATLAB\';  % change to appropriate path
%Root = 'C:\Users\Julian\Documents\';
dataFile = 'BatData_Sample.csv';  % change to appropriate path


videoFile = 'BatVideo_DavidBoerma_1.b.avi';  % change to appropriate path
%videoFile = 'BatVideo_Breuer_1.c.avi';

fRate = 1;

% Edit "plots" function for custom plot calculations and labels
% Edit "Faces" function to setup the faces between the vertices