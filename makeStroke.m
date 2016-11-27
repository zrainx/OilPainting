function K=makeStroke(R,x0,y0,referenceImage,gx,gy,canvas,paintParameters)
% Creating curved brush strokes
strokeColor=referenceImage(x0,y0,:);
K=[]; K=[K [x0;y0]];
x=x0; y=y0;
lastDx=0; lastDy=0;
[imageHeight,imageWidth,channel]=size(referenceImage);
maxStrokeLength=paintParameters.maxLength;
minStrokeLength=paintParameters.minLength;
fc=paintParameters.fc;
for i=1:maxStrokeLength
   
    if (i>minStrokeLength) && ...
       norm(reshape(referenceImage(x,y,:)-canvas(x,y,:),3,[]))< ...
       norm(reshape(referenceImage(x,y,:)-strokeColor,3,[]))
       return;
    end

%     if (i>minStrokeLength) && ...
%        sum(reshape(referenceImage(x,y,:)-canvas(x,y,:),3,[])< ...
%        reshape(referenceImage(x,y,:)-strokeColor,3,[]))
%        return;
%     end

    if norm([gx(x,y),gy(x,y)])==0
        return;
    end
    dx=gy(x,y); dy=-gx(x,y);
    if (lastDx * dx + lastDy * dy)<0
        dx=-dx; dy=-dy;
    end
    dx=fc*dx+(1-fc)*lastDx;
    dy=fc*dy+(1-fc)*lastDy;
    dx=dx/sqrt(dx^2+dy^2);
    dy=dy/sqrt(dx^2+dy^2);
    x=x+floor((2*R+1)*dx);y=y+floor((2*R+1)*dy);
    x=min(x,imageHeight);y=min(y,imageWidth);
    x=max(x,1);y=max(y,1);
    K=[K [x;y]];
    lastDx=dx;lastDy=dy;
end

return;
end


