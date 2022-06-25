	;
	; ｵﾊﾅ 98
	; Programed by T.KANAI

	; ﾅﾝｶ ﾄﾞｳﾃﾞﾓｲｲ ﾌﾟﾛｸﾞﾗﾑ ﾅﾉﾃﾞ
	; ｿｰｽ ｷﾀﾅｲﾃﾞｽ｡

	;2022/06/24 tsutoban@gmail.com
	;このソース、どこから拾ったか思い出せない・・・。
	;コンパイルしてみたら、エラーでまくりだったので、直しました。
	;なぜか最後のほうにＢＡＳＩＣリストがあって・・・。
	;（消しました。）元のファイルは拡張子がａｓｓでした。
	;
	;修正　その１　シンボルemsg5が無かったので、追加。多分16色チェック時の
	;　　　　　　　エラーメッセージ
	;　　　その２　| が使われてたので、全部\n（改行）に置換
	;　　　その３　シンボルgrcgwが無かったので、追加。
	;
	;修正後、アセンブラ＋リンカでｃｏｍファイル作って問題なく
	;起動することを確認しました。(PC-9821Cx + ODP:Cylix)
	;
	;TurboAssembler使いました。
	;オリジナルのflower98.com 7044byte
	;修正後　　のflower98.com 7172byte
	;です。一応別ファイルにそれぞれのダンプリストつけました。

	;2022/06/25
	;修正箇所について　　整形してません。

code	segment
	assume	cs:code,ds:code,es:code,ss:code

vspeed	equ 08 ; 3-

ti10t	=	0133h;6KHz:019ah 8KHz:0133h 10KHz:00f6h 12KHz:00cdh 14KHz:00b0h
ti10m	=	308  ;6KHz:410   8KHz:308   10KHz:246   12KHz:205   14KHz:176  
ti08t	=	00fah;6KHz:014dh 8KHz:00fah 10KHz:00c8h 12KHz:00a6h 14KHz:008fh
ti08m	=	250  ;6KHz:333   8KHz:250   10KHz:200   12KHz:167   14KHz:143  


bseg	=	0a800h
rseg	=	0b000h
gseg	=	0b800h
iseg	=	0e000h

grcgw	db	?

fadet	equ 1000


	org	0100h
start:  jmp start2
	db	'ｵﾊﾅ 98 Ver.1.1',01ah
msg1	db	'found HGSL  int_vector:','$'
msg2	db	'H',0dh,0ah,'$'

emsg1	db	'FILE OPEN ERROR',0dH,0aH,'$'
emsg2	db	'OUT OF MEMORY',0dh,0ah,'$'
emsg3	db	'FILE READ ERROR',0dh,0ah,'$'
emsg4	db	'HGSL IS NOT RESIDENT',0dh,0ah,'$'
emsg5	db	'Color16 is not implimented.',0dh,0ah,'$'

pcm01	db	'FLO01_.PCM',0
pcm02	db	'FLO02_.PCM',0
pcm03	db	'FLO03_.PCM',0
pcm04	db	'FLO04_.PCM',0
pcm05	db	'FLO05_.PCM',0
pcm06	db	'FLO06_.PCM',0
pcm07	db	'FLO07_.PCM',0
pcm08	db	'FLO08_.PCM',0
pcm09	db	'FLO09_.PCM',0
pcm10	db	'FLO10_.PCM',0
pcm11	db	'FLO11_.PCM',0
pcm12	db	'FLO12_.PCM',0
pcm13	db	'FLO13_.PCM',0
pcm14	db	'FLO14_.PCM',0
pcm15	db	'FLO15_.PCM',0
pcm16	db	'FLO16_.PCM',0
pcm17	db	'FLO17_.PCM',0
pcm18	db	'FLO18_.PCM',0

pic01	db	'OPEN.HGS',0
pic02	db	'END.HGS',0
pic03	db	'FLO01.HGS',0
pic04	db	'FLO02.HGD',0
pic05	db	'FLO03.HGD',0
pic06	db	'FLO04.HGD',0
pic07	db	'FLO05.HGD',0
pic08	db	'FLO06.HGD',0
pic09	db	'FLO07.HGD',0
pic10	db	'FLO08.HGD',0
pic11	db	'FLO09.HGD',0
pic12	db	'FLO10.HGD',0
pic13	db	'FLO11.HGD',0
pic14	db	'FLO12.HGD',0
pic15	db	'FLO13.HGD',0
pic16	db	'FLO14.HGD',0
pic17	db	'FLO15.HGD',0
pic18	db	'FLOSU.HGD',0


pal01	db 00,00,00 ,15,15,15 ,00,00,00 ,15,15,15
	db 00,00,00 ,00,00,00 ,00,00,00 ,00,00,00
	db 00,00,00 ,15,15,15 ,00,00,00 ,15,15,15
	db 00,00,00 ,00,00,00 ,00,00,00 ,00,00,00

pal02	db 00,00,00 ,00,00,00 ,15,15,15 ,15,15,15
	db 00,00,00 ,00,00,00 ,00,00,00 ,00,00,00
	db 00,00,00 ,00,00,00 ,15,15,15 ,15,15,15
	db 00,00,00 ,00,00,00 ,00,00,00 ,00,00,00

pal01c	db 15,15,15 ,00,00,00 ,15,15,15 ,00,00,00
	db 15,15,15 ,15,15,15 ,15,15,15 ,15,15,15
	db 15,15,15 ,00,00,00 ,15,15,15 ,00,00,00
	db 15,15,15 ,15,15,15 ,15,15,15 ,15,15,15

pal02c	db 15,15,15 ,15,15,15 ,00,00,00 ,00,00,00
	db 15,15,15 ,15,15,15 ,15,15,15 ,15,15,15
	db 15,15,15 ,15,15,15 ,00,00,00 ,00,00,00
	db 15,15,15 ,15,15,15 ,15,15,15 ,15,15,15




	even
FAD02	DW     0,    9,   25,   43,   74,  108,  145,  154,  224,  238
	DW   306,  327,  336,  392,  417,  427,  491,  512,  530,  594
	DW   617,  635,  716,  752,  778,  867,  909,  937, 1043, 1094
	DW  1133, 1213, 1272, 1316, 1414, 1471, 1532, 1622, 1696, 1767
	DW  1860, 1949, 2037, 2135, 2243, 2373, 2475, 2583, 2702, 2813
	DW  2913, 3025, 3143, 3256, 3383, 3979, 4655, 5619, 6672, 7771
	DW  8805, 9945,11078,12303,13522,14751,16031,17297,18483,19764
	DW 21028,22273
FAD03	DW     0,  409,  846, 1314, 1814, 2352, 2932, 3493, 4056, 4591
	DW  5098, 5564, 5976, 6392, 6725, 7537, 8284, 8998, 9726,10470
	DW 11218,12010,12802,13576,14339,15098,15824,16844,17996,19229
	DW 20520,21966,23344,24615,25696,26812,27746,28375,28924,29439
	DW 29791
FAD04	DW     0,  240,  513,  800, 1069, 1327, 1576, 1855
FAD05	DW     0,  273,  502,  770, 1017, 1265, 1539, 1772, 2057, 2349
	DW  2622
FAD06	DW     0,  219,  450,  682,  933, 1195, 1446, 1769, 2163, 2547
	DW  2996, 3412, 3837, 4285, 4737, 5245, 5679, 6121, 6564, 7031
	DW  7512, 8055, 8588, 9038, 9528,10019,10491,11018,11550,12062
	DW 12573,13349
FAD07	DW     0,  567,  985, 1517, 2159, 2760, 3216, 3700
FAD08	DW     0,   82,  262,  545,  853, 1107, 1390, 1713, 2347, 3107
	DW  3895, 4370, 4950, 5405, 6048, 6754, 7273, 7923, 8592, 9506
	DW 10186,10996,11819,12615,13429
FAD09	DW     0,  195,  510,  927
FAD10	DW     0,   72,  131,  231, 1041, 1992, 2902, 3850, 4751, 5440
	DW  6153, 6651, 7067
FAD11	DW     0,  404,  742, 1099, 1447, 1783, 2120, 2518, 2879, 3270
	DW  3606
FAD12	DW     0,  458,  816, 1082, 1236, 1406, 1482, 1683, 1692, 1763
	DW  1903, 2067
FAD13	DW     0,  328,  699, 1123, 1506, 1930, 2337, 2729, 3119, 3546
	DW  3952
FAD14	DW     0,  402,  797, 1241, 1698, 2231, 2667, 3153, 3621, 4121
	DW  4653
FAD15	DW     0,  525, 1042, 1530, 2037, 2590, 3092, 3594, 4147, 4678
	DW  5197
FAD16	DW     0,  319,  626,  878, 1164, 1402, 1668, 1879, 2109, 2327
	DW  2579, 2792, 3055, 3289, 3531


a01d	dw	0,0 ,0,0 ,0,0 ,0,0
	;DW	00FF0H,0003EH
	DW	01271H,0003EH
	DW	014A2H,0800FH
	DW	01684H,000F8H
	DW	01865H,0F001H
	DW	019F7H,0F001H
	DW	01B89H,0E003H
	DW	01D1BH,0F001H
	DW	01EAEH,0007CH
	DW	01FF0H,0C007H
	DW	020E3H,000F8H
	DW	021D5H,0E003H
	DW	02278H,0003EH
	DW	022CAH,0F001H
	DW	022CDH,0800FH
	DW	02280H,0001FH
	DW	02193H,000F8H
	DW	01F65H,0003EH
	DW	01CE7H,0007CH
	DW	01979H,000F8H
	DW	015B9H,0800FH
	DW	01299H,0007CH
	DW	00F78H,0007CH
	DW	00CA6H,0800FH
	DW	00A74H,0E003H
	DW	00842H,0F001H
	DW	00750H,0007CH
	DW	006FDH,0001FH
	DW	0079AH,0F001H
	DW	008D8H,0C007H
	DW	00AB6H,0007CH
	DW	00DD4H,0007CH
	DW	010A3H,000F8H
	DW	013C3H,000F8H
	DW	016E3H,000F8H
	DW	01A03H,0007CH
	DW	01D73H,0800FH
	DW	01FF4H,0001FH
	DW	02316H,000F8H
	DW	025E8H,0007CH
	DW	0286AH,0800FH
	DW	02AEDH,0007CH
	DW	02C80H,000F8H
	DW	02EB2H,0007CH
	DW	03044H,0C007H
	DW	03227H,000F8H
	DW	034A8H,0E003H
	dw	0,0 ,0,0 ,0,0 ,0,0 ,0,0 ,0,0 ,0,0 ,0,0 ,0,0 ,0,0
	dw	0ffffh

a02d	dw	38,174,0ffffh
	dw	38,171,0ffffh
	dw	38,169,0ffffh
	dw	38,165,0ffffh
	dw	37,165,0ffffh
	dw	36,162,19,173,0ffffh
	dw	36,161,18,171,0ffffh
	dw	36,160,18,170,61,173,0ffffh
	dw	35,158,18,169,61,172,0ffffh
	dw	34,154,18,169,60,171,0ffffh
	dw	34,154,18,168,60,171,0ffffh
	dw	34,151,17,164,60,168,0ffffh
	dw	34,151,17,164,60,165,0ffffh
	dw	34,144,16,162,59,163,0ffffh
	dw	34,144,16,162,59,162,0ffffh
	dw	33,147,15,159,58,161,0ffffh
	dw	32,147,15,157,58,154,0ffffh
	dw	32,147,13,154,57,149,0ffffh
	dw	31,142,12,148,56,142,0ffffh
	dw	31,139,12,148,56,138,0ffffh
	dw	31,139,12,147,56,138,0ffffh
	dw	30,139,12,142,54,139,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0,56,0ffffh
	dw	0fffeh
	
fl09t	dw	0*2,1*2,2*2,3*2,4*2,5*2,6*2,7*2,7*2,7*2,7*2,7*2,7*2,7*2
	dw	8*2,9*2,10*2
	
fljpt	dw	fl00,fl01,fl02,fl03,fl04,fl05,fl06,fl07,fl08,fl09,fl10
	dw	fl11,fl12,fl13

	even
intt	dw	int40,int41,int42,int43,int44,int45,int46,int47
	dw	int48,int49,int4a,int4b,int4c,int4d,int4e,int4f
	dw	int50,int51,int52,int53,int54,int55,int56,int57
	dw	int58,int59,int5a,int5b,int5c,int5d,int5e,int5f
	dw	int60,int61,int62,int63,int64,int65,int66,int67
	dw	int68,int69,int6a,int6b,int6c,int6d,int6e,int6f
	dw	int70,int71,int72,int73,int74,int75,int76,int77
	dw	int78,int79,int7a,int7b,int7c,int7d,int7e,int7f


;	CRESTA ORIGINAL	PSG LEVEL TABLE
	even
psgt4		DB	 0, 0, 0	; 0
	even
		DB	 5, 9, 1	; 1
	even
		DB	 0,12, 0	; 2
	even
		DB	 6,13, 1	; 3
	even
		DB	 5,14, 1	; 4
	even
		DB	 0,15, 0	; 5
	even
		DB	 9,15, 5	; 6
	even
		DB	12,15, 0	; 7
	even
		DB	13,15, 6	; 8
	even
		DB	14,15, 5	; 9
	even
		DB	15,15, 0	;10
	even
		DB	15,15, 9	;11
	even
		DB	15,15,12	;12
	even
		DB	15,15,13	;13
	even
		DB	15,15,14	;14
	even
		DB	15,15,15	;15


	align 4
start2:	cld
	;ﾌﾟﾛｸﾞﾗﾑｻｲｽﾞ ﾉ ｾｯﾄ
	mov bx,offset program_end
	shr bx,1
	shr bx,1
	shr bx,1
	shr bx,1
	inc bx
	mov ah,4ah
	int 21h
	jnc pssne
	mov dx,offset emsg2
	mov ah,9
	int 21h
	mov ax,4c00h
	int 21h
	align 4
pssne:	mov sp,offset spwe
	;ﾁﾒｲﾃｷｴﾗｰ ｶｷｶｴ
	mov ax,2524h
	mov dx,offset failr
	int 21h
	;ﾁｭｳﾀﾞﾝｷｰ ｷﾝｼ
	mov ax,2523h
	mov dx,offset myin23
	int 21h
	;key_beep off
	xor ax,ax
	mov es,ax
	mov al,es:[500h]
	mov [m500],al
	or byte ptr es:[500h],100000b
; COMMENT !
	;16ｼｮｸﾎﾞｰﾄﾞ ﾁｪｯｸ
	xor ax,ax
	mov es,ax
	mov al,es:[054ch]
	and al,110b
	cmp al,110b
	jz c16ok
c16err:	mov dx,offset emsg5
	mov ah,9
	int 21h
	jmp ret_dos
	align 4
c16ok:
	mov al,1
	out 6ah,al
	call waith
	xor al,al
	mov [grcgw],al
	out 7ch,al
	call waith ; grcg off
; !
	xor al,al
	out 7ch,al
	call waith ; grcg off
	;hgsl ﾁｪｯｸ
	mov ax,3540h
	align 4
hgslc1:	int 21h
	cmp word ptr es:[bx+2],'H'+256*'G'
	jnz hgslc2
	cmp word ptr es:[bx+4],'S'+256*'L'
	jz  hgslc3
hgslc2:
	inc al
	jns hgslc1
	mov ah,9
	mov dx,offset emsg4
	int 21h
	jmp ret_dos
	align 4
hgslc3:
	mov cl,al
	sub al,40h
	xor ah,ah
	add ax,ax
	mov bx,ax
	mov ax,[bx+offset intt]
	mov [hgsladd],ax
	mov ah,9
	mov dx,offset msg1
	int 21h
	xor dh,dh
mov dl,cl
call prdx
mov ah,9
mov dx,offset msg2
int 21h
	mov ah,9
call chgsl
mov cs:[pws],ds
mov ax,cs
mov ds,ax
mov [pwo],si
sb2c:	;ｻｳﾝﾄﾞﾎﾞｰﾄﾞ2 ﾁｪｯｸ
	call sbc
	;ﾊﾞｯﾌｧ ｶｸﾎ
	mov bx,2202+221+1393+1978;
	mov ah,48h
int 21h
jnc bune
	mov dx,offset emsg2
mov ah,9
int 21h
jmp ret_dos
	align 4
bune:	mov [paran],ax
	;
	mov ah,0dh
int 18h ; text off
	;
	mov ax,350ah
int 21h
mov [i0ao],bx
mov [i0as],es
	;
	;pcmp
	call siv
	;
	mov ds,cs:[002ch]
xor si,si
xor ax,ax
env02:	cmp [si],ax
jz env01
inc si
jns env02
jmp nenv
	align 4
env01:	add si,4
	mov al,[si  ]
	cmp al,'A'
jc nenv
cmp al,'Z'+1
jc env05
	cmp al,'a'
jc nenv
cmp al,'z'+1
jnc nenv
env05:	cmp word ptr [si+1],'\:'
jnz nenv
	mov di,si
mov cx,80
env03:	lodsb
and al,al
jz env04
loop env03
jmp nenv
	align 4
env04:	mov al,'\'
env06:	dec si
cmp [si],al
jnz env06
	mov cx,si
mov si,di
sub cx,si
inc cx
mov di,offset filenw
	mov ax,cs
mov es,ax
rep	movsb
	mov ds,ax
mov [filenwl],di
	mov si,offset pic01
env07:	lodsb
stosb
and al,al
jnz env07
	mov dx,offset filenw
mov ax,3d00h
int 21h
jc nenv
	mov bx,ax
mov ah,3eh
int 21h
	jmp enve

	align 4
nenv:	mov word ptr cs:[filenwl],offset filenw
enve:
	;
	mov ch,10000000b
mov ah,42h
int 18h ;200line UPPER
	xor al,al
out 0a6h,al
call waith
	mov ah,9
call chgsl
mov cs:[palwo],si
mov cs:[palws],ds
open:	;
	; ｵｰﾌﾟﾆﾝｸﾞ
	;
	mov ax,cs
mov ds,ax
	mov si,[paran]
mov di,offset segw
	mov dx,offset pic01
call filer
	mov ah,41h
int 18h ; gra off
	xor dx,dx
mov ah,4
call chgsl
	mov ds,[paran]
xor si,si
xor bx,bx
xor cx,cx
xor ah,ah
call chgsl
	mov ah,40h
int 18h ; gra on
	mov cx,fadet
mov ah,5
call chgsl
	;
	mov ax,cs
mov ds,ax
	mov dx,offset gvsi
mov ax,250ah
int 21h
	in al,02h
and al,0fbh
out 02h,al
out 64h,al ; vsync on
	mov word ptr [gvsic],0
opwl:	call escc
cmp word ptr [gvsic],180
jc opwl
	;
	mov cx,fadet
mov ah,6
call chgsl
	;
	; ﾊｼﾞﾏﾘ
	;
	; paran    pcm
	; segww	   ﾀｲﾖｳ
	; segw+2   ｶﾞｿﾞｳ1
	; segww+2  ｶﾞｿﾞｳ2

	;cls
	mov al,10000000b
out 7ch,al
call waith ; grcg tdw
	xor al,al
out 7eh,al
call waith
out 7eh,al
call waith
out 7eh,al
	call waith
out 7eh,al
call waith
	mov ax,bseg
mov es,ax
xor di,di
mov cx,80*200/2
rep	stosw
	xor al,al
out 7ch,al
call waith ; grcg off
	;ｽﾃｰｼﾞ ﾋｮｳｼﾞ
	mov ax,cs
mov ds,ax
	mov si,[paran]
mov di,offset segw
	mov dx,offset pic03
call filer
	mov ds,[paran]
xor si,si
xor bx,bx
mov cx,200
mov ah,1
call chgsl
	;pcm ﾘｮｳｲｷ ｶｸﾎ
	mov ax,cs
mov ds,ax
	mov ax,[paran]
add ax,2202
mov [segw],ax ; (16128+8736+10368)/16=2202
	mov [segww],ax
	;ﾀｲﾖｳ ﾛｰﾄﾞ
	mov si,[segw]
mov di,offset segw+2
	mov dx,offset pic18
call filer
	;ｶﾞｿﾞｳ ﾘｮｳｲｷ 1 ｶｸﾎ
	mov ax,[segw+2]
add ax,1393;22273/16+1
mov [segw+4],ax
mov [segww+2],ax
	;ｶﾞｿﾞｳ ﾘｮｳｲｷ 2 ｶｸﾎ
	add ax,1978;29791/16+1+1855/16+1
mov [segw+6],ax
mov [segww+4],ax
	;v-sync ﾜﾘｺﾐ
	mov ax,cs
mov ds,ax
	in al,02h
or al,4
out 02h,al ; vsync off
	mov dx,offset evsi
mov ax,250ah
int 21h
	mov word ptr [gvsic],vspeed-1
mov word ptr [sunc],65534
	mov byte ptr [evsif],0
mov byte ptr [dpla],0
	;
	mov byte ptr [floc],0
mov byte ptr [sunsw],0
mov byte ptr [palsw],0

	;
	in al,02h
and al,0fbh
out 02h,al
out 64h,al ; vsync on
	;
	
	;pcm01 ﾛｰﾄﾞ
	mov ax,cs
mov ds,ax
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm01
call filer
	;｢ﾄﾞｺｶﾗｶ ﾄﾝﾃﾞｷﾀ ﾀﾈｶﾞ ﾋﾄﾂﾌﾞ ｱﾘﾏｼﾀ｣
	call fpcmp
p0101:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0101	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ﾀﾈｶﾞﾄﾌﾞ
	mov word ptr [seedc],offset a01d+4
mov byte ptr [floc],1
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm02
call filer
	mov si,[segw+2]
mov di,offset segw+4
	mov dx,offset pic04
call filer
p0102:	call escc
cmp word ptr [seedc],0ffffh
jc p0102
	;｢ｿﾉﾀﾈﾊ ｽｸｽｸﾄ ｿﾀﾞﾁﾏｼﾀ｣
	call fpcmp
p0103:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0103	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ﾊﾅｶﾞ ﾊｴﾊｼﾞﾒﾙ with ｻﾞｯｿｳ
	mov word ptr [p02c],offset a02d
mov word ptr [hgsap],offset fad02
	mov byte ptr [floc],2
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm03
call filer
	mov si,[segww+2]
mov di,offset segw+6
	mov dx,offset pic05
call filer
	mov si,[segw+6]
mov [p02aw],si
mov di,offset segw+6
	mov dx,offset pic06
call filer
p0201:	call escc
cmp word ptr [p02c],0fffeh
jc p0201
	;｢ｱｯ ｱﾌﾞﾅｲ ﾀﾍﾞﾗﾚﾁｬｳ｣
	call fpcmp
p0202:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0202	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ﾈｺ ｻﾞｯｿｳﾀﾍﾞﾃ ﾀﾁｻﾙ
	mov word ptr [p03c],0
mov word ptr [hgsap],offset fad03
	mov byte ptr [floc],3
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm04
call filer
	mov si,[segw+2]
mov di,offset segw+4
	mov dx,offset pic07
call filer
p0301:	call escc
cmp word ptr [p03c],47
jc p0301
	;｢ｱｰﾖｶｯﾀ ﾄﾞｷﾄﾞｷｼﾀﾜ｣
	call fpcmp
p0302:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0302	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ﾁｮｯﾄ ﾊﾟﾀﾊﾟﾀ ｽﾙ
	mov word ptr [p04c],0
mov word ptr [hgsap],offset fad05
	mov byte ptr [floc],4
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm05
call filer
	mov si,[segww+2]
mov di,offset segw+6
	mov dx,offset pic08
call filer
	mov si,[segw+6]
mov [p04aw],si
mov di,offset segw+6
	mov dx,offset pic09
call filer
p0401:	call escc
cmp word ptr [p04c],10
jc p0401
	;｢ｿｼﾃ ﾋﾄﾂﾉ ﾁｲｻﾅﾂﾎﾞﾐ ｦ ﾂｹﾏｼﾀ｣
	call fpcmp
p0402:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0402	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ﾂﾎﾞﾐ ｦ ﾂｹﾙ
	mov word ptr [p05c],0
mov word ptr [p05c2],0
mov word ptr [p05c3],0
	mov byte ptr [floc],5
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm06
call filer
	mov si,[segw+6]
mov [p05aw],si
mov di,offset segw+6
	mov dx,offset pic10
call filer
p0501:	call escc
cmp word ptr [p05c],60
jc p0501
	;｢ｼｶｼ ｿﾉﾄｷ｣
	call fpcmp
p0502:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0502	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｸﾓｻﾝ ﾄｳｼﾞｮｳ
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm07
call filer
	mov si,[segw]
mov [p05pw1],si
mov di,offset segw
	mov dx,offset pcm08
call filer
	mov si,[segw]
mov [p05pw2],si
mov di,offset segw
	mov dx,offset pcm09
call filer
	mov si,[segw+2]
mov di,offset segw+4
	mov dx,offset pic11
call filer
	mov si,[segw+4]
mov [p05aw2],si
mov di,offset segw+4
	mov dx,offset pic12
call filer
p0503:	call escc
cmp word ptr [p05c],80+28+6
jc p0503
	;｢ｳﾜｰ ﾀｽｹﾃｰ｣
	mov word ptr [timec],0
mov word ptr [timec2],0
	mov ax,[paran]
mov [bpoi],ax
mov word ptr [bpoio],0
	mov ax,[p05pw1]
mov [bpoim],ax
mov byte ptr [lbitf],0
	in al,2
and al,0feh
out 2,al ; int on
p0504:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0504	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;｢ｺﾞﾛｺﾞﾛ ﾋﾟｶｯ｣
	mov word ptr [timec],0
mov word ptr [timec2],0
	mov ax,[p05pw1]
mov [bpoi],ax
mov word ptr [bpoio],0
	mov ax,[p05pw2]
mov [bpoim],ax
mov byte ptr [lbitf],0
	in al,2
and al,0feh
out 2,al ; int on
p0505:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0505	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｶﾐﾅﾘ ﾁｮｸｹﾞｷ
	mov word ptr [p06c],0
	mov byte ptr [floc],6
p0601:	call escc
cmp word ptr [p06c],3
jc p0601
	;｢ｳｫｫｫｫｰｰｰｰｰ｣
	mov word ptr [timec],0
mov word ptr [timec2],0
	mov ax,[p05pw2]
mov [bpoi],ax
mov word ptr [bpoio],0
	mov ax,[segw]
mov [bpoim],ax
mov byte ptr [lbitf],0
	in al,2
and al,0feh
out 2,al ; int on
p0602:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0602	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｻﾞｯｿｳ ｸﾀﾞｹﾁﾙ
	mov word ptr [p07c],0
mov byte ptr [palsw],0
	mov byte ptr [floc],7
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm10
call filer
	mov si,[segww+2]
mov di,offset segw+6
	mov dx,offset pic13
call filer
p0701:	call escc
cmp word ptr [p07c],3+9
jc p0701
	;｢ｶﾐﾅﾘ ﾊ ﾎｶﾉﾊﾅ ﾆ ｵﾁﾏｼﾀ｣
	call fpcmp
p0702:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0702	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｻﾞｯｿｳ ｳｺﾞﾒｸ
	mov word ptr [p08c],0
	mov byte ptr [floc],8
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm11
call filer
	mov si,[segw+6]
mov [p08aw],si
mov di,offset segw+6
	mov dx,offset pic14
call filer
p0801:	call escc
cmp word ptr [p08c],10
jc p0801
	;｢ｳﾜｰ ﾜﾀｼﾆｱﾀﾗﾅｸﾃ ﾖｶｯﾀﾜｰ｣
	call fpcmp
p0802:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0802	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｱﾏｸﾞﾓ ﾋｸ
	mov word ptr [p09c],0
mov word ptr [p09c2],0
	mov byte ptr [floc],9
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm12
call filer
	mov si,[segw+2]
mov di,offset segw+4
	mov dx,offset pic15
call filer
p0901:	call escc
cmp word ptr [p09c],17+16
jc p0901
	;｢ｱｯ ﾂﾎﾞﾐｶﾞ ﾋﾗｷｿｳ｣
	call fpcmp
p0902:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p0902	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｱｯ･･･ ﾂﾎﾞﾐｶﾞ･･･
	mov word ptr [p10c],0
	mov byte ptr [floc],10
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm13
call filer
	mov si,[segww+2]
mov di,offset segw+6
	mov dx,offset pic16
call filer
p1001:	call escc
cmp word ptr [p10c],20
jc p1001
	;｢ﾊｯ ﾎｯ ﾓｳｽｺｼ ｶﾞﾝﾊﾞﾚ｣
	call fpcmp
p1002:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p1002	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｶﾞﾝﾊﾞﾙﾝ
	mov word ptr [p10c],0
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm14
call filer
p1003:	call escc
cmp word ptr [p10c],20
jc p1003
	;｢ﾖｼ ｶﾞﾝﾊﾞﾚ ｶﾞﾝﾊﾞﾚ ﾓｳｽｺｼﾀﾞ｣
	call fpcmp
p1004:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p1004	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｶﾞﾝﾊﾞﾙﾝ 2
	mov word ptr [p10c],0
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm15
call filer
p1005:	call escc
cmp word ptr [p10c],20
jc p1005
	;｢ｶﾞﾝﾊﾞﾚ ｶﾞﾝﾊﾞﾚ ｶﾞﾝﾊﾞﾚｰ｣
	call fpcmp
p1006:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p1006	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｵﾊﾅ ｻｸ
	mov word ptr [p11c],0
	mov byte ptr [floc],11
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm16
call filer
	mov si,[segw+2]
mov di,offset segw+4
	mov dx,offset pic17
call filer
p1101:	call escc
cmp word ptr [p11c],10
jc p1101
	;ｻｲﾃ ﾊﾟﾀﾊﾟﾀ
	mov word ptr [p12c],0
mov word ptr [p12c2],0
	mov byte ptr [floc],12
	;｢ｳﾜｰ ｻｲﾀ ｻｲﾀ｣
	call fpcmp
p1102:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p1102	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;
	mov word ptr [p12c],0
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm17
call filer
p1201:	call escc
cmp word ptr [p12c],8
jc p1201
	;｢ｷﾚｲﾆｻｲﾀ｣
	call fpcmp
p1202:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p1202	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｻｲﾃ ﾊﾟﾀﾊﾟﾀ 2
	mov word ptr [p12c],0
	mov si,[paran]
mov di,offset segw
	mov dx,offset pcm18
call filer
p1203:	call escc
cmp word ptr [p12c],8
jc p1203
	;｢ﾖｶｯﾀﾈｰ｣
	call fpcmp
p1204:	call escc
	mov ax,[bpoim]
cmp [bpoi],ax
jc p1204	;pcm ｶﾞ ｵﾜﾙﾏﾃﾞ ﾏｯﾃｲﾙ
	;ｻｲﾃ ﾊﾟﾀﾊﾟﾀ 3
	mov word ptr [p12c],0
p1205:	call escc
cmp word ptr [p12c],16
jc p1205
	;fade out
	mov word ptr [p13c],0
mov word ptr [p13fad],0
mov byte ptr [p13fc],0
	mov byte ptr [floc],13
p1301:	call escc
cmp word ptr [p13c],56
jc p1301
	;
	mov ds,cs:[i0as]
mov dx,cs:[i0ao]
mov ax,250ah
int 21h
	in al,02h
and al,0fbh
out 02h,al
out 64h,al ; vsync on
	;
	; ｴﾝﾃﾞｨﾝｸﾞ
	;
	mov ax,cs
mov ds,ax
	mov si,[paran]
mov di,offset segw
	mov dx,offset pic02
call filer
	mov ah,41h
int 18h ; gra off
	xor dx,dx
mov ah,4
call chgsl
	mov ds,[paran]
xor si,si
xor bx,bx
xor cx,cx
xor ah,ah
call chgsl
	mov ah,40h
int 18h ; gra on
	mov cx,fadet
mov ah,5
call chgsl
	;
	mov ax,cs
mov ds,ax
	mov dx,offset gvsi
mov ax,250ah
int 21h
	in al,02h
and al,0fbh
out 02h,al
out 64h,al ; vsync on
	mov word ptr [gvsic],0
enwl:	call escc
cmp word ptr [gvsic],180
jc enwl
	;
	mov cx,fadet
mov ah,6
call chgsl
	;
	jmp open



	align 4
fpcmp:	mov word ptr [timec],0
mov word ptr [timec2],0
	mov ax,[paran]
mov [bpoi],ax
mov word ptr [bpoio],0
	mov ax,[segw]
mov [bpoim],ax
mov byte ptr [lbitf],0
	in al,2
and al,0feh
out 2,al ; int on
	ret














	align 4
flow:	cld
	push ds
push es
push cx
push dx
push bx
push bp
push si
push di
	call sunp
	mov bl,cs:[floc]
xor bh,bh
add bx,bx
call word ptr cs:[bx+offset fljpt]
	jmp flje
	
	align 4
fl00:	ret
	
	align 4
fl01:	;ﾀﾈ ｹｽ
	mov bx,cs:[seedc]
cmp bx,0ffffh
jz fl0102
	mov ax,rseg+80*200/16
mov ds,ax
	mov di,cs:[bx]
mov ax,cs:[bx+2]
	xor [di],ax
xor [di+80],ax
xor [di+80*2],ax
	;ﾀﾈ ｶｸ
	add bx,4
mov di,cs:[bx]
cmp di,0ffffh
jz fl0101
mov ax,cs:[bx+2]
	mov cs:[seedc],bx
	xor [di],ax
xor [di+80],ax
xor [di+80*2],ax
fl0102:	ret
	align 4
fl0101:	mov cs:[seedc],di
jmp fl0102
	
	align 4
fl02:	;ﾊｴﾊｼﾞﾒﾙ with ｻﾞｯｿｳ
fl0203:	mov bp,cs:[p02c]
cmp bp,0fffeh
jnc fl0202
	mov bx,cs:[bp]
add bp,2
mov cs:[p02c],bp
	cmp bx,0fffeh
jz fl0201
jnc fl0202
	mov cx,cs:[bp]
add bp,2
mov cs:[p02c],bp
	mov ds,cs:[segw+2]
mov bp,cs:[hgsap]
mov si,cs:[bp]
	add bp,2
mov cs:[hgsap],bp
	mov ah,1
add cx,200
call chgsl
	jmp fl0203
	align 4
fl0202:	ret
	align 4
fl0201:	mov cs:[p02c],bx
jmp fl0202

	align 4
fl03:	;ﾈｺ ﾀﾁｻﾘﾅｶﾞﾗ ｸｿｦｽﾙ
	mov ax,cs:[p03c]
inc ax
mov cs:[p03c],ax
dec ax
cmp ax,40
jnz fl0306
	 mov word ptr cs:[hgsap],offset fad04
	 ;line(603,107)-(639,121),2,bf
	 mov bp,ax
	 mov ax,rseg+80*200/16
mov es,ax
	 mov di,80*107+74
mov bl,15
mov ax,0ffffh
mov dx,80-6
fl0307:	 mov cx,6/2
rep	 stosw
add di,dx
dec bl
jnz fl0307
fl0306:	mov bp,cs:[hgsap]
mov si,cs:[bp]
add bp,2
mov cs:[hgsap],bp
	cmp ax,14
jc fl0301
cmp ax,26
jc fl0302
	cmp ax,40
jc fl0303
cmp ax,47
jc fl0304
fl0305:	ret
	align 4
fl0301:	mov ds,cs:[segww+2]
	mov bx,27
mov cx,100+200
mov ah,1
call chgsl
jmp fl0305
	align 4
fl0302:	mov ds,cs:[segww+2]
	mov bx,11
mov cx,56+200
mov ah,1
call chgsl
jmp fl0305
	align 4
fl0303:	mov ds,cs:[segww+2]
	xor bx,bx
mov cx,56+200
mov ah,1
call chgsl
jmp fl0305
	align 4
fl0304:	mov ds,cs:[p02aw]
	mov bx,8
mov cx,104+200
mov ah,1
call chgsl
jmp fl0305

	align 4
fl04:	mov ax,cs:[p04c]
cmp ax,10
jnc fl0401
	inc ax
mov cs:[p04c],ax
	mov bp,cs:[hgsap]
mov si,cs:[bp]
add bp,2
mov cs:[hgsap],bp
	mov ds,cs:[segw+2]
mov bx,8
mov cx,104+200
mov ah,1
call chgsl
fl0401:	ret

	align 4
fl05:	mov ax,cs:[p05c]
cmp ax,80+28+6
jnc jfl0501
inc ax
mov cs:[p05c],ax
	mov ax,cs:[p05c2]
mov dx,ax
	inc ax
cmp ax,37+1
jc fl0502
sub ax,27
fl0502:	mov cs:[p05c2],ax
	cmp dx,31
jnc fl0503
	;
	mov bx,dx
add bx,bx
mov si,cs:[bx+offset fad06]
	mov ds,cs:[segww+2]
xor bx,bx
cmp dx,13
jnc fl0504
mov bx,8
fl0504:	mov cx,56+200
mov ah,1
call chgsl
	jmp fl0505
	align 4
jfl0501:	jmp fl0501
	align 4
fl0503:	;
	mov bx,dx
sub bx,31
add bx,bx
mov si,cs:[bx+offset fad07]
	mov ds,cs:[p04aw]
xor bx,bx
mov cx,56+200
mov ah,1
call chgsl
fl0505:	;ｱﾏｸﾞﾓ
	cmp cs:[p05c],80
jc fl0501
	mov ax,cs:[p05c3]
mov dx,ax
	inc ax
cmp cs:[p05c],80+28
jnc fl0506
	 cmp ax,19+1
jc fl0506
sub ax,11
fl0506:	mov cs:[p05c3],ax
	mov bx,dx
add bx,bx
mov si,cs:[bx+offset fad08]
	mov ds,cs:[p05aw]
mov bx,14
cmp dx,7
jc fl0507
	xor bx,bx
mov byte ptr cs:[sunsw],255
fl0507:	mov cx,0+200
mov ah,1
call chgsl
	;
fl0501:	ret

	align 4
fl06:	mov ax,cs:[p06c]
cmp ax,3
jnc fl0601
inc ax
mov cs:[p06c],ax
dec ax
	mov ds,cs:[segw+2]
	cmp ax,1
jc fl0602
jz fl0603
	mov si,cs:[offset fad09+4]
mov bx,5
mov cx,110+200
jmp fl0604
	align 4
fl0602:	mov si,cs:[offset fad09+0]
mov bx,29
mov cx,13+200

	mov byte ptr cs:[palsw],255
jmp fl0604
	align 4
fl0603:	mov si,cs:[offset fad09+2]
mov bx,9
mov cx,59+200
fl0604:	mov ah,1
call chgsl
fl0601:	ret

	align 4
fl07:	mov ax,cs:[p07c]
cmp ax,3+9
jnc fl0701
inc ax
mov cs:[p07c],ax
dec ax
	mov ds,cs:[p05aw2]
mov bx,ax
add bx,bx
mov si,cs:[bx+offset fad10]
	cmp ax,1
jc fl0702
jz fl0703
cmp ax,3
jc fl0704
	xor bx,bx
mov cx,90+200
jmp fl0705
	align 4
fl0702:	mov bx,35
mov cx,31+200
jmp fl0705
	align 4
fl0703:	mov bx,9
mov cx,60+200
jmp fl0705
	align 4
fl0704:	mov bx,9
mov cx,110+200
fl0705:	mov ah,1
call chgsl
fl0701:	ret

	align 4
fl08:	mov ax,cs:[p08c]
cmp ax,10
jnc fl0801
inc ax
mov cs:[p08c],ax
dec ax
	mov ds,cs:[segww+2]
mov bx,ax
add bx,bx
mov si,cs:[bx+offset fad11]
	xor bx,bx
mov cx,90+200
mov ah,1
call chgsl
fl0801:	ret

	align 4
fl09:	mov ax,cs:[p09c]
cmp ax,17+16
jnc fl0901
inc ax
mov cs:[p09c],ax
dec ax
	cmp ax,17
jnz fl0904
mov byte ptr cs:[sunsw],0
fl0904:	jnc fl0903
	mov ds,cs:[p08aw]
	mov bx,ax
add bx,bx
mov bx,cs:[bx+offset fl09t]
	mov si,cs:[bx+offset fad12]
	xor bx,bx
mov cx,0+200
mov ah,1
call chgsl
	;
fl0903:	mov ax,cs:[p09c2]
mov bx,ax
inc ax
cmp ax,9+1
jc fl0902
sub ax,10
fl0902:	mov cs:[p09c2],ax
	mov ds,cs:[segww+2]
add bx,bx
mov si,cs:[bx+offset fad11]
	xor bx,bx
mov cx,90+200
mov ah,1
call chgsl
fl0901:	ret

	align 4
fl10:	mov ax,cs:[p10c]
cmp ax,20
jnc fl1001
inc ax
mov cs:[p10c],ax
dec ax
	mov ds,cs:[segw+2]
mov bx,ax
cmp bx,10
jc fl1002
sub bx,10
fl1002:	add bx,bx
mov si,cs:[bx+offset fad13]
	mov bx,22
mov cx,66+200
mov ah,1
call chgsl
fl1001:	ret

	align 4
fl11:	mov ax,cs:[p11c]
cmp ax,10
jnc fl1101
inc ax
mov cs:[p11c],ax
dec ax
	mov ds,cs:[segww+2]
mov bx,ax
add bx,bx
mov si,cs:[bx+offset fad14]
	mov bx,22
mov cx,66+200
mov ah,1
call chgsl
fl1101:	ret

	align 4
fl12:	inc word ptr cs:[p12c]
jnz fl1203
dec word ptr cs:[p12c]
fl1203:	mov ax,cs:[p12c2]
mov dx,ax
inc ax
cmp ax,10
jc fl1202
xor ax,ax
fl1202:	mov cs:[p12c2],ax
	mov ds,cs:[segw+2]
mov bx,dx
add bx,bx
mov si,cs:[bx+offset fad15]
	mov bx,22
mov cx,66+200
mov ah,1
call chgsl
fl1201:	ret

	align 4
fl13:	mov ax,cs:[p13c]
cmp ax,56
jnc fl1301
inc ax
mov cs:[p13c],ax
	mov ax,cs:[p12c2]
mov dx,ax
inc ax
cmp ax,10
jc fl1302
xor ax,ax
fl1302:	mov cs:[p12c2],ax
	mov ds,cs:[segw+2]
mov bx,dx
add bx,bx
mov si,cs:[bx+offset fad15]
	mov bx,22
mov cx,66+200
mov ah,1
call chgsl
	;
	mov ax,gseg
mov ds,ax
mov di,cs:[p13fad]
mov cx,80*200/7/4+1
mov ax,7
fl1303:	stc
rcr byte ptr [di],1
add di,ax
	stc
rcr byte ptr [di],1
add di,ax
	stc
rcr byte ptr [di],1
add di,ax
	stc
rcr byte ptr [di],1
add di,ax
	loop fl1303
	mov bl,cs:[p13fc]
inc bl
cmp bl,8
jc fl1304
	 inc word ptr cs:[p13fad]
xor bl,bl
fl1304:	mov cs:[p13fc],bl
fl1301:	ret


	align 4
flje:	xor byte ptr cs:[dpla],0ffh
jz flo01
	call gm1
jmp flo02
	align 4
flo01:	call gm2
flo02:	pop di
pop si
pop bp
pop bx
pop dx
pop cx
pop es
pop ds
ret


	align 4
sunp:	cmp byte ptr cs:[sunsw],0
jnz sunp2
	mov bx,cs:[sunc]
add bx,2
cmp bx,28
jc sunp1
xor bx,bx
sunp1:	mov cs:[sunc],bx
	mov si,cs:[bx+offset fad16]
mov ds,cs:[segww]
	xor bx,bx
mov cx,200
mov ah,1
call chgsl
sunp2:	ret




	align 4
gm1:	mov ax,rseg
mov ds,ax
mov si,80*200
	mov ax,bseg
mov es,ax
xor di,di
mov cx,80*200/2
rep	movsw
	cmp byte ptr cs:[palsw],0
mov si,offset pal01c
jnz gm11
	mov si,offset pal01
gm11:	call pals
	ret
	
	align 4
gm2:	mov ax,rseg
mov ds,ax
mov si,80*200
		    mov es,ax
xor di,di
mov cx,80*200/2
rep	movsw
	cmp byte ptr cs:[palsw],0
mov si,offset pal02c
jnz gm21
	mov si,offset pal02
gm21:	call pals
	ret
	
	align 4
pals:	mov ax,cs
mov ds,ax
les di,dword ptr [palwo]
mov cx,48/2
rep	movsw
	mov ah,00100000b
pals1:	in al,0a0h
test al,ah
jnz pals1
pals2:	in al,0a0h
test al,ah
jz  pals2
	mov ah,4
mov dx,100
call chgsl
	ret



	align 4
evsi:	sti
push ax
	inc word ptr cs:[gvsic]
jz evsi1
evsir:	cmp byte ptr cs:[evsif],0
jnz evsi2
	cmp word ptr cs:[gvsic],vspeed
jnc evsi3
evsi2:	mov al,20h
out 0,al
out 64h,al
pop ax
jmp dword ptr cs:[i0a_adr]
	align 4
evsi1:	dec word ptr cs:[gvsic]
jmp evsir
	align 4
evsi3:	mov byte ptr cs:[evsif],255
	mov al,20h
out 0,al
out 64h,al
	mov word ptr cs:[gvsic],0 ; sub word ptr cs:[gvsic],vspeed
	call flow
	mov byte ptr cs:[evsif],0
	pop ax
jmp dword ptr cs:[i0a_adr]


	align 4
gvsi:	sti
push ax
	inc word ptr cs:[gvsic]
jz gvsi1
gvsir:	mov al,20h
out 0,al
pop ax
out 64h,al
jmp dword ptr cs:[i0a_adr]
	align 4
gvsi1:	dec word ptr cs:[gvsic]
jmp gvsir


	align 4
escc:	mov ax,0400h
int 18h
ror ah,1
jnc escc1
jmp memk
	align 4
escc1:	ret


	align 4
dspl:	mov ax,si
and ax,0fh
	shr si,1
shr si,1
shr si,1
shr si,1
mov bx,ds
add bx,si
mov ds,bx
	and ax,0fh
mov si,ax
ret

	align 4
espl:	mov ax,di
and ax,0fh
	shr di,1
shr di,1
shr di,1
shr di,1
mov bx,es
add bx,di
mov es,bx
	and ax,0fh
mov di,ax
ret

	align 4
filer:	;dx
	push es
push di
mov ax,cs
mov es,ax
mov di,[filenwl]
mov bx,dx
fnm01:	mov al,[bx]
inc bx
stosb
and al,al
jnz fnm01
	pop di
pop es
mov dx,offset filenw
	;
	mov ax,3d00h
int 21h
jnc fone
foe:	mov dx,offset emsg1
mov ah,9
int 21h
jmp memk
	align 4
fone:	mov [fh],ax
	;
	push ds
mov bx,[fh]
xor dx,dx
mov cx,8000h
fir1:	mov ds,si
mov ah,3fh
int 21h
jnc frne
fre:	mov ax,cs
mov ds,ax
mov dx,offset emsg3
mov ah,9
int 21h
jmp filec
	align 4
frne:	and ax,ax
jz fir3
	mov bp,ax
shr ax,1
shr ax,1
shr ax,1
shr ax,1
add si,ax
	test bp,0fh
jz fir2
inc si
fir2:	jmp fir1
	align 4
fir3:	pop ds
mov bx,[fh]
mov ah,3eh
int 21h
	mov [di],si
add di,2
ret


	align 4
prdx:	push ax
push cx
push dx
	mov al,dh
ror al,1
ror al,1
ror al,1
ror al,1
and al,0fh
call prdxs
	mov al,dh
and al,0fh
call prdxs
	mov al,dl
ror al,1
ror al,1
ror al,1
ror al,1
and al,0fh
call prdxs
	mov al,dl
and al,0fh
call prdxs
	pop dx
pop cx
pop ax
ret
	align 4
prdxs:	cmp al,10
jnc prdxs1
add al,'0'
jmp prdxs2
	align 4
prdxs1:	add al,'A'-10
prdxs2: mov cl,dl
mov dl,al
mov ah,6
int 21h
mov dl,cl
	ret


	align 4
filec:	mov bx,cs:[fh]
mov ah,3eh
int 21h

memk:	;mov es,cs:[paran]
mov ah,49h
int 21h
	mov ds,cs:[i0as]
mov dx,cs:[i0ao]
mov ax,250ah
int 21h
	in al,02h
and al,0fbh
out 02h,al
out 64h,al ; vsync on
	mov ax,cs
mov ds,ax
call riv
	xor al,al
out 7ch,al
call waith ; grcg off

	;mov al,cs:[gvrf]
out 0a6h,al
call waith
out 0a4h,al
call waith
	mov dx,50
mov ah,4
call chgsl
ret_dos: mov ax,0c00h
int 21h;key-ini
	xor ax,ax
mov ds,ax
mov al,cs:[m500]
mov ds:[500h],al
	mov ah,0ch
int 18h
	mov ax,4c00h
int 21h


	align 4
failr:	mov al,3
iret

	align 4
myin23:	iret

	align 4
chgsl:	jmp word ptr cs:[hgsladd]

	align 4
int40:	int 40h
ret
	align 4
int41:	int 41h
ret
	align 4
int42:	int 42h
ret
	align 4
int43:	int 43h
ret
	align 4
int44:	int 44h
ret
	align 4
int45:	int 45h
ret
	align 4
int46:	int 46h
ret
	align 4
int47:	int 47h
ret
	align 4
int48:	int 48h
ret
	align 4
int49:	int 49h
ret
	align 4
int4a:	int 4ah
ret
	align 4
int4b:	int 4bh
ret
	align 4
int4c:	int 4ch
ret
	align 4
int4d:	int 4dh
ret
	align 4
int4e:	int 4eh
ret
	align 4
int4f:	int 4fh
ret
	align 4
int50:	int 50h
ret
	align 4
int51:	int 51h
ret
	align 4
int52:	int 52h
ret
	align 4
int53:	int 53h
ret
	align 4
int54:	int 54h
ret
	align 4
int55:	int 55h
ret
	align 4
int56:	int 56h
ret
	align 4
int57:	int 57h
ret
	align 4
int58:	int 58h
ret
	align 4
int59:	int 59h
ret
	align 4
int5a:	int 5ah
ret
	align 4
int5b:	int 5bh
ret
	align 4
int5c:	int 5ch
ret
	align 4
int5d:	int 5dh
ret
	align 4
int5e:	int 5eh
ret
	align 4
int5f:	int 5fh
ret
	align 4
int60:	int 60h
ret
	align 4
int61:	int 61h
ret
	align 4
int62:	int 62h
ret
	align 4
int63:	int 63h
ret
	align 4
int64:	int 64h
ret
	align 4
int65:	int 65h
ret
	align 4
int66:	int 66h
ret
	align 4
int67:	int 67h
ret
	align 4
int68:	int 68h
ret
	align 4
int69:	int 69h
ret
	align 4
int6a:	int 6ah
ret
	align 4
int6b:	int 6bh
ret
	align 4
int6c:	int 6ch
ret
	align 4
int6d:	int 6dh
ret
	align 4
int6e:	int 6eh
ret
	align 4
int6f:	int 6fh
ret
	align 4
int70:	int 70h
ret
	align 4
int71:	int 71h
ret
	align 4
int72:	int 72h
ret
	align 4
int73:	int 73h
ret
	align 4
int74:	int 74h
ret
	align 4
int75:	int 75h
ret
	align 4
int76:	int 76h
ret
	align 4
int77:	int 77h
ret
	align 4
int78:	int 78h
ret
	align 4
int79:	int 79h
ret
	align 4
int7a:	int 7ah
ret
	align 4
int7b:	int 7bh
ret
	align 4
int7c:	int 7ch
ret
	align 4
int7d:	int 7dh
ret
	align 4
int7e:	int 7eh
ret
	align 4
int7f:	int 7fh
ret



	align 4
sbc:	;ｻｳﾝﾄﾞﾎﾞｰﾄﾞ ﾁｪｯｸ
vsy1:	in al,0a0h
test al,00100000b
jz  vsy1
vsy2:	in al,0a0h
test al,00100000b
jnz vsy2
vsy3:	in al,0a0h
test al,00100000b
jz  vsy3
	mov word ptr [port],0
	xor ax,ax
mov es,ax
test byte ptr es:[0501h],80h
jnz t8m
	mov ax,ti10t
mov bx,ti10m
jmp tmse
	align 4
t8m:	mov ax,ti08t
mov bx,ti08m
tmse:	mov [timen],ax
mov [coum],bx
sb1c:	;ｻｳﾝﾄﾞﾎﾞｰﾄﾞ1 ﾁｪｯｸ
	mov dx,088h+0
in al,dx
rol al,1
jc sb1c2
	 xor al,al
out dx,al
call waith
add dx,2
in al,dx
	 xor al,1
mov ah,al
out dx,al
call waith
in al,dx
cmp al,ah
jnz sb1c2
	 xor al,1
mov ah,al
out dx,al
call waith
in al,dx
cmp al,ah
jnz sb1c2
	 sub dx,2
jmp sb1c1
	align 4
sb1c2:	mov dx,188h+0
in al,dx
rol al,1
jc sbce
	 xor al,al
out dx,al
call waith
add dx,2
in al,dx
	 xor al,1
mov ah,al
out dx,al
call waith
in al,dx
cmp al,ah
jnz sbce
	 xor al,1
mov ah,al
out dx,al
call waith
in al,dx
cmp al,ah
jnz sbce
	 sub dx,2
	;found
sb1c1:	mov [port],dx
	mov cx,07b8h
call fmout
	mov cx,0f80h
call fmout
sbce:	ret


	align 4
siv:	cmp word ptr [port],0
jz beeia
	mov cx,0000h
call fmout
	mov cx,0100h
call fmout
	mov cx,0200h
call fmout
	mov cx,0300h
call fmout
	mov cx,0400h
call fmout
	mov cx,0500h
call fmout
	mov dx,offset pcmp
	jmp iase
	align 4
beeia:	mov al,01110000b
out 77h,al
call waith
mov al,6
out 37h,al
	mov dx,offset pcmb
iase:	cli
	mov al,00110100b
out 77h,al
	mov ax,3508h
int 21h
mov [tis],es
mov [tio],bx
	mov ax,2508h
int 21h
	mov ax,[timen]
out 71h,al
call waith
mov al,ah
out 71h,al
	in al,2
or al,1
out 2,al
sti
	mov byte ptr [lbitf],0
	ret


	align 4
riv:	cli
mov bx,ds
mov ds,cs:[tis]
mov dx,cs:[tio]
mov ax,2508h
	int 21h
mov ds,bx
	in al,2
or al,1
out 2,al
sti
sb1pe:	cmp word ptr [port],0
jz sb0pe
	mov cx,0800h
call fmout
	mov cx,0900h
call fmout
	mov cx,0a00h
call fmout
	jmp sbee
	align 4
sb0pe:	mov al,7
out 37h,al
mov al,01110110b
out 77h,al
call waith
	mov dx,3fdbh
xor ax,ax
mov es,ax
test byte ptr es:[0501h],80h
jnz t8be
	mov ax,1229
jmp bese
	align 4
t8be:	mov ax, 998
bese:	out dx,al
call waith
mov al,ah
out dx,al
sbee:	ret
	align 4
fmout:	mov dx,cs:[port]
fmo11:	in al,dx
test al,80h
jnz fmo11
	mov al,ch
out dx,al
call waith
fmo12:	in al,dx
test al,80h
jnz fmo12
	add dx,2
mov al,cl
out dx,al
call waith
	ret

	align 4
waith:	push ax
mov ah,01000000b
waith1:	in al,0a0h
test al,ah
jnz waith1
waith2:	in al,0a0h
test al,ah
jz  waith2
waith3:	in al,0a0h
test al,ah
jnz waith3
	pop ax
ret

	align 4
wait5f:	out 5fh,al
out 5fh,al
out 5fh,al
out 5fh,al
ret


	align 4
pcmp:	push ax
push bx
push dx
mov dx,ds
	inc cs:[timec]
jnz pcmp01
inc cs:[timec2]
	;
pcmp01:	lds bx,dword ptr cs:[bpoio]
	mov al,[bx]
mov ds,dx
xor byte ptr cs:[lbitf],0ffh
jz pcmp02
	shr al,1
shr al,1
shr al,1
shr al,1
jmp pcmp03
	align 4
pcmp02:	and al,0fh
	inc bx
and bx,15
jnz pcmp04
	inc word ptr cs:[bpoi]
	mov dx,cs:[bpoi]
sub dx,cs:[bpoim]
jnc pcmp05
pcmp04:	mov cs:[bpoio],bx
pcmp03:	xor ah,ah
add ax,ax
add ax,ax
add ax,offset psgt4
mov bx,ax
	mov dx,cs:[port]
	mov al, 8
out dx,al
mov ax,cs:[bx]    
add dl,2
out dx,al
sub dl,2
	mov al, 9
out dx,al
mov al,ah
add bx,2
add dl,2
out dx,al
sub dl,2
	mov al,10
out dx,al
mov al,cs:[bx]    
add dl,2
out dx,al
	;
	pop dx
pop bx
	mov al,20h
out 0,al
pop ax
iret
	align 4
pcmp05:	mov ah,al
in al,2
or al,1
out 2,al
mov al,ah
jmp pcmp04


	align 4
pcmb:	push ax
push bx
push dx
mov dx,ds
	inc cs:[timec]
jnz pcmb01
inc cs:[timec2]
pcmb01:	lds bx,dword ptr cs:[bpoio]
	mov al,[bx]
xor byte ptr cs:[lbitf],0ffh
jz pcmb02
	and al,0f0h
jmp pcmb03
	align 4
pcmb02:	add al,al
add al,al
add al,al
add al,al
pcmb03:	xor ah,ah
mov ds,dx
	mul word ptr cs:[coum]
mov al,ah
mov ah,dl
inc ax
	mov dx,3fdbh
out dx,al
out 5fh,al
mov al,ah
out dx,al
	cmp cs:[lbitf],0
jnz pcmb05
inc bx
jz pcmb06
pcmb04:	mov cs:[bpoio],bx
	shr bx,1
shr bx,1
shr bx,1
shr bx,1
add bx,cs:[bpoi]
sub bx,cs:[bpoim]
	jnc pcmb07
pcmb05:	pop dx
pop bx
	mov al,20h
out 0,al
pop ax
iret
	align 4
pcmb06:	add word ptr cs:[bpoi],1000h
jmp pcmb04
	align 4
pcmb07:	mov ax,cs:[bpoim]
mov cs:[bpoi],ax
mov word ptr cs:[bpoio],0
	in al,2
or al,1
out 2,al
jmp pcmb05






	even
port	dw 	?
timen	dw	?
coum	dw	?
tis	dw	?
tio	dw	?
timec	dw	?
timec2	dw	?
bpoio	dw	?
bpoi	dw	?
bpoim	dw	?
gvsic	dw	?
lbitf	db	?
m500	db	?

	;db ?;even?
fh	dw	?
hgsladd	dw	?
pwo	dw	?
pws	dw	?
i0a_adr	label	dword
i0ao	dw	?
i0as	dw	?
paran	dw	?	;ﾊﾞｯﾌｧ seg
segw	dw	20 dup (?)


palwo	dw	?
palws	dw	?
segww	dw	3 dup (?)

sunc	dw	?
seedc	dw	?
p02c	dw	?
p02aw	dw	?
hgsap	dw	?
p03c	dw	?
p04c	dw	?
p04aw	dw	?
p05c	dw	?
p05c2	dw	?
p05c3	dw	?
p05aw	dw	?
p05aw2	dw	?
p05pw1	dw	?
p05pw2	dw	?
p06c	dw	?
p07c	dw	?
p08c	dw	?
p08aw	dw	?
p09c	dw	?
p09c2	dw	?
p10c	dw	?
p11c	dw	?
p12c	dw	?
p12c2	dw	?
p13c	dw	?
p13fad	dw	?
p13fc	db	?
dpla	db	?
floc	db	?
sunsw	db	?
palsw	db	?
evsif	db	?


	;db ?;even?
filenwl	dw	?
filenw	db	80 dup (?)
	dw	128 dup (?)	;ｽﾀｯｸ ﾜｰｸ
spwe:


program_end	label	byte
code	ends
end start
