% cvPcaDemo - Demo of cvPca.m, cvPcaProj.m, and cvPcaInvProj.m

% A set of 2-dimensional prototype vectors
Proto = [
    0.7272    0.7286    0.6564    0.5472    0.7184    0.3568    0.5528    0.6564    0.9398
    0.8480    0.9551    0.7423    0.2595    0.9582    0.6164    0.5544    0.5508    0.8328
    ];
% Class labels for each prototype vector
ProtoClass = [
    2     2     2     1     2     1     1     1     2
    ];

[e, m] = cvPca(Proto);
e
m

figure; hold on;
color = {'r*', 'g*'};
for c=1:2
    X = Proto(:,ProtoClass == c);
    plot(X(1,:), X(2,:), color{c});
end
% plot axis (pricipal component, eigenvector)
for i=1:size(e,2)
    plot([-e(1,i),e(1,i)]+m(1),[-e(2,i),e(2,i)]+m(2),'b-');
end

e = e(:,1) % reduce dimension from 2 to 1
[Y, Ratio] = cvPcaProj(Proto, e, m);
Y
% plot Y on the original space
Proto_h = cvPcaInvProj(Y, e, m);
color = {'ro', 'go'};
for c=1:2
    X = Proto_h(:,ProtoClass == c);
    plot(X(1,:), X(2,:), color{c});
end
