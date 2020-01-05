function symbol_class = symbol_classification(vector_hor, vector_ver, line_distance)
    [rows, columns] = get_symbol_shape(vector_hor, vector_ver);
    shape_ratio = double(rows) / double(columns);
    % for difference between vorzeichen and quarter pause: quarter pause is
    % more than 3*line_distance
    symbol_class = classify_shape(shape_ratio);
    if (symbol_class == 3)
        if (line_distance*3 > rows)
            symbol_class =5;
        end
    end
    % output: 1=full note, 2=full/half pause, 3=quarter pause,
    % 4=eighth pause, 5=vorzeichen
    
    
end

function symbol_class = classify_shape(shape_ratio)
    % classify with nearest neighbor approach
    
    % full note: r:16, c:26                 => 0.62
    % full/half pause: r:8, c:16            => 0.5
    % quarter pause r:44, c:15/vorzeichen 33 iwas:   => 2.85
    % eighth pause: r:26, c:15              => 1.73
    
    distance_vec = abs([0.62 0.5 2.85 2.85 1.73] - shape_ratio);
    [~, index] = min(distance_vec);
    symbol_class = index;
    % output: 1=full note, 2=full/half pause, 3=quarter pause/vorzeichen,
    % 4=eighth pause
end
