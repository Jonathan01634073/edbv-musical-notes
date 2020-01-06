function result = find_next_note(img, proj, current_idx, cut_width, cut_margin, bottom_value)

    for ii=current_idx:size(proj, 2) - 5
        
        %// Half/Quarter etc.
        if (proj(ii) >= (30 - bottom_value))
            empty_space = true;
            cnt1 = 0;
                for jj=max(1,ii-6):min(ii, size(proj, 2))
                    if(proj(jj) >= bottom_value + 5)
                        cnt1 = cnt1 + 1
                    end
                end
                if(cnt1 >= 5)
                    empty_space = false;
                end
                    
                cnt2 = 0;
                for jj=max(1,ii):min(ii+6, size(proj, 2))
                    if(proj(jj) >= bottom_value + 5)
                        cnt2 = cnt2 + 1
                    end
                end
                if(cnt2 >= 5)
                    empty_space = false;
                end
                if(empty_space == false)
                    result.point = ii;
                    result.cut_width = cut_width;
                    result.cut_margin = cut_margin;
                    return;
                end
        end
        
        %// Crosses
        if(proj(ii) >= 20)
            is_cross = false;
            second_line = -1;
            for jj=(ii-6):(ii-1)
                if(abs(proj(ii) - proj(jj)) < 3)
                    second_line = jj;
                end
            end
            
            if(second_line ~= -1)
                for jj = second_line:ii
                    if(proj(jj) <= proj(ii)- 10 && proj(jj) >= bottom_value + 10)
                        is_cross = true;
                    end
                end
            end
            
            if(is_cross == true)
                result.point = ii;
                result.cut_width = 8;
                result.cut_margin = cut_margin;
                return;
            end
        end
        
        %// Full Notes
        if (proj(ii) >= 10 + bottom_value && ii > 15)
            is_full_note = false;
            second_line = -1;
            for jj=(ii-12):(ii-1)
                if(abs(proj(ii) - proj(jj)) < 3)
                    second_line = jj;
                end
            end
            
            if(second_line ~= -1)
                for jj = second_line:ii
                    if(proj(jj) <= proj(ii)-6 && proj(jj) > bottom_value)
                        is_full_note = true;
                    end
                end
            end
            
            if(is_full_note == true)
                for jj = max(1,ii - cut_width+cut_margin):min(ii+cut_width+cut_margin, size(proj, 2))
                    if (proj(jj) >= 24)
                        is_full_note = false;
                    end
                end
            end
            
            if(is_full_note == true)
                result.point = ii;
                result.cut_width = cut_width;
                result.cut_margin = cut_margin;
                return;
            end
        end
    end
    result.point = -1;
    result.cut_width = cut_width;
    result.cut_margin = cut_margin;
end