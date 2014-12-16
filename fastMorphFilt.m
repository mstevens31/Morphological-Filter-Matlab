function filteredData = fastMorphFilt(data, elementSize, w)
% fastMorphFilt
% Author: Michael Stevens
% Created: 20141216 15:04 AEST

% data: (1 x n) original data to be filtered
% elementSize: (integer > 0) length of the structuring element used to smooth the
% data.  Should be relative to Sample rate eg. for a sampling rate of 100
% Hz, an elementSize of 200 is equivalent to 2 seconds of data.
% w: (double between 0 and 1) weighting factor. The morph filter performs
% opening and closing operations on the data, then combines the results
% using a weight. The default is 0.5. w = 0 means that only opening
% operation (minimum) will be used, while 1 means that the closing operation (maximum) will be
% used.

% Code based on description presented in 
% Wang D, He D-C (1994) A fast implementation of 1-D grayscale morphological filters. IEEE Trans. Circuits Syst. II Analog Digit. Signal Process. 41, 9, pp. 634–636.
%%
% check bounds on w
if exist('w','var')~=1
    w=0.5;
elseif w < 0
    w=0;
elseif w>1
    w=1;
end

%%
% check bounds on elementSize
if elementSize < 1
    elementSize=1;
end

%% Morphological filtering
minData = fastOpen(elementSize,data);

maxData = fastClose(elementSize,data);

filteredData = (1-w)*minData + (w)*maxData;

%% plotting code for checking output
% close all

% plot(data)
% hold on
% 
% plot(filteredData, 'm')
% plot(minData, '-g')
% plot(maxData, '-b')
% hold off
end