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

[imageHeight,imageWidth,~]=size(referenceImage);
for r=1:grid:imageHeight-grid
    for c=1:grid:imageWidth-grid
        M=D(r:r+grid,c:c+grid);
        areaError=mean2(M);
        T=paintParameters.T;
        if(areaError > T)
            [r1,c1]=find(M==max(max(M)),1);
            r1=r1+r-1;c1=c1+c-1;
            s=makeStroke(Ri,r1,c1,referenceImage,gx,gy,canvas,paintParameters);
            strokes{1}=[strokes{1};{referenceImage(r1,c1,:)}];
            strokes{2}=[strokes{2};{s}];
        end
    end
end

[canvas]=paintAllStrokes(canvas,strokes,Ri,paintParameters);


end

