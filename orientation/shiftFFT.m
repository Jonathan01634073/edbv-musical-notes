function res = shiftFFT(image, height, width)
    halfHeight = floor(height / 2);
    halfWidth = floor(width / 2);
    
    firstQuadrant = image(1:halfHeight, 1:halfWidth);
    secondQuadrant = image(1:halfHeight, halfWidth:end);
    thirdQuadrant = image(halfHeight:end, 1:halfWidth);
    fourthQuadrant = image(halfHeight:end, halfWidth:end);
    
    res = [fourthQuadrant thirdQuadrant; secondQuadrant firstQuadrant];
end