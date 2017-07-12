function myPreprocessor=preprocessorInit(myParameters,myMicrophones)
	myPreprocessor.PP_FRAMESIZE=myParameters.GLOBAL_FRAMESIZE;
    myPreprocessor.myMicrophones=myMicrophones;
	myPreprocessor.windows=generatePowerComplementaryWindow(myPreprocessor.PP_FRAMESIZE);
%     myPreprocessor.micArray=[];

%     myPreprocessor.workingArray1Real = zeros(myPreprocessor.PP_FRAMESIZE,1);%(float*) newTable1D(myPreprocessor.PP_FRAMESIZE, sizeof(float));
%     myPreprocessor.workingArray1Imag = zeros(myPreprocessor.PP_FRAMESIZE,1);%(float*) newTable1D(myPreprocessor.PP_FRAMESIZE, sizeof(float));
%     myPreprocessor.workingArray2Real = zeros(myPreprocessor.PP_FRAMESIZE,1);%(float*) newTable1D(myPreprocessor.PP_FRAMESIZE, sizeof(float));
%     myPreprocessor.workingArray2Imag = zeros(myPreprocessor.PP_FRAMESIZE,1);%(float*) newTable1D(myPreprocessor.PP_FRAMESIZE, sizeof(float));
    for indexMic=1:myPreprocessor.myMicrophones.nMics
        myPreprocessor.micArray(indexMic)=micstInit( myParameters,...
                  myPreprocessor.myMicrophones.micsPosition(indexMic,:),...
                  myPreprocessor.myMicrophones.micsGain(indexMic));
    end

end
function windows=generatePowerComplementaryWindow(len)
	windows=zeros(len,1);
    for k=0:len-1
        tmp = 4.0* k/ len;
        invert = 0;
        if (tmp < 1.0)
        elseif (tmp < 2.0)
          tmp = 2.0 - tmp;
          invert = 1;
        elseif (tmp < 3.0)
          tmp = tmp - 2.0;
          invert = 1;
        else
          tmp = 4.0 - tmp;
      	end

        tmp = tmp*1.9979;

        windows(k+1) = (0.5 - 0.5 * cos(tmp)) * (0.5 - 0.5 * cos(tmp));

        if (invert == 1)
          windows(k+1) = 1.0 - windows(k+1);
        end
        windows(k+1) = sqrt(windows(k+1));
    end
end
% function microphonesClone(myMicrophonesSource , myMicrophonesDest)
%     myMicrophonesDest.nMics = myMicrophonesSource.nMics;
%     myMicrophonesDest.nPairs = myMicrophonesSource.nPairs;
%     myMicrophonesDest.micsPosition = myMicrophonesSource.micsPosition;
%     myMicrophonesDest.micsGain = myMicrophonesSource.micsGain;
%     myMicrophonesDest.mappingMatrix = myMicrophonesSource.mappingMatrix;
%     myMicrophonesDest.inverseMappingMatrix = myMicrophonesSource.inverseMappingMatrix;
% end