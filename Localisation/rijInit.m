
function myRij = rijInit( myMicrophones, myDelays, frameSize, filterRange, resetRange)
% 	 /***************************************************************************
%     * Step 1: Load parameters                                                  *
%     ***************************************************************************/

    myRij.RIJ_FRAMESIZE = frameSize;
    myRij.RIJ_FILTERRANGE = filterRange;
    myRij.RIJ_RESETRANGE = resetRange;

%     /***************************************************************************
%     * Step 2: Initialize delays range                                          *
%     ***************************************************************************/
    myRij.delayMin=(min(min(myDelays.lookup)));
    myRij.delayMax =(max(max (myDelays.lookup)));

    myRij.myMicrophones = myMicrophones ;

    myRij.freqReal = zeros(myRij.myMicrophones.nMics,frameSize);
    myRij.freqImag = zeros(myRij.myMicrophones.nMics,frameSize);

    myRij.crossCorr = zeros(myRij.myMicrophones.nPairs,frameSize);
    myRij.crossCorrFiltered = zeros(myRij.myMicrophones.nPairs,  (myRij.delayMax - myRij.delayMin + 1));
	myRij.workingArray = zeros(myRij.RIJ_FRAMESIZE,1);    
    myRij.workingArrayReal = zeros(myRij.RIJ_FRAMESIZE,1);
    myRij.workingArrayImag = zeros(myRij.RIJ_FRAMESIZE,1);

end


function myRij=rijLoadFrame(myRij,indexMic, frameReal, frameImag)
	myRij.freqReal(indexMic,:)=frameReal;
	myRij.freqImag(indexMic,:)=frameImag;
end

function myRij=rijProcess(myRij)

% 	 /***************************************************************************
%     * Step 1: Multiply the cross terms                                     *
%     ***************************************************************************/

    for indexPair = 1:myRij.myMicrophones.nPairs
		indexMic=myRij.myMicrophones.inversemappingMatrix(indexPair,:);

		for k=1:myRij.RIJ_FRAMESIZE
			myRij.workingArrayReal = myRij.RIJ_FRAMESIZE*myRij.freqReal(indexMic(1),k)*...
			myRij.freqReal(indexMic(2),k)+myRij.freqImag(indexMic(1),k)*myRij.freqImag(...
				indexMic(2),k);

			myRij.workingArrayReal = myRij.RIJ_FRAMESIZE*myRij.freqReal(indexMic(1),k)*...
			myRij.freqImag(indexMic(2),k)-myRij.freqImag(indexMic(1),k)*myRij.freqReal(...
				indexMic(2),k);
		end

		myRij.workingArray=myRij.workingArrayReal+myRij.workingArrayImag*i;
		myRij.crossCorr=ifft(myRij.workingArray);

    end


%     /***************************************************************************
%     * Step 2: Filter the cross-correlation terms     find the max point             *
%     ***************************************************************************/
    for indexPair=1:myMicrophones.nPairs
    	indexCrossFiltered=1;
    	for indexDelay =myRij.delayMin:myRij.delayMax
    		indexDelayCorrected=indexDelay-myRij.RIJ_FILTERRANGE
    		if indexDelayCorrected<0
    			indexDelayCorrected=indexDelayCorrected+myRij.RIJ_FRAMESIZE;
    		end
    		maxn=myRij.crossCorr(indexPair,indexDelayCorrected);
    		for indexDelay2=indexPair-myRij.RIJ_FILTERRANGE:indexPair+...
    			myRij.RIJ_FILTERRANGE
    			indexDelayCorrected=indexDelay2;
    			if (indexDelayCorrected<0)
    				indexDelayCorrected=indexDelayCorrected+myRij.RIJ_FRAMESIZE;
    			end
    			if (myRij.crossCorr(indexPair,indexDelayCorrected)>maxn)
    				maxn = myRij.crossCorr(indexPair, indexDelayCorrected);
    			end
    			myRij.crossCorrFiltered(indexPair, indexCrossFiltered)=maxn;
    			indexCrossFiltered=indexCrossFiltered+1;
    		end
    	end
    end
    


end
