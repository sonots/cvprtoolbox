% cvKmeansDemoVQ - Demo of vector quatization using cvKmeans.m
% A color image of 256x256x256 is quantized into n representative colors
% Special thanks to http://www.morguefile.com/ (Free image Archives)
function cvKmeansDemoVq(nColor)
if ~exist('nColor', 'var')
    nColor = 16;
end
I = imread('image/cvKmeansDemoVQ.jpg');
[m n c] = size(I);
I = double(I);
X = reshape(I, m*n, c)';

% main
[cluster, codebook] = cvKmeans(X, nColor);
for i=1:size(codebook, 2)
    idx = find(cluster == i);
    Xvq(:,idx) = repmat(codebook(:,i), 1, length(idx));
end

Ivq = reshape(Xvq', m, n, c);
Ivq = uint8(Ivq);
imshow(Ivq);
%imwrite(Ivq, sprintf('viewvq%02d.png', nColor), 'PNG');

disp('codebook =');
disp('     R         G         B');
disp(codebook');
end