function [labeled,maxIndex] = labelImageArea(image)

    labeled = zeros(size(image));
    maxIndex = 1;
    for i = 1:size(image,1)
        flag = boolean(0);
        for j = 1:size(image,2)
            if image(i,j) == 1
                labeled(i,j) = maxIndex;
                flag = boolean(1);
            else
                if flag
                    flag = boolean(0);
                    maxIndex = maxIndex + 1;
                end
            end
        end
    end
    
     for i = size(image,1)-1:-1:1
        j = 1;
        while j <= size(image,2)
            if image(i,j) == 1
                [r1,c1] = find(labeled(i,:) == labeled(i,j));
                r1(end+1) = i;
                r1(end+1) = i;
                c1(end+1) = max(min(c1,[],'all')-1,1);
                c1(end+1) = min(max(c1,[],'all')+1,size(image,2));
                values = labeled(i+1,c1);
                values(end+1) = labeled(i,j);
                values = values(values>0);
                values = unique(values);
                val = min(values,[],'all');
                for p = values
                    labeled(labeled == p) = val;
                end
                j = j + length(c1);
            else
                j = j + 1;
            end
        end
    end
end