% NAME
%   spPitchCorr - Pitch Estimation via Auto-correlation Method
% SYNOPSIS
%   [f0] = spPitchCorr(r, fs)
% DESCRIPTION
%   Estimate pitch frequencies via Cepstral method
% INPUTS
%   r        (vector) of size (maxlag*2+1)x1 which contains Corr coefficients. 
%             Use spCorr.m
%   fs       (scalar) the sampling frequency of the original signal
% OUTPUTS
%   f0       (scalar) the estimated pitch
% AUTHOR
%   Naotoshi Seo, April 2008
% See also
%   spCorr.m
function [f0] = spPitchCorr(r, fs)
 % search for maximum  between 2ms (=500Hz) and 20ms (=50Hz)
 ms2=floor(fs/500); % 2ms
 ms20=floor(fs/50); % 20ms
 % half is just mirror for real signal
 r = r(floor(length(r)/2):end);
 [maxi,idx]=max(r(ms2:ms20));
 f0 = fs/(ms2+idx-1);
end