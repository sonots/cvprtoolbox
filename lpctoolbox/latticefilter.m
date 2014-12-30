% Apply Lattice Filter
%
% [fM, bM] = latticefilter(k, x)
%
% Input arguments ([]s are optional):
%  k (vector) of size Mx1 which contains M reflection coefficients
%  x (vector) of size Nx1 which contains signals
%
% Output arguments ([]s are optional):
%  [fM] (vector) of size Nx1 which contains the forward linear prediction
%   residual signals. 
%  [bM] (vector) of size Nx1 which contains the backward linear prediction
%   residual signals.
%
% Reference: Adaptive Filter Theory, Haykin
% See also : lpclevinsondurbin.m, ilatticefilter.m
%   Yet another implementation of latcfilt.m (Signal Processing Toolbox)
% Author   : Naotoshi Seo, Wann-Jiun Ma
% Date     : Nov, 2007
function [fM, bM] = latticefilter(k,x)
N = length(x);
M = length(k);
fM = x;
bM = x;
for m=1:M
    pfM = [fM;0]; pbM = [0;bM]; % delay 1
    fM = pfM + conj(k(m))*pbM;
    bM = pbM + k(m)*pfM;
end
fM = fM(1:N);
bM = bM(1:N);
end