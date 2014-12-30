function spCepstrumDemo 
 [x, fs] = wavread('../sound/../sound/bee.wav'); x = x(1000:1480);
 % x = wgn(1, 1000, 2); fs = 16000;
 c = spCepstrum(x, fs, 'hamming', 'plot');
end