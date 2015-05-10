function center = centerOfMass(image)
%CENTEROFMASS computes the center of mass of an object

    surface = area(image);
    
    r = 0;
    c = 0;
    
    for i=1:size(image,1)
        for j=1:size(image,2)
            if image(i,j) == 255
                r = r + i;
                c = c + j;
            end;
        end;
    end;
    center = [r/surface; c/surface];

end

