function myParameters=ParametersLoadDefault()
    parametersStruct.GLOBAL_FRAMESIZE   =  1024;
    % // Number of samples per frame to allow zero padding (need to be a power of 2)
    parametersStruct.GLOBAL_LONGFRAMESIZE = 2048;
    % // Frame overlap (1 = 100%, 0.5 = 50%, 0.25 = 25%, ...)
    parametersStruct.GLOBAL_OVERLAP   =    0.5;
    % // Speed of sound (in meters / sec)
    parametersStruct.GLOBAL_C          =   343;
    % // Sampling rate (in samples / sec)
    parametersStruct.GLOBAL_FS         =   48000;
    % // MCRA: Size of the window to smooth spectrum in frequency
    parametersStruct.GLOBAL_BSIZE      =   3;
    % // MCRA: Window to smooth spectrum in frequency
    parametersStruct.GLOBAL_WINDOW0    =   0.25;
    parametersStruct.GLOBAL_WINDOW1    =  0.50;
    parametersStruct.GLOBAL_WINDOW2    =   0.25;
    % // Sphere: Number of levels
    parametersStruct.GLOBAL_SPHERE_NUMBERLEVELS = 4;
    % // Number of microphones
    parametersStruct.GLOBAL_MICSNUMBER  = 8;
    % // Number of particles in filters
    parametersStruct.GLOBAL_NBPARTICLES = 500;
    %     // Maximum number of tracked/separated sources
    parametersStruct.P_GEN_DYNSOURCES = 8;
    %     // +-----------------------------------------------------------------------+
    %     // | A. Geometry                                                           |
    %     // +-----------------------------------------------------------------------+
    parametersStruct.P_GEO_MICS_MIC1_GAIN = 1.0000;
    parametersStruct.P_GEO_MICS_MIC1_X = -0.16;
    parametersStruct.P_GEO_MICS_MIC1_Y = +0.16;
    parametersStruct.P_GEO_MICS_MIC1_Z = -0.16;
    parametersStruct.P_GEO_MICS_MIC2_GAIN = 1.0000;
    parametersStruct.P_GEO_MICS_MIC2_X = -0.16;
    parametersStruct.P_GEO_MICS_MIC2_Y = +0.16;
    parametersStruct.P_GEO_MICS_MIC2_Z = +0.16;
    parametersStruct.P_GEO_MICS_MIC3_GAIN = 1.0000;
    parametersStruct.P_GEO_MICS_MIC3_X = +0.16;
    parametersStruct.P_GEO_MICS_MIC3_Y = +0.16;
    parametersStruct.P_GEO_MICS_MIC3_Z = -0.16;
    parametersStruct.P_GEO_MICS_MIC4_GAIN = 1.0000;
    parametersStruct.P_GEO_MICS_MIC4_X = +0.16;
    parametersStruct.P_GEO_MICS_MIC4_Y = +0.16;
    parametersStruct.P_GEO_MICS_MIC4_Z = +0.16;
    parametersStruct.P_GEO_MICS_MIC5_GAIN = 1.0000;
    parametersStruct.P_GEO_MICS_MIC5_X = -0.16;
    parametersStruct.P_GEO_MICS_MIC5_Y = -0.16;
    parametersStruct.P_GEO_MICS_MIC5_Z = -0.16;
    parametersStruct.P_GEO_MICS_MIC6_GAIN = 1.0000;
    parametersStruct.P_GEO_MICS_MIC6_X = -0.16;
    parametersStruct.P_GEO_MICS_MIC6_Y = -0.16;
    parametersStruct.P_GEO_MICS_MIC6_Z = +0.16;
    parametersStruct.P_GEO_MICS_MIC7_GAIN = 1.0000;
    parametersStruct.P_GEO_MICS_MIC7_X = +0.16;
    parametersStruct.P_GEO_MICS_MIC7_Y = -0.16;
    parametersStruct.P_GEO_MICS_MIC7_Z = -0.16;
    parametersStruct.P_GEO_MICS_MIC8_GAIN = 1.0000;
    parametersStruct.P_GEO_MICS_MIC8_X = +0.16;
    parametersStruct.P_GEO_MICS_MIC8_Y = -0.16;
    parametersStruct.P_GEO_MICS_MIC8_Z = +0.16;
%     // Adaptation rate (alphaD)
    parametersStruct.P_MICST_ALPHAD = 0.1;
%            // Reverberation decay (gamma)
    parametersStruct.P_MICST_GAMMA = 0.3; %//0.1f;
%            // Level of reverberation (delta)
    parametersStruct.P_MICST_DELTA = 1.0;

%           // +---------------------------------------------------------------+
%            // | I. MCRA                                                       |
%            // +---------------------------------------------------------------+
%            // Coefficient to smooth the spectrum in time (alphaS)
    parametersStruct.P_MCRA_ALPHAS = 0.95;
%         // Probability smoothing parameter (alphaP)
    parametersStruct.P_MCRA_ALPHAP = 0.2;
%          // Constant smoothing parameter (alphaD)
    parametersStruct.P_MCRA_ALPHAD = 0.95;
%           // Maximum number of frames to refresh (L)
    parametersStruct.P_MCRA_L = 150;
%            // Decision parameter (delta)
    parametersStruct.P_MCRA_DELTA = 0.01;
% 
% // +-----------------------------------------------------------------------+
% // | B. Beamformer                                                         |
% // +-----------------------------------------------------------------------+
%  
% // +---------------------------------------------------------------+
% // | I. Potential sources                                          |
% // +---------------------------------------------------------------+
%     // Define the maximum number of sources that can be found
    parametersStruct.P_BF_MAXSOURCES = 4;
%     // Define the range where the neighbour delays are used to refine
%     // the result
    parametersStruct.P_BF_FILTERRANGE = 5;
%     // Define the number of delays next to the main delay to set to zero
%     // to find the peaks after the first one
    parametersStruct.P_BF_RESETRANGE = 5;
%     // Define the energy level
    parametersStruct.P_BF_ET = 600.0;
    
    

%     // +-----------------------------------------------------------------------+
%     // | D. Mixture                                                            |
%     // +-----------------------------------------------------------------------+

%     // Probability that a new source appears: Pnew
    parametersStruct.P_MIXTURE_PNEW = 0.005;

%     // Probability that a false detection occurs
    parametersStruct.P_MIXTURE_PFALSE = 0.05;

%     // +-----------------------------------------------------------+
%     // | I. New source                                             |
%     // +-----------------------------------------------------------+

%     // Threshold to reach in order to track a new source
    parametersStruct.P_MIXTURE_NEWTHRESHOLD = 0.5; %//0.7f;

%     // +---------------------------------------------------+
%     // | i. Confirm source exists                          |
%     // +---------------------------------------------------+

%     // Threshold to reach in order to confirm a source really exists
    parametersStruct.P_MIXTURE_CONFIRMEXISTS = 0.7;

%     // Threshold to count a source as existing
    parametersStruct.P_MIXTURE_CONFIRMCOUNTTS = 0.5;

%     // Number of times the threshold must be reached
    parametersStruct.P_MIXTURE_CONFIRMCOUNT = 50;

%     // Minimum horizontal angle difference that the new source needs to
%     // have with the already existing filters (rad)
    parametersStruct.P_MIXTURE_NEWANGLE = 1.0;

%     // +-----------------------------------------------------------+
%     // | II. Delete source                                         |
%     // +-----------------------------------------------------------+
% 
%     // +---------------------------------------------------+
%     // | i. Probation                                      |
%     // +---------------------------------------------------+

%     // Maximum number of frames while the source has not been tracked
%     // in order to delete this tracking for probation time
    parametersStruct.P_MIXTURE_CUMULATIVETIMEPROB = 50;

%     // Minimum value to consider to say that source is not observed for
%     // probation time
    parametersStruct.P_MIXTURE_TOBSPROB = 0.95; %//0.5f;

%     // +---------------------------------------------------+
%     // | i. Level 1                                        |
%     // +---------------------------------------------------+

%     // Maximum number of frames while the source has not been tracked
%     // in order to delete this tracking for time 1
    parametersStruct.P_MIXTURE_CUMULATIVETIME1 = 25;%//100;

%     // Minimum value to consider to say that source is not observed for
%     // time 1
    parametersStruct.P_MIXTURE_TOBS1 = 0.5;

%     // +---------------------------------------------------+
%     // | i. Level 2                                        |
%     // +---------------------------------------------------+
% 
%     // Maximum number of frames while the source has not been tracked
%     // in order to delete this tracking for time 2
    parametersStruct.P_MIXTURE_CUMULATIVETIME2 = 50;%//200;

%     // Minimum value to consider to say that source is not observed for
%     // time 2
    parametersStruct.P_MIXTURE_TOBS2 = 0.95; %//0.7f;

%     // Adaptation rate (alphaD)
    parametersStruct.P_MICST_ALPHAD = 0.1;

%     // Reverberation decay (gamma)
    parametersStruct.P_MICST_GAMMA = 0.3;% //0.1f;

%     // Level of reverberation (delta)
    parametersStruct.P_MICST_DELTA = 1.0;

    myParameters=parametersStruct;
end