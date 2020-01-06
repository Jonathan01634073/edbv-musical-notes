function connected_spots = get_connected_spots(side_stem_vec, line_points, note_location)
    spot_counter = 0;
    cur_spot_length = 0;
    in_spot = false;
    for i = 1 : length(side_stem_vec)
        if (ismember(i, line_points))
            continue;
        end
        half_note_dist = ceil((note_location(2) - note_location(1))/2);
        if ((i >= (note_location(1)-half_note_dist)) && (i <= (note_location(2))+half_note_dist))
            continue;
        end
        if (side_stem_vec(i))
            cur_spot_length = cur_spot_length + 1;
            if (cur_spot_length == 3)
                %this is a hotfix to make sure no note lines are counted as
                %spot
                spot_counter = spot_counter + 1;                
            end
        else
            cur_spot_length = 0;
        end
    end
    connected_spots = spot_counter;
end
