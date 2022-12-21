//Numpy array shape [32, 16]
//Min -2.000000000000
//Max 1.000000000000
//Number of zeros 154

#ifndef W4_H_
#define W4_H_

#ifndef __SYNTHESIS__
weight4_t w4[512];
#else
weight4_t w4[512] = {-0.250, 0.500, 0.375, 0.250, 0.375, 0.125, 0.000, 0.250, 0.125, 0.000, -0.250, -0.125, 0.000, -0.125, 0.000, -0.125, 0.125, 0.000, -0.250, 0.125, 0.000, -0.125, 0.125, 0.125, 0.625, -0.250, -0.250, 0.125, 0.250, 0.000, 0.000, -0.125, 0.000, -0.250, 0.000, 0.125, 0.000, 0.125, 0.000, 0.125, 0.125, 0.250, 0.000, -0.125, 0.000, 0.000, -1.000, 0.375, 0.000, 0.000, 0.250, 0.000, 0.125, 0.250, 0.000, -0.125, -0.500, 0.375, 0.375, 0.000, 0.000, 0.000, 0.000, 0.125, 0.125, 0.000, 0.125, 0.250, 0.750, 0.250, 0.250, 0.125, -0.625, 0.000, 0.375, 0.500, 0.500, 0.250, -0.125, 0.000, -0.125, 0.000, 0.125, 0.875, 0.000, -0.250, 0.000, -0.125, -0.125, 0.000, 0.000, 0.125, 0.125, 0.125, 0.125, 0.000, 0.000, 0.000, 0.000, 0.000, -0.250, 0.000, 0.250, 0.125, 0.500, 0.375, -0.125, 0.000, -0.125, 0.125, 0.375, 0.125, -0.250, 0.125, 0.000, 0.125, 0.375, 0.000, 0.250, 0.000, 0.500, -0.125, 0.625, 0.125, -0.375, -0.125, -0.125, 0.125, 0.125, 0.000, 0.125, -0.125, -0.250, 0.125, 0.000, 0.000, -0.125, 0.125, -0.250, 0.000, 0.625, 0.250, 0.000, 0.000, -0.125, 0.250, 0.375, 0.000, 0.000, 0.375, 0.375, -0.125, 0.250, 0.250, 0.125, 0.000, -0.125, 0.250, -0.125, -0.125, 0.250, 0.000, -0.125, 0.000, 0.250, 0.000, 0.750, 0.000, 0.000, -0.125, 0.000, -0.250, 0.125, 0.250, 0.125, 0.250, 0.000, 0.000, 0.000, 0.125, 0.375, 0.500, -0.125, -0.125, 0.375, -0.250, 0.000, -0.125, 0.125, 0.125, 0.000, 0.000, 0.250, 0.125, 0.000, 0.000, 0.375, 0.000, -0.250, 0.250, 0.125, -0.125, 0.125, 0.375, 0.375, 0.125, 0.250, 0.375, 0.125, 0.000, 0.125, -0.125, 0.375, -0.125, -0.250, 0.000, 0.250, 0.375, 0.250, 0.000, 0.000, 0.625, 0.125, -0.125, 0.250, 0.000, 0.125, 0.000, 0.500, 0.000, 0.250, 0.125, 0.000, 0.125, -0.250, 0.625, -0.375, 0.250, 0.000, 0.000, 0.000, 0.000, 0.250, 0.000, 0.000, -0.250, 0.375, 0.250, -0.250, 0.500, 0.250, 0.375, 0.250, 0.125, 0.000, 0.000, 0.125, 0.500, 0.500, -0.125, -0.125, -0.125, -0.125, -2.000, 0.125, -0.125, 0.000, 0.125, 0.125, 0.125, 0.125, 0.750, 0.250, -0.375, 0.875, 0.000, 0.125, 0.000, 0.000, 0.250, 0.250, -0.125, 0.000, 0.000, 0.000, -0.125, -0.125, 0.125, 0.125, 0.000, 0.250, 0.000, 0.125, 0.000, 0.125, 0.000, 0.000, -0.125, 0.250, 0.250, 0.125, 0.000, 1.000, -0.250, -0.125, 0.000, 0.250, 0.000, 0.000, 0.250, -0.375, 0.125, 0.375, 0.250, 0.125, 0.625, 0.125, 0.000, 0.000, -0.125, -0.125, 0.250, -0.375, 0.125, 0.000, 0.250, 0.000, 0.000, 0.125, 0.250, 0.000, 0.000, 0.000, 0.250, -0.125, 0.500, 0.625, 0.250, 0.000, -1.125, -0.125, 0.250, -0.125, -0.875, 0.375, 0.375, 0.125, 0.000, -0.125, -0.125, 0.125, 0.250, 0.250, -0.250, 0.000, 0.250, -0.250, 0.375, 0.125, 0.125, 0.000, -0.250, 0.375, 0.250, -0.125, 0.625, 0.125, 0.000, -0.250, 0.000, 0.000, 0.125, -0.250, 0.125, 0.000, 0.000, 0.250, -0.125, 0.500, -0.250, 0.625, 0.000, -0.125, 0.000, 0.125, 0.125, 0.125, 0.125, 0.250, 0.375, 0.000, 0.125, -0.250, 0.000, 0.250, 0.125, 0.000, 0.250, 0.250, 0.125, 0.625, 0.125, -0.125, -1.250, 0.250, 0.500, 0.125, 0.125, 0.250, 0.500, 0.250, -0.125, 0.125, -0.125, 0.125, -0.125, 0.000, 0.125, 0.125, -0.125, 0.500, -0.250, 0.125, -0.125, 0.125, 0.375, 0.000, 0.000, 0.250, -0.250, 0.000, 0.000, 0.500, -0.250, -0.125, -0.125, -0.125, 0.000, 0.125, -0.125, 0.125, 0.000, 0.500, 0.375, 0.125, 0.125, -0.125, 0.125, 0.000, 0.000, 0.000, 0.000, 0.000, 0.375, 0.375, 0.000, 0.000, -0.125, 0.000, 0.375, 0.250, -0.375, 0.125, 0.250, 0.375, 0.000, 0.125, 0.125, 0.125, 0.125, 0.125, 0.000, -0.125, 0.250, -0.375, 0.250, 0.125, 0.250, -0.125, -0.125, 0.000, 0.000, 0.000, 0.000, 0.000, 0.125, 0.000, 0.750, 0.000, 0.000, 0.000, 0.000, 0.000, 0.125, 0.000, -0.125, 0.125, 0.750, -0.500, -0.125, 0.000, 0.125, 0.125, 0.000, 0.000, 0.000, 0.250, 0.375, 0.125, 0.375, 0.000, 0.000};
#endif

#endif
