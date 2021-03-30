#ifndef PROCESS_H
#define PROCESS_H

#include <stdint.h>
#include "../../cpu/isr.h"
#include "../paging/paging.h"
#include "../../cpu/isr.h"
typedef struct  {
   int id;                // Process ID.
   uint32_t esp, ebp;       // Stack and base pointers.
   uint32_t eip;            // Instruction pointer.
   page_directory_t *page_directory; // Page directory of the process
   struct process *next;     // The next process in a linked list.
   
}process_t;

void context_save(registers_t * reg);
extern uint32_t read_eip();
void create_process(void * func);
void remove_process();
process_t * get_next_process();
#endif