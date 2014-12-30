function X = cvHisteq(I)
% cvHisteq - Histogram Equalization
%
% Synopsis
%   X = cvHisteq(I)
%
% Description
%   Histogram Equalization
%
% Inputs ([]s are optional)
%   (array)  I        Image. Image much be uint8|16|32|64. 
%
% Outputs ([]s are optional)
%   (array)  X        Equalized array
%
% Examples
%   I = cvuImgread('image/lena.png');
%   figure;imshow(I);
%   figure;imshow(uint8(cvHisteq(I)));
%
% See also
%   cvHistnorm, histeq (Image Processing Toolbox)

% Authors
%   Naotoshi Seo <sonots(at)sonots.com>
%
% License
%   The program is free to use for non-commercial academic purposes,
%   but for course works, you must understand what is going inside to use.
%   The program can be used, modified, or re-distributed for any purposes
%   if you or one of your group understand codes (the one must come to
%   court if court cases occur.) Please contact the authors if you are
%   interested in using the program without meeting the above conditions.
%
% Changes
%   04/01/2005  First Edition
type = class(I);
if ~strcmp('uint', type(1:4)),
    error('The class type of input image I must be one of uint8|16|32|64.');
end
L = double(intmax(type));
[nRow, nCol, C] = size(I);
% pdf
pdf = zeros(L+1, C);
for i = 0:L
    pdf(i+1, :) = sum(sum(I == i));
end
pdf = pdf ./ (nRow * nCol); % hist(reshape(I, nRow * nCol, 1), range);
% cdf
cdf = cumsum(pdf, 1);
% transform
X = zeros(nRow, nCol, C);
for c = 1:C
    for i = 0:L
        if (pdf(i+1, c) <= 0), continue; end
        X(:,:,c) = X(:,:,c) + (I(:,:,c) == i) * cdf(i+1, c);
    end
end
X = eval(sprintf('%s(X * L)', type));
end
