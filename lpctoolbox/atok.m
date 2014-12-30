% Convert AR Coefficients into Reflection Coefficients
%
% [k] = atok(a)
%
% Input arguments ([]s are optional):
%  a (vector) of size (M+1)x1 which contains the coefficients of an Mth
%   order forward linear predictor, a = conj([1 -w(1) -w(2) ... -w(M)]). 
%   This can also be viewed as the coefficients of an Mth-order 
%   autoregressive (AR) process 
%
% Output arguments ([]s are optional):
%  k (vector) of size Mx1 which contains (conjugated) M reflection
%  coefficients
%  [A] (traiangular matrix) of size (M+1)x(M+1) which contains 
%   the sets of pregressively generated AR coefficients. 
%   A(1:M+1,M+1) contains a of Mth order, A(1:M,M) contains a of M-1th order, 
%   A(1:M-1,M-1) contains a of M-2th order and so on.
%
% Reference: Adaptive Filter Theory, Haykin
% Author   : Naotoshi Seo, Wann-Jiun Ma
% Date     : Nov, 2007
function [k, A] = atok(a)
 M = length(a)-1;
 a = conj(a); % restore matlab way to textbook way
 k = [zeros(M-1,1); a(M+1)];
 A = [[ones(1,M); zeros(M,M)] a];
 for m=M:-1:1
     k = 1:m+1;
     A(k,m) = (A(k,m+1) - A(m+1,m+1).*conj(flipud(A(k,m+1)))) ...
         ./ (1 - norm(A(m+1,m+1))^2);
 end
 % Verify
 % A(1,:) == 1
 % diag(A,-1) == 0
 k = diag(A);
 k = k(2:M+1);
 k = conj(k); % to matlab way
 A = conj(A); % to matlab way
end
     