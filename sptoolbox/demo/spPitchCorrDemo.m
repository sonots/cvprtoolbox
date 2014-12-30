[x, fs] = wavread('../sound/bee.wav'); x = x(1000:1480);
r = spCorr(x, fs, [], 'plot');
f0 = spPitchCorr(r, fs)