#include <stdio.h>
#include <stdlib.h>
#include "common.h"

int *data;
volatile int size;

void prep(int ws) {
	size = ws/4;
	if (data != 0) free(data);
	data = (int*) malloc(sizeof(int)*size);
	if (data == 0) { 
		perror("failure to allocate data");
		exit(-1);
	}
	
	int i;
	for (i = 0; i < size; i++) {
		data[i] = rand() % size;
	}
}

int doit() {
	volatile int i;
	volatile int val = rand() % size;
	for (i = 0; i < 1000; i++) {
		val = data[val];
	}
	return i;
}
