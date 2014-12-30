% NAME
%   spLpc - The linear predictive coding (one-step finite observation 
%           wiener filter prediction)
% SYNOPSIS
%   [a P e] = spLpc(x, fs, ncoef, show)
% DESCRIPTION
%   Obtain LPC coefficients (AR model)
% INPUTS
%   x        (vector) of size Nx1 which contains signal
%   fs       (scalar) the sampling frequency
%   [ncoef]  (scalar) the number of coefficients. The default uses
%              ncoef = 2 + fs / 1000;
%             as a rule of thumb. 
% OUTPUTS
%   a        (vector) of size ncoefx1 which contains LPC coefficients
%   P        (scalar) variance (power) of the prediction error
%   e        (vector) of size Nx1 which contains residual error signals
% AUTHOR
%   Naotoshi Seo, April 2008
% USES
%   lpc.m (Signal Processing toolbox)
function [a P e] = spLpc(x, fs, ncoef)
 if ~exist('ncoef', 'var') || isempty(ncoef)
     ncoef = 2 + round(fs / 1000); % rule of thumb for human speech
 end
 [a P] = lpc(x, ncoef);
 if nargout > 2,
    est_x = filter([0 -a(2:end)],1,x);    % Estimated signal
    e = x - est_x;                        % Residual signal
 end 
end