function padded = padImage(image)
    [height, width] = size(image);
    
    maxsize = max(size(image));
    
    padded = uint8(zeros(maxsize));
    
    padded(1:height, 1:width) = image;
end