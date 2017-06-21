function myPotentialSources=potentialSourcesInit(myParameters)

% 	/***************************************************************************
% 	* Step 1: Load parameters                                                  *
% 	***************************************************************************/

	myPotentialSources.BF_MAXSOURCES = myParameters.P_BF_MAXSOURCES;

% 	/***************************************************************************
% 	* Step 1: Create arrays                                                    *
%     ***************************************************************************/
%     // Sources position
    myPotentialSources.sourcesPosition = zeros(myPotentialSources.BF_MAXSOURCES,3);% (float**) newTable2D(myPotentialSources->BF_MAXSOURCES, 3, sizeof(float));
%     // Sources probability
    myPotentialSources.sourcesProbability = zeros(myPotentialSources.BF_MAXSOURCES,1);%(float*) newTable1D(myPotentialSources->BF_MAXSOURCES, sizeof(float));
%     // Number of sources initialize as BF_MAXSOURCES, it's a variable as scence changes
    myPotentialSources.numberSources = myPotentialSources.BF_MAXSOURCES;


end