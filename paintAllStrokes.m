function [canvas]=paintAllStrokes(canvas,strokes,R,paintParameters)
% the strokes are rendered in random order to prevent an undesirable appearance of
% regularity in the brush strokes.
n=numel(strokes{1});
alpha=paintParameters.alpha;
[imageHeight,imageWidth,~]=size(canvas);
% m = fspecial('gaussian', 2*R+1, R/3);
m = fspecial('disk', R);
m = 1/m(R+1, R+1) .* m; %normalizing so the middle become 1

for index=randperm(n)
    color=alpha*strokes{1}{index};
    r_0=strokes{2}{index}(1,:);
    c_0=strokes{2}{index}(2,:);
    t_0=1:(2*R+1):(numel(r_0))*(2*R+1);
    t_1=1:((numel(r_0)-1)*(2*R+1));
    r_1=interp1(t_0,r_0,t_1,'spline');
    c_1=interp1(t_0,c_0,t_1,'spline');
    r_1=floor(r_1);
    c_1=floor(c_1);
    
    for i=1:numel(r_1)
        r=r_1(i);c=c_1(i);
        if(r>0)&&(r<imageHeight)&&(c>0)&&(c<imageWidth)
            % color(1,1,:)=[0 1 0];
            % canvas(r,c,:) = color;
            % crop for running out of bounds
            top = min(R, r-1);
            bottom = min(R, imageHeight-r);
            left = min(R, c-1);
            right = min(R, imageWidth-c);
            g = m(R+1-top:R+1+bottom, R+1-left:R+1+right);
            for chnl = 1:3
                org_can = canvas(r-top:r+bottom, c-left:c+right, chnl) .* (ones(size(g))-g);
                new_stk = double(color(chnl)).*g;
                canvas(r-top:r+bottom, c-left:c+right,chnl) = org_can + new_stk;
            end
        end
    end
end


end
