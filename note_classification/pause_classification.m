function pause_class = pause_classification(vector_hor, line_points)
    % 1 = full pause
    % 2 = half pause
    pause_class = 0;
    
    for i = 1:line_points
       if (i > 1 && vector_hor(i-1)~=0 && ~ismember(i-1, line_points))
           % upside of line point
           pause_class = 2;
           return;
       end
       if (i < length(vector_hor) && vector_hor(i+1)~=0 && ~ismember(i+1, line_points))
           % downside
           pause_class = 1;
           return;
       end
    end
end

