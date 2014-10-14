#include "vmm.h"
#include "console.h"
#include "stdint.h"
#include "machine.h"

#define MISSING() do { \
    putStr(__FILE__); \
    putStr(":"); \
    putDec(__LINE__); \
    putStr(" is missing\n"); \
    shutdown(); \
} while (0)

/* Each frame is 4K */
#define FRAME_SIZE (1 << 12)

/* A table contains 4K/4 = 1K page table entries */
#define TABLE_ENTRIES (FRAME_SIZE / sizeof(uint32_t))

/* A table, either a PD, or a PT */
typedef struct {
    uint32_t entries[TABLE_ENTRIES];
} table_s;


/* Address of first avaialble frame */
uint32_t avail = 0x100000;

/* pointer to page directory */
table_s *pd = 0;

/* zero-fill a frame */
static void zeroFrame(uint32_t ptr) {
    char* p = (char*) ptr;
    for (int i=0; i<FRAME_SIZE; i++) {
        *p = 0;
    }
}

/* The world's simplest frame allocator */
uint32_t vmm_frame(void) {
    uint32_t p = avail;
    avail += FRAME_SIZE;
    zeroFrame(p);
    return p;
}

/* handle a page fault */
void pageFault(uint32_t addr) {
   sayHex("page fault @ ", addr);
   //MISSING();
	uint32_t new_frame = vmm_frame();
	vmm_map(addr, new_frame);
}

/* Return a pointer to the PD, allocate it if you have to */
table_s* getPD() {
    if (pd == 0) {
        pd = (table_s*) vmm_frame();
    }
    return pd;            
}

/* Return a pointer to the PT that maps the given va,
   allocate it if you have to */
table_s* getPT(uint32_t va) {
    //MISSING();
	table_s* pt;
	pd = getPD();
	uint32_t pdi = va >> 22;
	uint32_t PDE = pd->entries[pdi];

	if ((PDE & 1) == 0) {
		pt = (table_s*) vmm_frame();	
		pd->entries[pdi]++;
	} else {
		pt = (table_s*) (PDE >> 12);
	}

    return pt;
}

/* Create a new mapping from va to pa */
void vmm_map(uint32_t va, uint32_t pa) {
    //MISSING();
	table_s* pt = getPT(va);
	uint32_t pti = ((va << 10) >> 22);
	uint32_t offset = (va & 0x00000fff);
	pt->entries[pti] = (pa | offset) + 1;
}

/* check if the page containing the given PA is dirty */
int vmm_dirty(uint32_t va) {
   // MISSING();
	table_s* pt = getPT(va);
	uint32_t pti = (va << 10) >> 22;	
	uint32_t pte = pt->entries[pti];
	int db = (int) ((pte << 26) >> 31);

    return db; 
}

/* check if the page containing the given PA has been accessed */
int vmm_accessed(uint32_t va) {
    //MISSING();
	table_s* pt = getPT(va);
	uint32_t pti = (va << 10) >> 22;
	uint32_t pte = pt->entries[pti];
	int accessed = (int) ((pte << 27) >> 31);

    return accessed;
}

/* return the PA that corresponds to the given VA, 0xffffffff is not mapped */
uint32_t vmm_pa(uint32_t va) {
    //MISSING();
	uint32_t ret;
	table_s* pt = getPT(va);
	uint32_t offset = (va & 0x00000fff);
	uint32_t pti = (va << 10) >> 22;
	uint32_t pte = pt->entries[pti];
	uint32_t p_bit = pte & 1;
	if (p_bit == 1) {
		ret = (pte | offset);
	} else {
		ret = 0xffffffff;
	}

    return ret;
}

/* unmap the given va */
void vmm_unmap(uint32_t va) {
    //MISSING();
	table_s* pt = getPT(va);
	uint32_t pti = (va << 10) >> 22;
	pt->entries[pti]--;

	pd = getPD();
	uint32_t pdi = va >> 22;
	pd->entries[pdi]--;

	invlpg(va);
}

/* print the contents of the page table */
void vmm_dump() {
    table_s *pd = getPD();
    sayHex("PD @ ",(uint32_t) pd);
    for (int i=0; i<TABLE_ENTRIES; i++) {
        uint32_t e = pd->entries[i];
        if (e != 0) {
            putStr("    ");
            putHex(i);
            sayHex(") PDE = ",e);
            table_s * pt = (table_s*) (e & 0xfffff000);
            for (int j=0; j<TABLE_ENTRIES; j++) {
                uint32_t e = pt->entries[j];
                if (e != 0) {
                    putStr("        ");
                    putHex(j);
                    sayHex(") PTE = ",e);
                }
            }
        }
    }
}

