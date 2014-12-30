% inverse of find.m
function A = invfind(B, num)
if ~exist('num','var') || isempty(num)
    num = max(B);
end
if size(B,1) == 1
    A = zeros(1,num);
else
    A = zeros(num,1);
end
A(B) = 1;
