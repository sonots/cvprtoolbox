% NAME
%   spPitchTrackCorr: Pitch Tracking via the Auto-correlation Method 
% SYNOPSIS
%   [F0, T, R] = 
%     spPitchTrackCorr(x, fs, frame_length, frame_overlap, maxlag, show)
% DESCRIPTION
%   Track F0 formants in time bins
% INPUTS
%   x               (vector) of size Nx1.
%   fs              (scalar) the sampling rate in Hz. 
%   [frame_length]  (scalar) the length of each frame in micro second. 
%                    The default is 30ms.  
%   [frame_overlap] (scalar) the length of each frame overlaps in micro second. 
%                    The default is frame_length / 2. 
%   [maxlag]        (scalar) seek the correlation sequence over the lag range 
%                    [-maxlag:maxlag]. The default is 20ms lag, that is, 
%                    50Hz (the minimum possible F0 frequency of human
%                    speech). 20ms lag must be enough. 
%   [show]          (bool)   plot or not. The default is 0.
% OUTPUTS
%   F0              (vector) of size 1xK which contains the fundamental 
%                    frequencies at each frame where K is the number of frames. 
%   T               (vector) of size 1xK whose value corresponds to the
%                    time center of each frame in second
%   [R]             (matrix) of size MxK which contains correlogram
% USES
%   spPitchCorr.m, spCorr.m
% AUTHOR
%   Naotoshi Seo, April 2006
function [F0, T, R] = spPitchTrackCorr(x, fs, frame_length, frame_overlap, maxlag, show)
 %% Initialization
 N = length(x);
 if ~exist('frame_length', 'var') || isempty(frame_length)
     frame_length = 30;
 end
 if ~exist('frame_overlap', 'var') || isempty(frame_overlap)
     frame_overlap = 20;
 end
 if ~exist('maxlag', 'var')
     maxlag = [];
 end
 if ~exist('show', 'var') || isempty(show)
     show = 0;
 end 
 nsample = round(frame_length  * fs / 1000); % convert ms to points
 noverlap = round(frame_overlap * fs / 1000); % convert ms to points
 
 %% Pitch detection for each frame
 pos = 1; i = 1;
 while (pos+nsample < N)
     frame = x(pos:pos+nsample-1);
     frame = frame - mean(frame); % mean subtraction
     R(:,i) = spCorr(frame, fs);
     F0(i) = spPitchCorr(R(:,i), fs);
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