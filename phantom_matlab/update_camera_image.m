function update_camera_image()

global camera_subs;
global handles;
img = camera_subs.LatestMessage.readImage;
imshow(img, 'Parent', handles.axes1);

end