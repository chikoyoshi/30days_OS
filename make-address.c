#include <stdio.h>

int main(){
	unsigned int i;
	for (i=0x90;i<=0x168000;i+=0x10){
		fprintf(stdout, "%08x: 0000 0000 0000 0000 0000 0000 0000 0000\n", i);
	}
	return 0;
}
