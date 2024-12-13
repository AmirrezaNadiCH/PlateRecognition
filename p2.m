% Loading The Image
clear;clc;close;
[file,path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},['Select An Image' ...
    ' File Containing A Car Plate']);
if file == 0
    return;
end
image = imread([path file]);
image = imresize(image, [300 500]);
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
image = myremovecom(image,500);
im2 = myremovecom(image,4000);
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

disp(result')
file = fopen('result.txt', 'wt');
fprintf(file,'%s\n',result);
fclose(file);
winopen('result.txt')