% NAME
%   spFormantsTrackLpc: Formants Tracking via the LPC Method 
% SYNOPSIS
%   [F, T] = spFormantsTrackLpc(x, fs, ncoef, 
%               frame_length, frame_overlap, window, show)
% DESCRIPTION
%   Formants Tracking via the LPC method
% INPUTS
%   x      (vector) of size Nx1.
%   fs     (scalar) the sampling rate in Hz. 
%   [ncoef](scalar) the number of LPC coefficients used for
%           estimation. ncoef = 2 + fs / 1000 is the default.
%   [frame_length]
%          (scalar) the length of each frame in micro second. 
%           The default is 30ms.  
%   [frame_overlap] 
%          (scalar) the length of each frame overlaps in micro second. 
%           The default is frame_length / 2. 
%   [window]
%          (string) the window function such as rectwin, hamming.  
%           if not specified, equivalent to hamming
%   [show] (boolean) plot or not. The default is 0.
% OUTPUTS
%   F      (vector) formants (fm = F(find(T == 0.01))
%   T      (vector) formant times
% AUTHOR
%   Naotoshi Seo, April 2006
function [F, T] = spFormantsTrackLpc(x, fs, ncoef, frame_length, frame_overlap, window, show)
 %% Initialization
 N = length(x);
 if ~exist('frame_length', 'var') || isempty(frame_length)
     frame_length = 30;
 end
 if ~exist('frame_overlap', 'var') || isempty(frame_overlap)
     frame_overlap = 20;
 end
 if ~exist('window', 'var') || isempty(window)
     window = 'hamming';
 end
 if ~exist('show', 'var') || isempty(show)
     show = 0;
 end
 if ~exist('ncoef', 'var')
     ncoef = [];
 end
 nsample = round(frame_length  * fs / 1000); % convert ms to points
 noverlap = round(frame_overlap * fs / 1000); % convert ms to points
 window   = eval(sprintf('%s(nsample)', window)); % e.g., hamming(nfft)
 
 pos = 1; t = 1;
 F = []; % formants
 T = []; % time (s) at the frame
 mid = round(nsample/2);
 while (pos+nsample <= N)
     frame = x(pos:pos+nsample-1);
     frame = frame - mean(frame);
     a = spLpc(frame, fs, ncoef);
     fm = spFormantsLpc(a, fs);
     for i=1:length(fm)
        F = [F fm(i)]; % number of formants are not same for each frame
        T = [T (pos+mid)/fs];
     end
     pos = pos + (nsample - noverlap);
     t = t + 1;
 end

 if show
     % plot waveform
     t=(0:N-1)/fs;
     subplot(2,1,1);
     plot(t,x);
     legend('Waveform');
     xlabel('Time (s)');
     ylabel('Amplitude');
     xlim([t(1) t(end)]);

     % plot formants trace
     subplot(2,1,2);
     plot(T, F, '.');
     hold off;
     legend('Formants');
     xlabel('Time (s)');
     ylabel('Frequency (Hz)');
     xlim([t(1) t(end)]);
 end
