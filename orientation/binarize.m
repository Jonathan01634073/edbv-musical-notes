function res = binarize(image, threshold)
    threshold = threshold * 255;

    image(image <= threshold) = 1;
    image(image > threshold) = 0;

    res = double(image);
end