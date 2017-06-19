function  myDelays= delayInit(myMicrophones, mySphere, c, Fs, radius)

%     /***************************************************************************
%     * Step 1: Save parameters                                                  *
%     ***************************************************************************/

    myDelays.DELAYS_RADIUS = radius;
    myDelays.C = c;
    myDelays.FS = Fs;

%     /***************************************************************************
%     * Step 2: Initialize objects                                               *
%     ***************************************************************************/

%     // +-------------------------------------------------------------------+
%     // | Step A: Initialize the unit sphere                                |
%     // +-------------------------------------------------------------------+

    myDelays.mySphere = mySphere;

%     // +-------------------------------------------------------------------+
%     // | Step B: Initialize the mics pair                                  |
%     // +-------------------------------------------------------------------+

    myDelays.myMicrophones = myMicrophones;

%     /***************************************************************************
%     * Step 3: Compute delays  
%     * something is repeatted,it's not necessary.such as myDelays.myMicphones.nMics;                                                  *
%     ***************************************************************************/

    myDelays.nPoints = myDelays.mySphere.SPHERE_NUMBERPOINTS;
    myDelays.nMics = myDelays.myMicrophones.nMics;
    myDelays.nPairs = myDelays.myMicrophones.nPairs;
    myDelays.lookup = zeros(myDelays.nPoints,myDelays.nPairs);
    distanceArray = zeros(myDelays.nMics);

    for indexPoint=1:myDelays.nPoints
        pointXYZ = myDelays.DELAYS_RADIUS * myDelays.mySphere.spherePoints(indexPoint,:);
        for indexMic1=1:myDelays.nMics
            micXYZ=myDelays.myMicrophones.micsPosition(indexMic1,:);

            distance=norm(micXYZ-pointXYZ);

            distanceArray(indexMic1)=distance;
        end

        for indexMic1 = 1:myDelays.nMics-1
            for indexMic2=indexMic1+1:myDelays.nMics
                indexPair = myDelays.myMicrophones.mappingMatrix...
                (indexMic1,indexMic2);

                diffDist = distanceArray(indexMic1)...
                 - distanceArray(indexMic2);
                 % the bias about time delay reflected in how many points
                 myDelays.lookup(indexPoint,indexPair) = round((myDelays.FS/myDelays...
                    .C)*diffDist+0.5);
            end
        end
    end

    
end

