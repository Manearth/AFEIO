function [projFront,projSide] = saveProj(filename,stretching)
a = imfinfo(filename);
planes = length(a);

projFront = imread(filename,1);
imtype = class(projFront);
projSide = zeros(size(projFront,1),planes);
eval(['projSide = ',imtype,'(projSide);']);

for k = 1:planes
    im = imread(filename,k);
    projFront = max(im,projFront);
    projSide(:,k) = max(im,[],2);
end

sizeStretch = round(planes*stretching);
projSide = imresize(projSide,[size(projSide,1),sizeStretch]);

