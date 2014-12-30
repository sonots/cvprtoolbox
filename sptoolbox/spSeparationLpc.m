% NAME
%   spSeparationLpc - Source-Filter Separation via LPC
% SYNOPSIS
%   [source, filter, a P e] = spSeparationLpc(x, fs, ncoef, show)
% DESCRIPTION
%   Source-Filter Separation via LPC. 
%   This deconvolve speech signal into source (vocal codes, white noise)
%   and filter (oral cavity, coloring, envelope) component
% INPUTS
%   x      (vector) of size Nx1 which contains signal
%   fs     (scalar) the sampling frequency
%   [ncoef]
%          (scalar) the number of coefficients of LPC. The default uses
%             ncoef = 2 + fs / 1000;
%           as a rule of thumb. 
%   [show] (boolean) plot or not. The default is 0.
% OUTPUTS
%   a      (vector) of size ncoefx1 which contains LPC coefficients
%   P      (scalar) variance (power) of the prediction error
%   e      (vector) of size Nx1 which contains residual error signals
% AUTHOR
%   Naotoshi Seo, April 2008
% USES
%   lpc.m (Signal Processing toolbox)
function [source, filter, a, P, e] = spSeparationLpc(x, fs, ncoef, show)
 %% Initialization
 if ~exist('show', 'var') || isempty(show)
     show = 0;
 end
 if ~exist('ncoef', 'var')
     ncoef = [];
 end

 %% get Linear prediction
 [a P e] = spLpc(x, fs, ncoef);

 %% get filter (envelope) component
 [filter, f]=freqz(1,a,512,fs);

 %% get source component
 source = fft(e); 
 source = source(1:ceil(length(source)/2)); % rest half is just mirror of real signal
 
 if show
     figure;
     % plot waveform
     subplot(3,2,1);
     t=(0:length(x)-1)/fs;        % times of sampling instants
     plot(t,x);
     title('Waveform');
     xlabel('Time (s)');
     ylabel('Amplitude');
     xlim([t(1) t(end)]);
     
     % plot poles
     subplot(3,2,3);
     zplane(0, a);
     title('Poles of LPC filter');
     
     % plot frequency reponse of original
     subplot(3,2,2);
     y = fft(x); original = y(1:ceil(length(y)/2));
     N = length(original);
     f = (1:N)/N*(fs/2);
     plot(f, 20*log10(abs(original)+eps));
     title('Spectrum');
     xlabel('Frequency (Hz)');
     ylabel('Magnitude (dB)');
     xlim([f(1) f(end)]);

     % plot frequency response of LPC (filter part)
     subplot(3,2,4);
     N = length(filter);
     f = (1:N)/N*(fs/2);
     plot(f,20*log10(abs(filter)+eps));
     title('Spectrum of Filter (LPC) Part');
     xlabel('Frequency (Hz)');
     ylabel('Magnitude (dB)');
     xlim([f(1) f(end)]);

     % plot frequency reponse of residual (source part)
     subplot(3,2,6);
     N = length(source);
     f = (1:N)/N*(fs/2);
     plot(f, 20*log10(abs(source)+eps));
     title('Spectrum of Source (Residual) Part');
     xlabel('Frequency (Hz)');
     ylabel('Magnitude (dB)');
     xlim([f(1) f(end)]);
 end
end
