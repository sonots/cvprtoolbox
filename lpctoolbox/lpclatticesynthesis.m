% Linear Prediction Synthesis Filter using Reflection Coefficients
%
% [x] = lpcltticesynthesis(k, N, P, f)
%
% Input arguments ([]s are optional):
%  k (matrix) of size MxNF which contains the reflection coefficients of 
%   an Mth order forward linear predictor for each frame
%  N (scalar) which is the frame length (# of samples). 
%  [P] (vector) of size 1xNF which contains the the variances (power) of the 
%   prediction errors for each frame. 
%  [f] (matrix) of size NxNF which contains the residual signals for each 
%   frame. If not given, white gaussian noises are used and P is required
%
% Output arguments ([]s are optional):
%  x (vector) of size (NxNF)x1 which contains the reconstructed signal
%
% Reference: Adaptive Filter Theory, Haykin
% See also : lpclatticeanalysis.m, ilatticefilter.m
% Author   : Naotoshi Seo, Wann-Jiun Ma
% Date     : Nov, 2007
function [x] = lpclatticesynthesis(k, N, P, f)
 [M, NF] = size(k);
 for i=1:NF
     if ~exist('f', 'var')
        v = wgn(N,1,0).*sqrt(P(i));
     else
        v = f(:,i);
     end
     frames(:,i) = ilatticefilter(k(:,i),v);
 end
 x = reshape(frames, N*NF, 1);
end
