function main
    %path='F:\TUWien\EDBV\';
    %file=dir([path 'someone.jpg']);
    image = imread('someone.png');
    
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
    
    test_img = sub_imgs{1,3};
    figure(55)
    print_image_list(sub_imgs,22);
    
    decompose(test_img, 1);
    
end