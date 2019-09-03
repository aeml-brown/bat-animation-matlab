function [] = sidePlot(paused,Bat,Mouse,N,k)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%Plot shoulder to wingtip
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

   %left side
   Lpoints = [];
   oldPoints = [];
   
   if paused == 0
   dL = sqrt((Bat(1,7) - Bat(1,1))^2 + (Bat(2,7) - Bat(2,1))^2 + (Bat(3,7) - Bat(3,1))^2);
   %right side
   dR = sqrt((Bat(1,8) - Bat(1,2))^2 + (Bat(2,8) - Bat(2,2))^2 + (Bat(3,8) - Bat(3,2))^2);
   subplot(1,3,3);
   
   Lpoints = [Lpoints; k+63, dL, dR,];
   
   plot(Lpoints(:, 1), Lpoints(:, 2), 'b');
   hold on
   plot(Lpoints(:,1),Lpoints(:,3), 'r');
   xlim([63,N+64]);
   ylim([0,200]);
   end
   if Mouse == 1
       frame = ginput;
       
       k = round(frame(1,1)) - 63;
       N = k + 1;
       oldPoints = Lpoints;
       for i=1:+1:k-1
       oldPoints(1,:) = [];
       end
       oldPoints = flip(oldPoints);
       Lpoints = [Lpoints; oldPoints];
       Mouse = 0
       %play
       %frame = round
   end
end

