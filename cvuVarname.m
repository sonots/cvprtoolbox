% cvuVarname - (CV Utility) Get a name of a variable
%
% Synopsis
%   [varname] = cvuVarname(var)
%
% Description
%   Get a name of a variable 
%
% Inputs ([]s are optional)
%   (variable) var    Any kinds of a variable
%
% Outputs ([]s are optional)
%   (string) varname  The variable name
%
% Example
%   >> a = 1;
%   >> cvuVarname(a)
%   ans
%       'a'
function varname = cvuVarname(var)
varname = inputname(1);
end
