function varargout = main(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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

function main_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);
movegui('center');

function varargout = main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% --------------------------------------------------------------------
function menu_file_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function menu_other_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function other_help_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function file_open_Callback(hObject, eventdata, handles)
[filename,pathname] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';'*.*','All Files' },'Open an image...');
global full_path
full_path = strcat(pathname,filename);
disp(full_path);
axes(handles.image_original);
imshow(full_path);

% --------------------------------------------------------------------
function file_save_Callback(hObject, eventdata, handles)
global image_filtered
imwrite(image_filtered,'result.jpg');

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)

% --- Executes on button press in apply_button.
function apply_button_Callback(hObject, eventdata, handles)
global full_path;
global image_filtered;
global image_original;
image_original = imread(full_path);
image_filtered = imread(full_path);


low_in = get(handles.c_lowin,'value');
low_out = get(handles.c_lowout,'value');
high_in = get(handles.c_highin,'value');
high_out = get(handles.c_highout,'value');

disp(low_in);
disp(low_out);
disp(high_in);
disp(high_out);
image_filtered = imadjust(image_filtered, [low_in;high_in],[low_out;high_out]);

if(get(handles.c_binary, 'value') == 1)
    image_filtered = rgb2gray(image_filtered);
    image_filtered = imbinarize(image_filtered);
elseif(get(handles.c_grayscale, 'value') == 1)
    image_filtered = rgb2gray(image_filtered);
else
    %do nothing
end

if(get(handles.c_motion, 'value') == 1)
    h = fspecial('motion');
    image_filtered = imfilter(image_filtered,h);
end
if(get(handles.c_gaussian, 'value') == 1)
    h = fspecial('gaussian',[1000,1],1);
    image_filtered = imfilter(image_filtered,h);
end
if(get(handles.c_laplacian, 'value') == 1)
    h = fspecial('average');
    image_filtered = imfilter(image_filtered,h);
end
if(get(handles.c_disk, 'value') == 1)
    h = fspecial('unsharp');
    image_filtered = imfilter(image_filtered,h);
end
if(get(handles.c_prewitt, 'value') == 1)
    h = fspecial('laplacian');
    image_filtered = imfilter(image_filtered,h);
end
if(get(handles.c_sobel, 'value') == 1)
    h = fspecial('sobel');
    image_filtered = imfilter(image_filtered,h);
end

if(get(handles.c_invert, 'value') == 1)
    image_filtered = imcomplement(image_filtered);
end

if(get(handles.c_erosion, 'value') == 1) 
    image_filtered = imerode(image_filtered,ones(3));
end

if(get(handles.c_erosion, 'value') == 1) 
    image_filtered = imerode(image_filtered,ones(3));
end

if(get(handles.c_estimate, 'value') == 1) 
    image_filtered = imopen(image_filtered,strel('disk',15));
end

if(get(handles.c_subtract, 'value') == 1)
    image_filtered = imsubtract(image_original,image_filtered);
end


axes(handles.image_generated);
imshow(image_filtered);


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


% --- Executes on button press in reset_button.
function reset_button_Callback(hObject, eventdata, handles)
% hObject    handle to reset_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_original
global image_filtered
figure(2),imhist(rgb2gray(image_original));

% --- Executes on button press in c_laplacian.
function c_laplacian_Callback(hObject, eventdata, handles)
% hObject    handle to c_laplacian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_laplacian


% --- Executes on button press in c_gaussian.
function c_gaussian_Callback(hObject, eventdata, handles)
% hObject    handle to c_gaussian (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_gaussian


% --- Executes on button press in c_motion.
function c_motion_Callback(hObject, eventdata, handles)
% hObject    handle to c_motion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_motion


% --- Executes on button press in c_sobel.
function c_sobel_Callback(hObject, eventdata, handles)
% hObject    handle to c_sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_sobel


% --- Executes on button press in c_prewitt.
function c_prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to c_prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_prewitt


% --- Executes on button press in c_disk.
function c_disk_Callback(hObject, eventdata, handles)
% hObject    handle to c_disk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_disk



function c_contrast_Callback(hObject, eventdata, handles)
% hObject    handle to c_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c_contrast as text
%        str2double(get(hObject,'String')) returns contents of c_contrast as a double


% --- Executes during object creation, after setting all properties.
function c_contrast_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_threshold_Callback(hObject, eventdata, handles)
% hObject    handle to c_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c_threshold as text
%        str2double(get(hObject,'String')) returns contents of c_threshold as a double


% --- Executes during object creation, after setting all properties.
function c_threshold_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_threshold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in c_invert.
function c_invert_Callback(hObject, eventdata, handles)
% hObject    handle to c_invert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_invert


% --- Executes on button press in c_erosion.
function c_erosion_Callback(hObject, eventdata, handles)
% hObject    handle to c_erosion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_erosion


% --- Executes on button press in c_dilate.
function c_dilate_Callback(hObject, eventdata, handles)
% hObject    handle to c_dilate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_dilate


% --- Executes on button press in c_estimate.
function c_estimate_Callback(hObject, eventdata, handles)
% hObject    handle to c_estimate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_estimate


% --- Executes on button press in c_subtract.
function c_subtract_Callback(hObject, eventdata, handles)
% hObject    handle to c_subtract (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of c_subtract


% --- Executes on slider movement.
function c_lowin_Callback(hObject, eventdata, handles)
% hObject    handle to c_lowin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function c_lowin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_lowin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function c_lowout_Callback(hObject, eventdata, handles)
% hObject    handle to c_lowout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function c_lowout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_lowout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function c_highin_Callback(hObject, eventdata, handles)
% hObject    handle to c_highin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function c_highin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_highin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function c_highout_Callback(hObject, eventdata, handles)
% hObject    handle to c_highout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function c_highout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_highout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in c_edited.
function c_edited_Callback(hObject, eventdata, handles)
% hObject    handle to c_edited (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image_original
global image_filtered
figure(3),imhist(rgb2gray(image_filtered));