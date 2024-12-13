function grayscaled = mygrayfun(image)
    r_c = 0.299;
    g_c = 0.578;
    b_c = 0.114;
    grayscaled = r_c * image(:,:,1) + g_c * image(:,:,2) + b_c * image(:,:,3);
end