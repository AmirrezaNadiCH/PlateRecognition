% Loading The Image
clear;clc;close;
[file,path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},['Select An Image' ...
    ' File Containing A Car Plate']);
if file == 0
    return;
end
image = imread([path '\' file]);

blue_part = RGBRange(image,[0,80],[0,120],[100,255]);
white_part = RGBRange(image,[100,255],[100,255],[100,255]);
blue_part = imresize(blue_part,[300,500]);
white_part = imresize(white_part,[300,500]);
image = imresize(image,[300,500]);
blue_part = myremovecom(double(blue_part),30);

subplot(2,2,1)
imshow(blue_part)
title('Separated Blue Part')
subplot(2,2,2)
imshow(white_part)
title('Separated White Part')

[blue_labeled,maxSegment] = mysegmentation(blue_part);
subplot(2,2,3)
imshow(image)
title('Spotted Central Blue Areas')
hold on
for i = 1:maxSegment-1
    [r,c] = find(blue_labeled==i);
    mr = min(r);
    Mr = max(r);
    Mc = max(c);
    mc = min(c);
    deltar = Mr-mr;
    if mc >= 0.8*500 || mc <= 0.2*500 || mr <= 0.2*300 || mr >= 0.8*300
        continue
    end
    rectangle('Position',[mc,mr,Mc-mc,Mr-mr],'EdgeColor','g','LineWidth',2)
    if any(white_part(mr:Mr,Mc+2)==1)
        image = imcrop(image,[mc-20,mr-20,7*deltar+40,deltar+40]);
        break;
    end
end
hold off

subplot(2,2,4)
imshow(image)
title("Ready For Plate Reading")
figure
%==========================================================================
image = imresize(image,[300,500]);
subplot(2,2,1)
imshow(image)
title('Original')
% Generating Gray Scale And Black-And-White
subplot(2,2,2)
image = mygrayfun(image);
imshow(image)
title('Gray Scaled')

subplot(2,2,3)
image = mybinaryfun(image);
imshow(image)
title('Binary')

subplot(2,2,4)
image = myremovecom(image,400);
im2 = myremovecom(image,5000);
image = image - im2;
imshow(image)
title('Ready For Segmentation And Correlation')
% Segmentation And Correlation
[labeled,maxSegment] = mysegmentation(image);
hold on
label_positions = zeros(2,maxSegment-1);
for i = 1:maxSegment-1
    [r,c] = find(labeled == i);
    mc = min(c,[],'all');
    mr = min(r,[],'all');
    Mc = max(c,[],'all');
    Mr = max(r,[],'all');
    label_positions(1,i) = i;
    label_positions(2,i) = mc;
    rectangle('Position',[mc,mr,Mc-mc,Mr-mr],'EdgeColor','g','LineWidth',2)
end

[temp,indexs] = sort(label_positions(2,:));
label_positions(1,:) = label_positions(1,indexs);
label_positions(2,:) = label_positions(2,indexs);

persian_training_loading;
load TRAININGSET.mat
figure
colcount = ceil(maxSegment/2);
result = [];
for i = 1:maxSegment-1
    [r,c] = find(labeled == label_positions(1,i));
    character = image(min(r):max(r), min(c):max(c));
    subplot(2,colcount,i)
    imshow(character)
    decision = cell(2,1);
    decision{1,1} = 0;
    decision{2,1} = '';
    for j = 1:length(TRAIN)
        temp = corr2(TRAIN{1,j},imresize(character,size(TRAIN{1,j})));
        if temp >= 0.45 && temp >= decision{1,1}
            decision{1,1} = temp;
            decision{2,1} = TRAIN{2,j};
        end
    end
    result = [result decision{2,1}];
end
result = result(1:min(8,end));
disp(result')
file = fopen('result.txt', 'wt');
fprintf(file,'%s\n',result);
fclose(file);
winopen('result.txt')
