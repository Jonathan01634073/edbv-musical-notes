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
    % every one note difference jumps by a value of 2 per step, except from
    % e to f
    e4_position = max(line_points);
    pitch = 64 + get_relative_pitch(line_distance, note_location, e4_position);
    if (pitch >= 65)
        % we counted 2 for the jump from e to f, which is wrong
        pitch = pitch-1;
        if (pitch >= 72)
            pitch = pitch -1;
            if (pitch >= 77)
                pitch = pitch -1;
            end
        end
    elseif (pitch <= 59)
        pitch = pitch + 1;
    end
    
    
end

function pitch = get_f_pitch(line_points, line_distance, note_location)
    g2_position = max(line_points);
    pitch = 43 + get_relative_pitch(line_distance, note_location, g2_position);
    if (pitch >= 48)
        pitch = pitch-1;
            if (pitch >= 53)
                pitch = pitch -1;
                if (pitch >= 60)
                    pitch = pitch - 1;
                end
            end
    elseif (pitch <= 40)
        pitch = pitch+1;
        if (pitch <= 35)
            pitch = pitch+1;
        end
    end
end

function pitch = get_relative_pitch(line_distance, note_location, base_position)
    % numbers for e and f:
    %   64 & 65, 52 & 53
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
    while (lower-higher >= line_distance)
        lower = lower - line_distance;
        line_counter = line_counter + 1;
    end
    pitch = 4 * line_counter;
    % because of uncertainties, it is now unclear if it is on the same
    % line, between this line and the next, or on the next line
    dif = lower-higher;
    if (dif > 4.5 && dif < 8.5)
        pitch = pitch + 2;
    elseif (dif >= 7.5)
        pitch = pitch + 4;
    end
    pitch = pitch * multiplier;
end
