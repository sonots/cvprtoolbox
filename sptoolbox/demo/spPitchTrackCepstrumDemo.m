[x, fs] = wavread('../sound/bee.wav');
[F0, T, C] = spPitchTrackCepstrum(x, fs, 30, 20, 'hamming', 'plot');
