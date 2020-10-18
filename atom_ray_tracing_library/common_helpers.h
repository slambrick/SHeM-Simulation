/*
 * Copyright (c) 2018, Sam Lambrick.
 * All rights reserved.
 * This file is part of the Sub-beam Ray Tracing simulation, subject to the
 * GNU/GPL-3.0-or-later.
 */

#ifndef _common_helpers_h
#define _common_helpers_h

#include "mtwister.h"


/*
 * Linearise [row][column] coordinates in an array of coordinates
 * such as a 3-column n-row matrix of vertices of a Surface3D
 */
void lin(int row, int col, int* ind);

/* Prints a 2 or three element vector */
void print1D_double(double const * vect, int dim);

/* Prints a 2 or three element vector */
void print1D_int(int const * vect, int dim);

/* Prints out a 3 by 3 double array passed as an argument. */
void print3x3(double matrix[3][3]);

void gaussian_random(double mu, double sigma, double Z[2], MTRand *myrng);

void gaussian_random_tail(double mu, double sigma, double cutoff, MTRand *myrand,
		double* rand1);

void gen_random_int(int max, MTRand *myrand, int* randint);

#endif
