function q1 = normalize2D( q1 )
%NORMALIZE2D normalizes a vector of 2D points

% normalize
meanQ1 = mean(q1')';
q1(1,:) = q1(1,:) - meanQ1(1);
q1(2,:) = q1(2,:) - meanQ1(2);
S1 = mean(sqrt(diag(q1' * q1)))/sqrt(2);
q1(1:2,:) = q1(1:2,:) / S1;

end

