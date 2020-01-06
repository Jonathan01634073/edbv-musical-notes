function res = rotate(image, i)
    res = image;
    
    i = mod(i, 4);
    
    for i = 1:i
        res = rotate90(res);
    end
end

function res = rotate90(image)
    [height, width] = size(image);
    
    res = uint8(zeros(width, height));
    
    j = width;
    
    for i = 1:width
        res(j,:) = image(:,i);
        j = j - 1;
    end
end