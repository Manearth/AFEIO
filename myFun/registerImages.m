function [dx, dy] = registerImages(im1, im2)

I = double(im1);
I = I - mean(I(:));
I2 = double(im2);
I2 = I2 - mean(I2(:));

C = ifft2(conj(fft2(I)) .* (fft2(I2)));
C = fftshift(C);
[x, y] = find(C == max(C(:)));


dx = x - round(size(im1, 1) / 2 - .5) - 1;
dy = y - round(size(im1, 2) / 2 - .5) - 1;

end