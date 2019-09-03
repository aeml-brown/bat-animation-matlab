xl = 5;
yl = 100; % wingspan

str_X0 = xl/4;
str_Y0 = 0;
str_Z0 = 0;

lmb_X0 = -xl/4;
lmb_Y0 = 0;
lmb_Z0 = 0;

shdR_X0 = xl/2;
shdR_Y0 = xl/yl;
shdR_Z0 = 0;

elbR_X0 = str_X0;
elbR_Y0 = shdR_Y0 + yl/4;
elbR_Z0 = 0;

wstR_X0 = shdR_X0;
wstR_Y0 = shdR_Y0 + yl/2;
wstR_Z0 = 0;

t3R_X0 = shdR_X0;
t3R_Y0 = shdR_Y0 + yl;
t3R_Z0 = 0;

ankR_X0 = -xl/2;
ankR_Y0 = xl/yl;
ankR_Z0 = 0;

t5R_X0 = ankR_X0;
t5R_Y0 = ankR_Y0 + yl/2;
t5R_Z0 = 0;

t4R_X0 = ankR_X0;
t4R_Y0 = ankR_Y0 + yl;
t4R_Z0 = 0;

mcp3R_X0 = shdR_X0;
mcp3R_Y0 = shdR_Y0 + 3*yl/4;
mcp3R_Z0 = 0;

mcp4R_X0 = 0;
mcp4R_Y0 = shdR_Y0 + 3*yl/4;
mcp4R_Z0 = 0;

mcp5R_X0 = 0;
mcp5R_Y0 = shdR_Y0 + yl/2;
mcp5R_Z0 = 0;

shdL_X0 = xl/2;
shdL_Y0 = -xl/yl;
shdL_Z0 = 0;

elbL_X0 = str_X0;
elbL_Y0 = shdL_Y0 - yl/4;
elbL_Z0 = 0;

wstL_X0 = shdL_X0;
wstL_Y0 = shdL_Y0 - yl/2;
wstL_Z0 = 0;

t3L_X0 = shdL_X0;
t3L_Y0 = shdL_Y0 - yl;
t3L_Z0 = 0;

ankL_X0 = -xl/2;
ankL_Y0 = -xl/yl;
ankL_Z0 = 0;

t5L_X0 = ankL_X0;
t5L_Y0 = ankL_Y0 - yl/2;
t5L_Z0 = 0;

t4L_X0 = ankL_X0;
t4L_Y0 = ankL_Y0 - yl;
t4L_Z0 = 0;

mcp3L_X0 = shdL_X0;
mcp3L_Y0 = shdL_Y0 - 3*yl/4;
mcp3L_Z0 = 0;

mcp4L_X0 = 0;
mcp4L_Y0 = shdL_Y0 - 3*yl/4;
mcp4L_Z0 = 0;

mcp5L_X0 = 0;
mcp5L_Y0 = shdL_Y0 - yl/2;
mcp5L_Z0 = 0;








t = 0:.01:5;
%length = sqrt(Platex.^2+Platey.^2);
% frequency
omega = 5;

amp = pi/4;

theta = amp*sin(omega*t);


str_X = ones(size(t,2),1)*str_X0;
lmb_X = ones(size(t,2),1)*lmb_X0;
shdR_X = ones(size(t,2),1)*shdR_X0;
elbR_X = ones(size(t,2),1)*elbR_X0;
wstR_X = ones(size(t,2),1)*wstR_X0;
t3R_X = ones(size(t,2),1)*t3R_X0;
t4R_X = ones(size(t,2),1)*t4R_X0;
t5R_X = ones(size(t,2),1)*t5R_X0;
mcp3R_X = ones(size(t,2),1)*mcp3R_X0;
mcp4R_X = ones(size(t,2),1)*mcp4R_X0;
mcp5R_X = ones(size(t,2),1)*mcp5R_X0;
ankR_X = ones(size(t,2),1)*ankR_X0;
shdL_X = ones(size(t,2),1)*shdL_X0;
elbL_X = ones(size(t,2),1)*elbL_X0;
wstL_X = ones(size(t,2),1)*wstL_X0;
t3L_X = ones(size(t,2),1)*t3L_X0;
t4L_X = ones(size(t,2),1)*t4L_X0;
t5L_X = ones(size(t,2),1)*t5L_X0;
mcp3L_X = ones(size(t,2),1)*mcp3L_X0;
mcp4L_X = ones(size(t,2),1)*mcp4L_X0;
mcp5L_X = ones(size(t,2),1)*mcp5L_X0;
ankL_X = ones(size(t,2),1)*ankL_X0;


str_Y = cos(theta)'*str_Y0;
lmb_Y = cos(theta)'*lmb_Y0;
shdR_Y = ones(size(t,2),1)*shdR_Y0;
elbR_Y = cos(theta)'*elbR_Y0 - cos(theta)'*shdR_Y0 + shdR_Y;
wstR_Y = cos(theta)'*wstR_Y0 - cos(theta)'*shdR_Y0 + shdR_Y;
t3R_Y = cos(theta)'*t3R_Y0 - cos(theta)'*shdR_Y0 + shdR_Y;
t4R_Y = cos(theta)'*t4R_Y0 - cos(theta)'*shdR_Y0 + shdR_Y;
t5R_Y = cos(theta)'*t5R_Y0 - cos(theta)'*shdR_Y0 + shdR_Y;
mcp3R_Y = cos(theta)'*mcp3R_Y0 - cos(theta)'*shdR_Y0 + shdR_Y;
mcp4R_Y = cos(theta)'*mcp4R_Y0 - cos(theta)'*shdR_Y0 + shdR_Y;
mcp5R_Y = cos(theta)'*mcp5R_Y0 - cos(theta)'*shdR_Y0 + shdR_Y;
ankR_Y = ones(size(t,2),1)*ankR_Y0;
shdL_Y = ones(size(t,2),1)*shdL_Y0;
elbL_Y = cos(theta)'*elbL_Y0 - cos(theta)'*shdL_Y0 + shdL_Y;
wstL_Y = cos(theta)'*wstL_Y0 - cos(theta)'*shdL_Y0 + shdL_Y;
t3L_Y = cos(theta)'*t3L_Y0 - cos(theta)'*shdL_Y0 + shdL_Y;
t4L_Y = cos(theta)'*t4L_Y0 - cos(theta)'*shdL_Y0 + shdL_Y;
t5L_Y = cos(theta)'*t5L_Y0 - cos(theta)'*shdL_Y0 + shdL_Y;
mcp3L_Y = cos(theta)'*mcp3L_Y0 - cos(theta)'*shdL_Y0 + shdL_Y;
mcp4L_Y = cos(theta)'*mcp4L_Y0 - cos(theta)'*shdL_Y0 + shdL_Y;
mcp5L_Y = cos(theta)'*mcp5L_Y0 - cos(theta)'*shdL_Y0 + shdL_Y;
ankL_Y = ones(size(t,2),1)*ankL_Y0;

str_Z = sin(theta)'*str_Y0;
lmb_Z = sin(theta)'*lmb_Y0;
shdR_Z = zeros(size(t,2),1)*shdR_Y0;
elbR_Z = sin(theta)'*elbR_Y0 - sin(theta)'*shdR_Y0 + shdR_Z;
wstR_Z = sin(theta)'*wstR_Y0 - sin(theta)'*shdR_Y0 + shdR_Z;
t3R_Z = sin(theta)'*t3R_Y0 - sin(theta)'*shdR_Y0 + shdR_Z;
t4R_Z = sin(theta)'*t4R_Y0 - sin(theta)'*shdR_Y0 + shdR_Z;
t5R_Z = sin(theta)'*t5R_Y0 - sin(theta)'*shdR_Y0 + shdR_Z;
mcp3R_Z = sin(theta)'*mcp3R_Y0 - sin(theta)'*shdR_Y0 + shdR_Z;
mcp4R_Z = sin(theta)'*mcp4R_Y0 - sin(theta)'*shdR_Y0 + shdR_Z;
mcp5R_Z = sin(theta)'*mcp5R_Y0 - sin(theta)'*shdR_Y0 + shdR_Z;
ankR_Z = zeros(size(t,2),1)*ankR_Y0;
shdL_Z = zeros(size(t,2),1)*shdL_Y0;
elbL_Z = -sin(theta)'*elbL_Y0 + sin(theta)'*shdL_Y0 - shdL_Z;
wstL_Z = -sin(theta)'*wstL_Y0 + sin(theta)'*shdL_Y0 - shdL_Z;
t3L_Z = -sin(theta)'*t3L_Y0 + sin(theta)'*shdL_Y0 - shdL_Z;
t4L_Z = -sin(theta)'*t4L_Y0 + sin(theta)'*shdL_Y0 - shdL_Z;
t5L_Z = -sin(theta)'*t5L_Y0 + sin(theta)'*shdL_Y0 - shdL_Z;
mcp3L_Z = -sin(theta)'*mcp3L_Y0 + sin(theta)'*shdL_Y0 - shdL_Z;
mcp4L_Z = -sin(theta)'*mcp4L_Y0 + sin(theta)'*shdL_Y0 - shdL_Z;
mcp5L_Z = -sin(theta)'*mcp5L_Y0 + sin(theta)'*shdL_Y0 - shdL_Z;
ankL_Z = zeros(size(t,2),1)*ankL_Y0;


header = {"shdL_X" 'shdL_Y' 'shdL_Z' 'shdR_X' 'shdR_Y' 'shdR_Z' ...
          "wstL_X" 'wstL_Y' 'wstL_Z' 'wstR_X' 'wstR_Y' 'wstR_Z' ...
          "elbL_X" 'elbL_Y' 'elbL_Z' 'elbR_X' 'elbR_Y' 'elbR_Z' ...
          "t3L_X" 't3L_Y' 't3L_Z' 't3R_X' 't3R_Y' 't3R_Z' ...
          "t4L_X" 't4L_Y' 't4L_Z' 't4R_X' 't4R_Y' 't4R_Z' ...
          "t5L_X" 't5L_Y' 't5L_Z' 't5R_X' 't5R_Y' 't5R_Z' ...
          "mcp3L_X" 'mcp3L_Y' 'mcp3L_Z' 'mcp3R_X' 'mcp3R_Y' 'mcp3R_Z' ...
          "mcp4L_X" 'mcp4L_Y' 'mcp4L_Z' 'mcp4R_X' 'mcp4R_Y' 'mcp4R_Z' ...
          "mcp5L_X" 'mcp5L_Y' 'mcp5L_Z' 'mcp5R_X' 'mcp5R_Y' 'mcp5R_Z' ...
          "ankL_X" 'ankL_Y' 'ankL_Z' 'ankR_X' 'ankR_Y' 'ankR_Z' ...
          "lmb_X" 'lmb_Y' 'lmb_Z' 'str_X' 'str_Y' 'str_Z'};


Data = zeros(size(t,2),66);


Data(:,1) = shdL_X;
Data(:,3) = shdL_Y;
Data(:,2) = -shdL_Z;
Data(:,4) = shdR_X;
Data(:,6) = shdR_Y;
Data(:,5) = -shdR_Z;
Data(:,7) = wstL_X;
Data(:,9) = wstL_Y;
Data(:,8) = -wstL_Z;
Data(:,10) = wstR_X;
Data(:,12) = wstR_Y;
Data(:,11) = -wstR_Z;
Data(:,13) = elbL_X;
Data(:,15) = elbL_Y;
Data(:,14) = -elbL_Z;
Data(:,16) = elbR_X;
Data(:,18) = elbR_Y;
Data(:,17) = -elbR_Z;
Data(:,19) = t3L_X;
Data(:,21) = t3L_Y;
Data(:,20) = -t3L_Z;
Data(:,22) = t3R_X;
Data(:,24) = t3R_Y;
Data(:,23) = -t3R_Z;
Data(:,25) = t4L_X;
Data(:,27) = t4L_Y;
Data(:,26) = -t4L_Z;
Data(:,28) = t4R_X;
Data(:,30) = t4R_Y;
Data(:,29) = -t4R_Z;
Data(:,31) = t5L_X;
Data(:,33) = t5L_Y;
Data(:,32) = -t5L_Z;
Data(:,34) = t5R_X;
Data(:,36) = t5R_Y;
Data(:,35) = -t5R_Z;
Data(:,37) = mcp3L_X;
Data(:,39) = mcp3L_Y;
Data(:,38) = -mcp3L_Z;
Data(:,40) = mcp3R_X;
Data(:,42) = mcp3R_Y;
Data(:,41) = -mcp3R_Z;
Data(:,43) = mcp4L_X;
Data(:,45) = mcp4L_Y;
Data(:,44) = -mcp4L_Z;
Data(:,46) = mcp4R_X;
Data(:,48) = mcp4R_Y;
Data(:,47) = -mcp4R_Z;
Data(:,49) = mcp5L_X;
Data(:,51) = mcp5L_Y;
Data(:,50) = -mcp5L_Z;
Data(:,52) = mcp5R_X;
Data(:,54) = mcp5R_Y;
Data(:,53) = -mcp5R_Z;
Data(:,55) = ankL_X;
Data(:,57) = ankL_Y;
Data(:,56) = -ankL_Z;
Data(:,58) = ankR_X;
Data(:,60) = ankR_Y;
Data(:,59) = -ankR_Z;
Data(:,61) = lmb_X;
Data(:,63) = lmb_Y;
Data(:,62) = -lmb_Z;
Data(:,64) = str_X;
Data(:,66) = str_Y;
Data(:,65) = -str_Z;

Plate = [header; num2cell(Data)];