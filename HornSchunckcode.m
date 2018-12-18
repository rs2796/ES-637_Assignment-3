

image1 = imread('eval-data-gray\Army\frame11.png');
image2 = imread('eval-data-gray\Army\frame10.png');


image1 = double(image1);
image2 = double(image2);
u = zeros(size(image1));
v = zeros(size(image2));
[fx, fy, ft] = derivatives(image1, image2);
matrix = [0,1/4,0;1/4,0,1/4;0,1/4,0];
lambda = 2;
n = input('Enter the number or times you want to run the loop: ');
for i = 1:n
    u1=conv2(u,matrix,'same');
    v1=conv2(v,matrix,'same');
    % Compute flow vectors constrained by its local average and the optical flow constraints
    u= u1 - ( fx .* ( ( fx .* u1 ) + ( fy .* v1 ) + ft ) ) ./ ( lambda^2 + fx.^2 + fy.^2); 
    v= v1 - ( fy .* ( ( fx .* u1 ) + ( fy .* v1) + ft ) ) ./ ( lambda^2 + fx.^2 + fy.^2);
end

u(isnan(u))=0;
v(isnan(v))=0;
figure('Name','Optical Flow');
for i=1:size(u,1)
    for j=1:size(u,2)
        if floor(i/20)~=i/20 || floor(j/20)~=j/20
            
            
            u(i,j)=0;
            v(i,j)=0;
        end
    end
end
image1 = uint8(image1);

quiver(u, v, 30,'-', 'color', 'b', 'linewidth', 1);
title('Optical Flow by HornSchunck method');
set(gca,'YDir','reverse');

figure('Name','Optical Flow on Image1');
imshow(image1);
hold on;
quiver(u, v, 30,'-', 'color', 'r', 'linewidth', 1);
title('Optical Flow by HornSchunck method on image1');




