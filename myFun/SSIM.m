function re=SSIM(X,Y)
X=double(X);
Y=double(Y);

ux=mean2(X);
uy=mean2(Y);
uxy = mean2(X.*Y);

sig2x=var(X(:),1);
sig2y=var(Y(:),1);
sigxy=uxy-ux*uy;

k1=0.01;%维持稳定的常数
k2=0.03;
L=255;
c1 = (k1*L)^2;
c2 = (k2*L)^2;

l1 = (2*ux*uy+c1)/(ux.^2+uy.^2+c1);
l2 = 2*sigxy+c2;
l3 = sig2x+sig2y+c2;

re=l1*l2/l3;

end