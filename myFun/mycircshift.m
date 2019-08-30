function out = mycircshift(input,dxy)
dx = dxy(1);
dy = dxy(2);

input = padarray(input,[abs(dx),abs(dy)],0,'both');
input = circshift(input,[dx,dy]);
out = input(abs(dx)+1:end-abs(dx),abs(dy)+1:end-abs(dy));
end