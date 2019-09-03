function [haxes] = xsubplots(int,T)
% This function creates an amount of subplots dictated by the value of the
% int input. Each subplot has x-axis limit of 0 to T, where T represents
% the number of timesteps. The function returns a column vector, haxes,
% which stores references to all of the subplots. This function is called
% in the plots function, where the user makes and plots their desired
% calculations
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

    % creates a column vector to store subplots
    haxes = [int,1];
    % loops for each subplot
    for i=1:1:int
        haxes(i,1) = subplot(int,1,i); % creates and stores ith subplot
        xlim([0,T]); % sets x-axis limits
    end
        
end

