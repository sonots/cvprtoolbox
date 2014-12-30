% NAME
%   spFormantsLpc - Formants Estimation via LPC Method
% SYNOPSIS
%   [F] = spFormantsLpc(a, fs)
% DESCRIPTION
%   Estimate formants frequencies
% INPUTS
%   a        (vector) of size ncoefx1 which contains the LPC coefficients
%             of the original signal. Use spLpc.m
%   fs       (scalar) the sampling frequency of the original signal
% OUTPUTS
%   F        (vector) of size ncoefx1 which contains formants
% AUTHOR
%   Naotoshi Seo, April 2008
% See also
%   spLpc.m
function [F] = spFormantsLpc(a, fs)
 r = roots(a);
 r = r(imag(r)>0.01);
 F = sort(atan2(imag(r),real(r))*fs/(2*pi));
end