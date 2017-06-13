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
    myParameters=parametersStruct;
end