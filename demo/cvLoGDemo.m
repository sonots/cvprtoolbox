% cvLoGDemo - Demo of cvLoG
I = cvuImgread('../image/lena.png');
O = cvLoG(I, 400);
figure; imshow(I);
figure; imshow(O);
O = cvLoG(I);
figure; imshow(uint8(cvuNormalize(O, [0, 255])));
