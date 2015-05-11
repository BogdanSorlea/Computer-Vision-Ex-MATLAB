function P = resectioning(q3d, q)
%RESECTIONING calculates camera pose from 3D-2D point pairs
    
    B = [];
    for i=1:size(q,2)
        Qx = q3d(1,i);
        Qy = q3d(2,i);
        Qz = q3d(3,i);
        x = q(1,i);
        y = q(2,i);
        B = [B;
            0 -Qx y*Qx 0 -Qy y*Qy 0 -Qz y*Qz 0 -1 y;
            Qx 0 -x*Qx Qy 0 -x*Qy Qz 0 -x*Qz 1 0 -x;
            -y*Qx x*Qx 0 -y*Qy x*Qy 0 -y*Qz x*Qz 0 -y x 0]; %#ok<AGROW>
    end;
    % alternative option:
    %[eVec, ~] = eig(B'*B);
    %F = reshape(eVec(:,1),3,3);
    [~,S,V] = svd(B);
    P = reshape(V(:,12),3,4);

end

