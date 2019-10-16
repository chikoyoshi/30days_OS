; nasmfunc


section .text         ;オブジェクトファイルではこれを書いてからプログラムを書く
    GLOBAL  _io_hlt

_io_hlt:                ;void io_hlt(void);
    HLT
    RET
