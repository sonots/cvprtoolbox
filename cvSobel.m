function O = cvSobel(I, thresh, direction)
% cvSobel - Sobel Edge Detection
%
% Synopsis
%   O = cvSobel(I, [thresh], [direction])
%
% Description
%   Sobel Edge Detection
%
% Inputs ([]s are optional)
%   (matrix) I        N x M x C matrix representing the input image
%   (scalar) [thresh = []]
%                     The sensitivity threshold. Ignores all edges
%                     that are not stronger than thresh. 
%                     If empty([]) is given, no thresholding. 
%                     Can be a 1 x C vector for a color image. 
%   (string) [direction = 'horizontal']
%                     'horizontal' or 'vertical' or '45' or '135'.
%
% Outputs ([]s are optional)
%    (matrix) O       N x M x C matrix representing the output.
%
% Examples
%   I = cvuImgread('image/lena.png');
%   O = cvSobel(I, 96, '45');
%   figure; imshow(I);
%   figure; imshow(O);
%   O = cvSobel(I, [], '45');
%   figure; imshow(uint8(cvuNormalize(O, [0, 255])));
%
% See also
%   edge (edge.m does thining lines too)
%
% Requirements
%   cvConv2 (requires conv2)

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
%   02/01/2007  First Edition
if ~exist('direction', 'var') || isempty(direction)
    direction = '45';
end
if ~exist('thresh', 'var') || isempty(thresh)
    thresh = [];
end
if ~isa(I, 'double')
    I = double(I);
end

if strcmp(direction, 'horizontal')
    mask = [-1 -2 -1;
            0  0  0 ;
            1  2  1];
elseif strcmp(direction, 'vertical')
    mask = [-1 0 1;
            -2 0 2;
            -1 0 1];
elseif strcmp(direction, '135')
    mask = [0  1 2;
           -1  0 1;
           -2 -1 0];
elseif strcmp(direction, '45')
    mask = [-2 -1 0;
            -1  0 1;
             0  1 2];
end

[N, M, C] = size(I);
O = zeros(N, M, C);
for c = 1:C
    O(:,:,c) = cvConv2(I(:,:,c), mask, 'reflect');
end

if ~isempty(thresh)
    if isscalar(thresh), thresh = repmat(thresh, 1, C); end;
    for c = 1:C
        O(:,:,c) = (abs(O(:,:,c)) > thresh(c));
    end
end
end