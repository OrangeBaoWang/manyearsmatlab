function beamformerInit(myParameters,myMicrophones)


    /***************************************************************************
    * Step 1: Save parameters                                                  *
    ***************************************************************************/

    myBeamformer.BF_SPHERENBLEVELS = myParameters.GLOBAL_SPHERE_NUMBERLEVELS;
    myBeamformer.BF_MAXSOURCES = myParameters.P_BF_MAXSOURCES;
    myBeamformer.BF_FILTERRANGE = myParameters.P_BF_FILTERRANGE;
    myBeamformer.BF_RESETRANGE = myParameters.P_BF_RESETRANGE;
    myBeamformer.BF_ET = myParameters.P_BF_ET;
    /***************************************************************************
    * Step 2: Create objects                                                   *
    ***************************************************************************/

    // +-----------------------------------------------------------------------+
    // | Step A: Microphones                                                   |

    myBeamformer.myMicrophones=myMicrophones;
    



end