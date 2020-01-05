function result = separate_key(image, bottom_value)
    
    image_grey = rgb2gray(image{1,1});
    image_binary = imbinarize(image_grey);
    img = imcomplement(image_binary);

    symbol_count = 0;
    symbol_beginning = 1;
    
    symbol_list = {};
    
    proj = sum(img, 1);
    
    
    for ii=1:size(img,2)
        if (proj(ii) < bottom_value+10 && symbol_count == 0)
            if(sum(proj(1:1,symbol_beginning:ii)) > 250-bottom_value)
                image_frag = image{1,1}(1:size(img, 1),symbol_beginning:ii,1:3);
                
                symbol_list{end + 1} = image_frag;
                
                symbol_count = symbol_count + 1;
                symbol_beginning = ii;
            end
        end
    end
    
    rest = image{1,1}(1:size(img, 1),symbol_beginning:size(img,2),1:3);
    
    
    print_image_list(symbol_list, 7);
    result.key = symbol_list;
    result.rest = rest;
    
end