function [ canvas ] = paint( sourceImage,paintParameters )
    % paint the canvas,from largest to smallest   
    canvas = zeros(size(sourceImage));   
    R=paintParameters.R;
    fc=paintParameters.fc;
    for Ri = R       
        G=(2*Ri+1)*fc;
        m=fspecial('gaussian',G,G);
        referenceImage = imfilter(sourceImage,m,'replicate');
%         m=fspecial('sobel');
%         grayReferenceImage=rgb2gray(referenceImage);
%         gx=imfilter(grayReferenceImage,m,'replicate');
%         m=m';
%         gy=imfilter(grayReferenceImage,m,'replicate');
        [gx,gy]=gradient(referenceImage);
        canvas = paintLayer(canvas,referenceImage,gx,gy,Ri,paintParameters);
        
        subplot(1,2,2);
        imshow(canvas);
        drawnow;
    end
end

