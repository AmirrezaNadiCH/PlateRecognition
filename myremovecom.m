function result = myremovecom(image, threshold)
    [labeled,maxIndex] = labelImageArea(image);
    for i = 1:maxIndex
        if mycountarea(labeled,i) < threshold
            image = myremovearea(image,labeled,i);
        end
    end
    result = image;
end

