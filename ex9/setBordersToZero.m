function newImage = setBordersToZero(image)
%SETBORDERSTOZERO sets borders (zone unaffected 
%   by dilation/erosion to zero)

    newImage = image;
    newImage(1,:) = zeros(1, size(image,2));
    newImage(end,:) = zeros(1, size(image,2));
    newImage(:,1) = zeros(size(image,1), 1);
    newImage(:,end) = zeros(size(image,1), 1);

end

