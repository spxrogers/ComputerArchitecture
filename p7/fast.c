#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include "common.h"
#include <omp.h>

void fast() {
    /* Replace this with your implementation */
    int i,j,k,l;
        int block = 40;

        #pragma omp parallel for
        for (i=0; i<N; i+=block) {
                for (j=0; j<N; j+=block) {
                        for(k = i; k < i+block; ++k) {
                                for(l = j; l < j+block; ++l) {
                                        out[l][k] = in[k][l];
                                }
                        }
                }
        }
}
