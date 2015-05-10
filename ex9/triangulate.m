function Q = triangulate(P1, P2, q1, q2)
%TRIANGULATE finds a point based on models of 2 cameras
%   and two 2D points

    x = 1;
    y = 2;
    
    B = [P1(3,:) * q1(x,1) - P1(1,:);
        P1(3,:) * q1(y,1) - P1(2,:);
        P2(3,:) * q2(x,1) - P2(1,:);
        P2(3,:) * q2(y,1) - P2(2,:)];
    
    [~,~,v] = svd(B);
    
    Q = v(:,end);

end

