function preprocessorInit(myPreprocessor,myParameters,myMicrophones)
	myPreprocessor.PP_FRAMESIZE=myParameters.GLOBAL_FRAMESIZE;
	microphonesClone(myMicrophones,myPreprocessor.myMicrophones);
	myPreprocessor.window=zeros(myPreprocessor.PP_FRAMESIZE,1); 

end