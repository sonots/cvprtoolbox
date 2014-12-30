% NAME
%   spPitchCepstrum - Pitch Estimation via Cepstral Method
% SYNOPSIS
%   [f0] = spPitchCepstrum(c, fs)
% DESCRIPTION
%   Estimate pitch frequencies via Cepstral method
% INPUTS
%   c        (vector) of size Nx1 which contains cepstrum coefficients. 
%             Use spCepstrum.m
%   fs       (scalar) the sampling frequency of the original signal
% OUTPUTS
%   f0       (scalar) the estimated pitch
% AUTHOR
%   Naotoshi Seo, April 2008
% See also
%   spCepstrum.m
function [f0] = spPitchCepstrum(c, fs)
 % search for maximum  between 2ms (=500Hz) and 20ms (=50Hz)
 ms2=floor(fs*0.002); % 2ms
 ms20=floor(fs*0.02); % 20ms
 [maxi,idx]=max(abs(c(ms2:ms20)));
 f0 = fs/(ms2+idx-1);
end