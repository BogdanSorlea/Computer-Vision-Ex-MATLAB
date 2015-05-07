function count = computeConsensus(l, points, th)
%CONSENSUS computes consensus (how many points lie within a th distance of
%l line)
    count = 0;
    for i=1:size(points, 2)
        if pointPositionToLine(l, points(1,i), th) == 1
            count = count + 1;
        end
    end;

end

