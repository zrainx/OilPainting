function [ x, y ] = stroke_location( i, width, height )
%STROKE_LOCATION Chooses the location of the ith stroke
%   currently returns a random X,Y

    x = randi([1, height]);
    y = randi([1, width]);
end

