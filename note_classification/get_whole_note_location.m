function blob_loc = get_whole_note_location(vector_hor, note_line_distance, note_stem_thickness, line_points)
    blob_loc = zeros(2, 1);
    spot_length = 0;
    note_line_dist_low = note_line_distance - ceil(note_line_distance*0.1);
    note_line_dist_high = note_line_distance + ceil(note_line_distance*0.1);
    
    for i = 1 : length(vector_hor)
        if (vector_hor(i) > note_stem_thickness)
            if (ismember(i, line_points) && (spot_length == 0))
                spot_length = 0;
            elseif (spot_length < note_line_dist_high)
                spot_length = spot_length + 1;
            end
        else
            spot_length = 0;
        end
        if ((spot_length>=note_line_dist_low) && (spot_length<=note_line_dist_high))
            blob_loc(1) = i-spot_length;
            blob_loc(2) = i;
            return;
        end
    end
end

