function result= dlmread_empty(filename,delimiter,r,c,emptyval)
%DLMREAD Read ASCII delimited file.
%   RESULT = DLMREAD(FILENAME) reads numeric data from the ASCII
%   delimited file FILENAME.  The delimiter is inferred from the formatting
%   of the file.
%
%   RESULT = DLMREAD(FILENAME,DELIMITER) reads numeric data from the ASCII
%   delimited file FILENAME using the delimiter DELIMITER.  The result is
%   returned in RESULT.  Use '\t' to specify a tab.
%
%   When a delimiter is inferred from the formatting of the file,
%   consecutive whitespaces are treated as a single delimiter.  By
%   contrast, if a delimiter is specified by the DELIMITER input, any
%   repeated delimiter character is treated as a separate delimiter.
%
%   RESULT = DLMREAD(FILENAME,DELIMITER,R,C) reads data from the
%   DELIMITER-delimited file FILENAME.  R and C specify the row R and column
%   C where the upper-left corner of the data lies in the file.  R and C are
%   zero-based so that R=0 and C=0 specifies the first value in the file.
%
%   All data in the input file must be numeric. DLMREAD does not operate 
%   on files containing nonnumeric data, even if the specified rows and
%   columns for the read contain numeric data only.
%
%   RESULT = DLMREAD(FILENAME,DELIMITER,RANGE) reads the range specified
%   by RANGE = [R1 C1 R2 C2] where (R1,C1) is the upper-left corner of
%   the data to be read and (R2,C2) is the lower-right corner.  RANGE
%   can also be specified using spreadsheet notation as in RANGE = 'A1..B7'.
%
%   RESULT = DLMREAD(FILENAME,DELIMITER,R,C,EMPTYVAL) reads the data
%   specified in FILENAME starting at row R and column C (both
%   zero-indexed), but fills empty cells with a value specified by
%   EMPTYVAL.  EMPTYVAL must be a numeric value or NaN.
%
%   Data files where
%   the lines end with a non-whitespace delimiter will produce a result with
%   an extra last column filled with zeros.
%
%   See also DLMWRITE, CSVREAD, TEXTSCAN, LOAD.
%
% Obsolete syntax removed from MATLAB toolbox\matlab\iofun\dlmread.m:
%   RESULT= DLMREAD(FILENAME,DELIMITER,R,C,RANGE) 
%   Original dlmread.m function:
%   Copyright 1984-2009 The MathWorks, Inc.
%   $Revision: 5.40.4.24 $  $Date: 2012/03/05 23:01:13 $
% 
%   Modified by Kristofer D. Kusano
%   $Revision: 1.0.0.0 $    $Date: 2013/08/29 11:53:00 $
% Validate input args
fid = -1;
if nargin==0
    error(message('MATLAB:dlmread:Nargin')); 
end
% Get Filename
if ~ischar(filename)
    error(message('MATLAB:dlmread:InvalidInputType')); 
end
% Get Delimiter
if nargin==1 % Guess default delimiter
    [fid, theMessage] = fopen(filename);
	if fid < 0
		error(message('MATLAB:dlmread:FileNotOpened', filename, theMessage));
	end
	str = fread(fid, 4096,'*char')';
    frewind(fid);
    delimiter = guessdelim(str);
    if isspace(delimiter);
        delimiter = '';
    end 
else
    delimiter = sprintf(delimiter); % Interpret \t (if necessary)
end
if length(delimiter) > 1,
    error(message('MATLAB:dlmread:InvalidDelimiter'));
end
% Get row and column offsets
empty_char = 0; % default output for empty value
if nargin<=2, % dlmread(file) or dlmread(file,dim)
    r = 0;
    c = 0;
    nrows = -1; % Read all rows
    range = [];
elseif nargin==3, % dlmread(file,delimiter,range)
    if length(r)==1, % Catch obsolete syntax dlmread(file,delimiter,r)
        warning(message('MATLAB:dlmread:ObsoleteSyntax'));
        result= dlmread(filename,delimiter,r,0);
        return
    end
    range = r;
    if ischar(range)
        range = local_str2rng(range);
    end
    r = range(1);
    c = range(2);
    nrows = range(3) - range(1) + 1;
elseif nargin==4, % dlmread(file,delimiter,r,c) or dlmread(file,delimiter,r,c,emptyval)
    nrows = -1; % Read all rows
    range = [];
elseif nargin==5,
    nrows = -1;
    range = [];
    if (isnumeric(emptyval))
        empty_char = emptyval;
    else
        error('dlmread_empty:InvalidEmptyval',...
            'EMPTYVAL must be a numeric value')
    end
end
% attempt to open data file
if fid == -1
    [fid, theMessage] = fopen(filename);
    if fid < 0
        error(message('MATLAB:dlmread:FileNotOpened', filename, theMessage));
    end
end
% Read the file using textscan
try
	if isempty(delimiter)
		result  = textscan(fid,'',nrows,'headerlines',r,'headercolumns',c,...
						   'returnonerror',0,'emptyvalue',empty_char, 'CollectOutput', true);
	else
		delimiter = sprintf(delimiter);
		whitespace  = setdiff(sprintf(' \b\t'),delimiter);
		result  = textscan(fid,'',nrows,...
					   'delimiter',delimiter,'whitespace',whitespace, ...
					   'headerlines',r,'headercolumns',c,...
					   'returnonerror',0,'emptyvalue',empty_char,'CollectOutput', true);
	end
catch exception
	fclose(fid);
	throw(exception);
end
% close data file
fclose(fid);
result = result{1};
% textscan only trims leading columns, trailing columns may need clipping
if ~isempty(range)
    ncols = range(4) - range(2) + 1;
    % adjust ncols if necessary
    if ncols ~= size(result,2)
        result= result(:,1:ncols);
    end
end
% num rows should be correct, textscan clips
if nrows > 0 && nrows ~= size(result,1)
    error(message('MATLAB:dlmread:InternalSizeMismatch'))
end
function m=local_str2rng(str)
    m = [];
    
    % convert to upper case
    str = upper(str);
    
    % parse the upper-left and bottom-right cell locations
    k = strfind(str,'..');
    if length(k)~=1, return; end % Couldn't find '..'
    
    ulc = str(1:k-1);
    brc = str(k+2:end);
    
    % get upper-left col
    k = find(~isletter(ulc), 1 );
    if isempty(k) || k<2, return; end
    topl(2) = sum(cumprod([1 26*ones(1,k-2)]).*(ulc(k-1:-1:1)-'A'+1))-1;
    topl(1) = str2double(ulc(k:end))-1;
    
    % get bottom-right col
    k = find(~isletter(brc), 1 );
    if isempty(k) || k<2, return; end
    botr(2) = sum(cumprod([1 26*ones(1,k-2)]).*(brc(k-1:-1:1)-'A'+1))-1;
    botr(1) = str2double(brc(k:end))-1;
    
    m=[topl botr];