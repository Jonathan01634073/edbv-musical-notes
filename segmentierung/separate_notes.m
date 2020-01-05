function result = separate_notes(image, bottom_value)
    image_grey = rgb2gray((image{1,1}));
    image_binary = imbinarize(image_grey);
    img = imcomplement(image_binary);
    
    proj = sum(img, 1);
    frag_list = {};
    
    bar_list = {}
    
    %bar(proj);
    %disp(proj);
    
    frag_end = 0;
    
    %SETTINGS
    cut_width = 16;
    cut_margin = (-2);
    
    cut_full_note_margin = (-2);
    
    idx = 6; %cut_width + cut_margin;
    
    result = find_next_note(img, proj, idx, cut_width, cut_margin, bottom_value);
    
    br = false;
    while (result.point ~= (-1))
        % next_note_idx = find_next_note(img, proj, idx, cut_width, cut_margin, bottom_value);
        extract_frag = image{1,1}(1:size(image{1,1}, 1),    max(result.point - result.cut_width + result.cut_margin, 1):min(result.point+result.cut_width+result.cut_margin, size(image{1,1}, 2)),   1:3);
        frag_list{end + 1} = extract_frag;
        
        if(result.cut_width == 8)
           pr = sum(1 -imbinarize(rgb2gray(extract_frag)), 2);
           bar_list{end + 1} = pr;
           br = true;
        end
        
        idx =  result.point + result.cut_width + result.cut_margin;
        
        result = find_next_note(img, proj, idx, cut_width, cut_margin, bottom_value);
    end
    
    if(br == true)
        figure(1000);
        display(bar(bar_list{2}));
    end
    
    result = frag_list;
end