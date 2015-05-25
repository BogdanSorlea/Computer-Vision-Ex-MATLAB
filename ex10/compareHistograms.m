function distance = compareHistograms(histog1, histog2)
%COMPAREHISTOGRAMS returns distance between 2 histograms

    distance = 0;

    for i=1:size(histog1,1)
        diff = histog1(i) - histog2(i);
        sum = histog1(i) + histog2(i);
        if sum ~= 0
            distance = distance + (diff * diff / sum);
        end;
    end;
end

