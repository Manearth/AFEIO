function [x1,x2,y1,y2] = findEdge(b)
bn = max(b,[],1);
ind = find(bn == 1);
x1 = ind(1);
x2 = ind(end);
mx = round((x1+x2)/2);
dx = x2-x1;

bn = max(b,[],2);
ind = find(bn == 1);
y1 = ind(1);
y2 = ind(end);
my = round((y1+y2)/2);
dy = y2-y1;

l = round(max(dx,dy)/2)+10;

x1 = mx-l;
x2 = mx+l;
y1 = my-l;
y2 = my+l;
end