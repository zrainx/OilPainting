function [ canvas ] = paintLayer( canvas,referenceImage,gx,gy,Ri,paintParameters )
% search each grid point?s neighborhood to find the nearby point with the greatest error, 
% and paint at this location. All strokes for the layer are planned at once before rendering. 
% Then the strokes are rendered in random order to prevent an undesirable appearance of 
% regularity in the brush strokes.

strokes={{},{}};
diff=referenceImage-canvas;
D=sqrt(diff(:,:,1).^2+diff(:,:,2).^2+diff(:,:,3).^2);
fg=paintParameters.fg;
grid=floor(fg*(2*Ri+1));

[imageHeight,imageWidth,channel]=size(referenceImage);
for x=1:grid:imageHeight-grid
    for y=1:grid:imageWidth-grid
        M=D(x:x+grid,y:y+grid);
        areaError=mean2(M);
        T=paintParameters.T;
        if(areaError > T)
            [x1,y1]=find(M==max(max(M)),1);
            x1=x1+x-1;y1=y1+y-1;
            s=makeStroke(Ri,x1,y1,referenceImage,gx,gy,canvas,paintParameters);
            strokes{1}=[strokes{1};{referenceImage(x1,y1,:)}];
            strokes{2}=[strokes{2};{s}];
        end
    end
end

[canvas]=paintAllStrokes(canvas,strokes,Ri,paintParameters);


end

