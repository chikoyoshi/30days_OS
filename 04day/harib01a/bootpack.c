extern void _io_hlt(void);
extern void _write_mem8(int addr, int data);

void HariMain(void)
{
    /*  HLT命令はC言語にない関数を作成    */
    int i;      /*int 32bit整数*/

    for (i=0xa0000; i<=0xaffff; i++){
        _write_mem8(i, 15);   /* MOV BYTE [i],15*/
    }

    for (;;){
        _io_hlt();
    }
}
