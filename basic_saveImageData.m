function basic_saveImageData(obj, ~, fileName)
% saveImageData saves acquired images to TIFF files.
%
% saveImageData is a callback function fired by a videoinput
% FramesAvailable event.

[data, time, metadata] = getdata(obj, obj.FramesAcquiredFcnCount);

writeTIFF( data, numel(metadata), fileName, metadata(1).FrameNumber);

end