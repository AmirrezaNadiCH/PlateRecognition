function [segmentation,lasSegment] = mysegmentation(image)
   [labeled, maxIndex] = labelImageArea(image);
    lasSegment = 1;
    for i = 1:maxIndex
        if sum(labeled==i,'all') ~= 0
            labeled(labeled == i) = lasSegment;
            lasSegment = lasSegment + 1;
        end
    end
    segmentation = labeled;
end