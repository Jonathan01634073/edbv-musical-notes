function angle = computeAngle(fft, precision)
    maxsize = max(size(fft));
    
    center = ceil((maxsize+1)/2);
    evenS = mod(maxsize+1, 2);
    
    fft = rotate(fft(center:end, 1+evenS:center), 1) + uint8(fft(center:end, center:end));
    
    fft = fft(2:end, 2:end);

    angles = floor(90/precision);
    score = zeros(angles, 1);
    maxDist = maxsize/2-1;
    
    for angle = 0:angles-1
        [y,x] = computeCart(angle, precision, maxDist);
        for i = 1:maxDist
            score(angle+1) = score(angle+1) + fft(round(y(i)+1), round(x(i)+1));
        end
    end
    
    [~, position] = max(score);
    angle = (position-1)*precision;
    angle = mod(45+angle,90)-45;
end