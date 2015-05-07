function selection = random2Draw(listOfPoints)
%RANDOM2DRAW randomly draws 2 points from a provided list of points

    % assuming 2 lines and n columns (or rather, draw of columns)
    n = size(listOfPoints, 2);
    position = randi([1, n]);
    selection = listOfPoints(:,position);
    listOfPoints = [listOfPoints(:,1:position-1), ...
                        listOfPoints(:,position+1:end)];
    position = randi([1, n-1]);
    selection = [selection listOfPoints(:,position)];

end

