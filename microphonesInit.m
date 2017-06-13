


function myMicrophones=micphonesInit(nMics)
	%nMIcs=6;
	myMicrophones.nMics=nMics;
	myMicrophones.nPairs = (myMicrophones.nMics * (myMicrophones.nMics - 1)) / 2;
	myMicrophones.micsPosition=zeros(nMics,3);
	myMicrophones.micsGain=zeros(nMics,1);
	myMicrophones.mappingMatrix=zeros(nMics,nMics)+diag(-ones(nMics,1));
	indexpair=1;
	for index1=1:nMics-1
		for index2=index1+1:nMics
			myMicrophones.mappingMatrix(index1,index2)=indexpair;
		     indexpair=indexpair+1;
		end
	end
	myMicrophones.inversemappingMatrix=zeros(indexpair,2);
	indexpair=1;
	for index1=1:nMics-1
		for index2=index1+1:nMics
			myMicrophones.inversemappingMatrix(indexpair,1)=index1;
			myMicrophones.inversemappingMatrix(indexpair,2)=index2;
		    indexpair=indexpair+1;
		end
	end
end


function microphonesClone( myMicrophonesSource, myMicrophonesDest)



%     /***************************************************************************
%     * Step 1: Copy parameters                                                  *
%     ***************************************************************************/

    myMicrophonesDest.nMics = myMicrophonesSource.nMics;
    myMicrophonesDest.nPairs = myMicrophonesSource.nPairs;

%     /***************************************************************************
%     * Step 2: Copy matrix                                                      *
%     ***************************************************************************/
% 
%     // +-----------------------------------------------------------------------+
%     // | Step A: Microphone positions                                          |
%     // +-----------------------------------------------------------------------+

    for indexMic1=1:myMicrophonesDest.nMics
        myMicrophonesDest.micsPosition(indexMic1,1) = myMicrophonesSource.micsPosition(indexMic1,1);
        myMicrophonesDest.micsPosition(indexMic1,2) = myMicrophonesSource.micsPosition(indexMic1,2);
        myMicrophonesDest.micsPosition(indexMic1,3) = myMicrophonesSource.micsPosition(indexMic1,3);
    end

%     // +-----------------------------------------------------------------------+
%     // | Step B: Microphone gains                                              |
%     // +-----------------------------------------------------------------------+

    for indexMic1=1:myMicrophonesDest.nMics%(indexMic1 = 0; indexMic1 < myMicrophonesDest.nMics; indexMic1++)
        myMicrophonesDest.micsGain(indexMic1) = myMicrophonesSource.micsGain(indexMic1);
    end

%     // +-----------------------------------------------------------------------+
%     // | Step C: Forward matrix                                                |
%     // +-----------------------------------------------------------------------+

    for indexMic1=1:myMicrophonesDest.nMics
        for indexMic2=1:myMicrophonesDest.nMics
            myMicrophonesDest.mappingMatrix(indexMic1,indexMic2) = myMicrophonesSource.mappingMatrix(indexMic1,indexMic2);
        end
    end

%     // +-----------------------------------------------------------------------+
%     // | Step C: Inverse matrix                                                |
%     // +-----------------------------------------------------------------------+

    for indexPair=1:myMicrophonesDest.nPairs
        myMicrophonesDest.inverseMappingMatrix(indexPair,1) = myMicrophonesSource.inverseMappingMatrix(indexPair,1);
        myMicrophonesDest.inverseMappingMatrix(indexPair,2) = myMicrophonesSource.inverseMappingMatrix(indexPair,2);
    end
end
