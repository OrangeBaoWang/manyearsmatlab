function myRij=rijProcess(myRij)

% 	 /***************************************************************************
%     * Step 1: Multiply the cross terms                                     *
%     ***************************************************************************/

    for indexPair = 1:myRij.myMicrophones.nPairs
		indexMic=myRij.myMicrophones.inversemappingMatrix(indexPair,:);

		for k=1:myRij.RIJ_FRAMESIZE
			myRij.workingArrayReal(k) = myRij.RIJ_FRAMESIZE*(myRij.freqReal(indexMic(1),k)*...
			myRij.freqReal(indexMic(2),k)+myRij.freqImag(indexMic(1),k)*myRij.freqImag(...
				indexMic(2),k));

			myRij.workingArrayImag(k) = -myRij.RIJ_FRAMESIZE*(myRij.freqReal(indexMic(1),k)*...
			myRij.freqImag(indexMic(2),k)-myRij.freqImag(indexMic(1),k)*myRij.freqReal(...
				indexMic(2),k));
		end


        myRij.workingArrayReal = myRij.RIJ_FRAMESIZE*(myRij.freqReal(indexMic(1),:).*...
        myRij.freqReal(indexMic(2),:)+myRij.freqImag(indexMic(1),:).*myRij.freqImag(...
        indexMic(2),:));
%         myRij.workingArrayReal=single(myRij.workingArrayReal);
         
        myRij.workingArrayImag = -myRij.RIJ_FRAMESIZE*(myRij.freqReal(indexMic(1),:).*...
        myRij.freqImag(indexMic(2),:)-myRij.freqImag(indexMic(1),:).*myRij.freqReal(...
        indexMic(2),:));
%         myRij.workingArrayImag=single(myRij.workingArrayImag);
    
    	myRij.workingArray=myRij.workingArrayReal+myRij.workingArrayImag*1i;
		myRij.crossCorr(indexPair,:)=real(ifft(myRij.workingArray));
%         fprintf('workingArrayReal: ');
%         myRij.workingArrayReal
%         fprintf('\n');
%         fprintf('workingArrayImag:');
%         myRij.workingArrayImag
%         fprintf('\n');
%         fprintf('real(ifft(myRij.workingArray):');
%         real(ifft(myRij.workingArray))
%         fprintf('\n');
%         clc;
    end


%     /***************************************************************************
%     * Step 2: Filter the cross-correlation terms     find the max point             *
%     ***************************************************************************/
    for indexPair=1:myRij.myMicrophones.nPairs
    	indexCrossFiltered=1;
    	for indexDelay = myRij.delayMin:myRij.delayMax
    		indexDelayCorrected = indexDelay-myRij.RIJ_FILTERRANGE;
    		if indexDelayCorrected<=0
    			indexDelayCorrected=indexDelayCorrected+myRij.RIJ_FRAMESIZE;
            end
            
%     		maxn=myRij.crossCorr(indexPair,indexDelayCorrected);
%     		for indexDelay2=indexDelay-myRij.RIJ_FILTERRANGE:indexDelay+...
%     			myRij.RIJ_FILTERRANGE
%     			indexDelayCorrected=indexDelay2;
%     			if (indexDelayCorrected<=0)
%     				indexDelayCorrected=indexDelayCorrected+myRij.RIJ_FRAMESIZE;
%     			end
%     			if (myRij.crossCorr(indexPair,indexDelayCorrected)>maxn)
%     				maxn = myRij.crossCorr(indexPair, indexDelayCorrected);
%                 end
%             end
%             myRij.crossCorrFiltered(indexPair, indexCrossFiltered)=maxn;
            myRij.crossCorrFiltered(indexPair, indexCrossFiltered) = ...
                myRij.crossCorr(indexPair,indexDelayCorrected);
            indexCrossFiltered=indexCrossFiltered+1;
    	end
    end
end