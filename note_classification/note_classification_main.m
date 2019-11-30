%% probleme mit meinem part:
%% punkte neben dem notenkopf werden noch nicht beachtet und zerst�ren potenziell den algo
%% dasselbe gilt f�r vorzeichen und jeglichen clutter
%% wenn die linien von verbundenen achteln f�r die horizontale projektion zuf�llig genauso dick sind wie ein notenkopf:
%%  -> verhalten undefined


image_rgb = imread('note_viertel.png');
image_gray = rgb2gray(image_rgb);
image_bin = imbinarize(image_gray);
image_bin = ~image_bin;


figure
imshow(image_bin);

vector_hor = sum(image_bin, 2);
vector_ver = sum(image_bin, 1);

line_points = get_line_points(vector_hor, vector_ver);
% matrix with start and end point of each note line
% dimensions: 5,2
line_locations = get_line_locations(line_points);
% minimum pixel amount when projecting vertically
min_ver_pixels = length(line_points);
% distance between first and last note line
note_lines_max_distance = line_points(size(line_points)) - line_points(1);
note_lines_max_distance = note_lines_max_distance(1);
% locations of the note stem is it exists
[note_stem_value, note_stem_loc] = max(vector_ver);
% distance between two note lines
note_line_distance = line_locations(2,1) - line_locations(1,2);
note_stem_thickness = 1 + note_stem_loc(length(note_stem_loc)) - note_stem_loc(1);



%%%             ALGORITHM               %%%

note_location = zeros(2, 1);
% 1 = whole, 2 = half,...
note_speed = 0;
%check if there is no note stem
if (note_stem_value < (note_lines_max_distance / 1.5))
    % there is no note stem
    % -> special symbol or whole note
    note_location = get_note_location(vector_hor, note_line_distance, note_stem_thickness, line_points);
    if (note_location == [0, 0])
        % special sign
        note_speed
        return;
    end
    % whole note
    note_speed = 1;
    note_location
    note_speed
    return;
end

note_location = get_note_location(vector_hor, note_line_distance, note_stem_thickness, line_points);
note_location

% check if it is faster than 1/4  by checking if there is a point where the
% value in vector_hor is higher than the stem thickness but is not the note
% blob
% this is obviously very vulnerable to clutter and will throw false
% positives if there is any clutter
faster_than_quarter = false;
if (has_clutter(vector_hor, note_stem_thickness, line_points, note_location))
    faster_than_quarter = true;
    faster_than_quarter
end


if (~faster_than_quarter)
    %note is 1/2 or 1/4
    if (is_half_note(vector_hor, note_location, note_stem_thickness, line_points))
        note_speed = 2;
        note_speed
        return;
    end
    note_speed = 3;
    note_speed
    return;
end

% note is confirmed faster than 1/4
% check if it is connected to out-of-scope notes
side_stem_vec = zeros(length(vector_hor));
if (vector_ver(1) > min_ver_pixels)
    side_stem_vec = image_bin(:, note_stem_loc(1)-1);
else
    side_stem_vec = image_bin(:, note_stem_loc(length(note_stem_loc))+1);
end

% go along side of stem and count black spots that are not the note or note
% lines
% this would seem very improvised again, but I believe it will work fine
note_speed = get_connected_spots(side_stem_vec, line_points, note_location) + 3;

note_speed












