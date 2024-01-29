close all
clear all

%ASLI KURT _ 151220182068
%reading the image that named NEI-medialibrary-4506615.jpg
Image = imread("NEI-medialibrary-4506615.jpg");

%displaying the image that has read
figure;
imshow(Image);
axis on
title('Original Image');

%extract the blue channel
Image_blue_channel = Image(:, :, 3); %the image is in RGB format

%displaying the blue channel of the image
figure;
imshow(Image_blue_channel);
axis on
title('Blue Channel of Image');

%definition of the parameters that used to apply canny edge detection operation
Tlow_blue = 0.05;
Thigh_blue = 0.15;
sigma_blue = 1;

%applying canny edge detecting operation
%BW = edge(I,method,threshold,sigma) has used.
Image_canny_blue = edge(Image_blue_channel,'Canny',[Tlow_blue Thigh_blue], sigma_blue);

%displaying the obtained image
figure;
imshow(Image_canny_blue);
axis on
title('Canny Edge Detection Operation applied blue channel of the image thr = [0.05 0.15]');

%definition of the parameter that used optimum sigma value in canny operation
sigma_blue_opt = 6;

%applying canny edge detecting operation
E_canny_blue_opt = edge(Image_blue_channel,'Canny',graythresh(Image_blue_channel), sigma_blue_opt);
%[E_canny_blue_opt,optThr_blue] = edge(Image_blue_channel,'canny');

%displaying the obtained image
figure; 
imshow(E_canny_blue_opt);
axis on
title('Canny Edge Detection Operation applied blue channel of the image');

%finding circles by using imfindcircles function
[centers, radii] = imfindcircles(E_canny_blue_opt, [14, 100]); %radius has selected between 14 and 100

%display the original image with circles
figure; 
imshow(E_canny_blue_opt);
axis on
title('Detected Circles after the using Optimum Values of Canny Operation Parameters');

%draw circles on the image that obtained after applying canny edge operation
viscircles(centers, radii, 'EdgeColor', 'r');

%displaying the image that has obtained
figure;
imshow(Image);
axis on
title('Center Locations and Perimeter Values on Original Image');
viscircles(centers, radii, 'EdgeColor', 'b' , 'LineWidth' , 0.5);

for i = 1:size(centers, 1)
    
    %defining the informations that center text, perimeter text and value
    center = '.Center';
    perimeterText = 'Perimeter = ';
    perimeterValue = 2 * pi * radii(i); % perimeter formula = 2*pi*radius

    %put the parameters together
    perimeter = [perimeterText num2str(perimeterValue)];
    
    %display the center of the circles and perimeter values by using text()
    text(centers(i, 1), centers(i, 2), center, 'Color', 'g', 'FontSize', 6, 'FontWeight', 'bold');
    text(centers(i, 1), centers(i, 2) + 15, perimeter, 'Color', 'r', 'FontSize', 7, 'FontWeight', 'bold');

end 
