function is_half_note = is_half_note(vector_hor, note_location, stem_thickness, line_points)
    mid_blob = ceil(note_location(1) + ((note_location(2) - note_location(1))/2));
    % ensure we didnt get a staff line
    while (ismember(mid_blob, line_points))
        mid_blob = mid_blob + 1;
    end
    % we decide if its full or not by checking if the projection at that
    % point meets a certain threshold
    % the threshold is kinda arbitrary right now
    threshold = stem_thickness * 3.5;
        is_half_note = true;
    if (vector_hor(mid_blob) > threshold)
        is_half_note = false;
    end
end

