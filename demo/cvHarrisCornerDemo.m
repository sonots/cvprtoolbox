% cvHarrisCornerDemo - Demo of cvHarrisCorner
function cvHarrisCornerDemo
I = cvuImgread('../image/lena.png');
wsize = 5; sigma = 1.0; nCorner = 300;
[Xcoord Ycoord] = cvHarrisCorner(I, wsize, sigma, nCorner);
figure;
imshow(I); hold on;
plot(Xcoord, Ycoord, 'y*');
end
