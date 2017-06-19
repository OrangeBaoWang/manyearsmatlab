function  [myRij]=rijRemoveSource(myRij,myDelays,indexPoint)

    for indexPair = 1:myRij.myMicrophones.nPairs

%     //for (indexPair = 0; indexPair < myRij->myMicrophones->nPairs; indexPair++)
% 
%         // +-------------------------------------------------------------------+
%         // | Step A: Get delay for this pair and point                         |
%         // +-------------------------------------------------------------------+

        delay = myDelays.lookup(indexPoint,indexPair);

%         // +-------------------------------------------------------------------+
%         // | Step B: Get the range that needs to be reset                      |
%         // +-------------------------------------------------------------------+

        delayMin = delay - myRij.RIJ_RESETRANGE;

        if (delayMin < myRij.delayMin)
            delayMin = myRij.delayMin;
        end

        delayMax = delay + myRij.RIJ_RESETRANGE;
        if (delayMax > myRij.delayMax)
            delayMax = myRij.delayMax;
        end

%         // +-------------------------------------------------------------------+
%         // | Step C: Reset                                                     |
%         // +-------------------------------------------------------------------+

        for delay = delayMin:delayMax        
            myRij.crossCorrFiltered(indexPair,delay - myRij.delayMin) = 0.0;
        end

end
