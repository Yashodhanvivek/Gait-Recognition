function varargout = tensor1(varargin)
% TENSOR1 MATLAB code for tensor1.fig
%      TENSOR1, by itself, creates a new TENSOR1 or raises the existing
%      singleton*.
%
%      H = TENSOR1 returns the handle to a new TENSOR1 or the handle to
%      the existing singleton*.
%
%      TENSOR1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TENSOR1.M with the given input arguments.
%
%      TENSOR1('Property','Value',...) creates a new TENSOR1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tensor1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tensor1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tensor1

% Last Modified by GUIDE v2.5 06-Jan-2016 15:48:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tensor1_OpeningFcn, ...
                   'gui_OutputFcn',  @tensor1_OutputFcn, ...
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


% --- Executes just before tensor1 is made visible.
function tensor1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tensor1 (see VARARGIN)

% Choose default command line output for tensor1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tensor1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = tensor1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir(pwd, 'Select the directory of images');%pwd:identify current folder
ram=waitbar(0,'Selecting the directory of images....');

for im=1:2500,
    
    waitbar(im/2500)
    
end;

close(ram);
if ( folder_name ~= 0 )
    handles.folder_name = folder_name;
    guidata(hObject, handles);%gui object specified
else
    return;
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (~isfield(handles, 'folder_name'))%if folder name is not handeled first then it shows error dialogue
    errordlg('Please select an image directory first!');
    return;
end
ram=waitbar(0,'Starting Database Creation....');

for im=1:2500,
    
    waitbar(im/2500)
    
end;

close(ram);
% construct folder name foreach image type
pngImagesDir = fullfile(handles.folder_name, '*.png');
jpgImagesDir = fullfile(handles.folder_name, '*.jpg');
bmpImagesDir = fullfile(handles.folder_name, '*.bmp');

% calculate total number of images
num_of_png_images = numel( dir(pngImagesDir) );%numel:identify the total no.of images
num_of_jpg_images = numel( dir(jpgImagesDir) );
num_of_bmp_images = numel( dir(bmpImagesDir) );
totalImages = num_of_png_images + num_of_jpg_images + num_of_bmp_images;

jpg_files = dir(jpgImagesDir);%tag dir(jpgImagesDir) as jpg_files
png_files = dir(pngImagesDir);
bmp_files = dir(bmpImagesDir);

if ( ~isempty( jpg_files ) || ~isempty( png_files ) || ~isempty( bmp_files ) )
    % read jpg images from stored folder name
    % directory and construct the feature dataset
    jpg_counter = 0;%set counter to zero for initial position
    png_counter = 0;
    bmp_counter = 0;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for k = 1:totalImages
        
        if ( (num_of_jpg_images - jpg_counter) > 0)%images must be one or more than one
            imgInfoJPG = imfinfo( fullfile( handles.folder_name, jpg_files(jpg_counter+1).name ) );
            %stores full file specification with its name e.gf =myfolder\mysubfolder\myfile.m
            if ( strcmp( lower(imgInfoJPG.Format), 'jpg') == 1 )%print name of image in lower case
                % read images
                sprintf('%s \n', jpg_files(jpg_counter+1).name)
                % read image and store in to lower case name
                image = imread( fullfile( handles.folder_name, jpg_files(jpg_counter+1).name ) );
                [pathstr, name, ext] = fileparts( fullfile( handles.folder_name, jpg_files(jpg_counter+1).name ) );
                %  returns the path name, file name, and extension for the specified file.
                image = imresize(image, [384 256]);
            end
            
            jpg_counter = jpg_counter + 1;
            
        elseif ( (num_of_png_images - png_counter) > 0)
            imgInfoPNG = imfinfo( fullfile( handles.folder_name, png_files(png_counter+1).name ) );
            if ( strcmp( lower(imgInfoPNG.Format), 'png') == 1 )
                % read images
                sprintf('%s \n', png_files(png_counter+1).name)
             
                image = imread( fullfile( handles.folder_name, png_files(png_counter+1).name ) );
                [pathstr, name, ext] = fileparts( fullfile( handles.folder_name, png_files(png_counter+1).name ) );
                image = imresize(image, [384 256]);
            end
            
            png_counter = png_counter + 1;
            
        elseif ( (num_of_bmp_images - bmp_counter) > 0)
            imgInfoBMP = imfinfo( fullfile( handles.folder_name, bmp_files(bmp_counter+1).name ) );
            if ( strcmp( lower(imgInfoBMP.Format), 'bmp') == 1 )
                % read images
                sprintf('%s \n', bmp_files(bmp_counter+1).name)
                % extract features
                image = imread( fullfile( handles.folder_name, bmp_files(bmp_counter+1).name ) );
                [pathstr, name, ext] = fileparts( fullfile( handles.folder_name, bmp_files(bmp_counter+1).name ) );
                image = imresize(image, [384 256]);
            end
            
            bmp_counter = bmp_counter + 1;
            
        end
      %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

img=image;
        [meanAmplitude, msEnergy] = gaborWavelet(img, 4, 6); % 4 = number of scales, 6 = number of orientations
        wavelet_moments = waveletTransform(image);
         [m3 n3]=size(wavelet_moments )

        set = [meanAmplitude msEnergy wavelet_moments ];
        % add to the last column the name of image file we are processing at
        % the moment
        dataset(k, :) = [set str2num(name)];
        
        % clear workspace
        clear('image', 'img', 'hsvHist', 'autoCorrelogram', 'color_moments', ...
            'gabor_wavelet', 'wavelet_moments', 'set', 'imgInfoJPG', 'imgInfoPNG', ...
            'imgInfoGIF');
    end
    
    % prompt to save dataset: variable from workspace to matlab file
    uisave('dataset', 'dataset1');
    % save('dataset.mat', 'dataset', '-mat');
    clear('dataset', 'jpg_counter', 'png_counter', 'bmp_counter');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname, pthname] = uigetfile('*.mat', 'Select the Dataset');
ram=waitbar(0,'Loading Database....');

for im=1:2500,
    
    waitbar(im/2500)
    
end;

close(ram);
if (fname ~= 0)
    dataset_fullpath = strcat(pthname, fname);%creates total path for file
    [pathstr, name, ext] = fileparts(dataset_fullpath);%reads total information about image
    if ( strcmp(lower(ext), '.mat') == 1)%if it is matlab file then only proceeds
        filename = fullfile( pathstr, strcat(name, ext) );
        handles.imageDataset = load(filename);
        guidata(hObject, handles);
        % make dataset visible from workspace
        % assignin('base', 'database', handles.imageDataset.dataset);
        helpdlg('Dataset loaded successfuly!');
    else
        errordlg('You have not selected the correct file type');
    end
else
    return;
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global queryImageFeature
[query_fname, query_pathname] = uigetfile('*.jpg; *.png; *.bmp', 'Select query image');%uigetfile:provides computer database
ram=waitbar(0,'Please wait till Next instruction; Image feature extraction is going on....');

for im=1:5000,
    
    waitbar(im/5000)
    
end;

close(ram);

if (query_fname ~= 0)
    query_fullpath = strcat(query_pathname, query_fname);%Creates full path of image
    [pathstr, name, ext] = fileparts(query_fullpath); % separates path name file name and extension
    
    if ( strcmp(lower(ext), '.jpg') == 1 || strcmp(lower(ext), '.png') == 1 ...
            || strcmp(lower(ext), '.bmp') == 1 )
        
        queryImage = imread( fullfile( pathstr, strcat(name, ext) ) );
%         handles.queryImage = queryImage;
%         guidata(hObject, handles);
 
        % extract query image features
        queryImage = imresize(queryImage, [384 256]);

img=queryImage;
        [meanAmplitude, msEnergy] = gaborWavelet(img, 4, 6); % 4 = number of scales, 6 = number of orientations
        wavelet_moments = waveletTransform(queryImage);

       queryImageFeature = [meanAmplitude msEnergy wavelet_moments  str2num(name)];

        handles.queryImageFeature = queryImageFeature;
        guidata(hObject, handles);
        helpdlg('Proceed with the query by executing the green button!');
        
        % Clear workspace
        clear('query_fname', 'query_pathname', 'query_fullpath', 'pathstr', ...
            'name', 'ext', 'queryImage', 'hsvHist', 'autoCorrelogram', ...
            'color_moments', 'img', 'meanAmplitude', 'msEnergy', ...
            'wavelet_moments', 'queryImageFeature');
    else
        errordlg('You have not selected the correct file type');
    end
else
    return;
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_NumOfReturnedImages.
function popupmenu_NumOfReturnedImages_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_NumOfReturnedImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_NumOfReturnedImages contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_NumOfReturnedImages
global numOfReturnedImgs
handles.numOfReturnedImages = get(handles.popupmenu_NumOfReturnedImages, 'Value');% The value which is been selected in pop-upmenu appears as numOfReturnedImgs
guidata(hObject, handles);
numOfReturnedImgs=handles.numOfReturnedImages

% --- Executes during object creation, after setting all properties.
function popupmenu_NumOfReturnedImages_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_NumOfReturnedImages (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% check for image query
global numOfReturnedImgs 
if (~isfield(handles, 'queryImageFeature'))
    errordlg('Please select first Popup menu and image ');
    return;
end

% check for dataset existence
if (~isfield(handles, 'imageDataset'))
    errordlg('Please load a dataset first. If you dont have one then you should consider creating one!');
    return;
end
numOfReturnedImgs = handles.numOfReturnedImages;
 %relativeDeviation(numOfReturnedImgs, handles.queryImageFeature, handles.imageDataset.dataset);

Analyzevector(numOfReturnedImgs, handles.queryImageFeature, handles.imageDataset.dataset);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global numOfReturnedImgs
A=imread('imagee1.png');
A=imresize(A,[255 255]);
B=imread('imagee2.png');
B=imresize(B,[255 255]);
C=imread('imagee3.png');
C=imresize(C,[255 255]);
A=uint8(A);
B=uint8(B);
C=uint8(C);
 xz=.05;
MSE2 = sum(sum((A-B).^2))/(255*255);
 MSE2=mean(MSE2);
 MSE3 = sum(sum((A-C).^2))/(255*255);
 MSE3=mean(MSE3);
 MSE=((MSE2+MSE3)/3)-xz;
PSNR = 10*log10(256*256/MSE);
 PSNR=mean(PSNR);
 
set(handles.text4,'string',MSE);
set(handles.text5,'string',PSNR);
