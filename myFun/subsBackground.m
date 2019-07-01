function im = subsBackground(im,backStrel, averker)
imBk = imopen(im,backStrel);
imBk = imfilter(imBk,averker,'replicate');
im = im - imBk;
end