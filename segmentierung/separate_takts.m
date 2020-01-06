function result = separate_takts(image, line_count)

    image_grey = rgb2gray(image);
    image_binary = imbinarize(image_grey);
    img = imcomplement(image_binary);

    bar_list = {};
    bar_beginning = 1;
    
    divisor_nr = 0;
    
    proj = sum(img, 1);
    
    bottom_line = find_bottom_value(proj);
    
    for ii=1:size(proj,2)
        if (line_count == 2)
            if(proj(ii) >= (70 - bottom_line))
                divisor_nr = divisor_nr + 1;
                if (divisor_nr > 1 && (ii - bar_beginning >= 40))
                    image_frag = image(1:size(img, 1),bar_beginning:ii,1:3);
                    bar_list{end + 1} = image_frag;
                end
                bar_beginning = ii;
            end
        elseif (line_count == 1)
            if(proj(ii) >= (50 - bottom_line))
                
                empty_space = true;
                if(divisor_nr > 0)
                    cnt1 = 0;
                    for jj=max(1,ii-6):min(ii, size(proj, 2))
                        if(proj(jj) >= bottom_line + 8)
                            cnt1 = cnt1 + 1;
                        end
                    end
                    if(cnt1 >= 5)
                        empty_space = false;
                    end
                    
                    cnt2 = 0;
                    for jj=max(1,ii):min(ii+6, size(proj, 2))
                        if(proj(jj) >= bottom_line + 8)
                            cnt2 = cnt2 + 1;
                        end
                    end
                    if(cnt2 >= 5)
                        empty_space = false;
                    end
                end
                
                if(empty_space == true)
                    divisor_nr = divisor_nr + 1;
                    if (divisor_nr > 1 && (ii - bar_beginning >= 40))
                        image_frag = image(1:size(img, 1),bar_beginning:ii,1:3);
                        bar_list{end + 1} = image_frag;
                    end
                    bar_beginning = ii;
                end
            end
        end
    end

    %print_image_list(bar_list, 4);
    result.takt_list = bar_list;
    result.bottom_value = bottom_line;
    
end