function l = lineFromPoints(a, b)
%LINEFROMPOINTS computes a line from two points

    a = a';
    b = b';
    slope = (a(2) - b(2)) / (a(1) - b(1));    
    l = [slope; -1; -slope * a(1) + a(2)];

end
