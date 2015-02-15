function image_point = computePinhole(camera_params, point)
%COMPUTEPINHOLE Given a pinhole camera model matrix and a point in space
%this function will convert to the camera space
%   camera_params is a 3x3 matrix, point is a 3x1 matrix

    dimensions_camera_params = size(camera_params);
    dimensions_point = size(point);
    
    if dimensions_camera_params(1) == 3 && ...
            dimensions_camera_params(2) == 3 && ...
            dimensions_point(1) == 3 && dimensions_point(2) == 1
        image_point = camera_params * point;
    end

end

