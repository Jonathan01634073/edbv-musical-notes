function [x,y] = computeCart(angle, precision, maxDist)
    angle = convertDegToRad(angle * precision);
    [x,y] = convertPolarToCart(angle, 0:maxDist-1);
end

function rad = convertDegToRad(angle)
    rad = angle * (pi / 180);
end

function [x,y] = convertPolarToCart(angle, distance)
    x = cos(angle) * distance;
    y = sin(angle) * distance;
end