% cvMatchTemplate - Template Matching
%
% Synopsis
%   R = cvMatchTemplate(I, T)
%
% Description
%   Template Matching
%
% Inputs ([]s are optional)
%   (matrix) I        N x M x C matrix representing an entire image
%   (matrix) T        D x P x C matrix representing a template where
%                     (D x P) < (N x M)
%   (string) [method = 'sqdiff']
%                     Method to be used for template matching.
%                     Currently support only sqdiff for simplicity.
%   - sqdiff          Squared difference
%                     R(x,y) = sum(x',y')[T(x',y')-I(x+x',y+y')]^2
%
% Outputs ([]s are optional)
%   (matrix) R        (N-D+1) x (M-P+1) x C matrix representing containing
%                     resulted coefficients of template matching.
%
% Examples
%   I = uint8(ceil(rand(128, 128) * 255));
%   T = I(50:74, 50:74);
%   R = cvMatchTemplate(I, T);
%   threshold = 0;
%   [x, y] = find(R <= threshold)
%   % 50 50

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
%   08/09/2008  First Edition
function R = cvMatchTemplate(I, T, method)
[D, P, C] = size(T);
[N, M, C] = size(I);
R = zeros(N-D+1, M-P+1, C);
for y = 1:N-D+1
    for x = 1:M-P+1
        R(y,x,:) = sum(sum((I(y:y+D-1, x:x+P-1,:) - T) .^ 2));
    end
end
