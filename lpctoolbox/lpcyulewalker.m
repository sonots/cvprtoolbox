% Compute Linear Predictor Coefficients by Yule-Walker equation
%
% [a, P] = lpcyulewalker(x, M, Rx, rx)
%
% Input arguments ([]s are optional):
%  x (vector) of size Nx1 which contains training data
%  M (scalar) which is the order of the predictive model (less than N)
%  [Rx] (matrix) of size MxM which is an auto-correlation matrix (Hermitian,
%  Toeplitz)
%  [rx] (vector) of size Mx1 which is the auto-correlation vector
%
% Output arguments ([]s are optional):
%  a (vector) of size (M+1)x1 which contains the coefficients of an Mth
%   order forward linear predictor, a = conj([1 -w(1) -w(2) ... -w(M)]). 
%   This can also be viewed as the coefficients of an Mth-order 
%   autoregressive (AR) process 
%  [P] (scalar) is the the variance (power) of the prediction error.
%
% NOTE: The residual signals can be obtained by
%  fM = filter(a, 1, x); % conj(a) is not required
% The reconstructed signals can be obtained by
%  xrec = filter(1, a, fM);
%
% Reference: Adaptive Filter Theory, Haykin
% See also : lpcautocorr.m, lpclevinsondurbin.m
%   Yet another implementation of lpc.m (Signal Processing toolbox)
% Author   : Naotoshi Seo, Wann-Jiun Ma
% Date     : Nov, 2007
function [a, P] = lpcyulewalker(x, M, Rx, rx)
if ~exist('Rx', 'var') || ~exist('rx', 'var')
    [Rx, rx] = lpcautocorr(x, M);
end
w = Rx\rx;
a = conj([1; -w]);
P = Rx(1,1) - rx'*w; % ' = conj transpose, .' non-conj transpose
% fM = filter(a, 1, x); % sample mean of power of prediction error
% P = mean(fM'*fM);
end