; hello-os
; TAB=4
        CYLS    EQU     10
		ORG		0x7c00			; このプログラムがどこに読み込まれるのか

; 以下は標準的なFAT12フォーマットフロッピーディスクのための記述

		JMP		entry
		DB		0x90
		DB		"HELLOIPL"		; ブートセクタの名前を自由に書いてよい（8バイト）
		DW		512				; 1セクタの大きさ（512にしなければいけない）
		DB		1				; クラスタの大きさ（1セクタにしなければいけない）
		DW		1				; FATがどこから始まるか（普通は1セクタ目からにする）
		DB		2				; FATの個数（2にしなければいけない）
		DW		224				; ルートディレクトリ領域の大きさ（普通は224エントリにする）
		DW		2880			; このドライブの大きさ（2880セクタにしなければいけない）
		DB		0xf0			; メディアのタイプ（0xf0にしなければいけない）
		DW		9				; FAT領域の長さ（9セクタにしなければいけない）
		DW		18				; 1トラックにいくつのセクタがあるか（18にしなければいけない）
		DW		2				; ヘッドの数（2にしなければいけない）
		DD		0				; パーティションを使ってないのでここは必ず0
		DD		2880			; このドライブ大きさをもう一度書く
		DB		0,0,0x29		; よくわからないけどこの値にしておくといいらしい
		DD		0xffffffff		; たぶんボリュームシリアル番号
		DB		"HELLO-OS   "	; ディスクの名前（11バイト）
		DB		"FAT12   "		; フォーマットの名前（8バイト）
        TIMES   18 DB 0         ; とりあえず18バイト開けておく

; プログラム本体

entry:
		MOV		AX,0			; レジスタ初期化
		MOV		SS,AX
		MOV		SP,0x7c00
		MOV		DS,AX

;ディスクを読む
        MOV     AX,0x0820
        MOV     ES,AX
        MOV     CH,0            ;シリンダ0
        MOV     DH,0            ;ヘッド0
        MOV     CL,2            ;セクタ2

readloop:
        MOV     SI,0            ;失敗回数のレジスタ

retry:        
        MOV     AH,0x02         ;ディスク読み込み
        MOV     AL,1            ; 1セクタ 
        MOV     BX,0            ;
        MOV     DL,0x00         ; Aドライブ
        INT     0x13            ;ディスクBIOS呼び出し
        JNC     next             ;エラーが起きなければfinへ
        ADD     SI,1            ;SIをインクリメント
        CMP     SI,5            ;SIと5を比較する
        JAE     error           ;5以上だったらerrorへ移動
        MOV     AH,0x00         ; 
        MOV     DL,0x00         ;Aドライブ
        INT     0x13            ;ドライブのリセット
        JMP     retry

next:
        MOV     AX,ES           ; アドレスを0x200すすめる
        ADD     AX,0x0020       
        MOV     ES,AX           ; ADD ES,0x020という命令がないからこうする
        ADD     CL,1            ; CLに1を足す
        CMP     CL,18           ; CLと18を比較
		JBE		readloop		; 無限ループ
        MOV     CL,1
        ADD     DH,1
        CMP     DH,2
        JB      readloop        ;DH<2のとき
        MOV     DH,0
        ADD     CH,1
        CMP     CH,CYLS
        JB      readloop        ;CH<CYLSだったらreadloop

        MOV     [0x0ff0], CH
        JMP     0xc200

error:
        MOV     SI,msg

putloop:
		MOV		AL,[SI]
		ADD		SI,1			; SIに1を足す
		CMP		AL,0
		JE		fin
		MOV		AH,0x0e			; 一文字表示ファンクション
		MOV		BX,15			; カラーコード
		INT		0x10			; ビデオBIOS呼び出し
		JMP		putloop

fin:
        HLT
        JMP     fin


msg:
		DB		0x0a, 0x0a		; 改行を2つ
		DB		"hello, world"
		DB		0x0a			; 改行
		DB		0

        TIMES   0x7dfe-($-$$)-0x7c00 DB 0

		DB		0x55, 0xaa
