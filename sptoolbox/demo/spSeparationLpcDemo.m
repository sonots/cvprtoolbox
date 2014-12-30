function spSeparationLpcDemo
 x1 = wgn(1000, 1, 1); fs = 16000;
 c = spSeparationLpc(x1, fs, 20, 'plot');

 [x2, fs] = wavread('../sound/bee.wav'); x2 = x2(1001:2000);
 c = spSeparationLpc(x2, fs, 30, 'plot');

 x3 = awgn(x2,50);
 c = spSeparationLpc(x3, fs, 30, 'plot');
end