void io_hlt(void);

void HariMain(void)
{
fin:
    /*  HLT命令はC言語にない関数を作成    */
    io_hlt();
    goto fin;
}
