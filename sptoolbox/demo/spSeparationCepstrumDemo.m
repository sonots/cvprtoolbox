function spSeparationCepstrumDemo
 x1 = wgn(1000, 1, 1); fs = 16000;
 c = spSeparationCepstrum(x1, fs, 20, 'hamming', 'plot');

 [x2, fs] = wavread('../sound/bee.wav'); x2 = x2(1001:2000);
 c = spSeparationCepstrum(x2, fs, 20, 'hamming', 'plot');

 x3 = awgn(x2,50);
 c = spSeparationCepstrum(x3, fs, 20, 'hamming', 'plot');
end