function note_head_width = get_note_head_width(note_line_distance)
%   dinamically creates template for a note head (quarter and faster)
%   only template for horizontal line in between staff lines is required

    % schwarze pixel sind 1
    % width of note head is at most allowed to be 1,4 times the
    % note_line_distance
    note_head_width = ceil(note_line_distance * 1.4);
end