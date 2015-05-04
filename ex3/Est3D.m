function Q=Est3D(q1, P1, q2, P2)

B = [P1(3,:) * q1(1,1) - P1(1,:); P1(3,:) * q1(2,1) - P1(2,:); P2(3,:) * q2(1,1) - P2(1,:); P2(3,:) * q2(1,1) - P2(1,:)];
[u, s, v] = svd(B);
Q = v(:, end);
