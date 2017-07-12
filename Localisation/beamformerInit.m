function myBeamformer=beamformerInit(myParameters,myMicrophones)

%     /***************************************************************************
%     * Step 1: Save parameters                                                  *
%     ***************************************************************************/

    myBeamformer.BF_SPHERENBLEVELS = myParameters.GLOBAL_SPHERE_NUMBERLEVELS;
    myBeamformer.BF_MAXSOURCES = myParameters.P_BF_MAXSOURCES;
    myBeamformer.BF_FILTERRANGE = myParameters.P_BF_FILTERRANGE;
    myBeamformer.BF_RESETRANGE = myParameters.P_BF_RESETRANGE;
    myBeamformer.BF_ET = myParameters.P_BF_ET;
%     /***************************************************************************
%     * Step 2: Create objects                                                   *
%     ***************************************************************************/
% 
%     // +-----------------------------------------------------------------------+
%     // | Step A: Microphones                                                   |

    myBeamformer.myMicrophones=myMicrophones;
    myBeamformer.mySphere = sphereInit(myBeamformer.BF_SPHERENBLEVELS);%( myBeamformer.BF_SPHERENBLEVELS );
    myBeamformer.myDelays = delayInit(myMicrophones, myBeamformer.mySphere,...
    myParameters.GLOBAL_C, myParameters.GLOBAL_FS, 1.5);
    myBeamformer.myRij = rijInit(myBeamformer.myMicrophones,...
    myBeamformer.myDelays, myParameters.GLOBAL_FRAMESIZE, myParameters.P_BF_FILTERRANGE,...
      myParameters.P_BF_RESETRANGE);
    myMicrophones.maxValues = zeros(myBeamformer.BF_MAXSOURCES,1);
    myMicrophones.maxIndexes = zeros (myBeamformer.BF_MAXSOURCES,1);
    myMicrophones.bestPoints = zeros(myBeamformer.BF_MAXSOURCES,3);
    
end