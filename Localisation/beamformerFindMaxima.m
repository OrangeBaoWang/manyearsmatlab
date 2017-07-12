function [myBeamformer,mySources] = beamformerFindMaxima (myBeamformer, myPreprocessor,mySources )
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
% 
%         /***************************************************************************
%     * Step 2: Find potential sources                                           *
%     ***************************************************************************/
    for indexPotential=1:myBeamformer.BF_MAXSOURCES

%         // +-------------------------------------------------------------------+
%         // | Step A: Find the maximum                                          |
%         // +-------------------------------------------------------------------+

        maxValue = -eps;
        maxIndex = -1;

        for indexPoint = 1:myBeamformer.myDelays.nPoints
            sumn=0;
            for indexPair=1:myBeamformer.myDelays.nPairs
                delay = myBeamformer.myDelays.lookup(indexPoint,indexPair);
                sumn=sumn+myBeamformer.myRij.crossCorrFiltered(indexPair,delay - myBeamformer.myRij.delayMin+1);
            end

            if (sumn>maxValue)
                maxValue = sumn;
                maxIndex = indexPoint;
            end
        end

        myBeamformer.maxValues(indexPotential)= maxValue;
        myBeamformer.maxIndexes(indexPotential)=maxIndex;
        
        myBeamformer.bestPoints(indexPotential,:) = myBeamformer.mySphere...
            .spherePoints(maxIndex,:);
% 
%         // +-------------------------------------------------------------------+
%         // | Step B: Reset the delays associated with the maximum              |
%         // +-------------------------------------------------------------------+
% 
%         // First verify that this was not the last iteration so that delays
%         // are reset only if needed

        if (~(indexPotential == myBeamformer.BF_MAXSOURCES ))
%             // Reset
            myBeamformer.myRij=rijRemoveSource(myBeamformer.myRij, myBeamformer.myDelays, maxIndex);
        end
    end



% 
%     /***************************************************************************
%     * Step 3: Generate potential sources and probabilities                     *
%     ***************************************************************************/

    %for (indexPotential = 0; indexPotential < myBeamformer->BF_MAXSOURCES; indexPotential++)
    for indexPotential = 1:myBeamformer.BF_MAXSOURCES

%         // +-------------------------------------------------------------------+
%         // | Step A: Get positions                                             |
%         // +-------------------------------------------------------------------+

        indexPoint = myBeamformer.maxIndexes(indexPotential);

%         x = sphereGetX(myBeamformer->mySphere, indexPoint);
%         y = sphereGetY(myBeamformer->mySphere, indexPoint);
%         z = sphereGetZ(myBeamformer->mySphere, indexPoint);
% 
%         mySources.sourcesPosition[indexPotential][0] = x;
%         mySources.sourcesPosition[indexPotential][1] = y;
%         mySources.sourcesPosition[indexPotential][2] = z;

        mySources.sourcesPosition(indexPotential,:) = myBeamformer.mySphere.spherePoints(indexPoint,:);

%         // +-------------------------------------------------------------------+
%         // | Step B: Get probability                                           |
%         // +-------------------------------------------------------------------+

        energy = myBeamformer.maxValues(indexPotential);

        switch (indexPotential)

            case 0

                v = energy / myBeamformer.BF_ET;

                if (v <= 1.0)
                    probability = v * v / 2.0;
                else
                    probability = 1.0 - (1.0 / (v * v * 2.0));
                end

            case 1
                probability = 0.3;

            case 2
                probability = 0.16;

            case 3
                probability = 0.03;

             otherwise
                probability = 0.01;
        end

        mySources.sourcesProbability(indexPotential) = probability;

    end


end
