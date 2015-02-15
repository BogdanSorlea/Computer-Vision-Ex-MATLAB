function inhomogeneous_point = inhomogeneous(homogeneous_point)
%INHOMOGENEOUS Calculates the inhomogeneous correspondent of N-dim. point
%   Input is a matrix of N rows and 1 column (N>1)

    dimension = size(homogeneous_point);

    if dimension(1) > 1 && dimension(2) == 1
        s = homogeneous_point(end,1);
        homogeneous_point = homogeneous_point(1:end-1);
        inhomogeneous_point = homogeneous_point ./ s;
    end;

end

