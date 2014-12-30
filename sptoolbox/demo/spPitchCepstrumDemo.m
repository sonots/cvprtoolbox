function spPitchCepstrumDemo 
 [x, fs] = wavread('../sound/bee.wav'); x = x(1000:1480);
 % x = wgn(1, 1000, 2); fs = 16000;
 c = spCepstrum(x, fs, 'hamming', 'plot');
 f0 = spPitchCepstrum(c, fs)