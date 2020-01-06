function fft = computeFFT(image, height, width)
    wM = zeros(height, height);
    wN = zeros(width, width);
    
    for u = 0 : (height - 1)
        for x = 0 : (height - 1)
            wM(u+1, x+1) = exp(-2 * pi * 1i / height * x * u);
        end
    end

    for v = 0 : (width - 1)
        for y = 0 : (width - 1)
            wN(y+1, v+1) = exp(-2 * pi * 1i / width * y * v);
        end
    end
    
    fft = wM * double(image) * wN;
end