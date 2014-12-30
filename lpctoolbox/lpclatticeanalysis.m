% Linear Prediction Analysis Filter using Reflection Coefficients
%
% [k, P, f, a, b] = lpclatticeanalysis(x, N, M)
%
% Input arguments ([]s are optional):
%  x (vector) of size NNx1 which contains the signal data
%  N (scalar) which is the frame length (# of samples). 
%   Let me denote NF = floor(NN/N) which is the number of frames.
%  M (scalar) which is the order of the predictive model (less than N)
%
% Output arguments ([]s are optional):
%  k (matrix) of size MxNF which contains the reflection coefficients of 
%   an Mth order forward linear predictor for each frame
%  P (vector) of size (M+1)xNF which contains the the variances (power) of the 
%   prediction errors for each frame at m-1th order filter (Use P(end,:))
%  [f] (matrix) of size NxNF which contains the forward residual signals 
%   for each frame
%  [a] (matrix) of size (M+1)xNF which contains the AR coefficients of 
%   an Mth order linear predictor, a = conj([1 -w(1) -w(2) ... -w(M)]),
%   for each frame
%  [b] (matrix) of size NxNF which contains the backward residual signals 
%   for each frame
%
% Reference: Adaptive Filter Theory, Haykin
% See also : lpclevinsondurbin.m, lpclatticesynthesis.m, latticefilter.m
% Author   : Naotoshi Seo, Wann-Jiun Ma
% Date     : Nov, 2007
function [k, P, f, a, b] = lpclatticeanalysis(x, N, M)
 NF = floor(length(x) / N);
 x = x(1:N*NF);
 frames = reshape(x, N, NF);
 for i=1:NF
     [a(:,i), P(:,i), k(:,i)] = lpclevinsondurbin(frames(:,i), M);
     [f(:,i), b(:,i)] = latticefilter(k(:,i),frames(:,i));
 end
end
