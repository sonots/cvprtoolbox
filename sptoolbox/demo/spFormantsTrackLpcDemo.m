[x, fs] = wavread('../sound/bee.wav');
[F, T] = spFormantsTrackLpc(x, fs, [], 30, 20, 'hamming', 'plot');
