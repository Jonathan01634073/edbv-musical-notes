%% probleme mit meinem part:
%% punkte neben dem notenkopf werden noch nicht beachtet und zerstören potenziell den algo
%% dasselbe gilt für vorzeichen und jeglichen clutter
%% wenn die linien von verbundenen achteln für die horizontale projektion zufällig genauso dick sind wie ein notenkopf:
%%  -> verhalten undefined
function classified_note = note_classification_main(image, line_points, is_treble_clef)
    %image_rgb = imread('note_viertel.png');
    image_gray = rgb2gray(image);
    image_bin = imbinarize(image_gray);
    image_bin = ~image_bin;

    %figure(220);
    %imshow(image_bin);

    vector_hor = sum(image_bin, 2);
    vector_ver = sum(image_bin, 1);

    
    %line_points = get_line_points(vector_hor, vector_ver);
    % matrix with start and end point of each note line
    % dimensions: 5,2
    line_locations = get_line_locations(line_points);
    % minimum pixel amount when projecting vertically
    min_ver_pixels = length(line_points);
    % distance between first and last note line
    note_lines_max_distance = line_points(size(line_points)) - line_points(1);
    note_lines_max_distance = note_lines_max_distance(1);
    % locations of the note stem if it exists
    [note_stem_value, note_stem_loc] = max(vector_ver);
    % distance between two note lines
    note_line_distance = line_locations(2,1) - line_locations(1,2);
    note_stem_thickness = 1 + note_stem_loc(length(note_stem_loc)) - note_stem_loc(1);

    %%%             ALGORITHM               %%%

    % 0.5=1/8, 2.0=1/2, 4.0=1
    note_tempo = 0;
    %check if there is no note stem
    if (contains_note_stem(note_lines_max_distance, image_bin(:,note_stem_loc), note_stem_value)==0)
        % there is no note stem
        % -> special symbol or whole note
        
        % classify by shape
        % output overall symbols: location of note=full note, 1=full pause, 2=half pause, 3=quarter pause,
        % 4=eighth pause, 5=vorzeichen
        
        % output by function: 1=full note, 2=full/half pause, 3=quarter pause,
        % 4=eighth pause, 5=vorzeichen
        symbol_class = symbol_classification(vector_hor, vector_ver, note_line_distance);
        
        % if it's whole note, get location
        if (symbol_class == 1)
            note_location = get_whole_note_location(vector_hor, note_line_distance, note_stem_thickness, line_points);
            note_tempo = 4.0;
            if (contains_dot(image_bin(max(note_location(1), 1):max(note_location(2), 1),:)))
                %%note_tempo = double(note_tempo) * 1.5;
            end
            midi_pitch = get_midi_pitch(line_points, note_line_distance, note_location, is_treble_clef);
            classified_note = [note_location(1); note_location(2); note_tempo; midi_pitch];
            return;
        end
        
        % if it's full/half pause or vorzeichen, classify again
        if (symbol_class == 2)
            symbol_class = pause_classification(vector_hor, line_points);
        end
        if (symbol_class == 5)
            % differentiate between vorzeichen type
        end
        switch symbol_class
            case 1
                note_tempo = 4.0;
            case 2
                note_tempo = 2.0;
            case 3
                note_tempo = 1.0;
            case 4
                note_tempo = 0.5;
        end
        classified_note = [note_tempo; symbol_class];
        return;
    end

    if(note_stem_loc(1) == 1 || note_stem_loc(length(note_stem_loc)) == length(vector_ver))
        % something went wrong
        classified_note = [-1; -1; -1; -1; note_stem_loc(1)];
        return;
    end
    
    note_location = get_note_location(image_bin, vector_hor, note_line_distance, note_stem_thickness, line_points, 1);
    if (note_location == false(2))
        % something went wrong 
        classified_note = [-1; -1; -1; -1; note_stem_loc(1)];
        return;
    end
    
    
        %note is 1/2
        if (is_half_note(vector_hor, note_location, note_stem_thickness, line_points))
            note_tempo = 2.0;
            if (contains_dot(image_bin(note_location(1):note_location(2),:)))
                %%note_tempo = double(note_tempo) * 1.5;
            end
            midi_pitch = get_midi_pitch(line_points, note_line_distance, note_location, is_treble_clef);
            classified_note = [note_location(1); note_location(2); note_tempo; midi_pitch; note_stem_loc(1)];
            return;
        end
    
    midi_pitch = get_midi_pitch(line_points, note_line_distance, note_location, is_treble_clef);
    
    flag_amount_left = 0;
    flag_amount_right = 0;
    if (vector_ver(1) > min_ver_pixels)
        % there is a left connection to another note
        % (if there is not we can just count on the right side of the stem)
        side_stem_vec = image_bin(:, note_stem_loc(1)-1);
        flag_amount_left = get_connected_spots(side_stem_vec, line_points, note_location);
    end
    
    side_stem_vec = image_bin(:, note_stem_loc(length(note_stem_loc))+1);
    flag_amount_right = get_connected_spots(side_stem_vec, line_points, note_location);

    % go along side of stem and count black spots that are not the note or note
    % lines
    flag_amount = max(flag_amount_left, flag_amount_right);
    % this conveniently returns 1 if there are no flags:
	note_tempo = power(0.5, flag_amount);
	
 
    classified_note = [note_location(1); note_location(2); note_tempo; midi_pitch; note_stem_loc(1)];
end










