function K=makeStroke(R,r,c,referenceImage,gx,gy,canvas,paintParameters)
% Creating curved brush strokes
strokeColor=referenceImage(r,c,:);
K=[]; K=[K [r;c]];
lastDx=0; lastDy=0;
[imageHeight,imageWidth,~]=size(referenceImage);
maxStrokeLength=paintParameters.maxLength;
minStrokeLength=paintParameters.minLength;
fc=paintParameters.fc;
for i=1:maxStrokeLength
   
    if (i>minStrokeLength) && ...
       norm(reshape(referenceImage(r,c,:)-canvas(r,c,:),3,[]))< ...
       norm(reshape(referenceImage(r,c,:)-strokeColor,3,[]))
       return;
    end

    if norm([gx(r,c),gy(r,c)])==0
        return;
    end
    dx=-gy(r,c); dy=gx(r,c);
     if (lastDx * dx + lastDy * dy)<0
         dx=-dx; dy=-dy;
     end
    dx=fc*dx+(1-fc)*lastDx;
    dy=fc*dy+(1-fc)*lastDy;
    dx=dx/sqrt(dx^2+dy^2);
    dy=dy/sqrt(dx^2+dy^2);
    c=c+floor((2*R+1)*dx);r=r+floor((2*R+1)*dy);
    r=min(r,imageHeight);c=min(c,imageWidth);
    r=max(r,1);c=max(c,1);
    lastDx=dx;lastDy=dy;
    K=[K [r;c]];   
end

return;
end


