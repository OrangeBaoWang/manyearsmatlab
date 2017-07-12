 function myMixture=mixtureInit(myParameters)
% 	// Index to loop through each filter spot
%     unsigned char indexFilter;
% 
%     /***************************************************************************
%     * Step 1: Load parameters                                                  *
%     ***************************************************************************/
% 
%     // +-----------------------------------------------------------------------+
%     // | General                                                               |
%     // +-----------------------------------------------------------------------+ 
%     // Maximum number of filter,The maximum number of sources...
%     that can be tracked and separated simultaneously.P_GEN_DYNSOURCES=8
    myMixture.MIXTURE_NBFILTERS = myParameters.P_GEN_DYNSOURCES;

%     // +-----------------------------------------------------------------------+
%     // | Probability                                                           |
%     // +-----------------------------------------------------------------------+

%     // Probability that a new source appears: Pnew.P_MIXTURE_PNEW=0.005
%   This parameter stands for the probability a new source appears. 
    myMixture.MIXTURE_PNEW = myParameters.P_MIXTURE_PNEW;
%     // Probability that a false detection occurs:P_MIXTURE_PFALSE=0.05

    myMixture.MIXTURE_PFALSE = myParameters.P_MIXTURE_PFALSE;

%     // +-----------------------------------------------------------------------+
%     // | Source tracking                                                       |
%     // +-----------------------------------------------------------------------+
%   P_MIXTURE_NEWTHRESHOLD=0.5,This parameter is the threshold to reach in
%   order to track a new source. By decreasing this value, the system becomes 
%   more sensitive to new source, but also more vulnerable to false detections.
%     // Threshold to reach in order to track a new source
%     myMixture.MIXTURE_NEWTHRESHOLD = myParameters.P_MIXTURE_NEWTHRESHOLD;
% 
%     // +-----------------------------------------------------------------------+
%     // | Source addition/removing                                              |
%     // +-----------------------------------------------------------------------+
% 
%     // Threshold to reach in order to confirm a source really exists
%     This parameter stands for the threshold to reach during a single iteration 
%     once a new source is detected to confirm this source really exists and start 
%     tracking this source. There is usually no need to change this parameter.
%     P_MIXTURE_CONFIRMEXISTS=0.7
    myMixture.MIXTURE_CONFIRMEXISTS = myParameters.P_MIXTURE_CONFIRMEXISTS;

%     // Threshold to count a source as existing
%     This parameter stands for the threshold to reach during a many iterations 
%     (the number of iterations is set by P_MIXTURE_CONFIRMCOUNT) once a new source 
%     is detected to confirm this source really exists and start tracking this 
%     source. There is usually no need to change this parameter.
%     P_MIXTURE_CONFIRMCOUNTTS=0.5
    myMixture.MIXTURE_CONFIRMCOUNTTS = myParameters.P_MIXTURE_CONFIRMCOUNTTS;

%     // Number of times the threshold must be reached
%     This parameter stands for the number of iterations for the probability to
%     be above the threshold P_MIXTURE_CONFIRMCOUNTTS once a new source is detected
%     to confirm this source really exists and start tracking this source. There
%     is usually no need to change this parameter.
    myMixture.MIXTURE_CONFIRMCOUNT = myParameters.P_MIXTURE_CONFIRMCOUNT;

%     // Maximum number of frames while the source has not been tracked
%     // in order to delete this tracking for probation time
%     P_MIXTURE_CUMULATIVETIMEPROB=50
    myMixture.MIXTURE_CUMULATIVETIMEPROB = myParameters.P_MIXTURE_CUMULATIVETIMEPROB;

%     // Maximum number of frames while the source has not been tracked
%     // in order to delete this tracking for time 1 25
    myMixture.MIXTURE_CUMULATIVETIME1 = myParameters.P_MIXTURE_CUMULATIVETIME1;

%     // Maximum number of frames while the source has not been tracked
%     // in order to delete this tracking for time 2
    myMixture.MIXTURE_CUMULATIVETIME2 = myParameters.P_MIXTURE_CUMULATIVETIME2;

%     // Minimum value to consider to say that source is not observed for
%     // probation time       0.95
    myMixture.MIXTURE_TOBSPROB = myParameters.P_MIXTURE_TOBSPROB;

%     // Minimum value to consider to say that source is not observed for
%     // time 1
    myMixture.MIXTURE_TOBS1 = myParameters.P_MIXTURE_TOBS1;
% 
%     // Minimum value to consider to say that source is not observed for
%     // time 2
    myMixture.MIXTURE_TOBS2 = myParameters.P_MIXTURE_TOBS2;

%     // Minimum horizontal angle difference that the new source needs to
%     // have with the already existing filters (rad)
%     //This parameter is no longer used in the new versions of the system. Do not modify.
    myMixture.MIXTURE_NEWANGLE = myParameters.P_MIXTURE_NEWANGLE;

%     // +-----------------------------------------------------------------------+
%     // | Others                                                                |
%     // +-----------------------------------------------------------------------+
% 
%     // Maximum number of potential sources 4
    myMixture.BF_MAXSOURCES = myParameters.P_BF_MAXSOURCES;

%     // Number of particles in filters   500
    myMixture.FILTER_NBPARTICLES = GLOBAL_NBPARTICLES;
% 
%     // Standard deviation 0.2
    myMixture.FILTER_STDDEVIATION = myParameters.P_FILTER_STDDEVIATION;

%     // Mixture base for f
    myMixture.MIXTURE_BASEF = myMixture.MIXTURE_NBFILTERS + 2;

%     /***************************************************************************
%     * Step 2: Create arrays                                                    *
%     ***************************************************************************/
% 
%     // +-----------------------------------------------------------------------+
%     // | Variables                                                             |
%     // +-----------------------------------------------------------------------+

    myMixture.listFilters = zeros(myMixture.MIXTURE_NBFILTERS,1);%(struct objFilter*) newTable1D(myMixture.MIXTURE_NBFILTERS, sizeof(struct objFilter));
    myMixture.filterID = zeros(myMixture.MIXTURE_NBFILTERS,1);%(ID_TYPE*) newTable1D(myMixture.MIXTURE_NBFILTERS, sizeof(ID_TYPE));
    myMixture.confirmSourceExists = zeros(myMixture.MIXTURE_NBFILTERS,1);%(float*) newTable1D(myMixture.MIXTURE_NBFILTERS, sizeof(float));
    myMixture.sumProbSourceExists = zeros(myMixture.MIXTURE_NBFILTERS,1);%(float*) newTable1D(myMixture.MIXTURE_NBFILTERS, sizeof(float));
    myMixture.flagSourceExists = zeros(myMixture.MIXTURE_NBFILTERS,1);%(unsigned char*) newTable1D(myMixture.MIXTURE_NBFILTERS, sizeof(unsigned char));
    myMixture.countSourceExists = zeros(myMixture.MIXTURE_NBFILTERS,1);%(unsigned int*) newTable1D(myMixture.MIXTURE_NBFILTERS, sizeof(unsigned int));
    myMixture.cumulativeTimeProb = zeros(myMixture.MIXTURE_NBFILTERS,1);%(unsigned int*) newTable1D(myMixture.MIXTURE_NBFILTERS, sizeof(unsigned int));
    myMixture.cumulativeTime1 = zeros(myMixture.MIXTURE_NBFILTERS,1);%(unsigned int*) newTable1D(myMixture.MIXTURE_NBFILTERS, sizeof(unsigned int));
    myMixture.cumulativeTime2 = zeros(myMixture.MIXTURE_NBFILTERS,1);%(unsigned int*) newTable1D(myMixture.MIXTURE_NBFILTERS, sizeof(unsigned int));
% 
%     // +-------------------------------------------------------------------+
%     // | Temporary variables                                               |
%     // +-------------------------------------------------------------------+

    myMixture.Pq = zeros(myMixture.BF_MAXSOURCES,1);%(float*) newTable1D(myMixture.BF_MAXSOURCES, sizeof(float));
    myMixture.Pfq = zeros(myMixture.MIXTURE_NBFILTERS+2,BF_MAXSOURCES);%(float**) newTable2D((myMixture.MIXTURE_NBFILTERS + 2), myMixture.BF_MAXSOURCES, sizeof(float));
    myMixture.POq_fq = zeros(myMixture.MIXTURE_NBFILTERS+2,BF_MAXSOURCES);%(float**) newTable2D((myMixture.MIXTURE_NBFILTERS + 2), myMixture.BF_MAXSOURCES, sizeof(float));
    myMixture.pOq_xvji = zeros(myMixture.FILTER_NBPARTICLES,1);%(float*) newTable1D(myMixture.FILTER_NBPARTICLES, sizeof(float));
    myMixture.Pqj_t = zeros(myMixture.FILTER_NBPARTICLES,myMixture.BF_MAXSOURCES);%(float**) newTable2D(myMixture.FILTER_NBPARTICLES, myMixture.BF_MAXSOURCES, sizeof(float));
    myMixture.Pq_t_H0 = zeros(myMixture.BF_MAXSOURCES,1);%(float*) newTable1D(myMixture.BF_MAXSOURCES, sizeof(float));
    myMixture.Pq_t_H2 = zeros(myMixture.BF_MAXSOURCES,1);%(float*) newTable1D(myMixture.BF_MAXSOURCES, sizeof(float));
    myMixture.fq = zeros(myMixture.BF_MAXSOURCES,1);%(unsigned char*) newTable1D(myMixture.BF_MAXSOURCES, sizeof(unsigned char));
    myMixture.filterConflict = zeros(myMixture.MIXTURE_NBFILTERS,1);%(unsigned char*) newTable1D(myMixture.MIXTURE_NBFILTERS, sizeof(unsigned char));

%     /***************************************************************************
%     * Step 3: Initialize values                                                *
%     ***************************************************************************/

%     // Initialize each filter
    for indexFilter = 1: myMixture.MIXTURE_NBFILTERS

%         // Initialize the filter
        filterInit(&myMixture.listFilters(indexFilter),myParameters);

%         // Set the filter ID to no filter
        myMixture.filterID(indexFilter) = MIXTURE_NOFILTER;

%         // Initialize the probability that the filter really exists
        myMixture.confirmSourceExists(indexFilter) = 0;

%         // Initialize the flag that the source exists
        myMixture.flagSourceExists(indexFilter) = MIXTURE_SOURCEDOESNOTEXIST;

%         // Initialize the counts for a filter to exist
        myMixture.countSourceExists(indexFilter) = 0;
        myMixture.sumProbSourceExists(indexFilter) = 0;

%         // Initialize the filter cumulative times to 0
        myMixture.cumulativeTimeProb(indexFilter) = 0;
        myMixture.cumulativeTime1(indexFilter) = 0;
        myMixture.cumulativeTime2(indexFilter) = 0;

end

%     // Initially there is no source being tracked
    myMixture.numberTrackingInProgress = 0;

%     /***************************************************************************
%     * Step 4: Initialize random module                                         *
%     ***************************************************************************/
% 
%     randInit();
% 
%     /***************************************************************************
%     * Step 5: Initialize ID manager module                                     *
%     ***************************************************************************/
% 
%     idManagerInit(&myMixture.idManager);

end