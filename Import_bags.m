close all
clear all
clc

%% Initialize variables.
filename = '/home/pela/bags/log_opti.txt';
startRow = 2;
endRow = 281;

%% Format string for each line of text:
%   column1: text (%s)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: double (%f)
%	column8: double (%f)
%   column9: double (%f)
%	column10: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%20s%5f%6f%6f%6f%6f%6f%6f%6f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow-startRow+1);

%% Remove white space around all cell columns.
dataArray{1} = strtrim(dataArray{1});

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
Time = dataArray{:, 1};
Acc_x = dataArray{:, 2};
Acc_y = dataArray{:, 3};
Acc_z = dataArray{:, 4};
Gyr_x = dataArray{:, 5};
Gyr_y = dataArray{:, 6};
Gyr_z = dataArray{:, 7};
Mag_x = dataArray{:, 8};
Mag_y = dataArray{:, 9};
Mag_z = dataArray{:, 10};

t = (Time - Time(1))*10e-8;

%% Clear temporary variables
clearvars filename startRow endRow formatSpec fileID dataArray ans;
