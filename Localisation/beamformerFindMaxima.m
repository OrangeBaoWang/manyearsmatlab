function myBeamformer = beamformerFindMaxima ( myBeamformer , myPreprocessor )

    % 	/***************************************************************************
    %     * Step 1: Rij object                                                       *
    %     ***************************************************************************/
    %     // +-----------------------------------------------------------------------+
    %     // | Step A: Load weighted spectra                                         |
    %     // +-----------------------------------------------------------------------+
    
    for indexMic =1 : myBeamformer.myMicrophones.nMics
    	myBeamformer.myRij=rijLoadFrame(myBeamformer.myRij, indexMic, myPreprocessor.micArray(indexMic).weightedResultReal,...
    	 myPreprocessor.micArray(indexMic).weightedResultImag);
    end

%      // +-----------------------------------------------------------------------+
%     // | Step B: Compute cross-correlations                                    |
%     // +-----------------------------------------------------------------------+

    myBeamformer.myRij=rijProcess(myBeamformer.myRij);


end
