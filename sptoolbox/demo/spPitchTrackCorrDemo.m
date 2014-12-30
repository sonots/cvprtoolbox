function spPitchTrackCorrDemo
[x, fs] = wavread('../sound/bee.wav');
[F0, T, R] = spPitchTrackCorr(x, fs, 30, 20, [], 'plot');
end
