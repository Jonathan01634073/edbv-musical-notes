function result = decompose(image, line_count)

    result = separate_takts(image, line_count);
    takt_separated = result.takt_list;
    bottom_value = result.bottom_value;
    
    %print_image_list(takt_separated, 6);

    takt_list = {};

    for ii=1:size(takt_separated, 2)
        if(ii > 1)
            takt_list{end + 1} = separate_notes(takt_separated(ii), bottom_value);
        else
            result = separate_key(takt_separated(ii), bottom_value);
            key = result.key;
            rest = result.rest;
            notes = separate_notes({result.rest}, bottom_value);
            takt_list{end + 1} = cat(2,key,notes);
        end
    end

    %for ii=1:size(takt_list, 2)
    %    print_image_list(takt_list{1,ii}, ii);
    %end
    
    result = takt_list;

end