function midi_pitch = get_midi_pitch(line_points, line_distance, note_location, is_treble_clef)
    % this is a simplified version, disregarding some midi conventions and
    % more or less approximating the midi value
    if (is_treble_clef)
        midi_pitch = get_g_pitch(line_points, line_distance, note_location);
    else
        midi_pitch = get_f_pitch(line_points, line_distance, note_location);
    end
end

function pitch = get_g_pitch(line_points, line_distance, note_location)
    %   c value is encoded as 60, we use it as default
    %   it is located on the first lower nonexistant staff line of G clef
    %   notes
    %   one inc/dec means half higher/lower pitch, so d = 62
    % so the next higher value directly on a line will be:
    % e = 64
    e4_position = max(line_points);
    pitch = 64 + get_relative_pitch(line_distance, note_location, e4_position);
end

function pitch = get_f_pitch(line_points, line_distance, note_location)
    g2_position = max(line_points);
    pitch = 43 + get_relative_pitch(line_distance, note_location, g2_position);
end

function pitch = get_relative_pitch(line_distance, note_location, base_position)
    note_position = note_location(2) - abs(note_location(2)-note_location(1));
    multiplier = 1;
    lower = base_position;
    higher = note_position;
    if (note_position > base_position)
        % note is further down than this, so should be less than
        % base_positions value
        multiplier = -1;
        lower = note_position;
        higher = base_position;
    end
    line_counter = 0;
    while (higher-lower > line_distance)
        lower = lower - line_distande;
        line_counter = line_counter + 1;
    end
    pitch = 4 * line_counter;
    % because of uncertainties, it is now unclear if it is on the same
    % line, between this line and the next, or on the next line
    dif = higher - lower;
    if (dif > 2.5 && dif < 7.5)
        pitch = pitch + 2;
    elseif (dif >= 7.5)
        pitch = pitch + 4;
    end
    pitch = pitch * multiplier;
        
end
