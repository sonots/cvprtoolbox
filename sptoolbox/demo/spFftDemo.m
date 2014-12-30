function spFftDemo
 % [x, fs] = wavread('../sound/bee.wav');
 x = wgn(1, 1000, 2);
 %t = linspace(-10,10);
 %x = sinc(t);
 y = spFft(x, 'rectwin', 'plot');
