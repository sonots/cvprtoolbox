% Apply Inverse Lattice Filter
%
% [x] = ilatticefilter(k, fM)
%
% Input arguments ([]s are optional):
%  k (vector) of size Mx1 which contains M reflection coefficients
%  fM (vector) of size Nx1 which contains the forward linear prediction
%   residual signals. 
%
% Output arguments ([]s are optional):
%  x (vector) of size Nx1 which contains the reconstructed signals
%
% Reference: Adaptive Filter Theory, Haykin
% See also : lpclevinsondurbin.m, latticefilter.m
% Author   : Naotoshi Seo, Wann-Jiun Ma
% Date     : Nov, 2007
function [x] = ilatticefilter(k,fM)
M = length(k);
N = length(fM);
f = [zeros(N, M) fM]; % M=1 is for f0
b = zeros(N+1, M+1); % and N=1 is for b(0)=0
% for n=1:N
%     for m=M:-1:1
%         f(n,m) = f(n,m+1) - conj(k(m))*b(n,m);
%         b(n+1,m+1) = b(n,m) + k(m)*f(n,m);
%     end
%     b(n+1,1) = f(n,1);
% end
for n=2:N
    for m=M:-1:1
        f(n,m) = f(n,m+1) - conj(k(m))*b(n-1,m);
        b(n,m+1) = b(n-1,m) + k(m)*f(n,m);
    end
    b(n,1) = f(n,1);            
end
x = f(:,1);
end