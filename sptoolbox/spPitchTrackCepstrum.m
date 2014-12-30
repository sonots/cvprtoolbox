% NAME
%   spPitchTrackCepstrum: Pitch Tracking via the Cepstral Method 
% SYNOPSIS
%   [F0, T, C] = 
%     spPitchTrackCepstrum(x, fs, frame_length, frame_overlap, window, show)
% DESCRIPTION
%   Track F0 formants in time bins
% INPUTS
%   x               (vector) of size Nx1.
%   fs              (scalar) the sampling rate in Hz. 
%   [frame_length]  (scalar) the length of each frame in micro second. 
%                    The default is 30ms.  
%   [frame_overlap] (scalar) the length of each frame overlaps in micro second. 
%                    The default is frame_length / 2. 
%   [window]        (string) the window function such as rectwin, hamming.  
%                    if not specified, equivalent to hamming
%   [show]          (bool)   plot or not. The default is 0.
% OUTPUTS
%   F0              (vector) of size 1xK which contains the fundamental 
%                    frequencies at each frame where K is the number of frames. 
%   T               (vector) of size 1xK whose value corresponds to the
%                    time center of each frame in second
%   [C]             (matrix) of size MxK which contains cepstrogram
% AUTHOR
%   Naotoshi Seo, April 2006
function [F0, T, C] = spPitchTrackCepstrum(x, fs, frame_length, frame_overlap, window, show)
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
 nsample = round(frame_length  * fs / 1000); % convert ms to points
 noverlap = round(frame_overlap * fs / 1000); % convert ms to points
 if ischar(window)
     window   = eval(sprintf('%s(nsample)', window)); % e.g., hamming(nfft)
 end
 
 %% Pitch detection for each frame
 pos = 1; i = 1;
 while (pos+nsample < N)
     frame = x(pos:pos+nsample-1);
     C(:,i) = spCepstrum(frame, fs, window);
     F0(i) = spPitchCepstrum(C(:,i), fs);
     pos = pos + (nsample - noverlap);
     i = i + 1;
 end
 T = (round(nsample/2):(nsample-noverlap):N-1-round(nsample/2))/fs;
 
if show 
    % plot waveform
    subplot(2,1,1);
    t = (0:N-1)/fs;
    plot(t, x);
    legend('Waveform');
    xlabel('Time (s)');
    ylabel('Amplitude');
    xlim([t(1) t(end)]);

    % plot F0 track
    subplot(2,1,2);
    plot(T,F0);
    legend('pitch track');
    xlabel('Time (s)');
    ylabel('Frequency (Hz)');
    xlim([t(1) t(end)]);
end