; nasmfunc


section .text         ;オブジェクトファイルではこれを書いてからプログラムを書く
    GLOBAL  io_hlt, io_cli, io_sti, io_stihlt
    GLOBAL  io_in8, io_in16, io_in32
    GLOBAL  io_out8, io_out16, io_out32
    GLOBAL  io_load_eflags, io_store_eflags

    GLOBAL  _write_mem8

io_hlt:                ;void io_hlt(void);
    HLT
    RET

io_cli:                 ;void cli(void)
    CLI
    RET

io_sti:                 ;void sti(void)
    STI
    RET

io_stihlt:              ;void stihlt(void)
    STI
    HLT
    RET

io_in8:                 ;int io_in8(int port);
    MOV     EDX, [ESP+4]    ;port
    MOV     EAX, 0
    IN      AL, DX          ;8
    RET

io_in16:                ;int io_in16(int port);
    MOV     EDX, [ESP+4]
    MOV     EAX, 0
    IN      AX,  DX         ;16
    RET

io_in32:                ;int io_in32(int port)
    MOV     EDX, [ESP+4]
    IN      EAX, DX         ;32
    RET

io_out8:                ;void io_out8(int port, int data)
    MOV     EDX, [ESP+4]    ;port
    MOV     AL,  [ESP+8]    ;data
    OUT     DX,  AL         ;8
    RET

io_out16:               ;void io_out16(int port, int data);
    MOV     EDX, [ESP+4]
    MOV     EAX, [ESP+8]
    OUT     DX,  AX         ;16
    RET

io_out32:
    MOV     EDX, [ESP+4]
    MOV     EAX, [ESP+8]
    OUT     DX,  EAX        ;32
    REt

io_load_eflags:         ; int io_load_eflags(void)
    PUSHFD              ; push eflags double-word
    POP     EAX
    RET

io_store_eflags:        ; void io_store_eflags(int eflags);
    MOV     EAX, [ESP+4]
    PUSH    EAX
    POPFD               ; pop eflags double-word
    RET

write_mem8:         ;void write_mem8(int addr, int data);
    ;[ESP+0]~[ESP+3]までに関数の戻り先のアドレスが入っている
    MOV ECX, [ESP+4]        ;ESP+4にaddrが入っている([ESP+4]~[ESP+7]まで) int=32bit=4byte
    MOV AL,  [ESP+8]        ;ESP+8にdataが入っている([ESP+8]~[ESP11]まで)
    MOV [ECX], AL
    RET


