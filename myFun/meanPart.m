function a = meanPart(im)
a = sum(im(:));
    if a>0
        a = a/sum(sum(im>0));
    end
end