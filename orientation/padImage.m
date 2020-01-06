function padded = padImage(image)
    if ~ismatrix(image)
        image = image(:,:,1);
    end

    [height, width] = size(image);
    
    maxsize = max(size(image));
    
    padded = uint8(zeros(maxsize));
    
    padded(1:height, 1:width) = image;
end