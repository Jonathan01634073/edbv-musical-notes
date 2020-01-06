function [pks,locs] = findpeakscustom(m)
%FINDPEAKSCUSTOM Summary of this function goes here
%   Detailed explanation goes here
i=2;
n=1;
result=0;
location=0;
length(m)
while i<length(m)
    if m(i)>m(i-1)
        j=1;
        while m(i+j)==m(i) && i+j<length(m)
           j=j+1;     
        end
        if m(i+j)<m(i)
            result(n)=m(i);
            location(n)=i;
            n=n+1;
        end
    end
    
    i=i+1;
end
pks = result(:);
locs = location(:);
end

