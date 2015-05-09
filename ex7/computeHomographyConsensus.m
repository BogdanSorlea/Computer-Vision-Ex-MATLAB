function [count, inliers] = computeHomographyConsensus(H, q1, q2, th)
%CONSENSUS computes consensus (how many points lie within a th distance of
%	h homography)

    count = 0;
    inliers = [];
    for i=1:size(q1, 2)
        
        t1 = norm(prod(H * q2(:,i)) - prod(q1(:,i)));
        t2 = norm(prod(H / q1(:,i)') - prod(q2(:,i)));
        dist = t1 * t1 + t2 * t2;
        if dist < th
            count = count + 1;
            inliers = [inliers [q1(1:2,i); q2(1:2,i)]]; %#ok<AGROW>
        end;
        
    end;

end

