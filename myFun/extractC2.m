function l = extractC2(im,thresh,s1,s2,mianji)

c = im>thresh;

st2 = strel('square',s1);
st3 = strel('disk',s2);


c = imclose(c,st2);
c = imopen(c,st3);

e = bwlabel(c);
L = regionprops(e,'Area');
areas = [L.Area];
f = double(areas>=mianji).*(1:length(areas));
f = f(f>0);
l = (im<-1);
for p1 = f
    p0 = (e==p1);
    l = max(p0,l);
end