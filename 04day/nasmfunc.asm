; nasmfunc


section .text         ;オブジェクトファイルではこれを書いてからプログラムを書く
    GLOBAL  _io_hlt
    GLOBAL  _write_mem8

_io_hlt:                ;void io_hlt(void);
    HLT
    RET

_write_mem8:         ;void write_mem8(int addr, int data);
    ;[ESP+0]~[ESP+3]までに関数の戻り先のアドレスが入っている
    MOV ECX, [ESP+4]        ;ESP+4にaddrが入っている([ESP+4]~[ESP+7]まで) int=32bit=4byte
    MOV AL,  [ESP+8]        ;ESP+8にdataが入っている([ESP+8]~[ESP11]まで)
    MOV [ECX], AL
    RET
