

for k =timePoints
    %中断判断 更新时间
    if bstop ==1
        msgbox('Interrupted!');
        break
    end
    set(handles.edit9,'string',num2str(k));
    pause(0.1);
    disp(['now processing time point ',num2str(k)]);
    % 获取输入输出路径
    inputFile = [num2str(k),'_G1.',form];
    inputName = [inputFolder,inputFile];
    outFile = [num2str(k),'.tif'];
    outName = [outputFolder,'\',outFile];
    outName2 = strrep(outName,'.tif','C2.tif');
    tempNameWrite = fullfile(tempFolder,[num2str(k),'_G1write.tif']);
    tempNameWrite2 = strrep(tempNameWrite,'.tif','C2.tif');
    
    
    % 获得通道数，单色or双色/获得处理范围
    colorChannel = 1;
    if k>=C2num
        colorChannel =2;
    end
    
    %获取平面数量、尺寸及handle
    r = bfGetReader(inputName);
    numImages = r.getImageCount();
    numPlane = numImages/(2*colorChannel);
    s(2) =  r.getSizeX();
    s(1) =  r.getSizeY();
    stg = [G1st,1];
    edg = [numPlane,numPlane+1-G2ed];
    
    %顶帽变换核
    s1 = round(estSize*1.25);
    s2 = round(estSize*0.3);
    backStrel = strel('square',s1);
    averker = fspecial('average',s2);
    backStrelC2 = strel('square',2*s1);
    averkerC2 = fspecial('average',s2);
    
    tic
    %两个通道
    for G = 1:2
        
        %若G2 更新handle
        if G==2
            inputName = strrep(inputName,'_G1','_G2');
            tempNameWrite = strrep(tempNameWrite,'_G1','_G2');
            tempNameWrite2 = strrep(tempNameWrite2,'_G1','_G2');
            r = bfGetReader(inputName);
        end
        % 初始化图片亮度
        if G==1
            fff = zeros(2,numPlane);
        end
        %开始结束
        st = stg(G);ed = edg(G);
        
        delIfExi(tempNameWrite,tempNameWrite2,outName,outName2);
        %合图片
        for p1 = st:ed
            disp(['G',num2str(G),'-p',num2str(p1)]);
            if G == 1
                p = p1;
            else
                p = numPlane + 1 - p1;
            end
            lf = (p-1).*2.*colorChannel+1;
            rg = lf + colorChannel;
            im_lef = bfGetPlane(r,lf);
            im_righ = bfGetPlane(r,rg);
            if colorChannel ==2
                lf2 = lf+1;
                rg2 = rg+1;
                im_lef2 = bfGetPlane(r,lf2);
                im_righ2 = bfGetPlane(r,rg2);
                [img,img2] = smerge(im_lef,im_righ,im_lef2,im_righ2);
                 %解决串色
                 se = strel('square',2*s1);
                 img2 = img2 - c*imtophat(img,se);
                 %减背景
                img = subsBackground(img,backStrel, averker);
                img2 = subsBackground(img2,backStrelC2, averkerC2);
               

            else
                img = smerge(im_lef,im_righ);
                img = subsBackground(img,backStrel, averker);    
            end
            if G==2
                img = fliplr(img);
                if colorChannel ==2
                    img2 = fliplr(img2);
                end
            end
            %压缩与平均亮度
            img = compPic(img);
            imwrite(img,tempNameWrite,'writemode','append');
            if colorChannel == 2
                img21 = img2;
                img21 = imfilter(img21,averker);
                m = extractC2(img21,70,5,1,10);
                img2(~m) = 0;
                
                imwrite(img2,tempNameWrite2,'writemode','append');
            end
            
            fff(G,p1) = meanPart(img);
        end
        disp([num2str(G),'fusion finished'])  
        
    end
    
    % 获取第一次迭代的分界线
    n1 = strrep(tempNameWrite,'G2','G1');
    n2 = strrep(tempNameWrite,'G1','G2');
    ff = abs(fff(1,:)-fff(2,:)).*(fff(1,:)>0).*(fff(2,:)>0);
    spLine1 = find(ff == min(ff(ff>0)));
    [correspond,~] = findCorrMax(n1,n2,spLine1,stg(1),edg(2),numPlane,stg(1)-1,stg(2)-1,k,corrsave);
    d12 = spLine1 - correspond;
    fff(2,:) = circshift(fff(2,:),[0,d12]);
    
    % 获取最终的分界线
    ff = abs(fff(1,:)-fff(2,:)).*(fff(1,:)>0).*(fff(2,:)>0);
    ff(1:stg(1))=0;ff(edg(2):end)=0;
    ff(ff==0) = 100;
    spLine = find(ff==min(ff));
    mixing = find(ff - min(ff)<min(ff));
    st = mixing(1);ed = mixing(end);
    % spLine2 = findSpCor(stg(1),edg(2),d12,n1,n2,numPlane);
    disp(['1-',num2str(spLine),';d12-',num2str(d12)]);
    
    %获得偏差位置
    im1 = imread(strrep(tempNameWrite,'G2','G1'),spLine-stg(1)+1);
    im2 = imread(strrep(tempNameWrite,'G1','G2'),spLine-d12-stg(2)+1);
    [dx,dy] = registerImages(im1,im2);
    
    %融合
    n1 = strrep(tempNameWrite,'G2','G1');
    n2 = strrep(tempNameWrite,'G1','G2');
    ZMergeStEd(n1,n2,d12,outName,spLine-3,spLine+3,dx,dy,numPlane,stg,edg)
    delete(n1);delete(n2);
    if colorChannel ==2
        n1c2 = strrep(n1,'.tif','C2.tif');
        n2c2 = strrep(n2,'.tif','C2.tif');
        ZMergeStEd(n1c2,n2c2,d12,outName2,spLine-3,spLine+3,dx,dy,numPlane,stg,edg)
        delete(n1c2);delete(n2c2);
    end
end
toc
if bstop==0
    msgbox('Done!');
end
