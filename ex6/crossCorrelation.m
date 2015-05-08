function rho = crossCorrelation(a, b)
%CROSSCORRELATION Computes cross-correlation between 2 patches

    % remember that if the one patch is smooth
    % (same intensity everywhere)
    % the result will be NaN due to a sigma being 0

    %{
    figure('Name', 'a');
    imagesc(a);
    colormap gray;
    
    figure('Name', 'b');
    imagesc(b);
    colormap gray;
    %}
    
    n = size(a,1)*size(a,2);
    a = reshape(a, [1,n]);
    b = reshape(b, [1,n]);
    a = uint32(a);
    b = uint32(b);

    % this way will result in all points having the same
    % best correlated node
    
    sa = sum(a);
    sb = sum(b);
    saa = sum(a.*a);
    sab = sum(a.*b);
    sbb = sum(b.*b);
    
    rho = (sab - (sa * sb / n)) / ...
        sqrt((saa - (sa * sa / n)) * ...
                (sbb - (sb * sb / n)));
    
    %ua = mean(a);
    %ub = mean(b);
    
    % this is a stupid experiment to try and get
    % sigma to not be zero :|
    %{
    if sum((a - ua)) == 0
        coord = round(1 + rand(1)*(size(a,1)*size(a,2)-1));
        if a(1, coord) == 255
            a(1, coord) = 254;
        else
            a(1, coord) = a(1, coord) + 1;
        end;
        ua = mean(a);
    end;
    
    if sum((b - ub)) == 0
        coord = round(1 + rand(1)*(size(b,1)*size(b,2)-1));
        if b(1, coord) == 255
            b(1, coord) = 254;
        else
            b(1, coord) = b(1, coord) + 1;
        end;
        ub = mean(b);
    end;
    %}
    
    %{
    sigmaAsq = (1/size(a,2)-1) * ...
        sum((a - ua) .* (a - ua));
    
    sigmaBsq = (1/size(b,2)-1) * ...
        sum((b - ub) .* (b - ub));
    
    cov = (1/size(a,2)-1) * ...
        sum((a - ua) .* (b - ub));
    
    rho = cov / sqrt(sigmaAsq ^ 2 * sigmaBsq ^ 2);
    %}
    
    %{
    if isnan(rho)
        a
        ua
        ub
        conda = sum((a - ua))
        sigA1 = sum((a - ua) .* (a - ua))
        dima = size(a,2)
        dimb = size(b,2)
        sigmaAsq
        sigmaBsq
        cov
        rho
    end;
    %}

end

