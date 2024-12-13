function result = mycountarea(labeled_map, n)
    result = sum(labeled_map == n,'all');
end