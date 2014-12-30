% NAME
%   spSeparationCepstrum - Source-Filter Separation via Cepstrum
% SYNOPSIS
%   [source, filter, c, y] = 
%     spSeparationCepstrum(x, fs, ncoef, window, show)
% DESCRIPTION
%   Source-Filter Separation via the Cepstrum. 
%   This deconvolve speech signal into source (vocal codes, white noise)
%   and filter (oral cavity, coloring, envelope) component
% INPUTS
%   x      (vector) of size Nx1 which contains one frame signal
%   fs     (scalar) the sampling rate
%   [ncoef] 
%          (scalar) the number of coefficients of cepstrum to treat 
%           as low-time parts. The default uses
%             ncoef = 2 + fs / 1000;
%           as a rule of thumb. 
%   [window]
%          (string) the window function such as 'rectwin', 'hamming'. 
%           The default is 'rectwin' (or no window). 
%   [show] (boolean) plot or not. The default is 0. 
% OUTPUTS
%   source (vector) of size Nx1 which containts log magnitude (not dB) 
%           frequency response of high-time cepstrum parts that is 
%           source (vocal tract, white noise) component
%   filter (vector) of size Nx1 which constains log magnitude (not dB) 
%           frequency response of low-time cepstrum parts that is 
%           filter (oral cavity, coloring, envelope) component
%   [c]    (vector) of size Nx1 which contains cepstrum coefficients
%   [y]    (vector) of size Nx1 which contains frequency response of input
% AUTHOR
%   Naotoshi Seo, April 2008
function [source, filter, c, y] = spSeparationCepstrum(x, fs, ncoef, window, show)
 %% initialization
 N = length(x);
 x = x(:);
 if ~exist('show', 'var') || isempty(show)
     show = 0;
 end
 if ~exist('window', 'var') || isempty(window)
     window = 'rectwin';
 end
 if ~exist('ncoef', 'var') || isempty(ncoef)
     ncoef = 2 + round(fs / 1000);
 end
 
 %% get cepstrum
 [c, y] = spCepstrum(x, window);

 %% get high-time spectrum response
 highc = [zeros(ncoef,1); c(ncoef:end)];
 source = fft(highc); % recover high-time parts to log mag freq response
 
 %% get low-time spectrum response
 lowc = [c(1:ncoef); zeros(length(c)-ncoef,1)];
 filter = fft(lowc); % recover low-time parts to log mag freq response
 
 %% plot
 if show
     figure;
     ms1=fs/1000; % 1ms. maximum speech Fx at 1000Hz
     ms20=fs/50;  % 20ms. minimum speech Fx at 50Hz
     
     % plot waveform
     t=(0:N-1)/fs;        % times of sampling instants
     subplot(3,2,1);
     plot(t,x);
     xlabel('Time (s)');
     ylabel('Amplitude');
     title('(a) Waveform');
     
     % plot log spectrum
     f = (0:N/2-1)*fs/N; % rest half is mirror for real signal
     db = 20*log(abs(y(1:length(f))));
     subplot(3,2,2);
     plot(f,db);
     title('(b) Spectrum');
     xlabel('Frequency (Hz)');
     ylabel('Magnitude (dB)');
     ylim([-100 100]);
     
     % plot cepstrum between 1ms (=1000Hz) and 20ms (=50Hz)
     q=(ms1:ms20)/fs;
     subplot(3,2,3);
     plot(q,abs(c(ms1:ms20)));
     title('(c) Cepstrum');
     xlabel('Quefrency (s)');
     ylabel('Amplitude');

     % plot low-time spectrum response
     subplot(3,2,4);
     plot(f,20*real(filter(1:length(f))));
     title('(d) Low-time Spectrum (Filter)');
     xlabel('Frequency (Hz)');
     ylabel('Magnitude (dB)');
     ylim([-100 100]);

     % plot high-time spectrum response
     subplot(3,2,6);
     plot(f,20*real(source(1:length(f))));
     title('(e) High-time Spectrum (Source)');
     xlabel('Frequency (Hz)');
     ylabel('Magnitude (dB)');
     ylim([-100 100]);
 end

end