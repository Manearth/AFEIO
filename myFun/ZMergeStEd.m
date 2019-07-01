function ZMergeStEd(G1,G2,d12,outName,st,ed,dx,dy,numPlane,stg,edg)
s = size(imread(G1,1));
len = ed-st+1;
m = (cos(linspace(0,pi,len))+1)/2;
ccPlane = uint16(zeros(s));
if d12>=0
    for i = 1:d12
        imwrite(ccPlane,outName,'WriteMode','append');
    end
    for i = d12+1:(st-1)
        currentPlane = imread(G2,i-d12);
        currentPlane = circshift(currentPlane,[-dx,-dy]);
        imwrite(currentPlane,outName,'WriteMode','append');
    end
    disp(['G2end',num2str(i)]);
    for i = st:ed
        w1 = m(i-st+1);
        w2 = 1-w1;
        currentPlane = imread(G2,i-d12);
        currentPlane = circshift(currentPlane,[-dx,-dy]);
        currentPlane1 = imread(G1,i-stg(1)+1);
%         currentPlane = w1*currentPlane+w2*currentPlane1;
        currentPlane = max(currentPlane,currentPlane1);
        imwrite(currentPlane,outName,'WriteMode','append');
    end
    for i = (ed+1):numPlane
        currentPlane = imread(G1,i-stg(1)+1);
        imwrite(currentPlane,outName,'WriteMode','append');
    end
else
    disp ('case2')
    for i = 1:st-1-d12
        currentPlane = imread(G2,i);
        currentPlane = circshift(currentPlane,[-dx,-dy]);
        imwrite(currentPlane,outName,'WriteMode','append');
    end
    disp(['G2end',num2str(i)]);
    for i = st:ed
        w1 = m(i-st+1);
        w2 = 1-w1;
        currentPlane = imread(G2,i-d12);
        currentPlane = circshift(currentPlane,[-dx,-dy]);
        currentPlane1 = imread(G1,i+1-stg(1));
%         currentPlane = w1*currentPlane+w2*currentPlane1;
        currentPlane = max(currentPlane,currentPlane1);
        imwrite(currentPlane,outName,'WriteMode','append');
    end
    disp(['G1from',num2str(ed+1-stg(1)+1),'ifstg==1:',num2str(ed+1)]);
    for i = (ed+1):numPlane+d12
        currentPlane = imread(G1,i-stg(1)+1);
        imwrite(currentPlane,outName,'WriteMode','append');
    end
end
end