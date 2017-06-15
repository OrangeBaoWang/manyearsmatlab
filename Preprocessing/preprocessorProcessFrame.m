function myPreprocessor=preprocessorProcessFrame(myPreprocessor)

%    /***************************************************************************
%    * Step 1: Window                                                           *
%    ***************************************************************************/

    for index=1:myPreprocessor.myMicrophones.nMics
        myPreprocessor.micArray(index).xtime_windowed=myPreprocessor.micArray(index).xtime.*myPreprocessor.windows;
    end

 %   /***************************************************************************
 %   * Step 2: Compute the FFT of each microphone sound track frame             *
 %   ***************************************************************************/
   for micIndex=1:myPreprocessor.myMicrophones.nMics
   		fftxtime_windowed=fft(myPreprocessor.micArray(micIndex).xtime_windowed);
   		myPreprocessor.micArray(micIndex).xfreqReal=real(fftxtime_windowed);
   		myPreprocessor.micArray(micIndex).xfreqImag=imag(fftxtime_windowed);
   end


 %   /***************************************************************************
 %   * Step 3: Get the weighted expression for each frame (zeta(k)*X(k)/|X(k)|) *
 %   ***************************************************************************/

    for micIndex=1:myPreprocessor.myMicrophones.nMics
        myPreprocessor.micArray(micIndex)=micstProcessFrame(myPreprocessor.micArray(micIndex));
    end

end

function myMicST=micstProcessFrame(myMicST)

	myMicST.xfreqReal(1) = 0.0;
    myMicST.xfreqImag(1) = 0.0;
%    /***************************************************************************
%     * Step 1: Compute the power                                               *
%     **************************************************************************/
	myMicST.xpower=myMicST.xfreqReal.*myMicST.xfreqReal+myMicST.xfreqImag.*myMicST.xfreqImag;
% 
% /***************************************************************************
% * Step 2: Compute noise with MCRA                                         *
% **************************************************************************/
	[myMicST.noiseEstimator,myMicST.sigma]=mcraProcessFrame(myMicST.noiseEstimator,myMicST.xpower, myMicST.sigma);
    
%      /***************************************************************************
%      * Step 3: Compute the simple reverberation model                          *
%      **************************************************************************/

%    // lambda_rev_n,i(k) = gamma * lambda_rev_n-1,i(k) + (1 - gamma) * delta * | zeta_n-1_i(k) * X_n-1_i(k) |^2
    k=1;
    myMicST.lambda(k) = myMicST.MICST_GAMMA * myMicST.lambda_prev(k) + (1.0 - myMicST.MICST_GAMMA) * myMicST.MICST_DELTA * abs(myMicST.zeta_prev(k)) * abs(myMicST.zeta_prev(k)) * myMicST.xpower_prev(k);
    
     k=myMicST.MICST_HALFFRAMESIZE;
     myMicST.lambda(k) = myMicST.MICST_GAMMA * myMicST.lambda_prev(k) + (1.0 - myMicST.MICST_GAMMA) * myMicST.MICST_DELTA * abs(myMicST.zeta_prev(k)) * abs(myMicST.zeta_prev(k)) * myMicST.xpower_prev(k);  
    
    for k=2:myMicST.MICST_HALFFRAMESIZE-1
        myMicST.lambda(k) = myMicST.MICST_GAMMA * myMicST.lambda_prev(k) + (1.0 - myMicST.MICST_GAMMA) * myMicST.MICST_DELTA * abs(myMicST.zeta_prev(k)) * abs(myMicST.zeta_prev(k)) * myMicST.xpower_prev(k);
        myMicST.lambda(myMicST.MICST_FRAMESIZE - k+2) = myMicST.lambda(k);
    end

%        /***************************************************************************
%     * Step 4: Compute the estimate of the a priori SNR                        *
%     **************************************************************************/

%    // post[k] = | X_n_i[k] |^2 - sigma_2_i[k] - lambda_rev_n,i[k]
%    // ksi_n_i[k] = {(1 - alphaD) * [ zeta_n-1_i[k] ]^2 * | X_n-1_i[k] |^2 + alphaD * post[k]} / (sigma_2_i[k] + lambda_rev_n,i[k] + 1E-20)

    k=1;
    post = myMicST.xpower(k) - myMicST.sigma(k) - myMicST.lambda(k);
    post=max(post,0);
    myMicST.ksi(k) = ((1 - myMicST.MICST_ALPHAD) * myMicST.zeta_prev(k) * ...
        myMicST.zeta_prev(k) * myMicST.xpower_prev(k) + myMicST.MICST_ALPHAD * post) ...
        / (myMicST.sigma(k) + myMicST.lambda(k) + eps);
    
    k=myMicST.MICST_HALFFRAMESIZE;
    post = myMicST.xpower(k) - myMicST.sigma(k) - myMicST.lambda(k);
    post=max(post,0);
    myMicST.ksi(k) = ((1 - myMicST.MICST_ALPHAD) * myMicST.zeta_prev(k) * ...
        myMicST.zeta_prev(k) * myMicST.xpower_prev(k) + myMicST.MICST_ALPHAD * post) ...
        / (myMicST.sigma(k) + myMicST.lambda(k) + eps);
    
	for k=2:myMicST.MICST_HALFFRAMESIZE-1
		post = myMicST.xpower(k) - myMicST.sigma(k) - myMicST.lambda(k);
		post=max(post,0);
		myMicST.ksi(k) = ((1 - myMicST.MICST_ALPHAD) * myMicST.zeta_prev(k) * ...
		  	myMicST.zeta_prev(k) * myMicST.xpower_prev(k) + myMicST.MICST_ALPHAD * post) ...
            / (myMicST.sigma(k) + myMicST.lambda(k) + eps);
		myMicST.ksi(myMicST.MICST_FRAMESIZE - k+2) = myMicST.ksi(k);
	end



  %  /***************************************************************************
  %   * Step 5: Compute the weighting function                                  *
  %   **************************************************************************/

  %   // zeta_n_i[k] = ksi_n_i[k] / (ksi_n_i[k] + 1)
  	myMicST.zeta=myMicST.ksi./(myMicST.ksi+1);
%    /***************************************************************************
%     * Step 6: Compute the weighted spectrum                                   *
%     **************************************************************************/

%   // zeta_i[k] * X_i[k] / | X_i[k] |
	myMicST.weightedResultReal=myMicST.zeta.*myMicST.xfreqReal./(sqrt(myMicST.xpower)+eps);
	myMicST.weightedResultImag=myMicST.zeta.*myMicST.xfreqImag./(sqrt(myMicST.xpower)+eps);

    
%      /***************************************************************************
%      * Step 7: Update parameters                                               *
%      **************************************************************************/

    for k=1:myMicST.MICST_FRAMESIZE%(k = 0; k < myMicST.MICST_FRAMESIZE; k++)
        myMicST.lambda_prev(k) = myMicST.lambda(k);
        myMicST.xpower_prev(k) = myMicST.xpower(k);
        myMicST.zeta_prev(k) = myMicST.zeta(k);
    end


end



function [myMCRA,sigma]=mcraProcessFrame(myMCRA, xPower,sigma)
% 	  /***************************************************************************
%      * Step 1: Smooth the spectrum in frequency with window b                  *
%      **************************************************************************/
%     // Apply a linear convolution in the frequency-domain
    myMCRA.Sf(:) = 0;
   	for i=2:myMCRA.MICST_FRAMESIZE-1
   		myMCRA.Sf(i)=sum(xPower(i-1:i+1).*myMCRA.b);
    end
    myMCRA.Sf(1)=sum(xPower(1)*myMCRA.b(2)+xPower(2)*myMCRA.b(3));
    myMCRA.Sf(myMCRA.MICST_FRAMESIZE)=sum(xPower(myMCRA.MICST_FRAMESIZE)*myMCRA.b(2)+xPower(myMCRA.MICST_FRAMESIZE-1)*myMCRA.b(1));
%    	 /***************************************************************************
%      * Step 2: Smooth the spectrum in time                                     *
%      **************************************************************************/
%     // Apply equation S = alphaS * S_previous + (1 - alphaS) * Sf
%     //odd or even
    myMCRA.S(1) = myMCRA.MCRA_ALPHAS * myMCRA.S_prev(1) + (1.0 - myMCRA.MCRA_ALPHAS) * myMCRA.Sf(1);
    %myMCRA.S(myMCRA.MICST_FRAMESIZE)= myMCRA.MCRA_ALPHAS * myMCRA.S_prev(myMCRA.MICST_FRAMESIZE) + (1.0 - myMCRA.MCRA_ALPHAS) * myMCRA.Sf(A.MICST_FRAMESIZE);
    for k=2:myMCRA.MICST_HALFFRAMESIZE
    	myMCRA.S(k) = myMCRA.MCRA_ALPHAS * myMCRA.S_prev(k) + (1.0 - myMCRA.MCRA_ALPHAS) * myMCRA.Sf(k);
    	myMCRA.S(myMCRA.MICST_FRAMESIZE - k+1) = myMCRA.S(k);%//this equation have sense?yes,half;
    end

%      /***************************************************************************
%      * Step 3: Make a samplewise comparison and find minimum                   *
%      **************************************************************************/
%     // Check if the maximum number of frames is reached
%         // Smin(k,l) = min{Stmp(k,l-1),S(k,l)}
%         // Stmp(k,l) = S(k,l)


    if myMCRA.l==myMCRA.MCRA_L
    	myMCRA.S_min=min(myMCRA.S_tmp_prev,myMCRA.S);
    	myMCRA.Stmp=myMCRA.S;
    else
    	myMCRA.S_min=min(myMCRA.S_min_prev,myMCRA.S);
    	myMCRA.Stmp=min(myMCRA.S_tmp_prev,myMCRA.S);
    end


%       /***************************************************************************
%      * Step 4: Update the noise, if needed                                     *
%      **************************************************************************/
% 
%     // The noise is only updated if one of the following conditions is
%     // reached (these conditions are matched for each values of k, except for
%     // condition 1 which applies to all values of k)
%     //
%     // 1) It is the first group of L frames to be processed
%     // 2) S(k,l) < (Smin(k,l) * delta)
%     // 3) lambdaD(k,l) > |Y(k,l)|^2
	
	for k=1:myMCRA.MICST_FRAMESIZE
		if ((myMCRA.firstProcessing == 1) || ...
                (myMCRA.S(k) < (myMCRA.MCRA_DELTA * myMCRA.S_min(k))) || (myMCRA.lambdaD(k) > xPower(k)))
			if (((myMCRA.firstProcessing == 1) && ((1.0/myMCRA.l) > myMCRA.MCRA_ALPHAD)))
% 				// lambdaD(k,l+1) = (1/l) * lambdaD(k,l) + (1 - 1/l) * |Y(k,l)|^2
                myMCRA.lambdaD_next(k) = (1.0/myMCRA.l) * myMCRA.lambdaD(k) + (1.0 - (1.0/myMCRA.l)) * xPower(k);
            else
            	myMCRA.lambdaD_next(k) =  (myMCRA.MCRA_ALPHAD ) * myMCRA.lambdaD(k) + (1.0 - myMCRA.MCRA_ALPHAD) * xPower(k);
            end
        else
            	myMCRA.lambdaD_next(k) = myMCRA.lambdaD(k);
       end
    end

%     /***************************************************************************
%      * Step 5: Update parameters                                               *
%      **************************************************************************/
%     // Increment the frame counter and wrap around if needed
     myMCRA.l=myMCRA.l+1;
    if (myMCRA.l > myMCRA.MCRA_L)
%         // Remove the flag for the first group of frames to be processed
        myMCRA.firstProcessing = 0;
%         // Wrap around
        myMCRA.l = 1;
    end
%     // Update arrays;
    for k=1:myMCRA.MICST_FRAMESIZE
        myMCRA.S_min_prev(k) = myMCRA.S_min(k);
        myMCRA.S_prev(k) = myMCRA.S(k);
        myMCRA.S_tmp_prev(k) = myMCRA.S_tmp(k);
        myMCRA.lambdaD(k) = myMCRA.lambdaD_next(k);
%         sprintf('%s',class(sigma));
        sigma(k) = myMCRA.lambdaD_next(k);
    end
    sprintf('%s',class(sigma));
%     sigma=myMCRA.lambdaD_next;
end



