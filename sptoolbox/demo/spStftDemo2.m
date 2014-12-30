function spStftDemo2
% use spectrogram (digital signal processing toolbox)
 [x, fs] = wavread('../sound/bee.wav');
 frame_overlap = 10; % ms
 frame_length  = 20;
 window        = 'rectwin';

 nfft = round(frame_length  * fs / 1000); % convert ms to points
 noverlap = round(frame_overlap * fs / 1000); % convert ms to points
 window   = eval(sprintf('%s(nfft)', window)); % e.g., hamming(nfft)
 
 [S, F, T, P] = spectrogram(x, window, noverlap, nfft, fs);
 spectrogram(x, window, noverlap, nfft, fs, 'yaxis'); % plot
 