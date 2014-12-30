% Compute Linear Predictor Reflection Coefficients and  Linear Predictor
% Coefficients by the Levinson-Durbin recursion algorithm
%
% [a, P, k] = lpclevinsondurbin(x, M)
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
%  P (vector) of size Mx1 which contains the variance (power) of the 
%   prediction errors where P(m) denotes the power for the mth order model.
%  [k] (vector) of size Mx1 which contains (conjugated) M reflection coefficients
%
% Reference: Adaptive Filter Theory, Haykin
% See also : lpcautocorr.m
%   Yet another implementation of levinson.m (Signal Processing toolbox)
% Author   : Naotoshi Seo, Wann-Jiun Ma
% Date     : Nov, 2007
function [a, P, k] = lpclevinsondurbin(x, M, Rx, rx)
if ~exist('Rx', 'var') || ~exist('rx', 'var')
    [Rx, rx] = lpcautocorr(x, M);
end
P(1) = Rx(1,1); % r(0)
a = [1];
for m=1:M
    Delta = flipud(rx(1:m)).'*a;
    k(m) = - Delta / P(m);
    a = [a; 0] + k(m) * [0; conj(flipud(a))];
    P(m+1) = P(m) * (1 - k(m)*conj(k(m)));
end
a = conj(a); % to follow matlab way
P = P(2:M+1)';
k = conj(k(:)); % to follow matlab way
end