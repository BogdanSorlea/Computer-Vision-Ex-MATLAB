function F = Fest_8point(q1, q2)
%FEST_8POINT the 8-point algorithm estimates a fundamental
%   matrix

    B = [];
    x = 1;
    y = 2;
    for i=1:size(q1,2)
        B = [B;
            q1(x,i)*q2(x,i) q1(x,i)*q2(y,i) q1(x,i) ...
            q1(y,i)*q2(x,i) q1(y,i)*q2(y,i) q1(y,i) ...
            q2(x,i) q2(y,i) 1]; %#ok<AGROW>
    end;
    % alternative option:
    %[eVec, ~] = eig(B'*B);
    %F = reshape(eVec(:,1),3,3);
    [~,~,V] = svd(B);
    F = reshape(V(:,9),3,3);
    %F = F';
end

