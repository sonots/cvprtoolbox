% cvLaplacianDemo - Demo of cvLaplacian
I = cvuImgread('../image/lena.png');
O = cvLaplacian(I, 200);
figure; imshow(I);
figure; imshow(O);
O = cvLaplacian(I);
figure; imshow(uint8(cvuNormalize(O, [0, 255])));
