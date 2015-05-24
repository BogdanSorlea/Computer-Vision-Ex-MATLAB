function [] = SIFTrunF(title, ima, imb, F, th)
%SIFTRUN SIFT between 2 images

    figure('Name', title);
    disp(title);
    
    colors = {'y', 'm', 'c', 'r', 'b', 'g'};
    noOfMatches = 50;
    
    Ia = single(ima);
    Ib = single(imb);
    halfA = 0;
    halfB = 0;
    
    if size(Ia,1) > size(Ib,1)
        diff = size(Ia,1) - size(Ib,1);
        halfA = ceil(diff / 2);
        Iax = Ia;
        Ibx = [zeros(halfA,size(Ib,2)); ...
            Ib; zeros(diff-halfA,size(Ib,2))];
    else
        diff = size(Ib,1) - size(Ia,1);
        halfB = ceil(diff / 2);
        Iax = [zeros(halfB,size(Ia,2)); ...
            Ia; zeros(diff-halfB,size(Ia,2))];
        Ibx = Ib;
    end;
    Ii = [Iax Ibx];

    [fa, da] = vl_sift(Ia) ;
    [fb, db] = vl_sift(Ib) ;
    [matches, scores] = vl_ubcmatch(da, db) ;
    
    disp(['Scores - count | min | max: ' ...
        num2str(size(scores,2)) ' | ' ...
        num2str(max(scores)) ' | ' num2str(min(scores))]);

    [~, I] = sort(scores(1,:), 'descend');
    sortedMatches = matches(:,I);
    
    filteredMatches = [];
    
    for i=1:size(sortedMatches,2)
        distance = SampsonDistance(F, ...
            [fa(1:2,sortedMatches(1,i)); 1], ...
            [fb(1:2,sortedMatches(2,i)); 1]);
        if distance < th
            filteredMatches = [filteredMatches ...
                sortedMatches(:,i)]; %#ok<AGROW>
        end;
    end;
    
    if noOfMatches > size(filteredMatches, 2)
        noOfMatches = size(filteredMatches, 2);
    end;

    imagesc(Ii);
    colormap gray;
    %perm = randperm(size(fa,2)) ;
    %sel = perm(1:100) ;
    sela = filteredMatches(1,1:noOfMatches);

    fa(2,sela) = fa(2,sela) + halfB;
    h1 = vl_plotframe(fa(:,sela)) ;
    h2 = vl_plotframe(fa(:,sela)) ;
    set(h1,'color','k','linewidth',3) ;
    set(h2,'color','y','linewidth',2) ;

    %perm = randperm(size(fb,2)) ;
    %selb = perm(1:100) ;
    selb = filteredMatches(2,1:noOfMatches);

    fb(1,selb) = fb(1,selb) + size(Ia, 2);
    fb(2,selb) = fb(2,selb) + halfA;
    h3 = vl_plotframe(fb(:,selb)) ;
    h4 = vl_plotframe(fb(:,selb)) ;
    set(h3,'color','k','linewidth',3) ;
    set(h4,'color','y','linewidth',2) ;

    hold on;
    for i=1:size(selb,2)
        color = char(colors(1+round(rand(1) * ...
            (size(colors,2)-1))));
        plot([fa(1,sela(:,i)) fb(1,selb(:,i))], ...
            [fa(2,sela(:,i)) fb(2,selb(:,i))], ...
            'Color', color, 'LineWidth', 1);
    end;
    hold off;


end

