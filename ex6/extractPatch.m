function patch = extractPatch(image, n, line, column)
%EXTRACTPATCH Extracts a (2n+1)*(2n+1) pixel patch from image,
%   centered at (line,column)

    empty_lines = 0;

    if line-(n+1) < 0
        empty_lines = abs(line-n)+1;
    end;
    
    patch = zeros(empty_lines, size(image,2));
    patch = [patch; image(line-n+empty_lines:line-1,:)];
    patch = [patch; image(line,:)];
    
    empty_lines = 0;
    
    if line+n > size(image,1)
        empty_lines = abs(line+n-size(image,1));
    end;
    
    patch = [patch; image(line+1:line+n-empty_lines,:)];
    patch = [patch; zeros(empty_lines, size(image,2))];
    
    image = patch;
    
    empty_columns = 0;
    
    if column-(n+1) < 0
        empty_columns = abs(column-n)+1;
    end;
    
    patch = zeros(size(image,1), empty_columns);
    patch = [patch image(:,column-n+empty_columns:column-1)];
    patch = [patch image(:,column)];
    
    empty_columns = 0;
    
    if column+n > size(image,2)
        empty_columns = abs(column+n-size(image,2));
    end;
    
    patch = [patch image(:,column+1:column+n-empty_columns)];
    patch = [patch zeros(size(image,1), empty_columns)];

end

