function [im,im2] = smerge(im_left,im_righ,im2_left,im2_righ)
type = class(im_left);
mx = max(im_left,im_righ);


m = centerFind(mx);

[weigh_lf,weigh_rg] = creatMergeMatrix(m,size(im_left),201);
im = double(im_left).*weigh_lf + double(im_righ).*weigh_rg;
eval(['im=',type,'(im);']);

if nargin >=3
    im2 = double(im2_left).*weigh_lf + double(im2_righ).*weigh_rg;
    eval(['im2=',type,'(im2);']);
end
end

