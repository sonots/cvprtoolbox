% Compute sample auto-correation
%
% [Rx, rx] = lpcautocorr(x, M)
%
% Input arguments ([]s are optional):
%  x (vector) of size Nx1 which contains training data
%  M (scalar) which is the order of the predictive model (less than N)
%
% Output arguments ([]s are optional):
%  Rx (matrix) of size MxM which is an auto-correlation matrix (Hermitian, Toeplitz)
%  rx (vector) of size Mx1 which is the auto-correlation vector
%
% NOTE:
%  r(m) = E[x(n+m)*conj(x(n))] = E[x(n)*conj(x(n-m))]
%
% Reference: Adaptive Filter Theory, Haykin
% Author : Naotoshi Seo, Wann-Jiun Ma
% Date   : Nov, 2007
function [Rx, rx] = lpcautocorr(x, M)
N = length(x);
r = xcorr(x,x,'biased'); % r(-N) to r(N)
% 'biased' since it seems buit-in matlab AR fcns use biased estimates
rx = conj(r(N+1:N+M)); % or fliplr(r(1:N-1))
Rx = toeplitz(conj(r(N:N+M-1)), r(N:N+M-1));
end