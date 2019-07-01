function [correspond,s] = findCorrMax(referName,findName,referPlaneNum,stnum,ednum,numPlane,shiftRef,shiftFind,k,corrdir)
referPlane = imread(referName,referPlaneNum-shiftRef);
I = double(referPlane);
I = I- mean2(I);
s=zeros(numPlane,1)+eps;

for i = stnum:ednum
    
    %¶ÁÍ¼
    pr = i-shiftFind;
    currentPlane = imread(findName,pr);
    
    %ÕÒÆ«
    [dx, dy] = registerImages(referPlane, currentPlane);
    currentPlane = circshift(currentPlane,[-dx,-dy]);
    
    s(i) = SSIM(referPlane,currentPlane);
    
end


if exist('k','var')
    figure
    plot(s);
    a = getframe(gcf);
    imwrite(a.cdata,fullfile(corrdir,[num2str(k),'.tif']))
    close
end

correspond = find(s==max(s));
end