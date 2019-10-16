extern void _io_hlt(void);

void HariMain(void)
{
fin:
    /*  HLT命令はC言語にない関数を作成    */
    _io_hlt();
    goto fin;
}
