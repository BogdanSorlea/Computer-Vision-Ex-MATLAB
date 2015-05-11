function dist = FSampDist(F,p1,p2)
%FSAMPDIST computes Sampsons distance for fund. matrix

    a = p2' * F * p1;
    a = a*a;
    b = F * p1;
    c = b(2,1);
    c = c * c;
    b = b(1,1);
    b = b * b;
    d = p2' * F;
    e = d(1,2);
    e = e * e;
    d = d(1,1);
    d = d * d;
    
    dist = a / (b+c+d+e);

end

