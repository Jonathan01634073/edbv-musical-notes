function contains_stem = contains_note_stem(note_lines_distance, note_stem_vec, note_stem_value)
% checks if there is a note stem in the picture according to note_lines_distance
    min_length = note_lines_distance*0.7;
    max_length = note_lines_distance*1.5;
    contains_stem = 0;
    if (note_stem_value < min_length || note_stem_value > max_length)
        return;
    end
    
    %now check if there is a connected sequence of req_length
    
    spot_length = 0;
    
    for i = 1 : length(note_stem_vec)
        if (note_stem_vec(i)==0)
            spot_length = 0;
        else
            spot_length = spot_length + 1;
        end
        if (spot_length >= min_length)
            contains_stem = 1;
            return;
        end 
    end
end

