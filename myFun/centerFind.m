function m = centerFind(vec)
l = length(vec);
k = zeros(1,l);
for p =1:l
    k(p) = sum(vec(1:p));
end
k = k./max(k);
t = abs(k-0.5);
m = find(t==min(t));
end