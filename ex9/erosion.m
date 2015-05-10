function newImage = erosion(image)
%EROSION removes noise, esentially

    newImage = image;

    for i=2:size(image,1)-1
        for j=2:size(image,2)-1
            if image(i,j) == 255 && ...
                    (image(i+1,j) == 0 || ...
                    image(i-1,j) == 0 || ...
                    image(i,j+1) == 0 || ...
                    image(i,j-1) == 0)
                
                newImage(i,j) = 0;
            end;
        end;
    end;

end