% Convert Reflection Coefficients into AR Coefficients
%
% [a, A] = atok(k)
%
% Input arguments ([]s are optional):
%  [k] (vector) of size Mx1 which contains (conjugated) M reflection
%  coefficients
%
% Output arguments ([]s are optional):
%  a (vector) of size (M+1)x1 which contains the coefficients of an Mth
%   order forward linear predictor, a = conj([1 -w(1) -w(2) ... -w(M)]). 
%   This can also be viewed as the coefficients of an Mth-order 
%   autoregressive (AR) process 
%  [A] (matrix) of size (M+1)x(M+1) which contains the sets of pregressively
%   generated AR coefficients. A(1:M+1,M+1) contains a of Mth order. 
%   A(1:M,M) contains a of M-1th order, A(1:M-1,M-1) contains a of M-2th
%   order and so on.
%
% Reference: Adaptive Filter Theory, Haykin
% Author   : Naotoshi Seo, Wann-Jiun Ma
% Date     : Nov, 2007
function [a, A] = ktoa(k)
 M = length(k);
 k = conj(k); % restore matlab way to textbook way
 A = zeros(M+1,M+1);
 A(1,1) = 1;
 for m=2:M+1
     A(1:m,m) = [A(1:m-1,m-1); 0] + k(m-1).*[0; conj(flipud(A(1:m-1,m-1)))];
 end
 a = A(1:M+1,M+1);
 a = conj(a); % textbook way to matlab way
 A = conj(A); % textbook way to matlab way
end