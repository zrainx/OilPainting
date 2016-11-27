clc;
close all;
clear;

% set parameters
setParameters;

% read photos
sourceImage = im2double(imread('sample.png'));
% create canvas
canvas = zeros(size(sourceImage));
% show output
figure
subplot(1,2,1);
imshow(sourceImage);
title('Source Image');
 
subplot(1,2,2);
imshow(canvas);
title('Canvas');

% paint
canvas=paint(sourceImage,paintParameters); 

% show result
% figure
subplot(1,2,1);
imshow(sourceImage);
title('Source Image');

subplot(1,2,2);
imshow(canvas);
title('Canvas Ok');