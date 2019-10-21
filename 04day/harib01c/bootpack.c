extern void _io_hlt(void);
//extern void _write_mem8(int addr, int data);

void HariMain(void)
{
    /*  HLT命令はC言語にない関数を作成    */
    int i;      /*int 32bit整数*/
    char *p;

    for (i=0xa0000; i<=0xaffff; i++){
        p = i;
        *p = (char *)(i & 0x0f);
    }

    for (;;){
        _io_hlt();
    }
}
