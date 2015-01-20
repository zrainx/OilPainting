function [ canvas ] = add_stroke( x, y, wsize, color, canvas )
%ADD_STROKE add an stroke of given color and given size at location (x,y)
%           on canvas.
%   Currently just adds a gaussian of given size at the location.

if (wsize < 1),
    canvas(x,y,:) = color;
else
%     disp('not implemented yet!');
    % transparency as gaussian centered at (x,y)
    sigma = wsize/5;
    g = fspecial('gaussian', 2*wsize+1, sigma); % could move this outside every stroke
    g = 1/g(wsize+1, wsize+1) .* g; %normalizing so the middle become 1
    % crop for running out of bounds
    top = min(wsize, x-1);
    bottom = min(wsize, size(canvas,1)-x);
    left = min(wsize, y-1);
    right = min(wsize, size(canvas,2)-y);
    g = g(wsize+1-top:wsize+1+bottom, wsize+1-left:wsize+1+right);
    
    for chnl = 1:3,
% % %   Fix the out of bounds problem by cropping the gaussian
        org_can = canvas(x-top:x+bottom, y-left:y+right, chnl) .* (ones(size(g))-g);
        new_stk = double(color(chnl)).*g;
        canvas(x-top:x+bottom, y-left:y+right,chnl) = org_can + new_stk;
    end
    
end

end

