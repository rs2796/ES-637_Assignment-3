function [fx, fy, ft] = derivatives(image1, image2)



fx = conv2(image1,0.25* [-1 1; -1 1],'same') + conv2(image2, 0.25*[-1 1; -1 1],'same');
fy = conv2(image1, 0.25*[-1 -1; 1 1], 'same') + conv2(image2, 0.25*[-1 -1; 1 1], 'same');
ft = conv2(image1, 0.25*ones(2),'same') + conv2(image2, -0.25*ones(2),'same');
