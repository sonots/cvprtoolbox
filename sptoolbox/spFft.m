% NAME
%   spFft - Fourier Transform of a signal
% SYNOPSIS
%   [Y, YMag, YPhase, F] = spFft(X, window, show)
% DESCRIPTION
%   Get Frequency Response (and its magnitude and phase) of a signal and
%   plot
% INPUTS
%   X      (vector) of size Nx1 which contains signal
%   [window]
%          (string) the window function such as 'rectwin', 'hamming'. 
%           The default is 'rectwin' (or no window). 
%   [show] (boolean)   plot or not. The default is 0.
% OUTPUTS
%   Y      (vector) of size Nx1 which contains Frequency Response. 
%   [YMag] (vector) of size Nx1 which contains Magnitude Response. 
%   [YPhase] 
%          (vector) of size Nx1 which contains Phase Response. 
%   [F]    (vector) of size Nx1 which contains the x-axis (normalized 
%           frequency). 
% AUTHOR
%   Naotoshi Seo, April 2006
function [Y, YMag, YPhase, F] = spFft(X, window, show)
 %% Initialization
 N = length(X);
 X = X(:); % assure column vector
 if ~exist('show', 'var')
     show = 0;
 end
 if ~exist('window', 'var')
     window = 'rectwin';
 end
 
 %% do fourier transform of a windowed signal
 if ~strcmp(window, 'rectwin')
     X = X .* eval(sprintf('%s(N)', window)); % X .* hamming(N)
 end
 Y = fft(X, N);

 % Magnitude Response in dB (20 * log10)
 YMag = 20 * log10(abs(Y));
 % Phase Response
 YPhase = unwrap(angle(Y));
 % Normalized Frequency
 F = (0:N-1)/N; % * fs;

 %% Plot
 if show
     % plot magnitude
     figure;
     subplot(2,1,1);
     plot(F, YMag); grid on;
     xlabel('Normalized Frequency (\times\pi rad/sample)');
     ylabel('Magnitude (dB)');
     title('Magnitude Response');
     % plot phase
     subplot(2,1,2);
     plot(F, YPhase); grid on;
     xlabel('Normalized Frequency (\times\pi rad/sample)');
     ylabel('Phase (radian)');
     title('Phase Response');
 end
end