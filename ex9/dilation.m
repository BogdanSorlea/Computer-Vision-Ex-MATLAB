function newImage = dilation(image)
%DILATION amplifies noise and objects, esentially

    newImage = image;

    for i=2:size(image,1)-1
        for j=2:size(image,2)-1
            if image(i,j) == 255
                newImage(i+1,j) = 255;
                newImage(i-1,j) = 255;
                newImage(i,j+1) = 255;
                newImage(i,j-1) = 255;
            end;
        end;
    end;

end

