function varargout = DIREKTS(varargin)
% DIREKTS MATLAB code for DIREKTS.fig
%      DIREKTS, by itself, creates a new DIREKTS or raises the existing
%      singleton*.
%
%      H = DIREKTS returns the handle to a new DIREKTS or the handle to
%      the existing singleton*.
%
%      DIREKTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIREKTS.M with the given input arguments.
%
%      DIREKTS('Property','Value',...) creates a new DIREKTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DIREKTS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DIREKTS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DIREKTS

% Last Modified by GUIDE v2.5 03-Jun-2018 15:38:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DIREKTS_OpeningFcn, ...
                   'gui_OutputFcn',  @DIREKTS_OutputFcn, ...
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


% --- Executes just before DIREKTS is made visible.
function DIREKTS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DIREKTS (see VARARGIN)
axes(handles.axes3)
axis off; 
axes(handles.axes4)
axis off; 
axes(handles.axes1) 
axis off; 
background = imread('fondo.jpg'); 
imshow(background);       
set(handles.text2, 'Visible', 'off');
set(handles.text6, 'Visible', 'off');
set(handles.text8, 'Visible', 'off');
set(handles.text9, 'Visible', 'off');
svm='SVM';
set(handles.text4,'String',svm)
set(handles.text4,'BackgroundColor',[0.85 0.33 0.1])
ktps='K-TSP';
set(handles.text5,'String',ktps)
set(handles.text5,'BackgroundColor',[0.7 0.16 0.08])

%Carga la imagen en background
% Choose default command line output for DIREKTS
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DIREKTS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DIREKTS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function  pushbutton2_Callback(hObject, eventdata, handles)
cla(handles.axes4,'reset') 
axes(handles.axes4)
axis off; 
[FileName Path]=uigetfile({'*.jpg;*.bmp;*.tif;*.png'},'Abrir Imagen'); 
if isequal(FileName,0) 
return
else
I=imread(strcat(Path,FileName)); 
axes(handles.axes3) 
axis off; 
imshow(I);          
rojo=I(:,:,1);
H=fspecial('average');
GS=imfilter(rojo,H);
umbral=0.15;
fondo1=im2bw(rojo,umbral);
str=strel('disk',3,0); 
final=imopen(fondo1,str);
finalb=1-final;
I2 = im2uint8(finalb);
fondo = cat(3,I2,I2,I2); 
g=imsubtract(I,fondo);
saco=rgb2gray(g);
columna=max(saco);
RemoveC=find(columna<10);
g(:,RemoveC,:)=[];
fila= max(saco,[],2);
RemoveF=find(fila<10);
g(RemoveF,:,:)=[];
tamanio=size(g);
alto=tamanio(1);
ancho=tamanio(2);
taza=alto/ancho;
if (taza>0.91)
borro1=ancho*0.5*(1-0.83);
borro2=round(borro1);
limiteinf=borro2;
limitesup=alto-borro2;
final=g(limiteinf:limitesup,:,:);
g=final;
end
R=g(:,:,1);
G=g(:,:,2);
B=g(:,:,3);
AD=adapthisteq(R);
AD2=adapthisteq(G);
AD3=adapthisteq(B);
Nadpt=cat(3,AD,AD2,AD3);
Iout = imresize(Nadpt, [227 227]);
end
handles.direccion=strcat(Path,FileName); 
handles.Iout=Iout; 
load 'variables.mat'
IM=handles.Iout;
net=alexnet;
featureLayer = 'fc6';
trainingFeaturesB= activations(net, IM, featureLayer,'MiniBatchSize', 32, 'OutputAs', 'columns');
trainingFeaturesB=trainingFeaturesB';
trainingFeaturesEQUB = bsxfun(@minus,trainingFeaturesB,median(trainingFeatures50));
[label,scores] = predict(svm,trainingFeaturesEQUB); 
label=char(label);
color=strcmp(label,'Background Diabetic Retinopathy');
if color==1
set(handles.text2,'BackgroundColor',[0.3 0.75 0.93])
set(handles.text8,'BackgroundColor',[0.3 0.75 0.93])
label=char(label);
probsvm=num2str(round(scores(1,1)*100,2));
probsvm=strcat(probsvm,'%');
else
set(handles.text2,'BackgroundColor',[0.94 0.94 0.94])
set(handles.text8,'BackgroundColor',[0.94 0.94 0.94])
probsvm=num2str(round(scores(1,2)*100,2));
probsvm=strcat(probsvm,'%');
end
set(handles.text2, 'Visible', 'on');
set(handles.text2,'String',label)
set(handles.text8, 'Visible', 'on');
set(handles.text8,'String',probsvm)
k=0;
x=zeros(1,18);
x(1)=trainingFeaturesEQUB(1,3860)-trainingFeaturesEQUB(1,2020);
x(2)=trainingFeaturesEQUB(1,2671)-trainingFeaturesEQUB(1,2236);
x(3)=trainingFeaturesEQUB(1,2724)-trainingFeaturesEQUB(1,3397);
x(4)=trainingFeaturesEQUB(1,2204)-trainingFeaturesEQUB(1,3157);
x(5)=trainingFeaturesEQUB(1,3537)-trainingFeaturesEQUB(1,1221);
x(6)=trainingFeaturesEQUB(1,1097)-trainingFeaturesEQUB(1,890);
x(7)=trainingFeaturesEQUB(1,3672)-trainingFeaturesEQUB(1,1010);
x(8)=trainingFeaturesEQUB(1,2822)-trainingFeaturesEQUB(1,263);
x(9)=trainingFeaturesEQUB(1,2200)-trainingFeaturesEQUB(1,3817);
x(10)=trainingFeaturesEQUB(1,1539)-trainingFeaturesEQUB(1,1632);
x(11)=trainingFeaturesEQUB(1,604)-trainingFeaturesEQUB(1,2152);
x(12)=trainingFeaturesEQUB(1,3409)-trainingFeaturesEQUB(1,3638);
x(13)=trainingFeaturesEQUB(1,1916)-trainingFeaturesEQUB(1,236);
x(14)=trainingFeaturesEQUB(1,937)-trainingFeaturesEQUB(1,1218);
x(15)=trainingFeaturesEQUB(1,676)-trainingFeaturesEQUB(1,95);
x(16)=trainingFeaturesEQUB(1,248)-trainingFeaturesEQUB(1,3651);
x(17)=trainingFeaturesEQUB(1,3795)-trainingFeaturesEQUB(1,823);
x(18)=trainingFeaturesEQUB(1,3747)-trainingFeaturesEQUB(1,1140);
for i=1:18
    if x(i)>0
    k=k+1;
    end
end
if k<10
diag='Background Diabetic Retinopathy';
diag2=num2str(round((18-k)*100/18,2));
diag2=strcat(diag2,'%');
else
diag='Normal';
diag2=num2str(round(k*100/18,2));
diag2=strcat(diag2,'%');
end
color2=strcmp(diag,'Background Diabetic Retinopathy');
if color2==1
set(handles.text6,'BackgroundColor',[0.3 0.75 0.93])
set(handles.text9,'BackgroundColor',[0.3 0.75 0.93])
else
set(handles.text6,'BackgroundColor',[0.94 0.94 0.94])
set(handles.text9,'BackgroundColor',[0.94 0.94 0.94])
end
set(handles.text6, 'Visible', 'on');
set(handles.text6,'String',diag)
set(handles.text9, 'Visible', 'on');
set(handles.text9,'String',diag2)
axes(handles.axes4)
hold on
for i = 1:18
    if x(i)>0
       bar(i, x(i),'FaceColor','g');
    else
      bar(i, x(i),'FaceColor','r');
    end
end
hold off
guidata(hObject,handles) 
%hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%   67.8202  81.2470  62.1610

   %9.0408e-04 9.3269e-04 8.3542e-04
   
