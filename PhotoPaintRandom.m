% 
% Input: a photo
% Output: a stylized painting image based on input photo
%   By repeatedly selecting a random point on photo and placing a stroke of 
% that color on the image
% 
% Authoer: Yi Hua @ Rice University
% 

clc;
% close all;
clear;
%% Read in photo & Create canvas
photo = im2double(imread('DSC01128.jpg'));
canvas = zeros(size(photo));

% Display inputs
figure
subplot(1,2,1);
imshow(photo);
title('Photo');
 
subplot(1,2,2);
imshow(canvas);
title('Canvas');

[height, width, chnl] = size(photo);

%% Repeat placing stroke
brushhalf = 50;

numIter = 7000;
i = numIter;
while (i > 0),
    
    % select a random point on photo
    % This could be improved to select more interesting areas in the image
    [x, y] = stroke_location(i, width, height);
    
    % add a stroke on canvas
    % could try decrease size as i increases; size = constant/i or something
    % could try orient the stroke in the gradient orientation
    % could try adding texture to stroke
    canvas = add_stroke(x, y, brushhalf, photo(x,y,:), canvas);
    
    i = i - 1;
    if (mod(i, 150) == 0),
        brushhalf = brushhalf - 1;
    end
    
    if (mod(i, 100) == 0),
        subplot(1,2,1);
        imshow(photo);
        title('Photo');
        drawnow

        subplot(1,2,2);
        imshow(canvas);
        title('Canvas');
        drawnow

    end
end

%% Display result
% Display inputs
% figure
subplot(1,2,1);
imshow(photo);
title('Photo');

subplot(1,2,2);
imshow(canvas);
title('Canvas');