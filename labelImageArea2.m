function [labeled,maxIndex] = labelImageArea2(image)

    labeled = zeros(size(image));
    idx = 1;
    for i = 2:size(image,1)-1
        for j = 2:size(image,2)-1
            if (image(i,j) == 1)
                image_tp = image(i-1:i+1, j-1:j+1);
                label_tp = labeled(i-1:i+1, j-1:j+1);
                coefficient = idx;
                if sum(label_tp,'all') > 0
                    coefficient = label_tp(find(label_tp>0,1));
                else
                    idx = idx + 1;
                end
                labeled(i-1:i+1, j-1:j+1) = coefficient * image_tp;
            end
        end
    end

    for j = 2:size(image,2)-1
        for i = 2:size(image,1)-1
            if (image(i,j) == 1)
                image_tp = image(i-1:i+1, j-1:j+1);
                label_tp = labeled(i-1:i+1, j-1:j+1);
                coefficient = idx;
                if sum(label_tp,'all') > 0
                    coefficient = label_tp(find(label_tp>0,1));
                else
                    idx = idx + 1;
                end
                labeled(i-1:i+1, j-1:j+1) = coefficient * image_tp;
            end
        end
    end

    for i = 2:size(image,1)-1
        for j = 2:size(image,2)-1
            if (image(i,j) == 1)
                image_tp = image(i-1:i+1, j-1:j+1);
                label_tp = labeled(i-1:i+1, j-1:j+1);
                coefficient = idx;
                if sum(label_tp,'all') > 0
                    coefficient = label_tp(find(label_tp>0,1,'last'));
                else
                    idx = idx + 1;
                end
                labeled(i-1:i+1, j-1:j+1) = coefficient * image_tp;
            end
        end
    end

    for j = 2:size(image,2)-1
        for i = 2:size(image,1)-1
            if (image(i,j) == 1)
                image_tp = image(i-1:i+1, j-1:j+1);
                label_tp = labeled(i-1:i+1, j-1:j+1);
                coefficient = idx;
                if sum(label_tp,'all') > 0
                    coefficient = label_tp(find(label_tp>0,1,'last'));
                else
                    idx = idx + 1;
                end
                labeled(i-1:i+1, j-1:j+1) = coefficient * image_tp;
            end
        end
    end

    

    maxIndex = idx;
end