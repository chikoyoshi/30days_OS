; OS-program

    ORG     0xc200      ;このプログラムが読み込まれる場所

    MOV     AL,0x13     ;VGAグラフィックス
    MOV     AH,0x00     
    INT     0x10

fin:
    HLT
    JMP     fin
