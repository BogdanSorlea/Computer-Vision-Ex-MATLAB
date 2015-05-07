function position = pointPositionToLine(l, p, th)
%POINTPOSITIONTOLINE Summary of this function goes here
%   Detailed explanation goes here
    
    distance = abs(l * p);
    if distance > th
        position = 0;
    else
        position = 1;
    end;

end

