

image1 = imread('eval-data-gray\Army\frame11.png');
image2 = imread('eval-data-gray\Army\frame10.png');

% figure;
% imshow(image1);
% figure;
% imshow(image2);
image1 = double(image1);
image2 = double(image2);
x = zeros(size(image1));
y = zeros(size(image2));
[fx, fy, ft] = derivatives(image1, image2);
matrix = zeros(9,2);
vector  = zeros(9,1);


% Window = 3*3
for i = 2:size(fx,1)-1
    for j = 2:size(fx,2)-1
        matrix(:,1) = reshape(fx(i-1:i+1,j-1:j+1),9,1);
        matrix(:,2) = reshape(fy(i-1:i+1,j-1:j+1),9,1);
        vector(:,1) = -reshape(ft(i-1:i+1,j-1:j+1),9,1);
        xy = pinv(matrix)*vector;
        x(i,j) = xy(1);
        y(i,j) = xy(2);
    end
end

        
x(isnan(x))=0;
y(isnan(y))=0;
figure('Name','Optical Flow');
for i=1:size(x,1)
    for j=1:size(y,2)
        if floor(i/20)~=i/20 || floor(j/20)~=j/20
            
            
            x(i,j)=0;
            y(i,j)=0;
        end
    end
end
quiver(x, y, 30,'-', 'color', 'b', 'linewidth', 1);
ylim([0 400]);
title('Optical Flow by LucasKanade method');
set(gca,'YDir','reverse');



