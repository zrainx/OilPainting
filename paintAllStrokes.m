function [canvas]=paintAllStrokes(canvas,strokes,R,paintParameters)
% the strokes are rendered in random order to prevent an undesirable appearance of 
% regularity in the brush strokes.
n=numel(strokes{1});
alpha=paintParameters.alpha;

% for index=1:n    
%     color=alpha*strokes{1}{index};
%     X=strokes{2}{index}(1,:);
%     Y=strokes{2}{index}(2,:);
%     X=floor(X);Y=floor(Y);
%       
%      for i=1:numel(X)
%          canvas(X(i),Y(i),:) = color;    
%      end
% end

for index=randperm(n)    
    X=strokes{2}{index}(1,:);
    Y=strokes{2}{index}(2,:);
    if numel(X)>1 
        S=1:(2*R+1):numel(X)*(2*R+1);
        SS=1:numel(X)*(2*R+1);
        XX=interp1(S,X,SS,'spline');
        YY=interp1(S,Y,SS,'spline');
    else
        XX=X;YY=Y;
    end
    XX=floor(XX);
    YY=floor(YY);
    color=alpha*strokes{1}{index};
    if (R<1)
        for i=1:numel(XX)
            canvas(XX(i),YY(i),:) = color;
        end
    else
        for i=1:numel(XX)
            x=XX(i);
            y=YY(i);
            
            sigma = R/5;
            g = fspecial('gaussian', 2*R+1, sigma); % could move this outside every stroke
            g = 1/g(R+1, R+1) .* g; %normalizing so the middle become 1
            % crop for running out of bounds
            top = min(R, x-1);
            bottom = min(R, size(canvas,1)-x);
            left = min(R, y-1);
            right = min(R, size(canvas,2)-y);
            g = g(R+1-top:R+1+bottom, R+1-left:R+1+right);            
            for chnl = 1:3
                org_can = canvas(x-top:x+bottom, y-left:y+right, chnl) .* (ones(size(g))-g);
                new_stk = double(color(chnl)).*g;
                canvas(x-top:x+bottom, y-left:y+right,chnl) = org_can + new_stk;
            end
        end
    end
end

end
