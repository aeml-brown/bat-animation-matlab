function [] = addVideo(structure,int)
% This funtion is important because it is called whenever the video needs
% to be viewed. When called, the input structure is s, the structure where
% the video data is stored, and the input int is k, the integer which
% represents the frame number.
%
% Copyright Julian Lopez-Uricoechea & Kenny Breuer, Brown University 2019
%

    % changes the colormap so that the video is more clear
    colormap bone
    % display the image indexed in the structure referenced by int
    image(structure(int).cdata);
    % creates a title for the axes where the video frame is display with
    % the frame number
    title(['Frame' num2str(int)]);
end

