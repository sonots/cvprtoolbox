% cvLdaDemo - Demo of cvLda, cvLdaProj, cvLdaInvProj

% A set of 2-dimensional prototype vectors
Xp = [
    0.6213    0.5226    0.9797    0.9568    0.8801    0.8757    0.1730    0.2714    0.2523
    0.7373    0.8939    0.6614    0.0118    0.1991    0.0648    0.2987    0.2844    0.4692
    ];
% Class labels for each prototype vector
Cp = [
    1     1     1     2     2     2     3     3     3
    ];

[W] = cvLda(Xp, Cp);
W
[Y] = cvLdaProj(Xp, W);
Y

figure; hold on;
color = {'r*', 'g*', 'b*'};
for c=1:3
    X = Xp(:,Cp == c);
    plot(X(1,:),X(2,:),color{c});
end
% plot axis
me = mean(Xp, 2);
for m=1:size(W,2)
    W = W ./ abs(W) ./ 2; 
    plot([-W(1,m),W(1,m)]+me(1),[-W(2,m),W(2,m)]+me(2),'b-');
end
