function connected_spots = get_connected_spots(side_stem_vec, line_points, note_location)
    spot_counter = 0;
    in_spot = false;
    for i = 1 : length(side_stem_vec)
        if (ismember(i, line_points))
            continue;
        end
        half_note_dist = note_location(2) - note_location(1);
        if ((i >= note_location(1)-half_note_dist) && (i <= note_location(2))+half_note_dist)
            continue;
        end
        if (side_stem_vec(i))
            if (in_spot)
                continue;
            else
                in_spot = true;
                spot_counter = spot_counter + 1;
            end
        else
            in_spot = false;
        end
    end
    connected_spots = spot_counter;
end
