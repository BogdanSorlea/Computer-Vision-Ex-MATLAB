function selection = randomNDraw( n, listOfPoints )
%RANDOM10DRAW randomly draws 2 points from a provided list of points

    % assuming draw of columns
    listSize = size(listOfPoints, 2);
    selection = [];
    
    for i=1:n
        position = randi([1, listSize]);
        selection = [selection listOfPoints(:,position)]; %#ok<AGROW>
        listOfPoints = [listOfPoints(:,1:position-1), ...
                        listOfPoints(:,position+1:end)];
        listSize = listSize - 1;
    end;

end