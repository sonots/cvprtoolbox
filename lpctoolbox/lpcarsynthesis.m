% Linear Prediction Synthesis Filter using the AR coefficients
%
% [x] = lpcarsynthesis(a, N, P, f)
%
% Input arguments ([]s are optional):
%  a (matrix) of size (M+1)xNF which contains the AR coefficients of 
%   an Mth order linear predictor, a = conj([1 -w(1) -w(2) ... -w(M)]),
%   for each frame
%  N (scalar) which is the frame length (# of samples). 
%  [P] (vector) of size 1xNF which contains the the variances (power) of the 
%   prediction errors for each frame. 
%  [f] (matrix) of size NxNF which contains the residual signals for each 
%   frame. If not given, white gaussian noises are used and P is required.
%
% Output arguments ([]s are optional):
%  x (vector) of size (NxNF)x1 which contains the reconstructed signal
%
% Reference: Adaptive Filter Theory, Haykin
% See also : lpcanalysis.m
% Author   : Naotoshi Seo, Wann-Jiun Ma
% Date     : Nov, 2007
function x = lpcarsynthesis(a, N, P, f)
 M = size(a, 1)-1;
 NF = size(a, 2);
 for i=1:NF
     if ~exist('f', 'var')
        v = wgn(N,1,0).*P(i);%sqrt(P(i));
     else
        v = f(:,i);
     end
     frames(:,i) = filter(1,a(:,i),v);
 end
 x = reshape(frames, N*NF, 1);
end
