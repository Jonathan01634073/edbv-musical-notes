function main
    [filename, path] = uigetfile(fullfile(pwd,'*.jpg')) ;
    image = imread(fullfile(path, filename));
    original_image = image;
    
    if ~ismatrix(image)
        image = rgb2gray(image);
    end
    
    
    % find angle at which the image was taken
    %angle = horizonFFT(image, 0.1);
    %angle = mod(45+angle,90)-45;
    % uses this angle to straighten the image
    %res = imrotate_white(image, -angle);
    % convert image to black and white values
    bin_image =1-imbinarize(image, 0.9);

    imshow(bin_image);

    staff_lines = find_stafflines(bin_image);

    if ~isempty(staff_lines)


        % Identify positions to split into subimages for each row block
        split_pos = get_split_positions(bin_image, staff_lines);
        % Split into subimages
        sub_imgs = split_images(original_image, split_pos);
    end
    
    test_img = sub_imgs{1,1};
    %print_image_list(sub_imgs,22);
    
    takt_list = decompose(test_img, 1);
    
    % TODO FIX: THIS ONLY WORKS WITH THIS IMAGE AS 900 is an arbitrary
    % threshold
    image_grayy = rgb2gray(test_img);
    image_binn = imbinarize(image_grayy);
    image_binn = ~image_binn;
    vector_hor = sum(image_binn, 2);
    
    line_points = find(vector_hor > 900);
    
    for i=1:size(takt_list, 2)
        % inside a takt
        image_list = takt_list{1,i};
        for j=1:size(image_list, 2)
            % inside a single note
            note = note_classification_main(image_list{1, j}, line_points, 1);
            if (length(note)<4)
                continue;
            end
            % row index of note start in image
            fst = note(1);
            % row index of note end in image
            snd = note(2);
            % 1 = whole, 2 = half
            speed = note(3);
            midi_pitch = note(4);
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
        print_image_list(image_list, i+15);
    end
end
