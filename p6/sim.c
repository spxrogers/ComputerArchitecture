#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include "sim.h"
#include <string.h>
#include <ctype.h>
#define STACK_SIZE 1024
#define MEM_SIZE 1024
char* strdup(const char* s1); //func declare for compiler

/* The processor state */
struct StateStruct {
    /* TODO -- define the machine state, stack, memory, program, PC, ... */
	int SP;
	int stack[STACK_SIZE];
	int PC;
	char* progmem;
	int mem[MEM_SIZE];
};

State* init() {
    /* allocate memory */
    State* s = malloc(sizeof(State));

    /* zero the memory */
    bzero(s, sizeof(State));

    /* TODO -- initialize the state as needed */
	s->PC = 0;
	s->SP = 0;

    return s;
}

void prog(State* s, char* p) {
    /* TODO -- set the program */
	// char* p is the array of INS
	s->progmem = strdup(p);
}

void push(State* s, int v) {
    /* TODO -- push a value on the stack */
	s->stack[s->SP] = v;
	s->SP++;
}

// helper pop() method. returns stack[PC-1] and decrements PC
int pop(State* s) {
	s->SP--;
	return s->stack[s->SP];
}

// helper to get & return sequence of digits from program memory 
int getInts(State* s) {
	int i, temp, val;
	char ch;
	i = s->PC;
	val = 0;
		
	while (isdigit(s->progmem[i])) {
		val*=10;
		ch = s->progmem[i];
		temp = ch - '0';
		val+=temp;
		i++;
	}
	return val;
}

// recursive helper method to find length of integer sequence to update PC
int getLen(int val) {
	if (val < 10) return 1;
	else return 1 + getLen(val/10);
}

void run(State* s) {
    /* TODO -- get the program from the state */
    char* prog = s->progmem;
    printf("running: %s\n",prog);
    printf("initial stack:\n");
    stack(s);
    fflush(stdout);
    
    /* TODO -- simulate the execution */
	while (s->PC != -1) {
		char ins = s->progmem[s->PC];
		int t, val, a, v, right, left, len, memOfA;
		switch (ins) {
			case '.':
				s->PC = pop(s);
				break;
			case '-':
				push(s, pop(s)-pop(s));
				s->PC++;
				break;
			case '+':
				push(s, pop(s)+pop(s));
				s->PC++;
				break;
			case '*':
				push(s, pop(s)*pop(s));
				s->PC++;
				break;
			case '/':
				push(s, pop(s)/pop(s));
				s->PC++;
				break;
			case '%':
				push(s, pop(s)%pop(s));
				s->PC++;
				break;
			case '<':
				t = pop(s);
				val = pop(s);
				if (val < 0) s->PC=t;
				else s->PC++;
				break;
			case '>':
				t = pop(s);
                val = pop(s);
                if (val > 0) s->PC=t;
                else s->PC++;
				break;
			case '=':
				t = pop(s);
                val = pop(s);
                if (val == 0) s->PC=t;
                else s->PC++;
				break;
			case 'e':
				t = pop(s);
                if (s->SP == 0) s->PC=t;
                else s->PC++;
				break;
			case 'c':
				t = pop(s);
				push(s, s->PC+1);
				s->PC=t;
				break;
			case 'd':
				t = pop(s);
				push(s, t);
				push(s, t);
				s->PC++;
				break;
			case 'l':
				a = pop(s);
				memOfA = s->mem[a];
				push(s, memOfA);
				s->PC++;
				break;
			case 'p':
				pop(s);
				s->PC++;
				break;
			case 's':
				a = pop(s);
				v = pop(s);
				s->mem[a] = v;
				s->PC++;
				break;
			case 'x':
				right = pop(s);
				left = pop(s);
				push(s, right);
				push(s, left);
				s->PC++;
				break;
			case '0': case '1': case '2': case '3': case '4': 
			case '5': case '6': case '7': case '8': case '9':
				val = getInts(s);
				push(s, val);
				/* UPDATE PC */
				len = getLen(val);
				s->PC+=len;
				break;
		}
	}
    /* ############################## */	
    printf("final stack:\n");
    stack(s);
    fflush(stdout);

	free(s);        
}

void stack(State* s) {
    /* TODO -- show the stack as decimal ints (one per lines) */
	int index = (s->SP)-1;
	while (index > -1) {
		printf("%d\n",s->stack[index]);
		index--;
	}
}
