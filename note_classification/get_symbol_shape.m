function [rows, columns] = get_symbol_shape(vector_hor, vector_ver)
    
    rows = 0;
    row_length = 0;
    for i = 1 : length(vector_hor)
        if (vector_hor(i)>0)
                if (row_length > rows)
                    rows = row_length;
                end
                row_length = row_length +1;
        else
            if (row_length > rows)
                    rows = row_length;
            end
            row_length = 0;
        end
    end
    columns = 0;
    column_length = 0;
    for i = 1 : length(vector_ver)
        if (vector_ver(i)>0)
                if (column_length > columns)
                    columns = column_length;
                end
                column_length = column_length + 1;
        else
            if (column_length > columns)
                    columns = column_length;
            end
            column_length = 0;
        end
    end
end

