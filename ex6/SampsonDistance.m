function distance = SampsonDistance(F, q1, q2)
%SAMPSONDISTANCE computes the Sampson distance given 2 points
%   and a fundamental matrix

    fq1 = F * q1;
    q2f = q2' * F;
    
    numerator = (q2' * F * q1) * (q2' * F * q1);
    denominator = fq1(1) * fq1(1) + fq1(2) * fq1(2) + ...
        q2f(1) * q2f(1) + q2f(2) * q2f(2);
    distance = numerator / denominator;

end

