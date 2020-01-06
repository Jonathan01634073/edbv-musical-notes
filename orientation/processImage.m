function res = processImage(image)
    
    res = padImage(image);

    res = computeFFT(res);
    
    res = shiftFFT(res);

    res = computeAngle(image, res, 0.1);

    res = computeOrientation(res);

    res = binarize(res, 0.9);
    
end