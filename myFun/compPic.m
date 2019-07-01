function pic1 = compPic(pic1,g)
if nargin <2
    g = 0.2;
end
pic = uint8(pic1);
im2 = medfilt2(pic,[5,5]);
bw = imbinarize(im2,g);
% imshow(bw);

st1 = strel('square',8);
st2 = strel('square',5);
st3 = strel('disk',2);
bw1 = imclose(bw,st1);
bw2 = imopen(bw1,st2);
bw3 = imdilate(bw2,st3);

pic1(~bw3)=0;

end