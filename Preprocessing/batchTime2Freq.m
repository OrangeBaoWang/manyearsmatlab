
function signals = batchTime2Freq(signals)
	batchfreq=zeros(micarray.signals.SAMPLES_PER_BATCH/micarray.signals.shiftSize,signals.SAMPLES_PER_FRAME,micarray.NB_MICROPHONES);
	for Index=1:micarray.signals.SAMPLES_PER_BATCH/micarray.signals.shiftSize
		signals.framedata = signals.batchdata((Index-1)*signals.shiftSize+1:signals.SAMPLES_PER_FRAME+(Index-1)*signals.shiftSize+1);
		signals = frameTime2Freq(signals);
		batchfreq(Index,:,:)=signals.framedata_freq;
	end

end

function signals = frameTime2Freq(signals)
	[sizeArray,len] = size(signals.framedata);
	% get the xtime_windows
	signals.framedata_windowed = signals.framedata.*repmat(hann(signals.SAMPLES_PER_FRAME),sizeArray,1);
	% get fft of xtime_windows
	signals.framedata_freq = fft(signals.framedata_windowed); 
end