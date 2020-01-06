function angle = computeOrientation(image)
    [height, width] = size(image);
    
    angle = 0;
    
    done = nnz(image(height-120:height-30, width-70:width-30));
    
    if done > 3500 && done < 3600
        angle = 180;
    end 
end