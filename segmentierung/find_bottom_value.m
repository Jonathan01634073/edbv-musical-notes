function result = find_bottom_value(proj)
proj_sorted = sort(nonzeros(proj));
bottom_line = mode(proj_sorted(1:min(50, size(proj_sorted, 1))));

result = bottom_line;
end