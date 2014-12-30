[x, fs] = wavread('../sound/bee.wav');
a = spLpc(x, fs, [], 'plot');