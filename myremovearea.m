function result = myremovearea(image, labeled_map, n)
    image(labeled_map == n) = 0;
    result = image;
end