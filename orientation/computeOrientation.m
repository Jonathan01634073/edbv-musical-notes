function res = computeOrientation(image)
    [height, width] = size(image);
    
    res = image;
    
    done = nnz(image(height-120:height-30, width-70:width-30));
    
    if done > 3500 && done < 3600
        res = rotate(res, 2);
    end 
end