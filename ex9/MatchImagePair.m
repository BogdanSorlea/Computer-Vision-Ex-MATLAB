function [mab,E,R,t] = MatchImagePair(fa,da,fb,db,K,sigma)
%MATCHIMAGEPAIR SIFT matching of 2 images

    [matches, ~] = vl_ubcmatch(da, db);
    nMatches = size(matches,2);
    
    % I guess there is no need to sort by score
    %[~, I] = sort(scores(1,:), 'descend');
    %sortedMatches = matches(:,I);
    %qa = [fa(1:2,sortedMatches); 1];
    %qb = [fb(1:2,sortedMatches); 1];
    
    qa = [fa(1:2,matches(1,:)); ones(1,nMatches)];
    qb = [fb(1:2,matches(2,:)); ones(1,nMatches)];
    
    [E,R,t,~] = EestMex(K,qa',K,qb',sigma);
    
    F = inv(K)' * E * inv(K);
    
    mab = [];
    for i=1:nMatches
        if FSampDist(F,qa(:,i),qb(:,i)) < 3.84*3^2
            mab = [mab matches(:,i)]; %#ok<AGROW>
        end;
    end;
    
end

