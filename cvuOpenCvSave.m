% cvuOpenCvSave - (CV Utility) Save data in OpenCV CvFileStorage XML format
%
% Synopsis
%   cvuOpenCvSave(filename, var, varname)
%
% Description
%
% Inputs ([]s are optional)
%   (string) filename The xml filename to be written
%   (matrix) var      The matrix variable to be written
%   (string) [varname = filename]
%                     The variable name. If not given, 
%                     filename is used. 
%
% Outputs ([]s are optional)
%   None
%
% See also
%   cvuOpenCvLoad, OpenCV's cvSave

% Authors
%   Naotoshi Seo <sonots(at)sonots.com>
%
% License
%   The program is free to use for non-commercial academic purposes,
%   but for course works, you must understand what is going inside to use.
%   The program can be used, modified, or re-distributed for any purposes
%   if you or one of your group understand codes (the one must come to
%   court if court cases occur.) Please contact the authors if you are
%   interested in using the program without meeting the above conditions.
%
% Changes
%   12/01/2008  First Edition
function cvuOpenCvSave(filename, var, varname)
[dirname, basename, ext] = fileparts(filename);
if ~strcmp(ext, '.xml')
    error('Currently only xml is supported.');
end
if ~exist('varname', 'var') || isempty(varname)
    varname = basename;
end
%% Built-in xmlwrite
dom = com.mathworks.xml.XMLUtils.createDocument('opencv_storage');
domRootNode = dom.getDocumentElement;
domVarNode  = dom.createElement(varname);
domVarNode.setAttribute('type_id', 'opencv-matrix');
thisElement = dom.createElement('rows');
thisElement.appendChild(dom.createTextNode(sprintf('%d',size(var,1))));
domVarNode.appendChild(thisElement);
thisElement = dom.createElement('cols');
thisElement.appendChild(dom.createTextNode(sprintf('%d',size(var,2))));
domVarNode.appendChild(thisElement);
thisElement = dom.createElement('dt');
thisElement.appendChild(dom.createTextNode('d'));
domVarNode.appendChild(thisElement);
thisElement = dom.createElement('data');
%data = num2str(reshape(var.', 1, []));
% Above is bad because OpenCv cvLoad returns error if one line is too long
%data = num2str(reshape(var.', [], 1)); 
% is preferred, but matlab DOM did not work for this ...
data = mat2str(reshape(var.', [], 1));
data = data(2:end-1); % remove []
data = strrep(data, ';', '\n');
thisElement.appendChild(dom.createTextNode(data));
domVarNode.appendChild(thisElement);
domRootNode.appendChild(domVarNode);
tmpname = tempname();
xmlwrite(tmpname, dom);
% <?xml version="1.0" encoding="utf-8"?> -> <?xml version="1.0"?>
% @todo: find smarter way
tmp = fopen(tmpname, 'r');
fid = fopen(filename, 'w');
tline = fgetl(tmp);
fprintf(fid, '<?xml version="1.0"?>\n');
while 1
    tline = fgetl(tmp);
    if ~ischar(tline), break, end
    fprintf(fid, [tline,'\n']);
end
fclose(fid);
fclose(tmp);

% <?xml version="1.0" encoding="utf-8"?>
% <opencv_storage>
%    <A type_id="opencv-matrix">
%       <rows>3</rows>
%       <cols>4</cols>
%       <dt>f</dt>
%       <data>1 0 0 0 0 1 0 0 0 0 1 0</data>
%    </A>
% </opencv_storage>

%% xml_toolbox
% opencv_storage = [];
% eval(sprintf('opencv_storage.%s.ATTRIBUTE.type_id = ''opencv-matrix'';', varname));
% eval(sprintf('opencv_storage.%s.rows = size(var,1);', varname));
% eval(sprintf('opencv_storage.%s.cols = size(var,2);', varname));
% eval(sprintf('opencv_storage.%s.dt = ''d'';', varname));
% eval(sprintf('opencv_storage.%s.data = var.'';', varname));
% xml = xml_formatany(opencv_storage, 'opencv_storage');
% fid = fopen(filename, 'w');
% fprintf(fid, '<?xml version="1.0"?>\n');
% fprintf(fid, xml);
% fclose(fid);

% <?xml version="1.0"?>
% <opencv_storage xml_tb_version="3.1">
%   <A type_id="opencv-matrix">
%     <rows>3</rows>
%     <cols>4</cols>
%     <dt>f</dt>
%     <data>1 0 0 0 0 1 0 0 0 0 1 0</data>
%   </A>
% </opencv_storage>

%% xml_io_tools
% opencv_storage = [];
% eval(sprintf('opencv_storage.%s.ATTRIBUTE.type_id = ''opencv-matrix'';', varname));
% eval(sprintf('opencv_storage.%s.rows = size(var,1);', varname));
% eval(sprintf('opencv_storage.%s.cols = size(var,2);', varname));
% eval(sprintf('opencv_storage.%s.dt = ''d'';', varname));
% eval(sprintf('opencv_storage.%s.data = reshape(var.'', 1, []);',varname));
% xml_write(filename, opencv_storage);

% <?xml version="1.0" encoding="utf-8"?>
% <opencv_storage xml_tb_version="3.1">
%   <A type_id="opencv-matrix">
%     <rows>3</rows>
%     <cols>4</cols>
%     <dt>f</dt>
%     <data>[1 0 0 0 0 1 0 0 0 0 1 0]</data>
%   </A>
% </opencv_storage>

%% Goal
% #include "cxcore.h"
% 
% int main( int argc, char** argv )
% {
%     CvMat* mat = cvCreateMat( 3, 4, CV_32F );
%     CvFileStorage* fs = cvOpenFileStorage( "example.xml", 0, CV_STORAGE_WRITE );
% 
%     cvSetIdentity( mat );
%     cvWrite( fs, "A", mat, cvAttrList(0,0) );
% 
%     cvReleaseFileStorage( &fs );
%     cvReleaseMat( &mat );
%     return 0;
% }

% <?xml version="1.0"?>
% <opencv_storage>
% <A type_id="opencv-matrix">
%   <rows>3</rows>
%   <cols>4</cols>
%   <dt>f</dt>
%   <data>
%     1. 0. 0. 0. 0. 1. 0. 0. 0. 0. 1. 0.</data></A>
% </opencv_storage>
end