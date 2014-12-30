% cvGaborFilter2Demo - Demo of cvGaborFilter2
function cvGaborFilter2Demo
I = imread('../image/texture.20.png');
figure; imshow(I);
N = size(I, 1);
gamma = 1; %Lambda = [1 2 4 8 16 32 64];
b = .5;  theta = 0; phi = 0;
for i=1:log2(N/8)
    F = [ (.25 - 2^(i+.5)/N) (.25 + 2^(i-.5)/N) ]; Lambda = 1./F;
    for j=1:2
        lambda = Lambda(j);
        [GO, GF] = cvGaborFilter2(I, gamma, lambda, b, theta, phi);
        GO = cvuNormalize(GO, [0, 255]); % normalize to plot
        figure; imshow(uint8(GO));
    end
end
end
