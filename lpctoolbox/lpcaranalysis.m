% Linear Prediction Analysis Filter usiing AR coefficints
%
% [a, P, f] = lpcaranalysis(x, N, M)
%
% Input arguments ([]s are optional):
%  x (vector) of size NNx1 which contains the signal data
%  N (scalar) which is the frame length (# of samples). 
%   Let me denote NF = floor(NN/N) which is the number of frames.
%  M (scalar) which is the order of the predictive model (less than N)
%
% Output arguments ([]s are optional):
%  a (matrix) of size (M+1)xNF which contains the AR coefficients of 
%   an Mth order linear predictor, a = conj([1 -w(1) -w(2) ... -w(M)]),
%   for each frame
%  P (vector) of size 1xNF which contains the the variances (power) of the 
%   prediction errors for each frame. 
%  [f] (matrix) of size NxNF which contains the residual signals for each frame
%
% Reference: Adaptive Filter Theory, Haykin
% See also : lpcyulewalker.m, lpcarsynthesis.m
% Author   : Naotoshi Seo, Wann-Jiun Ma
% Date     : Nov, 2007
function [a, P, f] = lpcaranalysis(x, N, M)
 NF = floor(length(x) / N);
 x = x(1:N*NF);
 frames = reshape(x, N, NF);
 for i=1:NF
     [a(:,i), PP] = lpclevinsondurbin(frames(:,i),M);
     P(i) = PP(end,:);
%      [a(:,i), P(i)] = lpcyulewalker(frames(:,i), M);
     f(:,i) = filter(a(:,i),1,frames(:,i));
 end
end
