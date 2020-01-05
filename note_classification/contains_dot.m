function found = contains_dot(img_slice)
    % input is image slice of already classified note
    % just check in vector_ver if there is a bump after note head
    found = 0;
    vector_ver = sum(img_slice,1);
    cutoff = min(vector_ver);
    spotcounter = 0;
    for i = 1:length(vector_ver)
       if (vector_ver(i) > cutoff)
           spotcounter = spotcounter + 1;
       end
       if (spotcounter == 2)
           found = 1;
           return;
       end
    end
end

