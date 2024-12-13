function binary_im = mybinaryfun(image)
    binary_im = image <= graythresh(image)*256;
end