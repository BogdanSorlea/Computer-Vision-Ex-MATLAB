function corners = HarrisCorners(im, sigma, k, fTh)
%HARRISCORNERS Computes a list of features of type Harris corners

    t = sigma * sigma;
    x = -3 * ceil(sigma) : 3 * ceil(sigma);
    g = exp(-x.*x./(2*t)) / sqrt(2*pi*t);
    gx = (-x/t) .* exp(-x.*x ./ (2*t)) / sqrt(2*pi*t);

    Ix = filter2(g', filter2(gx, im, 'same'), 'same');
    Iy = filter2(gx', filter2(g, im, 'same'), 'same');
    
    Ix2 = Ix .* Ix;
    Iy2 = Iy .* Iy;
    Ixy = Ix .* Iy;
    
    a = filter2(g, Ix2, 'same');
    b = filter2(g, Iy2, 'same');
    c = filter2(g, Ixy, 'same');
    
    absum = a + b;
    r = a .* b - c .* c - k * absum .* absum;
    
    maxR = max(max(r));
    
    thR = r - fTh * maxR;
    idx = sign(thR);
    thR(idx==-1) = 0;
    thR(idx==0) = 0;

    for i=2:size(thR,1)-1
        for j=2:size(thR,2)-1
            if not(thR(i,j) > thR(i+1,j) && ...
                    thR(i,j) >= thR(i-1,j) && ...
                    thR(i,j) > thR(i,j+1) && ...
                    thR(i,j) >= thR(i,j-1))
                thR(i,j) = 0;
            end;
        end;
    end;
    
    thR(1,:) = zeros(1,size(thR,2));
    thR(size(thR,1),:) = zeros(1,size(thR,2));
    thR(:,1) = zeros(size(thR,1),1);
    thR(:,size(thR,2)) = zeros(size(thR,1),1);

    corners = [;];

    for i=2:size(thR,1)-1
        for j=2:size(thR,2)-1
            if thR(i,j) > 0
                corners(:,end+1) = [i; j]; %#ok<AGROW>
            end;
        end;
    end;

end

