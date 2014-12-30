% cvPcaDistDemo - Demo of cvPcaDist.m

% A set of 2-dimensional prototype vectors
Proto = [
    0.7272    0.7286    0.6564    0.5472    0.7184    0.3568    0.5528    0.6564    0.9398
    0.8480    0.9551    0.7423    0.2595    0.9582    0.6164    0.5544    0.5508    0.8328
    ];

[e, m] = cvPca(Proto, 1);

d = cvPcaDist(Proto, e, m);
d
% d =
% 
%     0.0000    0.0034    0.0003    0.0150    0.0047    0.0474    0.0003    0.0058    0.0346
    