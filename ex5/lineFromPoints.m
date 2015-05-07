function l = lineFromPoints(a, b)
%LINEFROMPOINTS computes a line from two points

    slope = (a(1,2) - b(1,2)) / (a(1,1)-b(1,1));    
    l = [slope, -1, -slope * a(1,1) + a(1,2)];

end
