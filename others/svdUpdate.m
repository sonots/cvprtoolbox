function [U, s, V] = svdUpdate( U, s, V, X ); 
%
% Incremental SVD 
%  
% -------------------------------------------------------------------------
%  [U, s, V] = svdUpdate( U, s, V, X );
%
%
%   Input:  DOUBLE U (p by r)  collumn space
%           DOUBLE s (r by 1)  singular values
%           DOUBLE V (q by r)  row space
%           DOUBLE X (p by c)  additional collumns of data where
%                              p is num of dimensions and c is the number
%                              of data
%
%  Output:  DOUBLE U (p by ?)  collumn space
%           DOUBLE s (? by 1)  singular values
%           DOUBLE V (q by ?)  row space 
%             
% -------------------------------------------------------------------------
%
% An implementation of the incremental SVD described in section 3 of
% Matthew Brands 2002 ECCV [1] paper. 
%  
%  [1] Brand, M.E., "Incremental Singular Value Decomposition of
%  Uncertain Data with Missing Values", European Conference on Computer
%  Vision (ECCV), Vol 2350, pps 707-720, May 2002 
%  
% An example:   
%
% % generate a matrix X
% X = rand(50, 10);
% 
% % compute the SVD of X and get the rank-r approximation
% [U S V] = svd( X, 'econ' );
% s = diag(S);
% 
% % update the SVD 100 times
% for ii = 1:100
%     % generate some random collumns to add to X  
%     X = rand(50, 20); 
% 
%     % compute the SVD of [X X]
%     [U, s, V] = svdUpdate( U, s, V, X ); 
% 
%     % update X if want
%     X = [X X];
% 
%     % compute the reprojection error (should be around 1e-10 )
%     norm(X - U*diag(s)*V') 
% end
%
% -------------------------------------------------------------------------
%  
% Author:      Nathan Faggian
% E-mail:      nathanf@mail.csse.monash.edu.au
% URL:         http://www.csse.monash.edu.au/~nathanf
%    
  
if isempty(U)
    [U S V] = svd( X, 'econ' );
    s = diag(S);
    return;
end
  
%
% add a column X or matrix which is p*c
%

c = size(X, 2);
r = size(s, 1);
q = size(V, 1);

%
% compute the projection of X onto the orthogonal subspace U
%

L = U'*X;

%
% compute the component of X orthogonal that is orthogonal to the subspace U
%

H = X - U*L;

%
% compute an orthogonal basis of H and the projection of X onto the
% subspace orthogonal to U
%

[J, K] = qr(H,0);
 
%
% compute the center matrix Q
%
 
Q = [      diag(s),  L;
        zeros(c,r),  K   ];

%
% compute the SVD of Q 
%

[Uu, Su, Vu] = svd(Q, 0);

%
% compute the updated SVD of [M,X]
%

orth = U(:,1)'*U(:,end);

U = [U, J] * Uu;

s = diag(Su);

V = [   V          , zeros(q, c); ...
        zeros(c, r), eye(c)     ] * Vu;

%
% compact the new SVD
%

r = min( size(U,1), size(V,2) );

U = U(:,1:r);
s = s(1:r);
V = V(:,1:r);