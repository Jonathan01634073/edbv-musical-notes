function res = processImage(image)
    image = image(:,:,1);

    padded = padImage(image);

    [height, width] = size(padded);

    fft = computeFFT(padded, height, width);

    res = shiftFFT(fft, height, width);

    res = log(abs(res) + 1);

    angle = computeAngle(res, 0.1);

    res = rotateImage(image, -angle); % todo

    angle = computeOrientation(image);

    if angle == 180
        res = rotate(res, 2);
    end

    res = binarize(res, 0.7);
end