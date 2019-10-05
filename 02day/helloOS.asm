; helloOS
; TAB=4
ORG 0x7c00              ; このプログラムがどこに読み込まれるか

    ;フロッピーの情報
JMP entry
DB  0x90    ;不明 
DB  "HELLOIPL"          ;ブートセクタ名(8byte)
DW  512                 ;1セクタの大きさ 
DB  1                   ;クラスタの大きさ
DW  1                   ;FATがどこからはじまるか
DB  2                   ;FATの個数
DW  224                 ;ルートディレクトリの大きさ(エントリ)
DW  2880                ;ドライブの大きさ(セクタ)
DB  0xf0                ;メディアのタイプ
DW  9                   ;FAT領域の長さ(セクタ)
DW  18                  ;1トラックあたりのセクタ
DW  2                   ;ヘッドの数
DD  0                   ;パーティションの関係
DD  2880                ;このドライブの大きさをもう一度書く
DB  0, 0, 0x29          ;不明
DD  0xffffffff          ;ボリュームシリアル名
DB  "HELLO-OS   "       ;ディスクの名前(11byte)
DB  "FAT12   "          ;フォーマットの名前(8byte)
RESB    18              ;18byte開ける

;プログラム本体

entry:
    MOV     AX, 0       ;レジスタ初期化
    MOV     SS, AX
    MOV     SP, 0x7c00
    MOV     DS, AX
    MOV     ES, AX

    MOV     SI, msg

putloop:
    MOV     AL, [SI]
    ADD     SI, 1       ;SIに1を足す
    CMP     AL, 0   
    JE      fin
    MOV     AH, 0x0e    ;1文字表示ファンクション
    MOV     BX, 15      ;カラーコード
    INT     0x10        ;ビデオBIOSの呼び出し
    JMP     putloop

fin:
    HLT                 ;何かあるまでCPUを停止させる
    JMP     fin         ;無限ループ

msg:    
    DB      0x0a, 0x0a  ;改行
    DB      "hello, world"
    DB      0

    RESB    0x7dfe-($-$$)   ;0x7dfまでを0x00で埋める

    DB      0x55, 0xaa

;ブートセクタ以外
    DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    RESB    4600
    DB      0xf0, 0xff, 0xff, 0x00, 0x00, 0x00, 0x00, 0x00
    RESB    1469432
