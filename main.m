function main
    [filename, path] = uigetfile(fullfile(pwd,'*.jpg')) ;
    image = imread(fullfile(path, filename));
    original_image = image;
    
    bin_image = processImage(image);

    imshow(bin_image);

    staff_lines = find_stafflines(bin_image);

    if ~isempty(staff_lines)


        % Identify positions to split into subimages for each row block
        split_pos = get_split_positions(bin_image, staff_lines);
        % Split into subimages
        sub_imgs = split_images(original_image, split_pos);
    end
    
    midi_pitches = [];
    %inside singel subimage
    for index=1:size(sub_imgs,2)
    test_img = sub_imgs{1,index};
    img_width = size(test_img,2);
    test_img = imresize(test_img, (1150/img_width));
    %print_image_list(sub_imgs,22);
    figure(22);
    imshow(test_img);
    
    takt_list = decompose(test_img, 1);
    
    % TODO FIX: THIS ONLY WORKS WITH THIS IMAGE AS 900 is an arbitrary
    % threshold
    image_grayy = rgb2gray(test_img);
    image_binn = imbinarize(image_grayy);
    image_binn = ~image_binn;
    vector_hor = sum(image_binn, 2);
    
    line_points = find_stafflines(image_binn);
        for i=1:size(takt_list, 2)
            % inside a takt
            image_list = takt_list{1,i};
            for j=1:size(image_list, 2)
                % inside a single note
                note = note_classification_main(image_list{1, j}, line_points, 1);
                if (length(note) == 2)
                    speed = note(1);
                    if (speed == 0)
                        % vorzeichen, we skip
                        continue;
                    end
                    midi_pitch = note(2);
                    midi_pitches = [midi_pitches; midi_pitch speed];
                else
                    fst = note(1);
                    snd = note(2);
                    % 1 = whole, 2 = half
                    speed = note(3);
                    midi_pitch = note(4);
                    midi_pitches = [midi_pitches; midi_pitch speed];
                    img = image_list{1, j};
                    if (snd>0 && snd>0)
                        img(max(fst, 1):max(snd, 1), :, 1) = 150;
                        if (length(note)==5)
                            img(:, note(5):note(5)+1, 2) = 150;
                        end
                        image_list{1, j} = img;
                        %figure(j*15);
                        %imshow(img);
                    end
                end
            end
            print_image_list(image_list, i+15);
        end
    end
    midi_pitches
end
