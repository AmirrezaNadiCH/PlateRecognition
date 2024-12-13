function result = RGBRange(image, red, green, blue)
result = boolean(zeros(size(image(:,:,1))));
r = image(:,:,1);
g = image(:,:,2);
b = image(:,:,3);
result(r>=red(1)) = 1;
result(r>=red(2)) = 0;
result(g<=green(1)) = 0;
result(g>=green(2)) = 0;
result(b<=blue(1)) = 0;
result(b>=blue(2)) = 0;
result = boolean(result);
end