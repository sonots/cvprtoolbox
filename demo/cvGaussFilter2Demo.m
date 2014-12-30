% cvGaussFilter2Demo - Demo of cvGaussFilter2
function cvGaussFilter2Demo
 I = imread('../image/texture.20.png');
 figure; imshow(I);
 Sigma = [3 0; 0 3];
 % 95% confidence range
 wsize = [4*ceil(sqrt(Sigma(1,1)))+1 4*ceil(sqrt(Sigma(2,2)))+1]; 
 [GO, GF] = cvGaussFilter2(I, wsize, Sigma, 'reflect', 'normsum');
 fig = figure; imshow(uint8(GO));
 % cvuResizeImageFig(fig, size(GO), 1);
end
