#include<stdlib.h>
#include<stdio.h>

#define NPAD 15 

struct element {
  struct element *next;
  int pad[NPAD];
};


int main(int argc, char **argv) {
  long i,size;
  struct element *temp;
  struct element *list; 
  char *stopstring;

  size = (argc == 2? strtol(argv[1],&stopstring,16):0x400000);
  printf("%ld\n", size);
  list = (struct element *)calloc(size, sizeof(struct element));

  for(i=0; i<size; i++) {
    if(i == size - 1 )
      list[i].next = &list[0];
    else
      list[i].next = &list[i+1];
  }

  temp = &list[0];
  for(i=0; i<size; i++) {
    temp = temp->next;
  } 

  return 0;
} 

