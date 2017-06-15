unction mySphere=sphereInit(numberLevels)

	// *************************************************************************
    // * STEP 1: Initialize context                                            *
    // *************************************************************************

	mySphere.SPHERE_NUMBERLEVELS = numberLevels;
	mySphere.SPHERE_NUMBERTRIANGLES = 20*mySphere.SPHERE_NUMBERLEVELS;
	mySphere.SPHERE_NUMBERPOINTS = mySphere.SPHERE_NUMBERTRIANGLES/2+2;
	mySphere.spherePoints = zeros(mySphere.SPHERE_NUMBERPOINTS ,3);
	sphereTriangles = zeros(mySphere.SPHERE_NUMBERPOINTS ,9);	

	// *************************************************************************
    // * STEP 2: Create dynamic arrays used only in this unction              *
    // *************************************************************************

    // *************************************************************************
    // * STEP 3: Compute parameters                                            *
    // *************************************************************************

    sint = 0.4472136;
    cost = 0.8944272;

    // *************************************************************************
    // * STEP 4: Generate the 12 points and 20 triangles or level 0           *
    // *************************************************************************

        // Point at the top o the sphere
        level0Points(1,1) = 0;
        level0Points(1,2) = 0;
        level0Points(1,3) = 1;

        // Point at the bottom o the sphere
        level0Points(12,1) = 0;
        level0Points(12,2) = 0;
        level0Points(12,3) = -1;

        // Now create two circles on each hemisphere that will be divided in 5
        // points

        // Circle on top hemisphere
        level0Points(2,1) = cost * sin(2.0 * M_PI * 0.0 / 5.0);
        level0Points(2,2) = cost * cos(2.0 * M_PI * 0.0 / 5.0);
        level0Points(2,3) = sint;
        level0Points(3,1) = cost * sin(2.0 * M_PI * 1.0 / 5.0);
        level0Points(3,2) = cost * cos(2.0 * M_PI * 1.0 / 5.0);
        level0Points(3,3) = sint;
        level0Points(4,1) = cost * sin(2.0 * M_PI * 2.0 / 5.0);
        level0Points(4,2) = cost * cos(2.0 * M_PI * 2.0 / 5.0);
        level0Points(4,3) = sint;
        level0Points(5,1) = cost * sin(2.0 * M_PI * 3.0 / 5.0);
        level0Points(5,2) = cost * cos(2.0 * M_PI * 3.0 / 5.0);
        level0Points(5,3) = sint;
        level0Points(6,1) = cost * sin(2.0 * M_PI * 4.0 / 5.0);
        level0Points(6,2) = cost * cos(2.0 * M_PI * 4.0 / 5.0);
        level0Points(6,3) = sint;

        // Circle on bottom hemisphere
        level0Points(7,1) = -1.0 * cost * sin(2.0 * M_PI * 0.0 / 5.0);
        level0Points(7,2) = -1.0 * cost * cos(2.0 * M_PI * 0.0 / 5.0);
        level0Points(7,3) = -1.0 * sint;
        level0Points(8,1) = -1.0 * cost * sin(2.0 * M_PI * 1.0 / 5.0);
        level0Points(8,2) = -1.0 * cost * cos(2.0 * M_PI * 1.0 / 5.0);
        level0Points(8,3) = -1.0 * sint;
        level0Points(9,1) = -1.0 * cost * sin(2.0 * M_PI * 2.0 / 5.0);
        level0Points(9,2) = -1.0 * cost * cos(2.0 * M_PI * 2.0 / 5.0);
        level0Points(9,3) = -1.0 * sint;
        level0Points(10,1) = -1.0 * cost * sin(2.0 * M_PI * 3.0 / 5.0);
        level0Points(10,2) = -1.0 * cost * cos(2.0 * M_PI * 3.0 / 5.0);
        level0Points(10,3) = -1.0 * sint;
        level0Points(11,1) = -1.0 * cost * sin(2.0 * M_PI * 4.0 / 5.0);
        level0Points(11,2) = -1.0 * cost * cos(2.0 * M_PI * 4.0 / 5.0);
    	level0Points(11,3) = -1.0 * sint;
// Use these points to define the 20 triangles for level 0

        // First define the step size to fill the array
        stepSize+1 = mySphere.SPHERE_NUMBERTRIANGLES / 20;

        // Fill the array

        sphereTriangles(0*stepSize+1,1) = level0Points(1,1);
        sphereTriangles(0*stepSize+1,2) = level0Points(1,2);
        sphereTriangles(0*stepSize+1,3) = level0Points(1,3);
        sphereTriangles(0*stepSize+1,4) = level0Points(3,1);
        sphereTriangles(0*stepSize+1,5) = level0Points(3,2);
        sphereTriangles(0*stepSize+1,6) = level0Points(3,3);
        sphereTriangles(0*stepSize+1,7) = level0Points(2,1);
        sphereTriangles(0*stepSize+1,9) = level0Points(2,2);
        sphereTriangles(0*stepSize+1,9) = level0Points(2,3);

        sphereTriangles(1*stepSize+1,1) = level0Points(1,1);
        sphereTriangles(1*stepSize+1,2) = level0Points(1,2);
        sphereTriangles(1*stepSize+1,3) = level0Points(1,3);
        sphereTriangles(1*stepSize+1,4) = level0Points(4,1);
        sphereTriangles(1*stepSize+1,5) = level0Points(4,2);
        sphereTriangles(1*stepSize+1,6) = level0Points(4,3);
        sphereTriangles(1*stepSize+1,7) = level0Points(3,1);
        sphereTriangles(1*stepSize+1,8) = level0Points(3,2);
        sphereTriangles(1*stepSize+1,9) = level0Points(3,3);

        sphereTriangles(2*stepSize+1,1) = level0Points(1,1);
        sphereTriangles(2*stepSize+1,2) = level0Points(1,2);
        sphereTriangles(2*stepSize+1,3) = level0Points(1,3);
        sphereTriangles(2*stepSize+1,4) = level0Points(5,1);
        sphereTriangles(2*stepSize+1,5) = level0Points(5,2);
        sphereTriangles(2*stepSize+1,6) = level0Points(5,3);
        sphereTriangles(2*stepSize+1,7) = level0Points(4,1);
        sphereTriangles(2*stepSize+1,8) = level0Points(4,2);
        sphereTriangles(2*stepSize+1,9) = level0Points(4,3);

        sphereTriangles(3*stepSize+1,1) = level0Points(1,1);
        sphereTriangles(3*stepSize+1,2) = level0Points(1,2);
        sphereTriangles(3*stepSize+1,3) = level0Points(1,3);
        sphereTriangles(3*stepSize+1,4) = level0Points(6,1);
        sphereTriangles(3*stepSize+1,5) = level0Points(6,2);
        sphereTriangles(3*stepSize+1,6) = level0Points(6,3);
        sphereTriangles(3*stepSize+1,7) = level0Points(5,1);
        sphereTriangles(3*stepSize+1,8) = level0Points(5,2);
        sphereTriangles(3*stepSize+1,9) = level0Points(5,3);

        sphereTriangles(4*stepSize+1,1) = level0Points(1,1);
        sphereTriangles(4*stepSize+1,2) = level0Points(1,2);
        sphereTriangles(4*stepSize+1,3) = level0Points(1,3);
        sphereTriangles(4*stepSize+1,4) = level0Points(2,1);
        sphereTriangles(4*stepSize+1,5) = level0Points(2,2);
        sphereTriangles(4*stepSize+1,6) = level0Points(2,3);
        sphereTriangles(4*stepSize+1,7) = level0Points(6,1);
        sphereTriangles(4*stepSize+1,8) = level0Points(6,2);
        sphereTriangles(4*stepSize+1,9) = level0Points(6,3);

        sphereTriangles(5*stepSize+1,1) = level0Points(10,1);
        sphereTriangles(5*stepSize+1,2) = level0Points(10,2);
        sphereTriangles(5*stepSize+1,3) = level0Points(10,3);
        sphereTriangles(5*stepSize+1,4) = level0Points(2,1);
        sphereTriangles(5*stepSize+1,5) = level0Points(2,2);
        sphereTriangles(5*stepSize+1,6) = level0Points(2,3);
        sphereTriangles(5*stepSize+1,7) = level0Points(3,1);
        sphereTriangles(5*stepSize+1,8) = level0Points(3,2);
        sphereTriangles(5*stepSize+1,9) = level0Points(3,3);

        sphereTriangles(6*stepSize+1,1) = level0Points(11,1);
        sphereTriangles(6*stepSize+1,2) = level0Points(11,2);
        sphereTriangles(6*stepSize+1,3) = level0Points(11,3);
        sphereTriangles(6*stepSize+1,4) = level0Points(3,1);
        sphereTriangles(6*stepSize+1,5) = level0Points(3,2);
        sphereTriangles(6*stepSize+1,6) = level0Points(3,3);
        sphereTriangles(6*stepSize+1,7) = level0Points(4,1);
        sphereTriangles(6*stepSize+1,8) = level0Points(4,2);
        sphereTriangles(6*stepSize+1,9) = level0Points(4,3);

        sphereTriangles(7*stepSize+1,1) = level0Points(7,1);
        sphereTriangles(7*stepSize+1,2) = level0Points(7,2);
        sphereTriangles(7*stepSize+1,3) = level0Points(7,3);
        sphereTriangles(7*stepSize+1,4) = level0Points(4,1);
        sphereTriangles(7*stepSize+1,5) = level0Points(4,2);
        sphereTriangles(7*stepSize+1,6) = level0Points(4,3);
        sphereTriangles(7*stepSize+1,7) = level0Points(5,1);
        sphereTriangles(7*stepSize+1,8) = level0Points(5,2);
        sphereTriangles(7*stepSize+1,9) = level0Points(5,3);

        sphereTriangles(8*stepSize+1,1) = level0Points(8,1);
        sphereTriangles(8*stepSize+1,2) = level0Points(8,2);
        sphereTriangles(8*stepSize+1,3) = level0Points(8,3);
        sphereTriangles(8*stepSize+1,4) = level0Points(5,1);
        sphereTriangles(8*stepSize+1,5) = level0Points(5,2);
        sphereTriangles(8*stepSize+1,6) = level0Points(5,3);
        sphereTriangles(8*stepSize+1,7) = level0Points(6,1);
        sphereTriangles(8*stepSize+1,8) = level0Points(6,2);
        sphereTriangles(8*stepSize+1,9) = level0Points(6,3);

        sphereTriangles(9*stepSize+1,1) = level0Points(9,1);
        sphereTriangles(9*stepSize+1,2) = level0Points(9,2);
        sphereTriangles(9*stepSize+1,3) = level0Points(9,3);
        sphereTriangles(9*stepSize+1,4) = level0Points(6,1);
        sphereTriangles(9*stepSize+1,5) = level0Points(6,2);
        sphereTriangles(9*stepSize+1,6) = level0Points(6,3);
        sphereTriangles(9*stepSize+1,7) = level0Points(2,1);
        sphereTriangles(9*stepSize+1,8) = level0Points(2,2);
        sphereTriangles(9*stepSize+1,9) = level0Points(2,3);

        sphereTriangles(10*stepSize+1,1) = level0Points(5,1);
        sphereTriangles(10*stepSize+1,2) = level0Points(5,2);
        sphereTriangles(10*stepSize+1,3) = level0Points(5,3);
        sphereTriangles(10*stepSize+1,4) = level0Points(8,1);
        sphereTriangles(10*stepSize+1,5) = level0Points(8,2);
        sphereTriangles(10*stepSize+1,6) = level0Points(8,3);
        sphereTriangles(10*stepSize+1,7) = level0Points(7,1);
        sphereTriangles(10*stepSize+1,8) = level0Points(7,2);
        sphereTriangles(10*stepSize+1,9) = level0Points(7,3);

        sphereTriangles(11*stepSize+1,1) = level0Points(6,1);
        sphereTriangles(11*stepSize+1,2) = level0Points(6,2);
        sphereTriangles(11*stepSize+1,3) = level0Points(6,3);
        sphereTriangles(11*stepSize+1,4) = level0Points(9,1);
        sphereTriangles(11*stepSize+1,5) = level0Points(9,2);
        sphereTriangles(11*stepSize+1,6) = level0Points(9,3);
        sphereTriangles(11*stepSize+1,7) = level0Points(8,1);
        sphereTriangles(11*stepSize+1,8) = level0Points(8,2);
        sphereTriangles(11*stepSize+1,9) = level0Points(8,3);

        sphereTriangles(12*stepSize+1,1) = level0Points(2,1);
        sphereTriangles(12*stepSize+1,2) = level0Points(2,2);
        sphereTriangles(12*stepSize+1,3) = level0Points(2,3);
        sphereTriangles(12*stepSize+1,4) = level0Points(10,1);
        sphereTriangles(12*stepSize+1,5) = level0Points(10,2);
        sphereTriangles(12*stepSize+1,6) = level0Points(10,3);
        sphereTriangles(12*stepSize+1,7) = level0Points(9,1);
        sphereTriangles(12*stepSize+1,8) = level0Points(9,2);
        sphereTriangles(12*stepSize+1,9) = level0Points(9,3);

        sphereTriangles(13*stepSize+1,1) = level0Points(3,1);
        sphereTriangles(13*stepSize+1,2) = level0Points(3,2);
        sphereTriangles(13*stepSize+1,3) = level0Points(3,3);
        sphereTriangles(13*stepSize+1,4) = level0Points(11,1);
        sphereTriangles(13*stepSize+1,5) = level0Points(11,2);
        sphereTriangles(13*stepSize+1,6) = level0Points(11,3);
        sphereTriangles(13*stepSize+1,7) = level0Points(10,1);
        sphereTriangles(13*stepSize+1,8) = level0Points(10,2);
        sphereTriangles(13*stepSize+1,9) = level0Points(10,3);

        sphereTriangles(14*stepSize+1,1) = level0Points(4,1);
        sphereTriangles(14*stepSize+1,2) = level0Points(4,2);
        sphereTriangles(14*stepSize+1,3) = level0Points(4,3);
        sphereTriangles(14*stepSize+1,4) = level0Points(7,1);
        sphereTriangles(14*stepSize+1,5) = level0Points(7,2);
        sphereTriangles(14*stepSize+1,6) = level0Points(7,3);
        sphereTriangles(14*stepSize+1,7) = level0Points(11,1);
        sphereTriangles(14*stepSize+1,8) = level0Points(11,2);
        sphereTriangles(14*stepSize+1,9) = level0Points(11,3);

        sphereTriangles(15*stepSize+1,1) = level0Points(12,1);
        sphereTriangles(15*stepSize+1,2) = level0Points(12,2);
        sphereTriangles(15*stepSize+1,3) = level0Points(12,3);
        sphereTriangles(15*stepSize+1,4) = level0Points(7,1);
        sphereTriangles(15*stepSize+1,5) = level0Points(7,2);
        sphereTriangles(15*stepSize+1,6) = level0Points(7,3);
        sphereTriangles(15*stepSize+1,7) = level0Points(8,1);
        sphereTriangles(15*stepSize+1,8) = level0Points(8,2);
        sphereTriangles(15*stepSize+1,9) = level0Points(8,3);

        sphereTriangles(16*stepSize+1,1) = level0Points(12,1);
        sphereTriangles(16*stepSize+1,2) = level0Points(12,2);
        sphereTriangles(16*stepSize+1,3) = level0Points(12,3);
        sphereTriangles(16*stepSize+1,4) = level0Points(8,1);
        sphereTriangles(16*stepSize+1,5) = level0Points(8,2);
        sphereTriangles(16*stepSize+1,6) = level0Points(8,3);
        sphereTriangles(16*stepSize+1,7) = level0Points(9,1);
        sphereTriangles(16*stepSize+1,8) = level0Points(9,2);
        sphereTriangles(16*stepSize+1,9) = level0Points(9,3);

        sphereTriangles(17*stepSize+1,1) = level0Points(12,1);
        sphereTriangles(17*stepSize+1,2) = level0Points(12,2);
        sphereTriangles(17*stepSize+1,3) = level0Points(12,3);
        sphereTriangles(17*stepSize+1,4) = level0Points(9,1);
        sphereTriangles(17*stepSize+1,5) = level0Points(9,2);
        sphereTriangles(17*stepSize+1,6) = level0Points(9,3);
        sphereTriangles(17*stepSize+1,7) = level0Points(10,1);
        sphereTriangles(17*stepSize+1,8) = level0Points(10,2);
        sphereTriangles(17*stepSize+1,9) = level0Points(10,3);

        sphereTriangles(18*stepSize+1,1) = level0Points(12,1);
        sphereTriangles(18*stepSize+1,2) = level0Points(12,2);
        sphereTriangles(18*stepSize+1,3) = level0Points(12,3);
        sphereTriangles(18*stepSize+1,4) = level0Points(10,1);
        sphereTriangles(18*stepSize+1,5) = level0Points(10,2);
        sphereTriangles(18*stepSize+1,6) = level0Points(10,3);
        sphereTriangles(18*stepSize+1,7) = level0Points(11,1);
        sphereTriangles(18*stepSize+1,8) = level0Points(11,2);
        sphereTriangles(18*stepSize+1,9) = level0Points(11,3);

        sphereTriangles(19*stepSize+1,1) = level0Points(12,1);
        sphereTriangles(19*stepSize+1,2) = level0Points(12,2);
        sphereTriangles(19*stepSize+1,3) = level0Points(12,3);
        sphereTriangles(19*stepSize+1,4) = level0Points(11,1);
        sphereTriangles(19*stepSize+1,5) = level0Points(11,2);
        sphereTriangles(19*stepSize+1,6) = level0Points(11,3);
        sphereTriangles(19*stepSize+1,7) = level0Points(7,1);
        sphereTriangles(19*stepSize+1,8) = level0Points(7,2);
        sphereTriangles(19*stepSize+1,9) = level0Points(7,3);




end