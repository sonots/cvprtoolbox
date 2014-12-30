function spStftDemo
 [x, fs] = wavread('../sound/bee.wav');
 %x = wgn(1, 1000, 2); fs = 16000;
 frame_overlap = 10; % ms
 frame_length  = 20;
 spStft(x(:), 'hamming', frame_overlap, frame_length, fs, 'plot');
