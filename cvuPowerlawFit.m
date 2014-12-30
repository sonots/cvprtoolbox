% cvuPowerlawFit - (CV Utility) Curve fitting by power law form y = p(1)*x^p(2)
%
% Synopsis
%   p = cvuPowerlawFit(xdata, ydata)
%
% Description
%   Curve fitting by power law form y = p(1)*x^p(2)
%
% Inputs ([]s are optional)
%   (vector) xdata    N x 1vector representing x coordinates
%   (vector) ydata    N x 1 vector representing y coordinates
%
% Outputs ([]s are optional)
%   (vector) p        1 x 2 vector representing estimated parameter
%
% Examples
%   xdata = 1:10;
%   ydata = [5.4263 1.8887 1.4712 1.0988 0.9137 0.5956 0.5823 0.4559 0.3585 0.2781];
%   p = cvuPowerlawFit(xdata, ydata);
%   figure;plot(xdata,ydata);hold on;
%   plot(xdata, p(1).*xdata.^p(2),'r-');

% Authors
%   Naotoshi Seo <sonots(at)sonots.com>
%
% License
%   The program is free to use for non-commercial academic purposes,
%   but for course works, you must understand what is going inside to
%   use. The program can be used, modified, or re-distributed for any
%   purposes only if you or one of your group understand not only
%   programming codes but also theory and math behind (if any).
%   Please contact the authors if you are interested in using the
%   program without meeting the above conditions.
%
% Changes
%   11/14/2008  First Edition
function p = cvuPowerlawFit(xdata, ydata)
xdata = xdata(:); ydata = ydata(:);
N = length(ydata);
p0(1) = ydata(1); % Starting guess
p0(2) = (log(ydata(N)) - log(p0(1))) / log(xdata(N));
options = optimset('LargeScale','on');
p = lsqcurvefit(@powerlaw, p0, xdata, ydata, [], [], options); 
end

function ydata = powerlaw(p,xdata)
ydata = p(1).*xdata.^p(2);
end