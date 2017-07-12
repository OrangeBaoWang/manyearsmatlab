function myRij=rijLoadFrame(myRij,indexMic, frameReal, frameImag)
	myRij.freqReal(indexMic,:)=frameReal;
	myRij.freqImag(indexMic,:)=frameImag;
end