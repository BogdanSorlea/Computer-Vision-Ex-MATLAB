function hq = homogenize(Q)
%HOMOGENIZE homogenizes an n-dimensional coordinate

    hq = Q;

    for i=1:size(Q,1)
        hq(i,:) = hq(i,:) ./ hq(end,:);
    end;

end

