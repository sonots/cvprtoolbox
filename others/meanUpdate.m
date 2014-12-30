function [ mu N ] = meanUpdate( mu0, N0, X ); 
%
% Incremental mean 
%  
% -------------------------------------------------------------------------
%  [ mu N] = meanUpdate( mu, X );
%
%
%   Input:  DOUBLE mu0 (p by 1)  mean vector
%           DOUBLE N0  (1 by 1)  number in previous data totally
%           DOUBLE X   (p by c)  additional collumns of data where
%                                p is num of dimensions and c is the number
%                                of data
%
%  Output:  DOUBLE mu (p by 1)   new mean vector
%           DOUBLE N  (1 by 1)   number of data totally
%             
% -------------------------------------------------------------------------
%  
% An example:   
%
% X = rand(5, 20);
% nBlock = 5;
% 
% mu = []; N = 0;
% for i = 1:nBlock:size(X,2)
%     Xi = X(:,i:min(size(X,2),i+nBlock-1));
%     [mu N] = meanUpdate(mu, N, Xi);
% end
% mu
% mu = mean(X,2)
%
% -------------------------------------------------------------------------
%  
% @author Naotoshi Seo
% @see svdUpdate.m

if isempty(mu0)
    mu = mean(X,2);
    N  = size(X,2);
else
    N1 = size(X,2);
    mu1 = mean(X,2);
    N = N0 + N1;
    mu = (N0/N)*mu0 + (N1/N)*mu1;
end