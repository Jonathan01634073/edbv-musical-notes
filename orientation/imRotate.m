function res = imRotate(image, degree)
    if(degree ~= 0)
        sinus = sind(degree);
        cosinus = cosd(degree);
        
        rotate = affine2d([ cosinus     -sinus      0;
                            sinus       cosinus     0;
                            0           0           1]);
        
        bounds = size(image);
        outputSize = getOutputBound(rotate,bounds);

        rows = bounds(1);
        cols = bounds(2);
        
        rowOffset = 0;
        rowPadding = outputSize(1) - rows;
        if(rowPadding <= 0)
            rowOffset = 1 + abs(rowPadding) / 2;
            rowPadding = 1;        
        end
        
        colOffset = 0;
        colPadding = outputSize(2) - cols;
        if(colPadding <= 0)
            colOffset = 1 + abs(colPadding) / 2;
            colPadding = 1;        
        end

        padded(1:rows + rowPadding, 1:cols + colPadding) = 255;
        padded(ceil(rowPadding / 2):(ceil(rowPadding / 2) + rows - 1), ceil(colPadding / 2):(ceil(colPadding / 2) + cols - 1)) = image;

        midx = ceil((size(padded,1) + 1) / 2);
        midy = ceil((size(padded,2) + 1) / 2);
        
        res(1:outputSize(1), 1:outputSize(2)) = 255;
        
        for i = 1:size(res, 1)
            for j = 1:size(res, 2)
                posi = i - midx + rowOffset;
                posj = j - midy + colOffset;
                 x = posi * cosinus + posj * sinus;
                 y = -posi * sinus + posj * cosinus;
                 x = round(x) + midx - 1;
                 y = round(y) + midy - 1;
                 if (x >= 1 && y >= 1 && x <= size(padded, 1) && y <= size(padded, 2))
                      res(i, j) = padded(x, y);      
                 end
            end
        end
        res = uint8(res);
    else
       res = image; 
    end
end

function outputSize = getOutputBound(rotate,bounds)
    hiA = (bounds-1)/2;
    loA = -hiA;
    hiB = ceil(max(abs(transformPointsForward(rotate,[loA(1) hiA(2); hiA(1) hiA(2)])))/2)*2;
    loB = -hiB;
    outputSize = hiB - loB + 1;
end