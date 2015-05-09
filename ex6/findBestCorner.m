function bestCorner = findBestCorner(patch, n, im, corners)
%FINDBESTCORNER for a given patch and a list of patch references
%   finds the best corresponding match (highest correlation)

    bestCorrelation = +Inf;
    bestCorner = 0;
    
    %patch = extractPatch(im, n, ...
    %    cornerToMatch(1,1), cornerToMatch(2,1));
    
    for i=1:size(corners,2)
        line = corners(1,i);
        column = corners(2,i);
        toMatch = extractPatch(im, n, line, column);
        correlation = crossCorrelation(patch, toMatch);
        
        % something is rotten in the state of Denmark
        % look more at
        % http://stackoverflow.com/questions/15215310/special-situation-in-normalized-cross-correlation-for-template-matching
        if isnan(correlation)
            correlation = 0;
        end;
%         if isnan(correlation)
%             bestCorrelation = -Inf;
%             bestCorner = corners(:,i);
%         else
            if abs(correlation) < bestCorrelation
                bestCorrelation = correlation;
                %bestCorner = corners(:,i);
                bestCorner = i;
            end;
%        end;
    end;
    
end

