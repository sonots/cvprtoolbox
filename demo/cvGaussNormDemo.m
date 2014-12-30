% cvGaussNormDemo - Demo of cvGaussNorm
I = imread('image/lena.png');
figure;imshow(I);
[nRow, nCol, nC] = size(I);
X = reshape(double(I), nRow*nCol, nC).';
X = cvGaussNorm(X, true);
I = reshape(X.', nRow, nCol, nC);
figure;imshow(uint8(cvHistnorm(I)));
