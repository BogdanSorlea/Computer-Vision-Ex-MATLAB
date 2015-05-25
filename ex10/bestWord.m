function word = bestWord(clusters, descriptor)
%BESTWORD returns the cluster for which the distance between
%   descriptor and cluster is smallest
%   descriptor is 1 x 128
%   clusters is 50 x 128

    bestDistance = Inf;

    for i=1:size(clusters,1)
        distance = 0;
        for j=1:size(descriptor,2)
            distance = distance + abs(descriptor(1,j) - ...
                clusters(i,j));
        end;
        if distance < bestDistance
            bestDistance = distance;
            word = i;
        end;
    end;

end

