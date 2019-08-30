function varargout = Alinement(varargin)
% ALINEMENT MATLAB code for Alinement.fig
%      ALINEMENT, by itself, creates a new ALINEMENT or raises the existing
%      singleton*.
%
%      H = ALINEMENT returns the handle to a new ALINEMENT or the handle to
%      the existing singleton*.
%
%      ALINEMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ALINEMENT.M with the given input arguments.
%
%      ALINEMENT('Property','Value',...) creates a new ALINEMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Alinement_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Alinement_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Alinement

% Last Modified by GUIDE v2.5 02-Feb-2019 15:45:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Alinement_OpeningFcn, ...
    'gui_OutputFcn',  @Alinement_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before Alinement is made visible.
function Alinement_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Alinement (see VARARGIN)

% Choose default command line output for Alinement
handles.output = hObject;
% if exist('dataAline')
%     disp('1');
%     load dataAline
%     set(handles.edit6,'string',num2str(handles.x1));
%     set(handles.edit7,'string',num2str(handles.x2));
%     set(handles.edit8,'string',num2str(handles.y1));
%     set(handles.edit9,'string',num2str(handles.y2));
%     set(handles.edit1,'string',handles.tp2);
% end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Alinement wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Alinement_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
tp2 = get(hObject,'String');
set(handles.edit1,'string',tp2);
altp = strrep(tp2,'-',':');
p1 = isstrprop(altp,'digit');
p2 = (altp==':');
p3 = (altp==',');
p = p1+p2+p3;
pp = min(p);
if pp==0
    errordlg('Unsupported format');
    error('Please input number list as "1,3-6,12"(means 1,3,4,5,6,12),seperate by"," and connect by"-"');
else
    altp = str2num(altp);
    aliNum = flip(sort(altp));
    aliNum = [aliNum,1];
    handles.tp2 = tp2;
    handles.aliNum = aliNum;
    guidata(hObject,handles);
end

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[~,dirName] = uigetfile('*.tif','Please select projection saving file..');
if dirName~=0
    set(handles.edit4,'string',dirName);
    handles.projSaving = dirName;
    guidata(hObject,handles);
end


function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double
handles.x1 = str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
handles.x2 = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double
handles.y1 = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double
handles.y2 = str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dirProj0 = handles.projSaving;

aliNum = handles.aliNum;
aliNum
l = length(aliNum)-1;
l

newDir = [dirProj0,'new'];
mkdir(newDir);
newFront = fullfile(newDir,'Front.tif');
newSide = fullfile(newDir,'Side.tif');
delIfExi(newFront,newSide);

tp = length(dir(fullfile(dirProj0,'*.tif')))/2;
tp
dxyz = zeros(tp,3);


for k = 1:l
    dirProj = [dirProj0,'Front-'];
    pc = aliNum(k);%参考图坐标
    pg = pc-1;%更改图坐标
    dx1 = dxyz(pc,1);dy = dxyz(pc,2);%先来12号
    n1 = [dirProj,num2str(pg),'.tif'];%更改
    n2 = [dirProj,num2str(pc),'.tif'];%参考
    im1 = imread(n1);im2 = imread(n2);
    im2 = circshift(im2,[dx1,dy]);%参考图先对齐
    [dx1,dy] = registerImages(im1,im2);%获得偏差
    dirProj = [dirProj0,'Side-'];
    dx2 = dxyz(pc,1);dz = dxyz(pc,3);%再来34号
    n1 = [dirProj,num2str(pg),'.tif'];%更改
    n2 = [dirProj,num2str(pc),'.tif'];%参考
    im1 = imread(n1);im2 = imread(n2);
    im2 = circshift(im2,[dx2,dz]);%参考图先对齐
    [dx2,dz] = registerImages(im1,im2);%获得偏差
    dx = round((dx1+dx2)/2);
    pl = aliNum(k+1);
    temp = repmat([dx,dy,dz],(pc-pl),1);
    dxyz(pl:pg,:) = temp;
end

stretchSize = size(im2,2);



maxProj = imread([dirProj0,'Front-',num2str(aliNum(1)),'.tif']);
for k = 1:tp
    k
    n1 = [dirProj0,'Front-',num2str(k),'.tif'];
    dx = dxyz(k,1);
    dy = dxyz(k,2);
    dz = dxyz(k,3);
    im1 = imread(n1);
    im0 = circshift(im1,[dx,dy]);
    imwrite(im0,newFront,'writemode','append');
    maxProj = max(maxProj,im0);
    n2 = [dirProj0,'Side-',num2str(k),'.tif'];
    im2 = imread(n2);
    im0 = circshift(im2,[dx,dz]);
    imwrite(im0,newSide,'writemode','append');
end

bw = getShape(maxProj);
[x1,x2,y1,y2] = findEdge(bw);

handles.tp = tp;
handles.dxyz = dxyz;
handles.stretchSize = stretchSize;
handles.x1 = x1;
handles.x2 = x2;
handles.y1 = y1;
handles.y2 = y2;
handles.newDir = newDir;
handles.newFront = newFront;
guidata(hObject, handles);

% save GUI/dataAline handles

set(handles.edit6,'string',num2str(x1));
set(handles.edit7,'string',num2str(x2));
set(handles.edit8,'string',num2str(y1));
set(handles.edit9,'string',num2str(y2));

msgbox('Please refer to the aligned file.');



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
x1 = handles.x1;
x2 = handles.x2;
y1 = handles.y1;
y2 = handles.y2;
tp = handles.tp;
newFront = handles.newFront;
newDir = handles.newDir;
out = fullfile(newDir,'cropTest.tif');

delIfExi(out);

for k = 1:tp
    orig = imread(newFront,k);
    crop = orig(y1:y2,x1:x2);
    imwrite(crop,out,'writemode','append');
    disp(k);
end

msgbox('Please refer to the crop test file.');



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[~,dirName] = uigetfile('*.*','Please select data saving file..');
if dirName~=0
    set(handles.edit10,'string',dirName);
    handles.dataSaving = dirName;
    guidata(hObject,handles);
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

stretchSize = handles.stretchSize;
x10 = handles.x1;
x20 = handles.x2;
y10 = handles.y1;
y20 = handles.y2;
dxyz = handles.dxyz;
tp = size(dxyz,1);
dataSaving = handles.dataSaving;
songbi = '.\myFun\test\';
ccplane = zeros(y20-y10+1,x20-x10+1);

f0 = [dataSaving,'1.tif'];
a = imfinfo(f0);
pnum = length(a);
stretching = stretchSize/pnum;
dxyz(:,3) = round(dxyz(:,3)/stretching);

a = imread(f0);
eval(['ccplane = ',class(a),'(ccplane);']);

% save data

for c2start = 1:tp+1
    if exist([dataSaving,'\',num2str(c2start),'C2.tif'],'file')
        break
    end
end

b = questdlg('ARE YOU SURE? Here is no way back...','Warning!!','Yes!','Wait...','default');
if b(1)=='Y'
    noC20 = fullfile(songbi,'temp.tif');
    for p = 1:pnum
        imwrite(ccplane,noC20,'writemode','append');
    end

    h = waitbar(0,'Aligning...');
    for k = 1:tp
        waitbar(k/tp,h);
        dx = dxyz(k,2);
        dy = dxyz(k,1);
        dz = dxyz(k,3);
        x1 = x10-dx;
        y1 = y10-dy;
        x2 = x20-dx;
        y2 = y20-dy;
        n = fullfile(dataSaving,[num2str(k),'.tif']);
        no = fullfile(songbi,[num2str(k),'.tif']);
        n2 = fullfile(dataSaving,[num2str(k),'C2.tif']);
        no2 = fullfile(songbi,[num2str(k),'C2.tif']);
        if k<c2start
            copyfile(noC20,no2);
        end
        
        if dz>0
            for p = 1:dz
                imwrite(ccplane,no,'writemode','append');
                if k>=c2start
                    imwrite(ccplane,no2,'writemode','append');
                end
            end
            for p = 1:pnum-dz
                im1 = imread(n,p);
                im = im1(y1:y2,x1:x2);
                imwrite(im,no,'writemode','append');
                if k>=c2start
                    im2 = imread(n2,p);
                    im22 = im2(y1:y2,x1:x2);
                    imwrite(im22,no2,'writemode','append');
                end
            end
        else
            st = -dz+1;
            for p = st:pnum
                im1 = imread(n,p);
                im = im1(y1:y2,x1:x2);
                imwrite(im,no,'writemode','append');
                if k>=c2start
                    im2 = imread(n2,p);
                    im22 = im2(y1:y2,x1:x2);
                    imwrite(im22,no2,'writemode','append');
                end
            end
            for p = 1:-dz
                imwrite(ccplane,no,'writemode','append');
                if k>=c2start
                    imwrite(ccplane,no2,'writemode','append');
                end
            end
        end
            delete(n);
            movefile(no,n);
            if k>=c2start
            delete(n2);
            end
            movefile(no2,n2);
    end
    delete(noC20);
    close(h);
    msgbox('All done, yeah!');
else
    msgbox('OK,please check the crop test again : )')
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear;clc
close(gcf);
main
