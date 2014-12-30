% cvuBytes - (CV Utility) Obtain the number of bytes
%
% Synopsis
%   [b] = cvuBytes(f)
%
% Description
%   Obtain the number of bytes 
%
% Inputs ([]s are optional)
%   (mixed)  f        The filename or a variable (not variable name)
%
% Outputs ([]s are optional)
%   (scalar) b        The number of bytes
%
% Example
%   cvuBytes('filename')
%   cvuBytes(X)
function b = cvuBytes(f)
if ischar(f)
    info=dir(f);
    b=info.bytes;
elseif isstruct(f)
    b=0;
    fields=fieldnames(f);
    for k=1:length(fields)
        b = b + bytes(f.(fields{k}));
    end
else
    info=whos('f');
    b=info.bytes;
end
 