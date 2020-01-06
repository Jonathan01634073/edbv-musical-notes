function [result] = imerodecustom(mat,mask)
%IMERODECUSTOM erodes image with a mask
% only pixels where the mask fits stay

mask=getnhood(mask);
m=floor(size(mask,1)/2);
n=floor(size(mask,2)/2);
pad=padarray(mat,[m n],1);
result=false(size(mat));
for i=1:size(pad,1)-(2*m)
    for j=1:size(pad,2)-(2*n)
        Temp=pad(i:i+(2*m),j:j+(2*n));
        result(i,j)=min(min(Temp-mask));
    end
end
result=~result;
end

