function fin = getShape(b)

b = uint8(b);

th = graythresh(b);
b0 = imbinarize(b,th);



fc = strel('square',15);
b0 = imclose(b0,fc);



e = bwlabel(b0);
A = regionprops(e, 'Area');
areas = [A.Area];
rnk = sort(areas,'descend');
r = find(areas == rnk(1));
fin = (e==r);



end