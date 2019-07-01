function [weigh_1,weigh_2] = creatMergeMatrix(center,s,len)
weigh = cos(linspace(0,pi,len))+1;
weigh_1 = zeros(1,s(2));
weigh_2 = weigh_1;
lef = center - floor(len/2);
righ = lef + len - 1;
weigh_1(lef : righ) = weigh;
weigh_2(lef : righ) = fliplr(weigh);
weigh_1(1:lef-1)=1;
weigh_2(righ+1:end)=1;
weigh_1 = double(weigh_1);
weigh_2 = double(weigh_2);
sum_weigh = weigh_1 + weigh_2;
weigh_1 = weigh_1 ./ sum_weigh;
weigh_2 = weigh_2 ./ sum_weigh;
% weigh_1(center) = 100;
% weigh_2(center) = 100;

weigh_1 = ones(s(1),1)*weigh_1;
weigh_2 = ones(s(1),1)*weigh_2;
end