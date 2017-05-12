LABEL_B12_8000:
	push hl
	push de
	push bc
	call LABEL_B12_802D
	ld b, $0F
	ld hl, $C00E
	xor a
-:	
	ld (hl), a
	ld de, $0018
	add hl, de
	ld (hl), a
	inc hl
	ld (hl), a
	inc hl
	ld (hl), a
	ld de, $0006
	add hl, de
	djnz -
	pop bc
	pop de
	pop hl

LABEL_B12_801F:
	push hl
	push bc
	ld hl, LABEL_B12_803B
	ld c, Port_PSG
	ld b, $08
	otir
	pop bc
	pop hl
	ret

LABEL_B12_802D:
	xor a
	ld hl, $C003
	ld (hl), a
	ld de, $C004
	ld bc, $000A
	ldir
	ret

LABEL_B12_803B:
.db	$80, $00, $A0, $00, $C0
.db $00, $E5, $FF

LABEL_B12_8043:
	ld hl, $C00C
	exx
	call LABEL_B12_80C9
	call LABEL_B12_80F0
	call LABEL_B12_82EF
	call LABEL_B12_80A4
	ld a, ($C002)
	or a
	jp m, ++
	ld ix, $C06E
	ld b, $07
--:	
	push bc
	ld a, $04
	cp b
	jr z, +
	bit 7, (ix+0)
	call nz, LABEL_B12_8772
-:	
	ld de, $0020
	add ix, de
	pop bc
	djnz --
	ret

+:	
	bit 7, (ix+0)
	call nz, LABEL_B12_86D0
	jr -

++:	
	ld ix, $C0EE
	ld b, $08
--:	
	push bc
	ld a, $01
	cp b
	jr z, +
	bit 7, (ix+0)
	call nz, LABEL_B12_8772
-:	
	ld de, $0020
	add ix, de
	pop bc
	djnz --
	ret

+:	
	bit 7, (ix+0)
	call nz, LABEL_B12_86D0
	jr -

LABEL_B12_80A4:	
	ld hl, $C12E
	bit 7, (hl)
	ret z
	ld a, ($C10E)
	or a
	jp m, ++
	bit 6, (hl)
	jr z, +
	inc hl
	ld a, (hl)
	cp $E0
	jr nz, +
	ld hl, $C06E
	set 2, (hl)
+:	
	ld hl, $C0AE
	set 2, (hl)
	ret

++:	
	set 2, (hl)
	ret

LABEL_B12_80C9:	
	ld hl, $C001
	ld a, (hl)
	or a
	ret z
	dec (hl)
	ret nz
	ld a, ($C002)
	or a
	res 7, a
	ld (hl), a
	ld hl, $C018
	ld de, $0020
	ld b, $07
	jp m, LABEL_B12_80EB
	ld hl, $C158
	ld de, $0020
	ld b, $05
LABEL_B12_80EB:	
	inc (hl)
	add hl, de
	djnz LABEL_B12_80EB
	ret

LABEL_B12_80F0:	
	ld a, ($C00A)
	or a
	ret z
	jp m, LABEL_B12_8155
	ld a, ($C00B)
	dec a
	jr z, +
	ld ($C00B), a
	ret

+:	
	ld a, ($C009)
	ld ($C00B), a
	ld a, ($C00A)
	inc a
	cp $0C
	ld ($C00A), a
	jr nz, ++
	xor a
	ld ($C00A), a
	ld a, ($C002)
	cp $7F
	jr nz, +
	ld a, $85
	jp LABEL_B12_832F

+:	
	or a
	jp p, LABEL_B12_8000
	ld a, ($C006)
	or a
	ret z
	jp LABEL_B12_8196

++:	
	ld ix, $C00E
	ld de, $0020
	ld b, $06
	ld a, ($C002)
	or a
	jp p, LABEL_B12_8145
	ld ix, $C14E
	ld b, $04
LABEL_B12_8145:	
	ld a, (ix+8)
	inc a
	cp $10
	jr z, +
	ld (ix+8), a
+:	
	add ix, de
	djnz LABEL_B12_8145
	ret

LABEL_B12_8155:	
	ld a, ($C00B)
	dec a
	jr z, +
	ld ($C00B), a
	ret

+:	
	ld a, $0A
	ld ($C00B), a
	ld a, ($C00A)
	inc a
	cp $8B
	ld ($C00A), a
	jr nz, +
	xor a
	ld ($C00A), a
	ld hl, $C0CE
	res 2, (hl)
	ret

+:	
	ld ix, $C00E
	ld de, $0020
	ld b, $06
-:	
	ld a, (ix+8)
	dec a
	jp m, +
	cp (ix+23)
	jr c, +
	ld (ix+8), a
+:	
	add ix, de
	djnz -
	ret


LABEL_B12_8196:	
	call LABEL_B12_801F
	ld a, ($C005)
	ld ($C002), a
	ld a, $80
	ld ($C00A), a
	ld a, $0A
	ld ($C00B), a
	ld hl, $C0CE
	set 2, (hl)
	push ix
	ld ix, $C00E
	ld b, $06
	ld de, $0020
-:	
	ld a, (ix+8)
	ld (ix+23), a
	ld a, $09
	ld (ix+8), a
	add ix, de
	djnz -
	pop ix
	jp LABEL_B12_8420


LABEL_B12_81CD:	
	ld a, $0A
	ld ($C00B), a
	ld ($C009), a
LABEL_B12_81D5:	
	ld a, $03
	ld ($C00A), a
	ld a, ($C002)
	or a
	jp m, +
	xor a
	ld ($C0CE), a
+:	
	ld a, $FF
	out (Port_PSG), a
	xor a
	ld ($C1CE), a
	jp LABEL_B12_8420


LABEL_B12_81F0:	
	ld hl, $C12E
	bit 7, (hl)
	jp z, LABEL_B12_8420
	xor a
	ld (hl), a
	ld a, $DF
	out (Port_PSG), a
	ld a, $FF
	out (Port_PSG), a
	jp LABEL_B12_8420


LABEL_B12_8205:	
	ld a, ($C002)
	cp $7F
	jp z, LABEL_B12_81CD
	ld a, $80
	ld ($C006), a
	jp LABEL_B12_81CD


LABEL_B12_8215:	
	xor a
	ld ($C10E), a
	ld ($C0EE), a
	ld hl, $C08E
	call +
	ld hl, $C1AE
	call +
	ld hl, LABEL_B12_803B
	ld c, Port_PSG
	ld b, $08
	otir
	jp LABEL_B12_8420

+:	
	ld de, $0020
	ld b, $03
-:	
	res 2, (hl)
	add hl, de
	djnz -
	ret


LABEL_B12_823F:	
.db $00, $00, $00, $00, $00, $00, $03, $00, $80, $80, $00, $00, $80, $80, $00, $00
.db $00, $7F, $7F, $00


LABEL_B12_8253:	
.dw	LABEL_B12_9E6C
.dw	LABEL_B12_9E91
.dw	LABEL_B12_9EB6
.dw	LABEL_B12_9EDB
.dw	LABEL_B12_9F00
.dw	LABEL_B12_9F25
.dw	LABEL_B12_9F4A
.dw	LABEL_B12_9F66
.dw	LABEL_B12_9F8B
.dw	LABEL_B12_9FB9
.dw	LABEL_B12_9FE7
.dw	LABEL_B12_A00C
.dw	LABEL_B12_A031
.dw	LABEL_B12_A05F
.dw	LABEL_B12_A08D
.dw	LABEL_B12_A0B2
.dw	LABEL_B12_A0B2
.dw	LABEL_B12_A0D7
.dw	LABEL_B12_A0FC
.dw	LABEL_B12_A121


LABEL_B12_827B:	
.dw	LABEL_B12_A13E
.dw	LABEL_B12_A156
.dw	LABEL_B12_A17E
.dw	LABEL_B12_A19E
.dw	LABEL_B12_A1D2
.dw	LABEL_B12_A1FF
.dw	LABEL_B12_A22C
.dw	LABEL_B12_A265
.dw	LABEL_B12_A22C
.dw	LABEL_B12_A281
.dw	LABEL_B12_A2C7
.dw	LABEL_B12_A2F1
.dw	LABEL_B12_A30D
.dw	LABEL_B12_A328
.dw	LABEL_B12_A357
.dw	LABEL_B12_A380
.dw	LABEL_B12_A3C4
.dw	LABEL_B12_A3E7
.dw	LABEL_B12_A423
.dw	LABEL_B12_A43A
.dw	LABEL_B12_A455
.dw	LABEL_B12_A468
.dw	LABEL_B12_A47D
.dw	LABEL_B12_A47D
.dw	LABEL_B12_A494
.dw	LABEL_B12_A4F6
.dw	LABEL_B12_A526
.dw	LABEL_B12_A543
.dw	LABEL_B12_A556
.dw	LABEL_B12_A57B
.dw	LABEL_B12_A59E
.dw	LABEL_B12_A5AC
.dw	LABEL_B12_A5CD
.dw	LABEL_B12_A5F3
.dw	LABEL_B12_A611
.dw	LABEL_B12_A63E
.dw	LABEL_B12_A63E
.dw	LABEL_B12_A651
.dw	LABEL_B12_A670
.dw	LABEL_B12_A69F
.dw	LABEL_B12_A6DD
.dw	LABEL_B12_A722
.dw	LABEL_B12_A76F
.dw	LABEL_B12_A794
.dw	LABEL_B12_A7C1
.dw	LABEL_B12_A7EE
.dw	LABEL_B12_A812
.dw	LABEL_B12_A840


LABEL_B12_82DB:	
.dw	LABEL_B12_A455
.dw	LABEL_B12_A468
.dw	LABEL_B12_A47D
.dw	LABEL_B12_A47D
.dw	LABEL_B12_A47D


LABEL_B12_82E5:	
.dw	LABEL_B12_8215
.dw	LABEL_B12_81F0
.dw	LABEL_B12_81CD
.dw	LABEL_B12_8205
.dw	LABEL_B12_8196

LABEL_B12_82EF:	
	ld a, ($C004)
	bit 7, a
	jp z, LABEL_B12_8000
	cp $A0
	jr c, LABEL_B12_832F
	cp $D0
	jp c, LABEL_B12_8389
	cp $D5
	jp c, +
	cp $DA
	jp nc, LABEL_B12_8000
	sub $D5
	add a, a
	ld c, a
	ld b, $00
	ld hl, LABEL_B12_82E5
	add hl, bc
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	jp (hl)

+:	
	sub $D0
	ld hl, LABEL_B12_82DB
	call LABEL_B12_8426
	ld de, $C12E
	ld a, $FF
	out (Port_PSG), a
	ld a, $DF
	out (Port_PSG), a
	jp LABEL_B12_83F4

LABEL_B12_832F:	
	cp $95
	jp nc, LABEL_B12_8420
	sub $81
	ret m
	ld b, $00
	ld c, a
	ld hl, LABEL_B12_823F
	add hl, bc
	push af
	ld a, ($C002)
	and $7F
	ld ($C005), a
	ld a, (hl)
	ld ($C001), a
	ld ($C002), a
	push af
	ld a, ($C00A)
	or a
	jp p, +
	ld ix, $C00E
	ld de, $0020
	ld b, $06
-:	
	ld a, (ix+23)
	ld (ix+8), a
	add ix, de
	djnz -
+:	
	call LABEL_B12_802D
	call LABEL_B12_801F
	pop af
	ld de, $C14E
	or a
	jp m, +
	call LABEL_B12_8000
	ld de, $C06E
+:	
	ld hl, LABEL_B12_8253
	jr +

+:	
	pop af
	call LABEL_B12_8426
	jp LABEL_B12_83F4

LABEL_B12_8389:	
	sub $A0
	ld hl, LABEL_B12_827B
	call LABEL_B12_8426
	ld h, b
	ld l, c
	inc hl
	inc hl
	ld a, (hl)
	cp $C0
	jr z, ++
	cp $E0
	jr z, +
	cp $A0
	jr z, +++
	push bc
	call LABEL_B12_8000
	pop bc
	ld de, $C06E
	jr LABEL_B12_83F4

+:	
	ld a, $DF
	out (Port_PSG), a
	ld hl, $C0CE
	set 2, (hl)
	ld a, $E7
	out (Port_PSG), a
++:	
	ld de, $C10E
	jr ++++

+++:	
	ld de, $0009
	add hl, de
	ld a, (hl)
	cp $E0
	jr nz, +
	ld a, $E7
	out (Port_PSG), a
	ld hl, $C0CE
	set 2, (hl)
	ld hl, $C1CE
	set 2, (hl)
	ld a, $DF
	out (Port_PSG), a
+:	
	ld de, $C0EE
	ld hl, $C08E
	set 2, (hl)
	ld hl, $C18E
	set 2, (hl)
++++:	
	ld a, $FF
	out (Port_PSG), a
	ld hl, $C0AE
	set 2, (hl)
	ld hl, $C1AE
	set 2, (hl)
LABEL_B12_83F4:	
	ld h, b
	ld l, c
	ld b, (hl)
	inc hl
-:	
	push bc
	push hl
	pop ix
	ld bc, $0009
	ldir
	ld a, $20
	ld (de), a
	inc de
	ld a, $01
	ld (de), a
	inc de
	xor a
	ld (de), a
	inc de
	ld (de), a
	inc de
	ld (de), a
	push hl
	ld hl, $0013
	add hl, de
	ex de, hl
	pop hl
	ld bc, +	; Overriding return address
	push bc
	jp LABEL_B12_8867

+:	
	pop bc
	djnz -
LABEL_B12_8420:	
	ld a, $80
	ld ($C004), a
	ret

LABEL_B12_8426:	
	add a, a
	ld b, $00
	ld c, a
	add hl, bc
	ld c, (hl)
	inc hl
	ld b, (hl)
	ret

LABEL_B12_842F:	
	ld c, a
	ld b, $00
	add hl, bc
	add hl, bc
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	ret

-:	
	ld (ix+13), a
LABEL_B12_843C:	
	push hl
	ld c, (ix+13)
	ld b, $00
	add hl, bc
	ld c, l
	ld b, h
	pop hl
	ld a, (bc)
	bit 7, a
	jp z, +++
	cp $83
	jr z, +
	cp $80
	jr z, ++
	ld a, $FF
	ld (ix+20), a
	pop hl
	ret

+:	
	inc bc
	ld a, (bc)
	jr -

++:	
	xor a
	jr -

+++:	
	inc (ix+13)
	ld l, a
	ld h, $00
	add hl, de
	ld (ix+16), a
	ret

LABEL_B12_846D:	
	ld e, (ix+3)
	ld d, (ix+4)
LABEL_B12_8473:	
	ld a, (de)
	inc de
	cp $E0
	jp nc, LABEL_B12_8519
	bit 3, (ix+0)
	jp nz, LABEL_B12_84E8
	cp $80
	jp c, LABEL_B12_84BF
	jr nz, +
+:	
	call LABEL_B12_8509
	ld a, (hl)
	ld (ix+14), a
	inc hl
	ld a, (hl)
	ld (ix+15), a
LABEL_B12_8494:	
	bit 5, (ix+0)
	jp z, +
	ld a, (de)
	inc de
	ld (ix+18), a
	ld (ix+17), a
	bit 3, (ix+0)
	ld a, (de)
	jr nz, ++
	ld (ix+17), a
	inc de
	ld a, (de)
	jr ++

+:	
	ld a, (de)
	or a
	jp p, ++
	ld a, (ix+21)
	ld (ix+10), a
	jr LABEL_B12_84CF

++:	
	inc de
LABEL_B12_84BF:	
	ld b, (ix+2)
	dec b
	jr z, +
	ld c, a
-:	
	add a, c
	djnz -
+:	
	ld (ix+10), a
	ld (ix+21), a
LABEL_B12_84CF:	
	xor a
	ld (ix+12), a
	ld (ix+13), a
	ld (ix+11), a
	ld (ix+19), a
	ld (ix+20), a
	ld (ix+3), e
	ld (ix+4), d
	ld a, $80
	ret

LABEL_B12_84E8:	
	ld h, a
	ld a, (de)
	inc de
	ld l, a
	ld a, (ix+5)
	or a
	jr z, +++
	jp p, +
	add a, l
	jr c, ++
	dec h
	jr ++

+:	
	add a, l
	jr nc, ++
	inc h
++:	
	ld l, a
+++:	
	ld (ix+14), l
	ld (ix+15), h
	jp LABEL_B12_8494

LABEL_B12_8509:	
	sub $80
	jr z, +
	add a, (ix+5)
+:	
	ld hl, LABEL_B12_8874
	ld c, a
	ld b, $00
	add hl, bc
	add hl, bc
	ret

LABEL_B12_8519:	
	ld hl, +	; Overriding return address
LABEL_B12_851C:	
	push hl
	sub $EE
	ld hl, LABEL_B12_8530
	add a, a
	ld c, a
	ld b, $00
	add hl, bc
	ld c, (hl)
	inc hl
	ld h, (hl)
	ld l, c
	jp (hl)

+:	
	inc de
	jp LABEL_B12_8473


LABEL_B12_8530:	
.dw	LABEL_B12_855E
.dw	LABEL_B12_8566
.dw	LABEL_B12_857E
.dw	LABEL_B12_8554
.dw	LABEL_B12_8627
.dw	LABEL_B12_85AD
.dw	LABEL_B12_85CA
.dw	LABEL_B12_85C1
.dw	LABEL_B12_85E7
.dw	LABEL_B12_86B5
.dw	LABEL_B12_8687
.dw	LABEL_B12_86A2
.dw	LABEL_B12_85A0
.dw	LABEL_B12_8595
.dw	LABEL_B12_85ED
.dw	LABEL_B12_8618
.dw	LABEL_B12_8566
.dw	LABEL_B12_8566


LABEL_B12_8554:	
	ld a, (de)
	ld ($C009), a
	ld ($C00B), a
	jp LABEL_B12_81D5


LABEL_B12_855E:	
	ld a, (de)
	add a, (ix+2)
	ld (ix+2), a
	ret


LABEL_B12_8566:	
	ld a, ($C00A)
	or a
	jp m, +
	ld a, (de)
	add a, (ix+8)
	jp ++

+:	
	ld a, (de)
	add a, (ix+23)
	and $0F
	ld (ix+23), a
	ret


LABEL_B12_857E:	
	ld a, (de)
	cp $01
	jr z, +
	res 0, (ix+7)
	res 1, (ix+7)
	ret

+:	
	set 0, (ix+7)
	set 1, (ix+7)
	ret


LABEL_B12_8595:	
	ld a, (de)
	inc de
	jr +

+:	
	add a, (ix+5)
	ld (ix+5), a
	ret


LABEL_B12_85A0:	
	ld a, (de)
	ld (ix+2), a
	ret

++:	
	and $0F
	ld (ix+8), a
	jp LABEL_B12_8867


LABEL_B12_85AD:	
	ld a, (de)
	or $E0
	out (Port_PSG), a
	or $FC
	inc a
	jr nz, +
	res 6, (ix+0)
	ret

+:	
	set 6, (ix+0)
	ret


LABEL_B12_85C1:	
	ld a, (de)
	inc de
	cp $80
	ret z
	ld (ix+7), a
	ret


LABEL_B12_85CA:	
	ld a, (de)
	ld (ix+6), a
	ret


LABEL_B12_85CF:
	ld b, 0
	ld c, $1C
	push ix
	pop hl
	add hl, bc
	ld a, (hl)
	or a
	jr nz, +
	ld a, (de)
	dec a
	ld (hl), a
	inc de
	inc de
	ret

+:
	inc de
	dec (hl)
	jr z, LABEL_B12_85E7
	inc de
	ret

	
LABEL_B12_85E7:	
	ex de, hl
	ld e, (hl)
	inc hl
	ld d, (hl)
	dec de
	ret


LABEL_B12_85ED:	
	ld a, (de)
	cp $01
	jr nz, +
	set 5, (ix+0)
	ld a, (ix+1)
	ld a, (ix+8)
	or a
	ret z
	dec (ix+8)
	dec (ix+8)
	ret

+:	
	res 5, (ix+0)
	ld a, (ix+1)
	ld a, (ix+8)
	or a
	ret z
	inc (ix+8)
	inc (ix+8)
	ret


LABEL_B12_8618:	
	ld a, (de)
	cp $01
	jr nz, +
	set 3, (ix+0)
	ret

+:	
	res 3, (ix+0)
	ret


LABEL_B12_8627:	
	ld hl, $C12E
	res 2, (hl)
	xor a
	ld ($C008), a
	ld (ix+0), a
	ld a, (ix+1)
	add a, $1F
	out (Port_PSG), a
	ld a, $E5
	out (Port_PSG), a
	ld a, ($C08E)
	and $80
	jr z, +
	ld hl, $C09C
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	ld a, ($C08F)
	call LABEL_B12_8812
	ld hl, $C08E
	res 2, (hl)
+:	
	ld hl, $C18E
	res 2, (hl)
	ld hl, $C1CE
	res 2, (hl)
	ld hl, $C0CE
	res 2, (hl)
	ld a, ($C0AE)
	and $80
	jr z, +
	ld hl, $C0BC
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	ld a, ($C0AF)
	call LABEL_B12_8812
	ld hl, $C0AE
	res 2, (hl)
+:	
	ld hl, $C1AE
	res 2, (hl)
	pop hl
	pop hl
	ret


LABEL_B12_8687:	
	ld a, (de)
	ld c, a
	inc de
	ld a, (de)
	ld b, a
	push bc
	push ix
	pop hl
	dec (ix+9)
	ld c, (ix+9)
	dec (ix+9)
	ld b, $00
	add hl, bc
	ld (hl), d
	dec hl
	ld (hl), e
	pop de
	dec de
	ret


LABEL_B12_86A2:	
	push ix
	pop hl
	ld c, (ix+9)
	ld b, $00
	add hl, bc
	ld e, (hl)
	inc hl
	ld d, (hl)
	inc (ix+9)
	inc (ix+9)
	ret


LABEL_B12_86B5:	
	ld a, (de)
	inc de
	add a, $18
	ld c, a
	ld b, $00
	push ix
	pop hl
	add hl, bc
	ld a, (hl)
	or a
	jr nz, +
	ld a, (de)
	ld (hl), a
+:	
	inc de
	dec (hl)
	jp nz, LABEL_B12_85E7
	inc de
	ret

LABEL_B12_86CD:
	push hl
	pop hl
	ret

LABEL_B12_86D0:	
	inc (ix+11)
	ld a, (ix+10)
	sub (ix+11)
	call z, +
	bit 2, (ix+0)
	ret nz
	bit 4, (ix+19)
	ret nz
	ld a, (ix+7)
	dec a
	ret m
	ld hl, LABEL_B12_A877
	call LABEL_B12_842F
	call LABEL_B12_8827
	or $F0
	out (Port_PSG), a
	ret

+:	
	ld e, (ix+3)
	ld d, (ix+4)
-:	
	ld a, (de)
	inc de
	cp $E0
	jp nc, +
	cp $80
	jp c, LABEL_B12_84BF
	call ++
	ld a, (de)
	inc de
	cp $80
	jp c, LABEL_B12_84BF
	dec de
	ld a, (ix+21)
	ld (ix+10), a
	jp LABEL_B12_84CF


LABEL_B12_871F:
	dec de
	jp LABEL_B12_84CF

+:	
	ld hl, +	; Overriding return address
	jp LABEL_B12_851C

+:	
	inc de
	jp -

++:	
	bit 3, a
	jr nz, +
	bit 5, a
	jr nz, ++
	bit 1, a
	jr nz, ++
	bit 0, a
	jr nz, +++
	bit 2, a
	jr nz, +++
	ld (ix+7), $00
	ld a, $FF
	out (Port_PSG), a
	ret

+:	
	ex af, af'
	ld a, $02
	ld b, $04
	jr ++++

++:	
	ld c, $04
	bit 0, a
	jr nz, +
	ld c, $03
+:	
	ex af, af'
	ld a, c
	ld b, $05
	jr ++++

+++:	
	ex af, af'
	ld a, $01
	ld b, $06
++++:	
	ld (ix+7), a
	ex af, af'
	bit 2, a
	jr z, +
	dec b
	dec b
+:	
	ld (ix+8), b
	ret

LABEL_B12_8772:	
	inc (ix+11)
	ld a, (ix+10)
	sub (ix+11)
	call z, LABEL_B12_846D
	ld ($C00C), a
	cp $80
	jp z, +++
	bit 5, (ix+0)
	jp z, +++
	exx
	ld (hl), $80
	exx
	ld a, (ix+18)
	bit 7, a
	jr z, +
	add a, (ix+14)
	jr c, ++
	dec (ix+15)
	jr ++

+:	
	add a, (ix+14)
	jr nc, ++
	inc (ix+15)
++:	
	ld (ix+14), a
+++:	
	bit 2, (ix+0)
	ret nz
	ld a, (ix+19)
	cp $1F
	ret z
	jr nz, +
+:	
	ld a, (ix+19)
	cp $FF
	jp z, +
	ld a, (ix+7)
	dec a
	jp m, +
	ld hl, LABEL_B12_A877
	call LABEL_B12_842F
	call LABEL_B12_8827
	or (ix+1)
	add a, $10
	out (Port_PSG), a
+:	
	ld a, ($C00C)
	or a
	jp m, +
	bit 7, (ix+20)
	ret nz
	ld a, (ix+6)
	dec a
	jp p, ++
	ret

+:	
	ld a, (ix+6)
	dec a
++:	
	ld l, (ix+14)
	ld h, (ix+15)
	jp m, +
	ex de, hl
	ld hl, LABEL_B12_A916
	call LABEL_B12_842F
	call LABEL_B12_843C
+:	
	bit 6, (ix+0)
	ret nz
	ld a, (ix+1)
	cp $E0
	jr nz, LABEL_B12_8812
	ld a, $C0
LABEL_B12_8812:	
	ld c, a
	ld a, l
	and $0F
	or c
	out (Port_PSG), a
	ld a, l
	and $F0
	or h
	rrca
	rrca
	rrca
	rrca
	out (Port_PSG), a
	ret

-:	
	ld (ix+12), a
LABEL_B12_8827:	
	push hl
	ld c, (ix+12)
	ld b, $00
	add hl, bc
	ld c, l
	ld b, h
	pop hl
	ld a, (bc)
	bit 7, a
	jr z, ++++
	cp $82
	jr z, +
	cp $81
	jr z, +++
	cp $80
	jr z, ++
	inc bc
	ld a, (bc)
	jr -

+:	
	pop hl
	ld a, $1F
	ld (ix+19), a
	add a, (ix+1)
	out (Port_PSG), a
	ret

++:	
	xor a
	jr -

+++:	
	ld (ix+19), $FF
	pop hl
	ret

++++:	
	inc (ix+12)
	add a, (ix+8)
	bit 4, a
	ret z
	ld a, $0F
	ret

LABEL_B12_8867:	
	ld a, (ix+8)
	and $0F
	or (ix+1)
	add a, $10
	out (Port_PSG), a
	ret


LABEL_B12_8874:
.db	$00, $00, $FF, $03
.db $C7, $03, $90, $03, $5D, $03, $2D, $03
.db $FF, $02, $D4, $02, $AB, $02, $85, $02
.db $61, $02, $3F, $02, $1E, $02, $00, $02
.db $E3, $01, $C8, $01, $AF, $01, $96, $01
.db $80, $01, $6A, $01, $56, $01, $43, $01
.db $30, $01, $1F, $01, $0F, $01, $00, $01
.db $F2, $00, $E4, $00, $D7, $00, $CB, $00
.db $C0, $00, $B5, $00, $AB, $00, $A1, $00
.db $98, $00, $90, $00, $88, $00, $80, $00
.db $79, $00, $72, $00, $6C, $00, $66, $00
.db $60, $00, $5B, $00, $55, $00, $51, $00
.db $4C, $00, $48, $00, $44, $00, $40, $00
.db $3C, $00, $39, $00, $36, $00, $33, $00
.db $30, $00, $2D, $00, $2B, $00, $28, $00
.db $26, $00, $24, $00, $22, $00, $20, $00
.db $1E, $00, $1C, $00, $1B, $00, $19, $00
.db $18, $00, $16, $00, $15, $00, $14, $00
.db $13, $00, $12, $00, $11, $00, $FF, $01
.db $F5, $06, $C0, $F8, $6A, $89, $AD, $1E
.db $AB, $12, $AE, $AB, $06, $B2, $0C, $06
.db $B0, $0C, $AE, $06, $B0, $12, $F8, $6A
.db $89, $AD, $24, $A9, $06, $AB, $AE, $B0
.db $0C, $AE, $06, $B3, $0C, $06, $B2, $0C
.db $B0, $AE, $F5, $0B, $80, $F8, $5A, $89
.db $B3, $1E, $B7, $06, $B3, $B5, $12, $0C
.db $B2, $06, $B3, $12, $F8, $5A, $89, $B7
.db $1E, $B3, $06, $B7, $0C, $B9, $B9, $B7
.db $B5, $12, $B5, $06, $0C, $0C, $0C, $F6
.db $08, $89, $B0, $1E, $B2, $06, $B3, $B5
.db $0C, $B5, $06, $0C, $06, $B3, $0C, $B2
.db $06, $F9, $B2, $12, $B0, $AE, $0C, $B0
.db $12, $F9, $F8, $B7, $89, $91, $06, $96
.db $12, $F8, $B7, $89, $91, $96, $98, $12
.db $93, $09, $0F, $98, $0C, $06, $0C, $06
.db $93, $0C, $06, $8F, $12, $0C, $96, $06
.db $8F, $91, $0C, $91, $06, $0C, $98, $91
.db $98, $12, $06, $12, $93, $0C, $98, $06
.db $0C, $06, $93, $0C, $06, $8F, $0C, $0C
.db $0C, $0C, $98, $95, $91, $91, $12, $91
.db $06, $0C, $0C, $0C, $F6, $72, $89, $96
.db $12, $0C, $91, $06, $96, $0C, $91, $12
.db $0C, $98, $06, $96, $95, $8F, $12, $8F
.db $0C, $06, $06, $96, $0C, $06, $0C, $F9
.db $01, $F8, $02, $8A, $AB, $06, $AD, $12
.db $F8, $02, $8A, $AB, $A9, $F8, $16, $8A
.db $AD, $1E, $AE, $06, $AD, $AB, $12, $A9
.db $0C, $AB, $06, $AD, $12, $F8, $16, $8A
.db $B0, $12, $12, $AD, $0C, $AE, $B0, $AD
.db $A9, $12, $B0, $06, $0C, $0C, $0C, $F6
.db $D1, $89, $AE, $12, $A9, $AE, $0C, $AD
.db $12, $A9, $1E, $AB, $12, $A7, $AB, $06
.db $AE, $0C, $06, $AD, $0C, $F9, $B0, $12
.db $12, $A7, $0C, $B0, $06, $AB, $12, $A7
.db $0C, $AB, $F9, $01, $F5, $06, $50, $F8
.db $70, $8A, $B1, $B5, $0C, $B3, $AC, $06
.db $AC, $24, $F8, $70, $8A, $B1, $09, $B3
.db $B5, $06, $B3, $24, $B1, $06, $B3, $F5
.db $07, $C0, $F8, $81, $8A, $B7, $30, $B5
.db $09, $B7, $B8, $06, $09, $B5, $BD, $BC
.db $2D, $BA, $18, $B1, $0C, $B3, $06, $B4
.db $F8, $81, $8A, $B7, $36, $B5, $06, $B7
.db $B8, $BD, $0C, $BC, $06, $BD, $BC, $24
.db $BA, $06, $BC, $BA, $30, $F6, $24, $8A
.db $B5, $12, $B1, $06, $30, $B8, $06, $B6
.db $0C, $B5, $06, $B3, $09, $B5, $B1, $06
.db $F9, $B4, $30, $B8, $0C, $06, $B6, $0F
.db $B4, $B3, $30, $BC, $0C, $06, $BA, $0F
.db $B8, $F9, $F8, $03, $8B, $06, $09, $09
.db $0C, $06, $94, $18, $96, $06, $98, $F8
.db $03, $8B, $0C, $96, $96, $06, $9B, $24
.db $94, $06, $06, $99, $12, $06, $06, $9C
.db $0C, $A0, $9C, $06, $99, $18, $0C, $9B
.db $12, $A4, $06, $18, $12, $0C, $A2, $A0
.db $06, $9F, $12, $06, $18, $99, $08, $08
.db $08, $08, $98, $08, $99, $08, $A4, $12
.db $12, $0C, $A2, $18, $18, $99, $12, $9C
.db $07, $A0, $11, $06, $08, $9C, $0A, $99
.db $1D, $9B, $12, $07, $18, $A4, $12, $10
.db $0C, $A2, $13, $06, $19, $99, $08, $08
.db $08, $08, $08, $08, $9B, $0C, $0C, $0C
.db $06, $9F, $07, $A2, $0B, $0C, $0C, $0C
.db $F6, $92, $8A, $99, $0C, $0C, $0C, $09
.db $03, $0C, $0C, $A0, $09, $09, $06, $9B
.db $09, $09, $F9, $F8, $47, $8B, $BA, $0C
.db $BC, $24, $F8, $47, $8B, $BA, $30, $B8
.db $12, $06, $18, $BA, $12, $B8, $1E, $BA
.db $12, $BC, $06, $18, $0C, $06, $12, $0C
.db $BA, $30, $B8, $09, $09, $06, $B7, $09
.db $09, $06, $BC, $24, $0C, $BA, $30, $F7
.db $00, $02, $1F, $8B, $F6, $13, $8B, $B8
.db $12, $06, $30, $BC, $09, $09, $06, $BA
.db $09, $09, $06, $BD, $09, $09, $06, $F9
.db $F8, $70, $8B, $B7, $0C, $B8, $24, $F8
.db $70, $8B, $B8, $30, $F8, $81, $8B, $30
.db $F8, $81, $8B, $B7, $30, $F6, $58, $8B
.db $B5, $12, $06, $30, $B8, $09, $09, $06
.db $B7, $09, $09, $06, $BA, $09, $09, $06
.db $F9, $B4, $12, $06, $18, $B6, $12, $B4
.db $1E, $B7, $12, $B8, $06, $18, $0C, $06
.db $12, $0C, $B7, $12, $06, $18, $B5, $09
.db $09, $06, $09, $09, $06, $B7, $24, $0C
.db $F9, $F8, $BE, $8B, $B3, $0C, $24, $F8
.db $BE, $8B, $B3, $30, $F8, $CE, $8B, $B5
.db $24, $0C, $B3, $30, $F8, $CE, $8B, $B3
.db $24, $0C, $30, $F6, $A1, $8B, $B1, $12
.db $06, $30, $B3, $09, $09, $06, $09, $09
.db $06, $B5, $09, $09, $06, $F9, $B1, $12
.db $06, $18, $12, $12, $0C, $B3, $12, $06
.db $18, $0C, $06, $12, $0C, $30, $B1, $09
.db $09, $06, $09, $09, $06, $F9, $01, $F5
.db $05, $B0, $F8, $3A, $8C, $BD, $1E, $BF
.db $06, $BD, $0C, $BC, $30, $F8, $3A, $8C
.db $BD, $1E, $BC, $06, $BD, $0C, $BF, $30
.db $80, $F5, $07, $70, $FE, $01, $F8, $49
.db $8C, $BA, $18, $B8, $B7, $06, $06, $BA
.db $BA, $0C, $B8, $06, $B7, $0C, $F8, $49
.db $8C, $B7, $06, $B8, $BA, $B7, $B8, $BA
.db $B7, $BA, $BF, $30, $FE, $FF, $F6, $E7
.db $8B, $B5, $06, $B7, $B8, $B7, $03, $B5
.db $09, $B7, $06, $B8, $BA, $12, $06, $B7
.db $B8, $F9, $F8, $29, $8C, $B7, $B5, $0C
.db $B5, $30, $B0, $F8, $29, $8C, $B7, $12
.db $F9, $BC, $06, $BA, $12, $B9, $0C, $B5
.db $03, $B9, $BA, $06, $BC, $1E, $12, $06
.db $BA, $12, $B9, $0C, $B7, $06, $B3, $24
.db $0C, $B5, $1E, $B1, $18, $B8, $0C, $B5
.db $06, $BC, $0C, $BA, $06, $B8, $0C, $F9
.db $F8, $F1, $8C, $99, $99, $99, $09, $98
.db $03, $99, $0C, $98, $98, $98, $06, $99
.db $9B, $99, $F8, $F1, $8C, $99, $99, $99
.db $06, $98, $99, $0C, $9B, $9B, $9B, $9B
.db $9B, $06, $A0, $9F, $9B, $A2, $A0, $9F
.db $A0, $03, $A2, $F8, $D8, $8C, $0C, $0C
.db $09, $03, $0C, $0C, $0C, $0C, $9B, $9B
.db $9B, $9B, $A0, $06, $9F, $9B, $A2, $A0
.db $9B, $9F, $A0, $F8, $D8, $8C, $99, $0C
.db $0C, $0C, $0C, $06, $0C, $06, $0C, $9B
.db $06, $0C, $06, $06, $0C, $06, $06, $9F
.db $06, $A0, $06, $A2, $06, $9B, $06, $A2
.db $06, $A0, $06, $9F, $06, $F6, $70, $8C
.db $9D, $0C, $9D, $9D, $9D, $09, $03, $0C
.db $0C, $0C, $09, $03, $9B, $0C, $0C, $0C
.db $09, $03, $0C, $0C, $0C, $06, $99, $12
.db $F9, $96, $0C, $0C, $0C, $0C, $0C, $0C
.db $06, $94, $96, $0C, $9D, $9D, $9D, $9D
.db $9D, $9D, $9D, $06, $A0, $9D, $9D, $96
.db $0C, $0C, $0C, $0C, $0C, $0C, $06, $94
.db $96, $0C, $F9, $F8, $80, $8D, $B1, $1E
.db $B3, $06, $B5, $B3, $B0, $18, $B1, $0C
.db $B0, $F8, $80, $8D, $B1, $30, $B3, $18
.db $BA, $B7, $30, $B5, $24, $06, $06, $1E
.db $12, $B3, $06, $1E, $06, $06, $1E, $0C
.db $B1, $24, $AC, $12, $B5, $0C, $B1, $06
.db $B5, $12, $B1, $0C, $B3, $18, $AE, $B3
.db $06, $B0, $AE, $B0, $0C, $AC, $06, $B0
.db $B3, $B5, $18, $B5, $0C, $06, $03, $03
.db $1E, $12, $B3, $09, $0F, $0C, $06, $24
.db $0C, $B1, $1E, $AC, $12, $B1, $06, $B5
.db $0C, $B1, $06, $B5, $12, $B1, $0C, $B7
.db $06, $B3, $BA, $B3, $B7, $B3, $BA, $B3
.db $BA, $0C, $B7, $B3, $B7, $F6, $13, $8D
.db $B1, $12, $AE, $B5, $0C, $03, $80, $0F
.db $AE, $1E, $B0, $03, $80, $0F, $AC, $12
.db $B5, $06, $AC, $12, $B0, $0C, $B5, $AC
.db $B1, $12, $AE, $B5, $0C, $B5, $06, $AE
.db $2A, $F9, $F8, $DB, $8D, $B8, $B8, $06
.db $0C, $B7, $30, $F8, $DB, $8D, $B8, $B8
.db $06, $0C, $BA, $36, $06, $0C, $0C, $0C
.db $F8, $F1, $8D, $0C, $06, $0C, $06, $0C
.db $BA, $18, $18, $06, $0C, $0C, $06, $0C
.db $F8, $F1, $8D, $0C, $06, $1E, $BA, $0C
.db $06, $06, $0C, $0C, $0C, $0C, $0C, $0C
.db $F6, $A2, $8D, $B5, $12, $12, $0C, $12
.db $B5, $1E, $B0, $12, $B0, $12, $06, $36
.db $B5, $12, $B5, $12, $0C, $12, $B5, $1E
.db $F9, $BC, $2A, $B0, $06, $BC, $1E, $12
.db $BA, $24, $AE, $06, $BA, $24, $0C, $B8
.db $1E, $18, $F9, $F8, $52, $8E, $AC, $05
.db $80, $0D, $AC, $12, $06, $36, $F8, $52
.db $8E, $B5, $B5, $06, $0C, $B4, $30, $F8
.db $52, $8E, $AC, $12, $1E, $04, $80, $0E
.db $AC, $1E, $F8, $52, $8E, $B5, $B5, $06
.db $0C, $B7, $36, $06, $0C, $0C, $0C, $F8
.db $5F, $8E, $0C, $06, $0C, $06, $0C, $B7
.db $18, $18, $06, $0C, $0C, $06, $0C, $F8
.db $5F, $8E, $0C, $06, $1E, $B7, $0C, $06
.db $06, $0C, $0C, $0C, $0C, $0C, $0C, $F6
.db $03, $8E, $B1, $03, $80, $0F, $B1, $12
.db $0C, $03, $80, $0F, $B1, $1E, $F9, $B9
.db $2A, $AD, $06, $B9, $1E, $12, $B7, $24
.db $AB, $06, $B7, $24, $0C, $B5, $1E, $18
.db $F9, $A9, $06, $AE, $AD, $AE, $B1, $1E
.db $B0, $06, $AE, $AC, $AB, $2A, $A7, $06
.db $18, $A9, $06, $AE, $AD, $AE, $B1, $1E
.db $B0, $06, $B1, $B3, $B6, $24, $B8, $06
.db $B6, $B5, $18, $F7, $00, $02, $71, $8E
.db $F5, $05, $A0, $F8, $B9, $8E, $06, $BA
.db $0C, $B8, $06, $B6, $24, $BD, $0C, $BA
.db $18, $F8, $B9, $8E, $B5, $B6, $24, $F5
.db $07, $B0, $B8, $0C, $B9, $18, $F6, $71
.db $8E, $BD, $06, $BC, $0C, $BA, $06, $B9
.db $24, $BA, $0C, $BC, $18, $F9, $9D, $0C
.db $0C, $A2, $A2, $A2, $A2, $9F, $9F, $9F
.db $9F, $9B, $9B, $9D, $9D, $A2, $A2, $A2
.db $A2, $9E, $9E, $9E, $9E, $9D, $9D, $F7
.db $00, $02, $C6, $8E, $9D, $9D, $9D, $9D
.db $9D, $9D, $98, $98, $98, $98, $9E, $9E
.db $9E, $9E, $A2, $A2, $A2, $A2, $9D, $9D
.db $9D, $9D, $98, $98, $98, $98, $9E, $9E
.db $9E, $9E, $9D, $9D, $F6, $C6, $8E, $80
.db $18, $AE, $1E, $AC, $06, $AB, $A9, $A7
.db $2A, $A2, $06, $15, $80, $1B, $AE, $1E
.db $AC, $06, $AE, $B0, $B1, $24, $B3, $06
.db $B1, $B0, $18, $F7, $00, $02, $07, $8F
.db $AE, $B5, $30, $B8, $B6, $B6, $B5, $B3
.db $B6, $18, $80, $30, $F6, $07, $8F, $FF
.db $01, $F5, $0A, $B0, $F8, $6F, $8F, $B0
.db $06, $B1, $B3, $18, $F8, $6F, $8F, $B3
.db $06, $B1, $B0, $18, $F5, $05, $A0, $F8
.db $8B, $8F, $A9, $06, $A9, $A9, $AB, $12
.db $AC, $2A, $B0, $06, $AE, $AC, $F8, $8B
.db $8F, $A9, $A8, $06, $A9, $AC, $0C, $AB
.db $06, $AC, $B0, $30, $F6, $39, $8F, $AC
.db $06, $A9, $B0, $A9, $AF, $A9, $AE, $AC
.db $AC, $A9, $B0, $A9, $AE, $A9, $AC, $A9
.db $AC, $A9, $AC, $AE, $B0, $AE, $AC, $A9
.db $B1, $0C, $F9, $A9, $06, $06, $06, $AB
.db $12, $A7, $24, $A6, $0C, $A7, $F9, $9D
.db $2A, $06, $9B, $30, $9A, $2A, $06, $99
.db $18, $9B, $9D, $2A, $9D, $06, $9B, $2A
.db $06, $9A, $30, $99, $0C, $9B, $06, $99
.db $98, $18, $F8, $D7, $8F, $96, $06, $96
.db $96, $98, $06, $80, $0C, $99, $1E, $9B
.db $06, $9D, $9B, $99, $0C, $F8, $D7, $8F
.db $96, $0C, $95, $06, $96, $99, $0C, $98
.db $06, $99, $9D, $30, $F6, $97, $8F, $96
.db $06, $06, $06, $98, $06, $80, $0C, $94
.db $24, $93, $0C, $94, $F9, $02, $B0, $30
.db $AE, $AC, $80, $18, $18, $B0, $30, $AE
.db $AC, $B5, $18, $B3, $AE, $06, $AE, $AE
.db $B0, $12, $AC, $24, $AB, $0C, $AC, $AE
.db $06, $AE, $AE, $B0, $12, $B1, $3C, $06
.db $06, $06, $B3, $12, $B0, $24, $AE, $0C
.db $B0, $B1, $B0, $06, $B1, $B5, $0C, $B4
.db $06, $B5, $B8, $30, $F6, $E6, $8F, $F8
.db $70, $90, $F4, $01, $FB, $F4, $F4, $F6
.db $36, $90, $01, $F8, $70, $90, $F6, $36
.db $90, $F8, $70, $90, $F4, $02, $F5, $05
.db $70, $F8, $7D, $90, $BA, $18, $B9, $12
.db $B3, $03, $B1, $F8, $7D, $90, $BA, $12
.db $BC, $03, $BA, $B9, $18, $F5, $0A, $60
.db $F8, $A9, $90, $B1, $12, $B5, $B1, $0C
.db $B3, $12, $AC, $1E, $F8, $A9, $90, $B8
.db $06, $B1, $B1, $B2, $1E, $BA, $06, $B3
.db $06, $B3, $06, $BC, $1E, $F6, $36, $90
.db $F0, $01, $FC, $01, $99, $FD, $10, $20
.db $FC, $00, $F0, $00, $F9, $F8, $95, $90
.db $B3, $0C, $B6, $B5, $06, $B1, $12, $B3
.db $30, $F8, $95, $90, $B3, $0C, $B6, $12
.db $B5, $06, $B6, $B8, $F9, $0C, $B6, $B5
.db $06, $B1, $0C, $B3, $03, $B1, $B3, $0C
.db $B6, $B1, $06, $B1, $0C, $B3, $03, $B1
.db $F9, $B6, $12, $BA, $B6, $0C, $B9, $06
.db $B6, $B5, $B3, $12, $B5, $0C, $F9, $F8
.db $70, $90, $9B, $0C, $F7, $00, $0E, $BA
.db $90, $98, $99, $9B, $F7, $00, $0C, $C3
.db $90, $9D, $9D, $9D, $9D, $F7, $01, $02
.db $BA, $90, $F8, $EF, $90, $96, $96, $96
.db $96, $98, $98, $98, $98, $F8, $EF, $90
.db $99, $06, $06, $06, $9A, $1E, $9B, $06
.db $06, $06, $9D, $1E, $F6, $BA, $90, $9E
.db $9E, $9E, $9E, $9D, $9D, $9D, $9D, $F9
.db $01, $F8, $70, $90, $B6, $0C, $B3, $BA
.db $B3, $B6, $B3, $BA, $B3, $B6, $B3, $BA
.db $B6, $BD, $18, $BC, $0C, $BA, $F8, $7D
.db $91, $B6, $0C, $B3, $BA, $B6, $BA, $06
.db $B6, $B3, $0C, $0C, $B3, $B6, $B3, $BA
.db $B3, $B6, $B3, $BA, $B8, $F8, $7D, $91
.db $BD, $0C, $BA, $B6, $BA, $BD, $12, $B5
.db $2A, $B0, $18, $AE, $0C, $B0, $06, $B3
.db $0C, $B7, $1E, $B6, $06, $BA, $0C, $BD
.db $12, $B6, $0C, $BC, $12, $B9, $B5, $2A
.db $FC, $01, $AF, $0A, $DF, $06, $AC, $0A
.db $DC, $0C, $FC, $00, $80, $18, $FC, $01
.db $AF, $0A, $DF, $03, $AF, $0A, $DF, $03
.db $AF, $0A, $DF, $03, $AF, $0A, $DF, $03
.db $AC, $0A, $DC, $03, $AC, $0A, $DC, $03
.db $A9, $0A, $F6, $03, $A9, $0A, $F6, $03
.db $FC, $00, $F6, $FC, $90, $B6, $B3, $BA
.db $B3, $B6, $B3, $BA, $B3, $B6, $B3, $BA
.db $B6, $BC, $06, $FC, $01, $AF, $0A, $DF
.db $06, $AC, $0A, $DC, $0C, $80, $00, $00
.db $06, $AF, $0A, $DF, $06, $AF, $0A, $DF
.db $06, $AC, $0A, $DC, $06, $FC, $00, $F9
.db $01, $01, $01, $F8, $F2, $91, $B1, $B3
.db $B0, $B1, $18, $B8, $F8, $F2, $91, $AE
.db $B0, $B1, $B3, $18, $B1, $F8, $E9, $91
.db $B5, $B3, $B1, $B3, $B5, $18, $BC, $06
.db $06, $06, $06, $06, $BA, $B8, $B6, $B8
.db $18, $B3, $F8, $E9, $91, $B5, $B1, $B3
.db $B5, $B6, $1E, $BD, $06, $BC, $BA, $BC
.db $0C, $B5, $BD, $1D, $80, $13, $F6, $AB
.db $91, $B8, $0C, $B8, $B8, $06, $B6, $B5
.db $B3, $F9, $B5, $06, $B1, $B8, $09, $03
.db $B6, $06, $B5, $03, $B3, $B5, $06, $B1
.db $B3, $12, $AC, $06, $18, $B0, $0C, $0C
.db $06, $F9, $F8, $3A, $92, $A0, $06, $9E
.db $9D, $9B, $9D, $18, $99, $F8, $3A, $92
.db $A0, $12, $98, $06, $99, $1E, $06, $98
.db $96, $F8, $49, $92, $0C, $06, $9D, $9B
.db $99, $9B, $12, $94, $06, $18, $F8, $49
.db $92, $A0, $A2, $9D, $99, $18, $80, $F6
.db $0A, $92, $99, $0C, $A5, $9E, $06, $A0
.db $9E, $0C, $92, $9E, $98, $99, $94, $A0
.db $F9, $94, $0C, $94, $94, $06, $9B, $12
.db $99, $0C, $0C, $06, $A0, $12, $9E, $0C
.db $F9, $01, $B1, $24, $B0, $18, $AC, $06
.db $AE, $B0, $24, $AA, $AC, $18, $B0, $0C
.db $AE, $18, $AC, $0C, $A9, $18, $06, $AA
.db $AC, $24, $B1, $B0, $18, $AC, $06, $AE
.db $B0, $18, $AA, $0C, $24, $AC, $18, $B0
.db $0C, $B3, $18, $AE, $0C, $B1, $24, $80
.db $F6, $5A, $92, $F8, $AF, $92, $94, $0C
.db $94, $80, $94, $94, $80, $91, $91, $80
.db $94, $0C, $18, $F8, $AF, $92, $94, $0C
.db $0C, $80, $94, $0C, $0C, $06, $96, $99
.db $0C, $0C, $0C, $24, $F6, $8B, $92, $99
.db $0C, $99, $80, $99, $18, $94, $0C, $92
.db $0C, $80, $92, $92, $0C, $80, $18, $F9
.db $01, $B5, $33, $80, $39, $0C, $B3, $B5
.db $B6, $3C, $80, $B6, $0C, $B5, $B5, $24
.db $B3, $B0, $B1, $B5, $B6, $B5, $23, $80
.db $25, $F6, $C1, $92, $FF, $01, $F8, $C5
.db $93, $B8, $03, $B7, $B5, $2A, $EF, $02
.db $FC, $01, $9F, $0A, $DF, $03, $9F, $0A
.db $DF, $06, $9C, $0A, $DC, $03, $9C, $0A
.db $DC, $03, $9F, $0A, $DF, $06, $9C, $0A
.db $DC, $03, $9F, $0A, $DF, $06, $9C, $0A
.db $DC, $03, $9C, $0A, $DC, $03, $9F, $0A
.db $DF, $03, $9C, $0A, $DC, $03, $9C, $0A
.db $DC, $03, $99, $0A, $F6, $03, $FC, $00
.db $EF, $FE, $F8, $C5, $93, $B7, $03, $B8
.db $BA, $B5, $21, $BD, $03, $BC, $BA, $18
.db $FC, $01, $EF, $02, $9F, $0A, $DF, $06
.db $9C, $0A, $DC, $03, $9C, $0A, $DC, $03
.db $9F, $0A, $DF, $03, $9F, $0A, $DF, $03
.db $9C, $0A, $DC, $03, $99, $0A, $F6, $03
.db $FC, $00, $EF, $FE, $F8, $E0, $93, $FC
.db $01, $EF, $02, $9C, $0A, $DC, $06, $9F
.db $0A, $DF, $06, $9F, $0A, $DF, $06, $9C
.db $0A, $DC, $06, $9F, $0A, $DF, $06, $9F
.db $0A, $DF, $06, $9C, $0A, $DC, $06, $99
.db $0A, $F6, $06, $FC, $00, $EF, $FE, $F8
.db $E0, $93, $FC, $01, $EF, $02, $9F, $0A
.db $DF, $03, $9F, $0A, $DF, $03, $9C, $0A
.db $DC, $06, $9F, $0A, $DF, $03, $9F, $0A
.db $DF, $03, $9C, $0A, $DC, $06, $9F, $0A
.db $DF, $03, $9F, $0A, $DF, $03, $9F, $0A
.db $DF, $03, $9C, $0A, $DC, $03, $9C, $0A
.db $DC, $03, $9C, $0A, $DC, $03, $99, $0A
.db $F6, $03, $99, $0A, $F6, $03, $FC, $00
.db $EF, $FE, $F6, $DE, $92, $AB, $03, $AA
.db $AB, $06, $AE, $03, $AD, $AE, $06, $B1
.db $03, $B0, $B1, $06, $B5, $03, $B4, $B5
.db $06, $BA, $1E, $B8, $06, $BA, $B8, $F9
.db $AE, $03, $80, $0F, $B1, $1E, $B0, $03
.db $80, $0F, $AE, $1E, $AD, $12, $AA, $1E
.db $F9, $F8, $25, $94, $92, $99, $98, $0C
.db $F8, $25, $94, $99, $0C, $98, $96, $1E
.db $95, $06, $96, $95, $92, $1E, $91, $06
.db $06, $92, $93, $12, $99, $3C, $91, $06
.db $06, $92, $93, $12, $8F, $3C, $91, $06
.db $06, $92, $93, $12, $96, $3C, $95, $06
.db $96, $98, $F6, $F1, $93, $93, $03, $92
.db $93, $06, $96, $95, $93, $03, $92, $93
.db $06, $99, $98, $93, $03, $92, $93, $06
.db $96, $95, $91, $0C, $92, $93, $03, $03
.db $93, $06, $96, $95, $93, $03, $92, $93
.db $06, $99, $98, $93, $03, $92, $93, $06
.db $96, $95, $F9, $01, $80, $30, $F8, $84
.db $94, $B1, $B0, $B5, $3C, $F8, $84, $94
.db $B1, $03, $B0, $B1, $06, $B5, $0B, $80
.db $31, $B5, $12, $B8, $1E, $BA, $12, $B9
.db $1E, $80, $30, $B5, $12, $B8, $1E, $80
.db $30, $B5, $03, $80, $0F, $B1, $3E, $80
.db $10, $F6, $54, $94, $AB, $03, $AA, $AB
.db $06, $AE, $03, $AD, $AE, $06, $B1, $03
.db $B0, $B1, $06, $B5, $03, $B4, $B5, $80
.db $33, $AB, $03, $AA, $AB, $06, $AE, $03
.db $AD, $AE, $06, $F9, $01, $F8, $BB, $94
.db $B5, $12, $B0, $B3, $2A, $06, $B2, $B3
.db $F8, $BB, $94, $B0, $2A, $A9, $06, $30
.db $F6, $A5, $94, $B5, $12, $B0, $B5, $0C
.db $B3, $06, $B2, $0C, $B0, $12, $AE, $0C
.db $F9, $F8, $DC, $94, $9D, $15, $98, $0F
.db $9B, $3C, $F8, $DC, $94, $9D, $2A, $06
.db $30, $F6, $C9, $94, $9D, $05, $80, $0D
.db $9D, $12, $98, $0C, $9B, $12, $12, $98
.db $0C, $F9, $01, $F8, $FD, $94, $B0, $12
.db $AD, $AE, $3C, $F8, $FD, $94, $AD, $2A
.db $06, $30, $F6, $EB, $94, $B0, $12, $AD
.db $B0, $0C, $AE, $06, $AD, $0C, $AB, $12
.db $A9, $0C, $F9, $01, $F5, $07, $80, $F8
.db $58, $95, $B0, $12, $B2, $06, $B3, $B2
.db $B0, $0C, $B2, $18, $B5, $F8, $58, $95
.db $B7, $06, $B5, $B3, $B2, $12, $B3, $0C
.db $B0, $24, $B5, $0C, $B3, $18, $B2, $B0
.db $36, $B0, $06, $06, $06, $06, $06, $06
.db $06, $F5, $07, $90, $F8, $66, $95, $B5
.db $30, $80, $F8, $66, $95, $B5, $2A, $B0
.db $06, $30, $F8, $79, $95, $30, $B5, $F1
.db $48, $F8, $79, $95, $B9, $30, $30, $F2
.db $B2, $12, $AE, $06, $B5, $B3, $B2, $B3
.db $B2, $12, $AE, $06, $18, $F9, $B8, $06
.db $B7, $B5, $B8, $0C, $B7, $06, $B5, $0C
.db $BA, $06, $B8, $B7, $B5, $12, $B7, $0C
.db $F9, $BD, $06, $BC, $BA, $BD, $0C, $06
.db $BA, $0C, $BF, $06, $BD, $BC, $BA, $12
.db $BC, $0C, $F9, $96, $2A, $06, $94, $30
.db $93, $94, $18, $96, $96, $30, $94, $93
.db $24, $93, $0C, $94, $94, $94, $94, $96
.db $96, $96, $96, $98, $98, $98, $98, $98
.db $06, $98, $98, $98, $98, $98, $98, $98
.db $99, $99, $99, $99, $99, $94, $99, $99
.db $9B, $9B, $9B, $9B, $0C, $9B, $06, $0C
.db $9D, $12, $0C, $0C, $98, $06, $95, $0C
.db $98, $06, $9D, $0C, $A0, $9D, $06, $99
.db $0C, $06, $0C, $06, $0C, $9B, $12, $0C
.db $06, $0C, $9D, $06, $98, $0C, $95, $98
.db $9D, $06, $A1, $0C, $9D, $06, $A4, $0C
.db $9D, $06, $A1, $0C, $99, $12, $0C, $06
.db $0C, $9B, $9B, $06, $0C, $0C, $06, $9D
.db $12, $0C, $98, $95, $06, $95, $0C, $98
.db $06, $99, $9B, $9D, $9B, $99, $99, $0C
.db $06, $0C, $06, $0C, $9B, $9B, $06, $12
.db $96, $0C, $9D, $12, $06, $12, $06, $30
.db $F2, $01, $B5, $2A, $06, $30, $B3, $2A
.db $06, $B5, $18, $B2, $B5, $2A, $06, $30
.db $B7, $24, $B3, $0C, $0C, $0C, $0C, $0C
.db $B5, $B5, $B5, $B5, $B7, $B7, $B7, $B7
.db $12, $06, $06, $06, $06, $06, $06, $06
.db $F8, $73, $96, $06, $BA, $B9, $BA, $0C
.db $BC, $12, $F8, $73, $96, $06, $BF, $BC
.db $BA, $B9, $BA, $BC, $BA, $F8, $73, $96
.db $06, $BD, $BF, $BF, $0C, $06, $BC, $0C
.db $B8, $06, $06, $06, $0C, $06, $0C, $BA
.db $06, $06, $06, $0C, $06, $0C, $BC, $2A
.db $06, $30, $F2, $B8, $06, $06, $06, $0C
.db $06, $0C, $BA, $06, $06, $06, $0C, $06
.db $0C, $BC, $12, $06, $12, $06, $F9, $01
.db $F5, $05, $80, $F8, $AB, $96, $B1, $2A
.db $06, $30, $F8, $AB, $96, $B1, $24, $B0
.db $0C, $AD, $30, $F5, $07, $40, $F8, $C3
.db $96, $AE, $30, $F8, $C3, $96, $B5, $B3
.db $F6, $88, $96, $80, $18, $AE, $0C, $AD
.db $A9, $18, $0C, $AE, $AC, $12, $AB, $A7
.db $36, $80, $1E, $AE, $0C, $AD, $A9, $18
.db $0C, $AE, $F9, $80, $18, $A7, $06, $AB
.db $0C, $AE, $06, $B1, $12, $B3, $0C, $B1
.db $AE, $1E, $A7, $06, $AB, $0C, $AE, $06
.db $B1, $18, $B0, $AD, $A9, $AD, $AE, $0C
.db $0C, $B1, $18, $B0, $F9, $F8, $0A, $97
.db $9E, $80, $F8, $0A, $97, $92, $9D, $9B
.db $22, $80, $38, $9B, $06, $99, $30, $80
.db $9D, $28, $2C, $9D, $0C, $9E, $24, $99
.db $0C, $30, $F7, $00, $02, $EF, $96, $F6
.db $E5, $96, $96, $0C, $A2, $24, $80, $30
.db $A0, $24, $94, $3C, $96, $0C, $A2, $24
.db $80, $30, $F9, $01, $96, $0C, $A2, $24
.db $80, $30, $A0, $3C, $B3, $0C, $B2, $AC
.db $A2, $30, $80, $B5, $2A, $B1, $06, $30
.db $A9, $0C, $24, $80, $30, $A7, $3C, $B0
.db $0C, $AE, $B3, $A9, $30, $80, $A7, $A4
.db $AA, $80, $12, $B0, $0C, $AE, $AA, $06
.db $A9, $30, $80, $12, $AE, $1E, $A7, $30
.db $80, $B0, $2E, $32, $30, $1E, $AB, $06
.db $AE, $3C, $80, $30, $B1, $31, $80, $2F
.db $B5, $30, $B3, $21, $80, $0F, $F6, $1C
.db $97, $FF, $01, $F5, $07, $80, $AE, $03
.db $AD, $AE, $24, $A9, $0C, $AA, $AC, $AD
.db $AE, $36, $A9, $06, $2A, $AE, $03, $AD
.db $F5, $05, $F0, $AE, $24, $A9, $0C, $AA
.db $AC, $B0, $AD, $AE, $30, $80, $B6, $06
.db $B3, $B5, $B1, $B3, $B5, $B0, $B3, $B6
.db $B3, $B5, $B1, $B3, $0C, $B0, $B6, $06
.db $B3, $B5, $B1, $B3, $B5, $B6, $B8, $B8
.db $2A, $F6, $6B, $97, $80, $06, $A2, $18
.db $9D, $9E, $9B, $A2, $A7, $A2, $9D, $A2
.db $9D, $9E, $9B, $A2, $A4, $A2, $30, $9E
.db $18, $9D, $9B, $9D, $9E, $A4, $A2, $9E
.db $12, $F6, $AC, $97, $01, $80, $06, $A9
.db $18, $AC, $AE, $A7, $AA, $30, $A9, $A9
.db $18, $AE, $A7, $AA, $A9, $30, $80, $B1
.db $06, $AE, $B0, $AC, $1E, $B1, $06, $AE
.db $B0, $AC, $1E, $06, $AA, $AC, $A9, $AA
.db $AC, $AE, $B0, $BC, $18, $BB, $12, $F6
.db $CD, $97, $01, $F8, $1E, $98, $A2, $09
.db $A7, $03, $A9, $09, $A0, $03, $80, $39
.db $AE, $03, $AC, $09, $A9, $03, $F8, $1E
.db $98, $A9, $30, $80, $09, $B5, $03, $B5
.db $0C, $B2, $B3, $F6, $FB, $97, $A2, $09
.db $A7, $03, $A9, $09, $A0, $03, $80, $39
.db $A0, $03, $A2, $0C, $F9, $F8, $56, $98
.db $9D, $A2, $03, $80, $12, $A2, $03, $9F
.db $09, $A0, $03, $A2, $09, $A5, $0C, $0C
.db $03, $A4, $0C, $A2, $F8, $56, $98, $9D
.db $09, $99, $33, $80, $09, $B2, $03, $B2
.db $0C, $AE, $B0, $F6, $2D, $98, $A2, $02
.db $80, $13, $A2, $03, $9F, $09, $A0, $03
.db $A2, $09, $9D, $0C, $0C, $03, $9B, $0C
.db $F9, $01, $80, $2D, $AE, $18, $03, $AB
.db $09, $AC, $03, $AE, $39, $18, $03, $AB
.db $09, $AC, $03, $AE, $39, $18, $03, $AB
.db $09, $AC, $03, $AE, $09, $A9, $3C, $AE
.db $03, $0C, $AB, $AC, $F6, $6A, $98, $01
.db $F5, $06, $80, $F8, $C5, $98, $06, $BA
.db $03, $80, $0F, $B8, $06, $06, $06, $F8
.db $C5, $98, $06, $BA, $24, $F5, $05, $70
.db $BC, $30, $BD, $06, $BC, $0C, $36, $BD
.db $18, $30, $BA, $BC, $12, $24, $B8, $06
.db $0C, $0C, $06, $BA, $0C, $05, $0D, $BC
.db $0C, $0C, $F6, $90, $98, $BA, $03, $80
.db $0F, $BD, $1E, $BA, $03, $80, $0F, $BD
.db $2A, $BF, $0C, $0C, $06, $0C, $06, $12
.db $B8, $06, $06, $06, $BA, $03, $80, $0F
.db $BD, $1E, $BA, $03, $80, $0F, $BD, $1C
.db $80, $0E, $B8, $0C, $0C, $06, $BC, $0C
.db $F9, $F8, $2E, $99, $99, $06, $06, $06
.db $F8, $2E, $99, $06, $06, $06, $F8, $64
.db $99, $06, $06, $06, $9E, $9E, $03, $03
.db $06, $03, $03, $06, $03, $03, $06, $03
.db $03, $06, $03, $03, $06, $06, $06, $A2
.db $A0, $9E, $F8, $64, $99, $03, $03, $12
.db $99, $06, $0C, $0C, $06, $9B, $0C, $06
.db $0C, $9D, $9D, $F6, $F1, $98, $9B, $09
.db $09, $0C, $06, $06, $06, $09, $09, $0C
.db $06, $06, $0C, $80, $06, $9B, $06, $A7
.db $A7, $9B, $9B, $9B, $09, $9B, $9B, $12
.db $99, $06, $06, $06, $9B, $09, $09, $0C
.db $06, $06, $06, $09, $09, $0C, $03, $06
.db $0C, $80, $09, $99, $0C, $0C, $06, $9B
.db $0C, $06, $12, $F9, $9D, $9D, $03, $03
.db $06, $03, $03, $06, $03, $03, $06, $03
.db $03, $06, $03, $03, $06, $03, $03, $06
.db $F9, $F8, $A9, $99, $06, $B7, $02, $80
.db $10, $B5, $06, $06, $06, $F8, $A9, $99
.db $06, $B7, $24, $B9, $30, $BA, $06, $B9
.db $0C, $1B, $80, $BB, $18, $BA, $30, $B7
.db $B8, $12, $24, $B5, $06, $0C, $0C, $06
.db $B7, $0C, $06, $0C, $B9, $B9, $F6, $79
.db $99, $F8, $C0, $99, $BC, $0C, $0C, $06
.db $0C, $BA, $06, $03, $80, $21, $F8, $C0
.db $99, $B5, $0C, $0C, $06, $B8, $0C, $F9
.db $B7, $02, $80, $10, $BA, $1E, $B7, $02
.db $80, $10, $BA, $2A, $F9, $F8, $F9, $99
.db $06, $04, $80, $20, $F8, $F9, $99, $06
.db $12, $06, $06, $06, $B5, $30, $B6, $06
.db $B5, $0C, $36, $B6, $18, $30, $B3, $B3
.db $12, $24, $B1, $06, $0C, $0B, $07, $B3
.db $0C, $05, $0C, $B5, $0D, $0C, $F6, $CD
.db $99, $B3, $02, $80, $10, $B6, $1E, $B3
.db $02, $80, $10, $B6, $1D, $80, $0D, $B8
.db $0C, $0C, $06, $0C, $B3, $06, $06, $80
.db $1E, $B3, $01, $80, $11, $B6, $1E, $B3
.db $01, $80, $11, $B6, $1C, $80, $0E, $B1
.db $0C, $0C, $06, $B3, $0C, $F9, $FF, $F2
.db $80, $01, $F5, $06, $70, $F8, $9F, $9A
.db $30, $F8, $9F, $9A, $AD, $30, $F8, $9F
.db $9A, $30, $B1, $06, $AE, $03, $B1, $B5
.db $06, $B3, $03, $B1, $B3, $06, $03, $B0
.db $06, $B1, $03, $B0, $AE, $B1, $06, $AE
.db $03, $B1, $B5, $06, $B3, $03, $B1, $B3
.db $06, $06, $B0, $B1, $AE, $24, $BA, $0C
.db $B8, $23, $B5, $07, $B8, $06, $F5, $09
.db $F0, $F8, $C6, $9A, $B3, $24, $B5, $0C
.db $B6, $18, $B5, $0C, $B3, $B0, $24, $B8
.db $0C, $B5, $18, $0C, $B8, $F8, $C6, $9A
.db $B0, $24, $BA, $0C, $B8, $18, $B6, $0C
.db $B5, $F5, $08, $60, $B1, $06, $B3, $B5
.db $B6, $B3, $B5, $B6, $B8, $B5, $B6, $B8
.db $BA, $BD, $0C, $BC, $F6, $2A, $9A, $B1
.db $06, $AE, $03, $B1, $B5, $06, $B3, $03
.db $B1, $B3, $06, $03, $B0, $06, $B1, $03
.db $B0, $AE, $B1, $06, $AE, $03, $B1, $B5
.db $06, $B3, $03, $B1, $B3, $06, $06, $B0
.db $B1, $AE, $2A, $AC, $06, $F9, $B9, $24
.db $B5, $0C, $B6, $18, $B5, $0C, $B3, $18
.db $B1, $0C, $B3, $B5, $AC, $23, $80, $0D
.db $F9, $F8, $10, $9B, $9D, $9D, $9D, $9D
.db $F8, $10, $9B, $94, $94, $94, $94, $F8
.db $2E, $9B, $9B, $9B, $9B, $9B, $9B, $9B
.db $9B, $9B, $98, $98, $98, $98, $99, $99
.db $99, $99, $F8, $2E, $9B, $98, $98, $98
.db $98, $98, $98, $98, $98, $92, $92, $92
.db $92, $94, $94, $94, $94, $F6, $D9, $9A
.db $96, $0C, $96, $96, $96, $96, $96, $96
.db $96, $92, $92, $92, $92, $94, $94, $94
.db $94, $96, $96, $96, $96, $96, $96, $96
.db $96, $92, $92, $92, $92, $F9, $9D, $0C
.db $9D, $9D, $9D, $9D, $9D, $9D, $9D, $99
.db $99, $99, $99, $99, $99, $99, $99, $F9
.db $01, $AE, $03, $B0, $B1, $06, $B1, $B0
.db $03, $AE, $02, $80, $18, $AE, $04, $B0
.db $03, $B1, $06, $06, $B0, $03, $AE, $1B
.db $AA, $2A, $A7, $06, $22, $80, $0E, $F8
.db $B3, $9B, $B0, $30, $30, $F8, $B3, $9B
.db $2A, $A7, $06, $22, $80, $0E, $F8, $B3
.db $9B, $B0, $30, $B5, $F8, $CA, $9B, $B6
.db $06, $B3, $0C, $BA, $B3, $06, $BC, $B3
.db $B6, $B3, $12, $BA, $0C, $B3, $B0, $06
.db $0C, $B0, $12, $B8, $3C, $F8, $CA, $9B
.db $B0, $06, $AC, $B3, $AC, $B5, $AC, $B3
.db $AC, $B0, $AC, $B3, $AC, $B3, $AC, $B3
.db $AC, $AE, $B0, $B1, $B3, $B0, $B1, $B3
.db $B5, $B1, $B3, $B5, $B6, $B8, $0C, $B8
.db $F6, $41, $9B, $AE, $03, $B0, $B1, $06
.db $B1, $B0, $03, $AE, $02, $80, $19, $AE
.db $03, $B0, $B1, $06, $B1, $B0, $03, $AE
.db $1B, $F9, $B5, $18, $BC, $B9, $B5, $B1
.db $BA, $BC, $30, $F9, $01, $F5, $09, $70
.db $BA, $1E, $B7, $06, $B8, $BA, $BC, $03
.db $BD, $09, $BC, $06, $BA, $12, $B8, $0C
.db $BA, $03, $B8, $B7, $24, $B5, $06, $F5
.db $05, $B0, $03, $B3, $AE, $12, $BA, $0C
.db $B8, $0C, $F5, $09, $70, $01, $BA, $1D
.db $B7, $06, $B8, $BA, $BD, $0C, $BC, $06
.db $BA, $12, $B8, $06, $BA, $24, $C3, $06
.db $C1, $BF, $BD, $18, $F5, $05, $B0, $BA
.db $0C, $B8, $F5, $05, $F0, $F8, $43, $9C
.db $F5, $08, $60, $B9, $03, $BA, $06, $06
.db $03, $06, $B9, $0C, $BA, $F5, $05, $F0
.db $F8, $43, $9C, $F5, $08, $60, $B9, $03
.db $BA, $06, $06, $03, $06, $C1, $0C, $BF
.db $F6, $D5, $9B, $B9, $12, $BC, $B9, $0C
.db $BF, $BF, $06, $BD, $0C, $BC, $06, $BA
.db $0C, $B9, $03, $BA, $06, $06, $03, $06
.db $B9, $0C, $BA, $F9, $F8, $8E, $9C, $96
.db $06, $03, $03, $9E, $9D, $09, $A2, $0C
.db $A0, $F8, $8E, $9C, $96, $06, $03, $03
.db $A2, $A0, $06, $03, $A0, $0C, $9E, $F8
.db $B5, $9C, $06, $03, $06, $9D, $0C, $9B
.db $F8, $B5, $9C, $A2, $A0, $03, $9E, $06
.db $A0, $0C, $A2, $F6, $5C, $9C, $96, $06
.db $96, $03, $03, $9E, $9D, $09, $96, $06
.db $03, $03, $9B, $0C, $96, $06, $03, $03
.db $9E, $9D, $09, $99, $0C, $9B, $96, $06
.db $96, $03, $03, $9E, $9D, $09, $96, $06
.db $03, $03, $9B, $0C, $F9, $9D, $12, $A1
.db $9D, $0C, $9F, $12, $9B, $99, $0C, $95
.db $03, $96, $06, $06, $03, $06, $95, $0C
.db $96, $95, $03, $06, $F9, $01, $B5, $24
.db $B3, $0C, $B8, $24, $B3, $0C, $B7, $24
.db $B3, $0C, $B5, $18, $B7, $0C, $B5, $B5
.db $24, $B8, $0C, $B3, $24, $B5, $0C, $30
.db $B3, $18, $B6, $0C, $B5, $30, $B9, $0C
.db $BA, $12, $B7, $B3, $0C, $B5, $03, $06
.db $06, $03, $06, $0C, $0C, $03, $06, $06
.db $03, $06, $0C, $0C, $30, $B3, $12, $B7
.db $BA, $0C, $B5, $03, $06, $06, $03, $06
.db $0C, $0C, $03, $06, $06, $03, $06, $BD
.db $0C, $BC, $F6, $CE, $9C, $01, $F8, $4C
.db $9D, $B4, $B7, $1E, $B8, $0C, $BA, $F8
.db $4C, $9D, $B8, $BA, $12, $B7, $0C, $BD
.db $BC, $F8, $60, $9D, $B8, $06, $BA, $B8
.db $B7, $0C, $B7, $B8, $09, $BA, $0F, $F8
.db $60, $9D, $BC, $06, $BD, $BF, $C1, $18
.db $BF, $F6, $1E, $9D, $B4, $06, $B1, $B8
.db $B7, $1E, $B4, $06, $B1, $BC, $BB, $1E
.db $B4, $06, $B1, $B4, $B6, $B8, $B6, $F9
.db $B8, $1E, $B5, $06, $B8, $BA, $BD, $0C
.db $BC, $BA, $B8, $06, $BA, $24, $F9, $F8
.db $B7, $9D, $9F, $0C, $9F, $06, $0C, $9D
.db $9B, $F8, $B7, $9D, $9F, $12, $A2, $0C
.db $A0, $9F, $06, $9D, $24, $9B, $06, $9D
.db $99, $12, $A0, $06, $9F, $0C, $9D, $9B
.db $06, $99, $1E, $98, $06, $99, $9B, $0C
.db $9B, $06, $06, $06, $06, $06, $0C, $9D
.db $1E, $9B, $06, $9D, $99, $12, $A0, $0C
.db $9F, $9D, $06, $A2, $24, $A0, $06, $A2
.db $0C, $A0, $18, $9F, $F6, $6F, $9D, $9B
.db $06, $9C, $99, $99, $99, $99, $99, $99
.db $98, $99, $99, $99, $99, $99, $99, $99
.db $9B, $9C, $99, $99, $99, $99, $A0, $F9
.db $01, $F8, $20, $9E, $BB, $18, $BD, $F8
.db $20, $9E, $BF, $18, $BD, $BC, $01, $B5
.db $05, $B8, $06, $B5, $BC, $0C, $B8, $06
.db $B5, $BC, $B8, $0C, $06, $B1, $0C, $B5
.db $06, $B8, $0C, $B7, $B8, $BA, $BC, $BA
.db $B8, $09, $0F, $B5, $0C, $B8, $06, $B5
.db $B8, $BC, $0C, $B8, $06, $B5, $B1, $0C
.db $06, $B8, $BA, $0C, $06, $B5, $0C, $B3
.db $B3, $B3, $06, $B5, $B7, $B5, $0C, $06
.db $B7, $B8, $BA, $0C, $BC, $F6, $D1, $9D
.db $B8, $06, $B4, $B1, $0C, $BD, $BC, $06
.db $BB, $1E, $B8, $0C, $BD, $B8, $06, $B4
.db $B1, $BD, $12, $BC, $0C, $F9, $01, $B5
.db $06, $B1, $B5, $B3, $B0, $B3, $B0, $B1
.db $B0, $09, $AE, $0F, $A9, $0C, $AE, $3C
.db $F2, $A5, $06, $A2, $A5, $A4, $A1, $A4
.db $A1, $A2, $A1, $9D, $12, $9D, $0C, $A2
.db $3C, $F2, $01, $B8, $06, $B5, $B8, $B7
.db $B3, $B7, $B3, $B5, $B3, $AE, $12, $AC
.db $0C, $B1, $3C, $F2


LABEL_B12_9E6C:
.db	$04, $80, $80, $02
.db $08, $89, $F8, $01, $05, $01, $80, $A0
.db $02, $72, $89, $F8, $00, $05, $04, $80
.db $C0, $02, $D1, $89, $F8, $00, $09, $05
.db $C0, $E0, $02, $6F, $A9, $00, $00, $00
.db $00

LABEL_B12_9E91:
.db	$04, $80, $80, $02, $24, $8A, $E8
.db $01, $06, $01, $80, $A0, $02, $92, $8A
.db $F4, $00, $06, $04, $80, $C0, $02, $13
.db $8B, $E8, $00, $09, $05, $C0, $E0, $02
.db $F4, $A9, $00, $00, $00, $00

LABEL_B12_9EB6:
.db	$04, $80
.db $80, $02, $E7, $8B, $EA, $01, $05, $02
.db $80, $A0, $02, $70, $8C, $F6, $00, $04
.db $04, $80, $C0, $02, $13, $8D, $EA, $00
.db $06, $05, $C0, $E0, $02, $60, $AA, $00
.db $00, $00, $00

LABEL_B12_9EDB:
.db	$04, $80, $80, $02, $71
.db $8E, $E4, $01, $07, $02, $80, $A0, $02
.db $C6, $8E, $F0, $00, $04, $04, $80, $C0
.db $02, $07, $8F, $E4, $00, $06, $05, $C0
.db $E0, $02, $09, $AB, $00, $00, $00, $00

LABEL_B12_9F00:
.db $04, $80, $80, $02, $39, $8F, $EC, $01
.db $05, $02, $80, $A0, $02, $97, $8F, $F8
.db $00, $05, $04, $80, $C0, $02, $E6, $8F
.db $EC, $00, $09, $04, $C0, $E0, $02, $84
.db $AB, $00, $00, $00, $00

LABEL_B12_9F25:
.db	$04, $80, $80
.db $02, $1F, $90, $E8, $01, $05, $02, $80
.db $A0, $02, $B7, $90, $F4, $00, $05, $04
.db $80, $C0, $02, $F9, $90, $E8, $00, $09
.db $05, $C0, $E0, $02, $DC, $AB, $00, $00
.db $00, $00

LABEL_B12_9F4A:
.db	$03, $80, $80, $03, $AB, $91
.db $E0, $01, $05, $01, $80, $A0, $03, $0A
.db $92, $F8, $00, $04, $04, $80, $C0, $03
.db $AA, $91, $EC, $00, $09, $05

LABEL_B12_9F66:
.db	$04, $80
.db $80, $02, $5A, $92, $F0, $01, $06, $02
.db $80, $A0, $02, $8B, $92, $FC, $00, $05
.db $04, $80, $C0, $02, $C1, $92, $F0, $00
.db $09, $05, $C0, $E0, $02, $96, $AC, $00
.db $00, $00, $00

LABEL_B12_9F8B:
.db	$05, $00, $80, $02, $DE
.db $92, $EC, $01, $06, $FF, $80, $80, $02
.db $DE, $92, $EC, $01, $06, $02, $80, $A0
.db $02, $F1, $93, $F8, $00, $05, $04, $80
.db $C0, $02, $54, $94, $EC, $00, $06, $05
.db $C0, $E0, $02, $B7, $AC, $00, $00, $00
.db $00

LABEL_B12_9FB9:
.db	$05, $00, $80, $02, $6B, $97, $F0
.db $00, $09, $FF, $80, $80, $02, $A5, $94
.db $F4, $01, $09, $02, $80, $A0, $02, $C9
.db $94, $F4, $00, $05, $04, $80, $C0, $02
.db $EB, $94, $F4, $00, $06, $05, $C0, $E0
.db $02, $33, $AD, $00, $00, $00, $00

LABEL_B12_9FE7:
.db	$04
.db $80, $80, $03, $0C, $95, $EE, $01, $05
.db $01, $80, $A0, $03, $8B, $95, $FA, $00
.db $05, $04, $80, $C0, $03, $1A, $96, $EE
.db $00, $09, $05, $C0, $E0, $03, $74, $AD
.db $00, $00, $00, $00

LABEL_B12_A00C:
.db	$04, $80, $80, $02
.db $88, $96, $EE, $01, $05, $01, $80, $A0
.db $02, $E5, $96, $FA, $00, $05, $04, $80
.db $C0, $02, $1C, $97, $EE, $00, $09, $05
.db $C0, $E0, $02, $17, $AE, $00, $00, $00
.db $00

LABEL_B12_A031:
.db	$05, $00, $80, $02, $6B, $97, $F0
.db $00, $09, $01, $80, $80, $02, $6B, $97
.db $F0, $00, $09, $01, $80, $A0, $02, $AC
.db $97, $F0, $00, $05, $04, $80, $C0, $02
.db $CD, $97, $F0, $00, $06, $05, $C0, $E0
.db $02, $69, $AE, $00, $00, $00, $00

LABEL_B12_A05F:
.db	$05
.db $00, $80, $02, $FB, $97, $F4, $01, $06
.db $FF, $80, $80, $02, $FB, $97, $F4, $01
.db $06, $01, $80, $A0, $02, $2D, $98, $F4
.db $00, $05, $04, $80, $C0, $02, $6A, $98
.db $F4, $00, $06, $03, $C0, $E0, $02, $9E
.db $AE, $00, $00, $00, $00

LABEL_B12_A08D:
.db	$04, $80, $80
.db $02, $90, $98, $E6, $01, $05, $02, $80
.db $A0, $02, $F1, $98, $F2, $00, $05, $04
.db $80, $C0, $02, $79, $99, $E6, $00, $05
.db $02, $C0, $E0, $02, $DE, $AE, $00, $00
.db $00, $00

LABEL_B12_A0B2:
.db	$04, $80, $80, $02, $2A, $9A
.db $EE, $00, $06, $01, $80, $A0, $02, $D9
.db $9A, $FA, $00, $04, $04, $80, $C0, $02
.db $41, $9B, $EE, $00, $06, $05, $C0, $E0
.db $02, $57, $AF, $00, $00, $00, $00

LABEL_B12_A0D7:
.db	$04
.db $80, $80, $02, $D5, $9B, $E8, $01, $06
.db $01, $80, $A0, $02, $5C, $9C, $F4, $00
.db $05, $04, $80, $C0, $02, $CE, $9C, $E8
.db $00, $06, $05, $C0, $E0, $02, $F1, $AF
.db $00, $00, $00, $0F

LABEL_B12_A0FC:
.db	$04, $80, $80, $02
.db $1E, $9D, $E8, $01, $09, $01, $80, $A0
.db $02, $6F, $9D, $F4, $00, $06, $04, $80
.db $C0, $02, $D1, $9D, $E8, $00, $06, $05
.db $C0, $E0, $02, $5A, $B0, $00, $00, $00
.db $00

LABEL_B12_A121:
.db	$03, $80, $80, $02, $37, $9E, $EC
.db $00, $05, $01, $80, $A0, $02, $49, $9E
.db $EC, $00, $05, $04, $80, $C0, $02, $5B
.db $9E, $EC, $00, $06, $05, $FF

LABEL_B12_A13E:
.db	$01, $88
.db $E0, $01, $48, $A1, $00, $00, $01, $00
.db $F3, $07, $00, $20, $01, $00, $00, $20
.db $F7, $00, $04, $4A, $A1, $F2

LABEL_B12_A156:
.db	$02, $A8
.db $A0, $01, $69, $A1, $00, $00, $00, $00
.db $A8, $C0, $01, $69, $A1, $08, $02, $05
.db $00, $02, $00, $15, $04, $02, $40, $E0
.db $06, $FB, $F2, $04, $F7, $00, $04, $69
.db $A1, $01, $50, $F8, $14, $F2

LABEL_B12_A17E:
.db	$02, $A8
.db $A0, $01, $91, $A1, $00, $01, $04, $00
.db $A8, $C0, $01, $91, $A1, $F0, $01, $04
.db $00, $03, $FF, $F0, $02, $00, $60, $0A
.db $01, $02, $00, $E0, $18, $F2

LABEL_B12_A19E:
.db	$02, $A8
.db $A0, $01, $B1, $A1, $00, $00, $04, $00
.db $A8, $E0, $01, $C6, $A1, $00, $00, $04
.db $00, $03, $F0, $A0, $06, $03, $D0, $E7
.db $06, $03, $00, $8F, $05, $FB, $14, $14
.db $F7, $00, $05, $B9, $A1, $F2, $00, $20
.db $13, $06, $F5, $04, $04, $00, $20, $05
.db $14, $F2

LABEL_B12_A1D2:
.db	$02, $A8, $A0, $01, $E5, $A1
.db $00, $00, $00, $00, $A8, $E0, $01, $F2
.db $A1, $00, $00, $00, $00, $03, $F0, $90
.db $04, $03, $FF, $DC, $08, $03, $20, $E9
.db $14, $F2, $00, $10, $25, $04, $00, $40
.db $15, $04, $00, $80, $FB, $14, $F2

LABEL_B12_A1FF:
.db	$02
.db $88, $A0, $01, $12, $A2, $00, $00, $00
.db $00, $88, $C0, $01, $12, $A2, $F6, $00
.db $00, $00, $01, $60, $01, $FB, $F2, $04
.db $F7, $00, $02, $12, $A2, $00, $60, $01
.db $FB, $F6, $FC, $F7, $00, $04, $1D, $A2
.db $00, $60, $14, $F2

LABEL_B12_A22C:
.db	$02, $A8, $A0, $01
.db $3F, $A2, $03, $01, $00, $00, $A8, $E0
.db $01, $58, $A2, $03, $01, $00, $00, $03
.db $80, $09, $06, $03, $FF, $FC, $08, $F5
.db $01, $04, $FC, $00, $03, $FF, $03, $FB
.db $F4, $FC, $F7, $00, $0A, $4C, $A2, $F2
.db $00, $30, $20, $03, $00, $F0, $FE, $08
.db $00, $78, $FE, $14, $F2

LABEL_B12_A265:
.db	$01, $A8, $E0
.db $01, $6F, $A2, $00, $00, $00, $00, $F3
.db $03, $00, $10, $10, $04, $00, $80, $FD
.db $0A, $F5, $04, $04, $00, $60, $F8, $0A
.db $F2

LABEL_B12_A281:
.db	$02, $88, $A0, $01, $94, $A2, $00
.db $00, $02, $00, $88, $E0, $01, $B2, $A2
.db $00, $00, $02, $00, $03, $F0, $02, $00
.db $10, $02, $F7, $00, $0C, $94, $A2, $F2
.db $03, $00, $04, $04, $10, $04, $F7, $00
.db $04, $A0, $A2, $FC, $01, $05, $00, $EF
.db $10, $F2, $00, $20, $02, $00, $10, $04
.db $F7, $00, $05, $B2, $A2, $F5, $00, $04
.db $FC, $01, $00, $A3, $F7, $12, $F2

LABEL_B12_A2C7:
.db	$02
.db $A8, $A0, $01, $DA, $A2, $10, $00, $00
.db $04, $A8, $C0, $01, $DA, $A2, $00, $00
.db $00, $04, $01, $40, $15, $04, $01, $80
.db $EE, $08, $EF, $FF, $FB, $0A, $14, $F7
.db $00, $04, $DA, $A2, $01, $80, $FA, $14
.db $F2

LABEL_B12_A2F1:
.db	$02, $80, $A0, $01, $04, $A3, $03
.db $01, $09, $00, $80, $C0, $01, $04, $A3
.db $03, $00, $09, $00, $A2, $02, $A5, $A9
.db $AB, $AC, $AE, $18, $F2

LABEL_B12_A30D:
.db	$02, $80, $A0
.db $01, $20, $A3, $03, $01, $09, $00, $80
.db $C0, $01, $20, $A3, $03, $00, $09, $00
.db $B1, $0C, $99, $AA, $A7, $F6, $20, $A3

LABEL_B12_A328:
.db $02, $A8, $A0, $01, $3B, $A3, $03, $01
.db $00, $00, $A8, $E0, $01, $49, $A3, $03
.db $01, $00, $00, $03, $FF, $C1, $03, $F7
.db $00, $03, $3B, $A3, $03, $80, $12, $08
.db $F2, $00, $10, $38, $03, $F7, $00, $03
.db $49, $A3, $00, $40, $FA, $08, $F2

LABEL_B12_A357:
.db	$02
.db $88, $A0, $01, $6A, $A3, $00, $00, $00
.db $00, $88, $E0, $01, $74, $A3, $00, $00
.db $00, $00, $02, $80, $03, $01, $20, $04
.db $03, $80, $08, $F2, $F3, $03, $00, $10
.db $03, $00, $80, $04, $00, $20, $08, $F2

LABEL_B12_A380:
.db $02, $88, $A0, $01, $AD, $A3, $00, $01
.db $00, $00, $88, $C0, $01, $AD, $A3, $30
.db $01, $00, $00, $05, $20, $40, $1F, $FC
.db $00, $05, $A0, $04, $08, $20, $04, $05
.db $00, $02, $FB, $10, $10, $EF, $01, $F7
.db $02, $03, $99, $A3, $F2, $01, $80, $01
.db $00, $A0, $01, $02, $20, $01, $01, $00
.db $01, $FB, $10, $10, $EF, $01, $F7, $02
.db $08, $AD, $A3, $F2

LABEL_B12_A3C4:
.db	$02, $A8, $A0, $01
.db $D7, $A3, $00, $04, $01, $00, $A8, $C0
.db $01, $D7, $A3, $F6, $04, $01, $00, $01
.db $70, $05, $04, $01, $80, $FB, $03, $F5
.db $02, $04, $01, $10, $DD, $0A, $F2

LABEL_B12_A3E7:
.db	$02
.db $A8, $A0, $01, $FA, $A3, $00, $00, $05
.db $00, $A8, $E0, $01, $10, $A4, $00, $00
.db $00, $00, $00, $80, $73, $06, $F5, $09
.db $04, $00, $40, $76, $06, $FB, $1A, $0A
.db $EF, $01, $F7, $00, $08, $01, $A4, $F2
.db $00, $30, $0C, $06, $00, $40, $26, $06
.db $FB, $02, $02, $EF, $01, $F7, $00, $08
.db $14, $A4, $F2

LABEL_B12_A423:
.db	$01, $A8, $C0, $01, $2D
.db $A4, $00, $00, $00, $00, $01, $00, $33
.db $03, $01, $A0, $F6, $02, $00, $60, $10
.db $0A, $F2

LABEL_B12_A43A:
.db	$02, $80, $A0, $01, $4D, $A4
.db $03, $01, $04, $00, $80, $C0, $01, $4E
.db $A4, $03, $00, $04, $00, $04, $A5, $06
.db $9E, $A7, $A5, $18, $F2

LABEL_B12_A455:
.db	$01, $88, $C0
.db $01, $5F, $A4, $00, $00, $01, $00, $03
.db $00, $03, $03, $F0, $03, $F6, $5F, $A4

LABEL_B12_A468:
.db $01, $A8, $C0, $01, $72, $A4, $00, $00
.db $00, $03, $02, $00, $E7, $06, $01, $80
.db $0E, $0A, $F6, $72, $A4

LABEL_B12_A47D:
.db	$01, $88, $E0
.db $01, $87, $A4, $FA, $03, $04, $00, $00
.db $A0, $01, $00, $10, $01, $00, $80, $02
.db $00, $28, $03, $F2

LABEL_B12_A494:
.db	$03, $88, $80, $01
.db $B0, $A4, $FF, $01, $00, $05, $88, $A0
.db $01, $B0, $A4, $00, $01, $00, $05, $88
.db $E0, $01, $D3, $A4, $FF, $01, $00, $00
.db $02, $00, $04, $FB, $FF, $02, $F7, $00
.db $14, $B0, $A4, $02, $00, $08, $FB, $FE
.db $02, $F7, $00, $08, $BB, $A4, $F5, $00
.db $04, $02, $00, $50, $FC, $01, $02, $00
.db $FF, $50, $F2, $00, $80, $04, $FB, $FF
.db $FE, $F7, $00, $14, $D3, $A4, $00, $80
.db $08, $FB, $FF, $FE, $F7, $00, $08, $DE
.db $A4, $F5, $05, $04, $00, $80, $50, $FC
.db $01, $00, $80, $FF, $50, $F2

LABEL_B12_A4F6:
.db	$02, $A8
.db $A0, $01, $09, $A5, $00, $00, $00, $00
.db $A8, $C0, $01, $09, $A5, $00, $00, $00
.db $00, $02, $00, $F6, $0A, $FB, $F8, $F6
.db $F7, $00, $08, $09, $A5, $02, $00, $A0
.db $02, $EE, $01, $EF, $01, $FB, $0C, $12
.db $F7, $00, $0A, $15, $A5, $F2

LABEL_B12_A526:
.db	$02, $80
.db $A0, $01, $39, $A5, $00, $01, $04, $00
.db $80, $C0, $01, $3A, $A5, $04, $00, $04
.db $00, $02, $A5, $03, $A9, $AB, $AC, $AE
.db $B0, $30, $F2

LABEL_B12_A543:
.db	$01, $A8, $C0, $01, $4D
.db $A5, $03, $01, $09, $00, $01, $00, $DA
.db $04, $00, $10, $0B, $0E, $F2

LABEL_B12_A556:
.db	$02, $88
.db $A0, $01, $69, $A5, $00, $00, $01, $04
.db $88, $E0, $01, $72, $A5, $00, $00, $01
.db $00, $04, $50, $06, $F7, $00, $09, $69
.db $A5, $F2, $00, $40, $08, $F7, $00, $09
.db $72, $A5, $F2

LABEL_B12_A57B:
.db	$02, $88, $A0, $02, $8E
.db $A5, $00, $00, $02, $00, $88, $E0, $02
.db $95, $A5, $00, $00, $02, $00, $03, $40
.db $06, $03, $00, $08, $F2, $F3, $03, $00
.db $80, $06, $00, $60, $08, $F2

LABEL_B12_A59E:
.db	$01, $88
.db $C0, $02, $A8, $A5, $03, $00, $02, $00
.db $01, $00, $03, $F2

LABEL_B12_A5AC:
.db	$02, $80, $A0, $01
.db $C0, $A5, $03, $01, $00, $00, $80, $C0
.db $01, $BF, $A5, $03, $00, $04, $00, $02
.db $99, $02, $FB, $01, $02, $F7, $00, $10
.db $C0, $A5, $99, $30, $F2

LABEL_B12_A5CD:
.db	$02, $A8, $A0
.db $01, $E0, $A5, $17, $04, $00, $00, $A8
.db $C0, $01, $E0, $A5, $00, $01, $00, $00
.db $02, $80, $1D, $06, $02, $80, $29, $06
.db $FB, $0A, $0A, $EF, $01, $F7, $00, $04
.db $E4, $A5, $F2

LABEL_B12_A5F3:
.db	$02, $80, $A0, $01, $06
.db $A6, $04, $01, $02, $00, $80, $C0, $01
.db $06, $A6, $0A, $00, $03, $00, $99, $04
.db $FB, $01, $01, $F7, $00, $12, $06, $A6
.db $F2

LABEL_B12_A611:
.db	$02, $80, $A0, $03, $25, $A6, $00
.db $01, $0A, $00, $80, $C0, $03, $24, $A6
.db $00, $00, $0A, $00, $02, $B5, $12, $B1
.db $06, $30, $B8, $06, $B6, $0C, $B5, $06
.db $B3, $09, $B5, $B1, $06, $B1, $B5, $0C
.db $B3, $AC, $06, $AC, $24, $F2

LABEL_B12_A63E:
.db	$01, $88
.db $E0, $01, $48, $A6, $00, $00, $01, $00
.db $00, $40, $0E, $F7, $00, $03, $48, $A6
.db $F2

LABEL_B12_A651:
.db	$02, $80, $A0, $01, $65, $A6, $00
.db $01, $05, $00, $80, $C0, $01, $64, $A6
.db $00, $01, $05, $00, $02, $A9, $0C, $B0
.db $B1, $B0, $B1, $B3, $B0, $B5, $20, $F2

LABEL_B12_A670:
.db $02, $A8, $A0, $01, $83, $A6, $03, $00
.db $04, $00, $A8, $E0, $01, $91, $A6, $03
.db $00, $04, $00, $03, $00, $33, $06, $F7
.db $00, $03, $83, $A6, $03, $FF, $F3, $14
.db $F2, $00, $20, $06, $06, $F7, $00, $03
.db $91, $A6, $00, $FF, $F4, $14, $F2

LABEL_B12_A69F:
.db	$02
.db $A8, $A0, $01, $B2, $A6, $30, $00, $00
.db $04, $A8, $E0, $01, $C6, $A6, $00, $00
.db $00, $00, $02, $00, $F8, $03, $01, $F0
.db $1C, $0A, $FC, $00, $04, $00, $06, $03
.db $00, $06, $02, $00, $08, $F2, $00, $40
.db $E8, $03, $00, $10, $18, $0A, $FC, $00
.db $F5, $02, $04, $00, $40, $06, $00, $10
.db $06, $00, $30, $08, $F2

LABEL_B12_A6DD:
.db	$02, $A8, $A0
.db $01, $F0, $A6, $00, $00, $07, $00, $A8
.db $E0, $01, $07, $A7, $00, $00, $07, $00
.db $03, $40, $0C, $06, $F5, $00, $04, $00
.db $10, $07, $10, $FC, $00, $03, $40, $04
.db $03, $20, $06, $03, $60, $06, $F2, $F3
.db $03, $00, $40, $F7, $06, $F5, $00, $04
.db $00, $10, $07, $10, $F3, $07, $FC, $00
.db $00, $40, $05, $00, $20, $06, $00, $60
.db $06, $F2

LABEL_B12_A722:
.db	$02, $88, $A0, $01, $35, $A7
.db $0E, $09, $00, $00, $88, $E0, $01, $52
.db $A7, $0F, $0A, $00, $02, $03, $00, $06
.db $02, $40, $05, $F7, $00, $03, $35, $A7
.db $01, $00, $0A, $FC, $01, $03, $00, $12
.db $08, $FB, $0A, $0A, $F7, $00, $04, $45
.db $A7, $F2, $03, $00, $06, $02, $40, $05
.db $F7, $00, $03, $35, $A7, $01, $00, $0A
.db $FC, $01, $03, $00, $12, $08, $FB, $0A
.db $0A, $F7, $00, $04, $62, $A7, $F2

LABEL_B12_A76F:
.db	$02
.db $A8, $A0, $01, $82, $A7, $00, $00, $00
.db $00, $A8, $E0, $01, $8B, $A7, $00, $00
.db $00, $00, $03, $10, $F8, $08, $00, $FF
.db $41, $0A, $F2, $00, $20, $F8, $05, $00
.db $20, $0C, $0A, $F2

LABEL_B12_A794:
.db	$02, $A8, $A0, $01
.db $A7, $A7, $00, $04, $09, $00, $A8, $E0
.db $01, $B4, $A7, $00, $00, $09, $00, $01
.db $00, $7A, $08, $03, $80, $B3, $04, $00
.db $20, $00, $0E, $F2, $00, $30, $04, $08
.db $00, $30, $04, $04, $00, $40, $F8, $0E
.db $F2

LABEL_B12_A7C1:
.db	$02, $88, $A0, $01, $D4, $A7, $00
.db $00, $00, $00, $88, $E0, $01, $E1, $A7
.db $00, $00, $00, $00, $00, $80, $01, $03
.db $FF, $04, $03, $80, $04, $03, $FF, $06
.db $F2, $00, $20, $01, $00, $2F, $04, $00
.db $10, $04, $00, $80, $06, $F2

LABEL_B12_A7EE:
.db	$02, $A8
.db $A0, $01, $01, $A8, $00, $00, $00, $00
.db $A8, $C0, $01, $01, $A8, $03, $01, $00
.db $00, $04, $80, $08, $06, $04, $FF, $FC
.db $04, $04, $80, $FC, $0A, $04, $80, $F6
.db $0A, $F2

LABEL_B12_A812:
.db	$02, $A8, $A0, $01, $25, $A8
.db $00, $00, $00, $00, $A8, $E0, $01, $2E
.db $A8, $00, $00, $00, $00, $00, $70, $2E
.db $08, $03, $B0, $92, $06, $F2, $F3, $03
.db $00, $01, $03, $04, $00, $01, $2A, $06
.db $F5, $04, $04, $00, $40, $06, $06, $F2

LABEL_B12_A840:
.db $02, $A8, $A0, $01, $53, $A8, $00, $00
.db $00, $00, $A8, $E0, $01, $64, $A8, $00
.db $00, $00, $00, $00, $10, $4A, $04, $03
.db $40, $06, $05, $03, $00, $FC, $06, $03
.db $F0, $BA, $05, $F2, $F3, $03, $00, $01
.db $0A, $04, $00, $02, $06, $05, $00, $01
.db $0C, $03, $00, $01, $0A, $06, $F2

LABEL_B12_A877:
.dw	LABEL_B12_A88D
.dw	LABEL_B12_A890
.dw	LABEL_B12_A89D
.dw	LABEL_B12_A8A6
.dw	LABEL_B12_A8AF
.dw	LABEL_B12_A8BA
.dw	LABEL_B12_A8D9
.dw	LABEL_B12_A8E4
.dw	LABEL_B12_A8F5
.dw	LABEL_B12_A901
.dw	LABEL_B12_A90B

LABEL_B12_A88D:
.db	$00, $00, $82

LABEL_B12_A890:
.db $00, $00, $01, $02, $02, $03, $03, $04
.db $04, $05, $05, $06, $82

LABEL_B12_A89D:
.db	$01, $00, $01
.db $01, $03, $04, $07, $0A, $82

LABEL_B12_A8A6:
.db	$01, $00
.db $00, $00, $00, $00, $01, $01, $82

LABEL_B12_A8AF:
.db	$02
.db $01, $00, $01, $02, $02, $03, $03, $04
.db $04, $81

LABEL_B12_A8BA:
.db	$00, $00, $01, $01, $01, $01
.db $02, $02, $02, $02, $03, $03, $03, $03
.db $04, $04, $04, $04, $05, $05, $05, $05
.db $06, $06, $06, $06, $07, $07, $07, $08
.db $81

LABEL_B12_A8D9:
.db	$04, $04, $03, $03, $02, $02, $01
.db $01, $02, $02, $81

LABEL_B12_A8E4:
.db	$00, $00, $00, $00
.db $00, $00, $04, $05, $06, $07, $08, $09
.db $0A, $0B, $0E, $0F, $82

LABEL_B12_A8F5:
.db	$00, $00, $01
.db $01, $03, $03, $04, $05, $05, $05, $83
.db $04

LABEL_B12_A901:
.db	$02, $02, $03, $03, $02, $02, $01
.db $01, $00, $00

LABEL_B12_A90B:
.db	$02, $01, $00, $00, $01
.db $01, $02, $03, $04, $05, $81

LABEL_B12_A916:
.dw	LABEL_B12_A920
.dw	LABEL_B12_A936
.dw	LABEL_B12_A952
.dw	LABEL_B12_A969
.dw	LABEL_B12_A969

LABEL_B12_A920:
.db $01, $01, $01, $01, $01, $01, $01, $01
.db $01, $01, $00, $00, $01, $01, $02, $02
.db $01, $00, $01, $01, $02, $02

LABEL_B12_A936:
.db	$01, $00
.db $00, $01, $02, $03, $03, $02, $01, $00
.db $00, $01, $02, $03, $03, $02, $02, $01
.db $00, $00, $00, $01, $02, $03, $04, $03
.db $02, $01

LABEL_B12_A952:
.db	$00, $01, $02, $04, $05, $04
.db $03, $02, $01, $00, $01, $02, $03, $04
.db $05, $04, $03, $02, $01, $00, $01, $01
.db $81

LABEL_B12_A969:
.db	$01, $00, $00, $00, $81, $FF, $85
.db $03, $81, $81, $81, $AF, $81, $81, $81
.db $F7, $00, $0E, $6F, $A9, $85, $06, $85
.db $89, $85, $03, $85, $85, $06, $89, $85
.db $03, $85, $89, $06, $F8, $AD, $A9, $A1
.db $06, $85, $03, $81, $89, $06, $81, $03
.db $81, $F8, $AD, $A9, $A5, $06, $89, $8D
.db $8D, $85, $06, $85, $89, $85, $8D, $85
.db $8D, $85, $F6, $6F, $A9, $85, $06, $81
.db $03, $81, $AB, $06, $85, $03, $81, $A1
.db $06, $85, $03, $81, $89, $06, $81, $03
.db $81, $85, $06, $85, $03, $81, $AB, $06
.db $85, $03, $81, $A1, $06, $85, $03, $81
.db $89, $06, $81, $03, $81, $85, $06, $81
.db $03, $81, $AB, $06, $85, $03, $81, $A1
.db $06, $85, $03, $81, $89, $06, $81, $03
.db $81, $85, $06, $85, $03, $81, $AB, $06
.db $81, $03, $81, $F9, $85, $0C, $89, $F7
.db $00, $06, $F4, $A9, $85, $89, $06, $85
.db $89, $89, $85, $85, $85, $0C, $89, $F7
.db $00, $06, $04, $AA, $85, $06, $81, $89
.db $85, $81, $85, $89, $89, $F8, $3F, $AA
.db $85, $0C, $81, $06, $84, $89, $0C, $81
.db $85, $85, $89, $81, $F8, $3F, $AA, $89
.db $06, $85, $89, $85, $89, $85, $89, $85
.db $85, $04, $85, $89, $85, $85, $89, $89
.db $06, $85, $85, $8D, $F6, $F4, $A9, $85
.db $0C, $81, $06, $84, $89, $0C, $81, $85
.db $85, $89, $81, $F7, $00, $02, $3F, $AA
.db $85, $0C, $81, $06, $84, $89, $0C, $81
.db $85, $08, $85, $89, $85, $85, $89, $F9
.db $F8, $B8, $AA, $F8, $C2, $AA, $85, $06
.db $89, $85, $89, $85, $85, $A9, $85, $F8
.db $C2, $AA, $85, $0C, $89, $81, $06, $85
.db $A9, $0C, $F8, $B8, $AA, $85, $06, $89
.db $89, $85, $89, $85, $AD, $85, $F8, $D2
.db $AA, $80, $06, $85, $89, $12, $85, $06
.db $89, $0C, $85, $06, $89, $89, $85, $89
.db $89, $85, $89, $F8, $D2, $AA, $89, $06
.db $89, $85, $89, $89, $85, $85, $89, $85
.db $03, $85, $89, $06, $85, $03, $85, $89
.db $06, $85, $89, $8D, $8D, $F6, $60, $AA
.db $87, $0C, $8D, $06, $85, $0C, $85, $06
.db $8D, $85, $85, $0C, $8D, $06, $85, $0C
.db $85, $06, $8D, $0C, $F7, $00, $03, $C2
.db $AA, $F9, $85, $85, $89, $85, $85, $0C
.db $85, $06, $89, $85, $0C, $89, $12, $85
.db $03, $03, $89, $0C, $85, $06, $85, $89
.db $85, $85, $0C, $85, $06, $89, $85, $0C
.db $89, $12, $85, $03, $03, $89, $06, $8D
.db $0C, $85, $06, $89, $0C, $85, $89, $85
.db $89, $06, $85, $0C, $85, $06, $89, $0C
.db $F9, $85, $0C, $89, $F8, $66, $AB, $85
.db $0C, $89, $85, $03, $06, $03, $AE, $0C
.db $F8, $66, $AB, $85, $03, $06, $03, $89
.db $06, $85, $85, $03, $89, $06, $85, $03
.db $AE, $0C, $F8, $66, $AB, $85, $0C, $89
.db $85, $03, $06, $03, $AE, $0C, $F8, $66
.db $AB, $85, $09, $03, $89, $06, $85, $85
.db $03, $06, $03, $8D, $06, $85, $F8, $70
.db $AB, $85, $0C, $8D, $85, $06, $85, $8D
.db $85, $03, $85, $F8, $70, $AB, $85, $04
.db $8D, $85, $85, $89, $85, $85, $85, $85
.db $89, $8D, $8D, $F6, $0C, $AB, $85, $0C
.db $8D, $85, $8D, $85, $8D, $84, $8D, $F9
.db $85, $0C, $8D, $85, $8D, $85, $8D, $12
.db $85, $06, $8D, $85, $85, $0C, $8D, $85
.db $AE, $06, $85, $F9, $85, $12, $06, $8D
.db $15, $85, $03, $85, $0C, $85, $89, $18
.db $85, $12, $06, $8D, $15, $85, $03, $85
.db $0C, $06, $8D, $85, $8D, $85, $85, $F7
.db $00, $02, $84, $AB, $F8, $CF, $AB, $85
.db $06, $85, $89, $85, $12, $A5, $0C, $85
.db $89, $85, $06, $89, $8D, $8D, $F8, $CF
.db $AB, $85, $0C, $89, $06, $89, $85, $09
.db $03, $89, $06, $89, $85, $0C, $89, $81
.db $06, $85, $89, $85, $F6, $84, $AB, $85
.db $06, $85, $8D, $85, $12, $A5, $0C, $85
.db $8D, $85, $85, $F9, $80, $20, $F8, $69
.db $AC, $F8, $7B, $AC, $F8, $69, $AC, $A5
.db $0C, $AD, $12, $85, $06, $A9, $84, $A5
.db $06, $85, $03, $84, $A9, $06, $85, $A5
.db $84, $AD, $85, $03, $84, $F8, $69, $AC
.db $F8, $7B, $AC, $A5, $0C, $AD, $A5, $06
.db $81, $A9, $0C, $A5, $AD, $A5, $06, $81
.db $A9, $0C, $A5, $AD, $12, $84, $06, $A9
.db $85, $A5, $0C, $A9, $A5, $06, $89, $AD
.db $8D, $F8, $89, $AC, $A5, $06, $85, $AD
.db $12, $85, $06, $A9, $0C, $F8, $89, $AC
.db $A5, $06, $85, $A9, $85, $A6, $0C, $AB
.db $F8, $89, $AC, $A5, $06, $85, $A9, $0C
.db $85, $06, $85, $03, $84, $AD, $06, $85
.db $03, $84, $A9, $06, $85, $A5, $8D, $0C
.db $85, $03, $85, $89, $06, $85, $03, $84
.db $A9, $06, $85, $A5, $A9, $8D, $03, $8D
.db $8D, $8D, $85, $89, $AD, $AD, $F6, $DE
.db $AB, $A5, $0C, $AD, $0C, $A1, $06, $84
.db $AD, $0C, $A5, $0C, $8D, $A5, $06, $85
.db $AD, $0C, $F9, $A5, $0C, $AD, $A5, $06
.db $85, $AD, $84, $A5, $0C, $A9, $AF, $AF
.db $F9, $A5, $06, $85, $AD, $85, $0C, $85
.db $03, $85, $A9, $06, $85, $F9, $85, $0C
.db $85, $89, $F7, $00, $07, $96, $AC, $85
.db $85, $06, $85, $89, $0C, $85, $0C, $85
.db $89, $F7, $00, $06, $A5, $AC, $85, $89
.db $89, $85, $85, $85, $F6, $96, $AC, $F8
.db $10, $AD, $89, $12, $85, $03, $03, $89
.db $0C, $F8, $10, $AD, $89, $85, $06, $03
.db $03, $89, $0C, $F8, $F7, $AC, $81, $81
.db $89, $85, $89, $85, $89, $85, $85, $85
.db $8D, $0C, $F8, $F7, $AC, $89, $89, $89
.db $85, $85, $03, $85, $89, $06, $85, $03
.db $03, $89, $06, $85, $03, $85, $85, $85
.db $89, $85, $89, $85, $F6, $B7, $AC, $85
.db $06, $81, $85, $8D, $81, $85, $89, $85
.db $85, $81, $85, $8D, $85, $85, $03, $85
.db $89, $06, $81, $8D, $85, $85, $8D, $F9
.db $85, $0C, $89, $09, $84, $03, $0C, $89
.db $0C, $85, $0C, $89, $09, $84, $03, $0C
.db $89, $09, $85, $03, $85, $0C, $89, $09
.db $85, $03, $85, $0C, $89, $09, $85, $03
.db $85, $0C, $F9, $F8, $57, $AD, $85, $0C
.db $85, $0C, $89, $06, $85, $0C, $85, $06
.db $89, $0C, $F8, $57, $AD, $8D, $06, $8D
.db $8D, $06, $8D, $85, $8D, $03, $85, $85
.db $06, $85, $89, $8D, $F6, $33, $AD, $85
.db $0C, $89, $06, $85, $0C, $85, $06, $89
.db $0C, $85, $06, $85, $89, $85, $0C, $85
.db $06, $89, $0C, $85, $0C, $89, $06, $85
.db $0C, $89, $06, $F9, $F8, $F5, $AD, $85
.db $18, $89, $F8, $F5, $AD, $85, $0C, $89
.db $85, $06, $85, $89, $0C, $85, $0C, $89
.db $06, $85, $0C, $06, $89, $0C, $85, $89
.db $12, $85, $06, $89, $0C, $85, $06, $89
.db $89, $89, $8D, $85, $03, $85, $89, $06
.db $89, $F8, $07, $AE, $85, $06, $85, $89
.db $85, $89, $03, $85, $06, $03, $89, $06
.db $89, $F8, $07, $AE, $89, $06, $85, $89
.db $85, $85, $03, $06, $03, $89, $06, $85
.db $03, $85, $F8, $07, $AE, $85, $06, $85
.db $89, $85, $89, $03, $85, $06, $03, $89
.db $06, $89, $85, $06, $85, $89, $85, $0C
.db $85, $06, $89, $0C, $85, $06, $85, $89
.db $85, $0C, $85, $06, $89, $0C, $89, $06
.db $85, $85, $89, $85, $85, $85, $85, $8D
.db $0C, $85, $8D, $18, $F2, $85, $0C, $85
.db $89, $12, $85, $06, $85, $18, $89, $85
.db $0C, $0C, $89, $12, $85, $06, $F9, $85
.db $06, $85, $89, $85, $0C, $85, $06, $89
.db $0C, $F7, $00, $03, $07, $AE, $F9, $F8
.db $51, $AE, $85, $A1, $A5, $85, $0C, $85
.db $F8, $51, $AE, $85, $0C, $85, $18, $A1
.db $0C, $85, $85, $85, $85, $80, $18, $85
.db $85, $A1, $80, $85, $85, $A1, $80, $85
.db $80, $85, $80, $85, $85, $A1, $80, $85
.db $85, $A1, $80, $85, $85, $A1, $80, $85
.db $80, $85, $80, $85, $A1, $A1, $F6, $17
.db $AE, $85, $0C, $85, $A1, $18, $85, $A1
.db $85, $12, $85, $A1, $18, $85, $0C, $A1
.db $85, $85, $0C, $85, $A1, $18, $85, $A1
.db $F9, $85, $03, $85, $85, $0C, $81, $89
.db $85, $85, $81, $89, $81, $F7, $00, $03
.db $6C, $AE, $85, $0C, $81, $89, $85, $85
.db $89, $89, $8D, $85, $80, $89, $85, $85
.db $85, $89, $85, $85, $85, $06, $85, $89
.db $85, $0C, $85, $06, $85, $0C, $85, $89
.db $85, $06, $85, $F6, $6C, $AE, $F8, $CF
.db $AE, $85, $03, $89, $0C, $85, $09, $03
.db $89, $0C, $F7, $00, $02, $9E, $AE, $F8
.db $CF, $AE, $85, $03, $89, $0C, $85, $09
.db $03, $89, $09, $85, $0C, $03, $89, $0C
.db $85, $09, $03, $89, $09, $85, $0C, $03
.db $89, $0C, $8D, $8D, $F6, $9E, $AE, $85
.db $09, $03, $89, $09, $85, $03, $85, $09
.db $03, $89, $09, $85, $0C, $F9, $F8, $32
.db $AF, $85, $06, $89, $0C, $85, $06, $89
.db $8D, $8D, $F7, $00, $03, $DE, $AE, $F8
.db $32, $AF, $85, $06, $89, $0C, $85, $06
.db $03, $03, $89, $06, $03, $03, $85, $06
.db $03, $03, $AD, $06, $85, $03, $03, $F7
.db $00, $07, $FE, $AE, $85, $06, $89, $8D
.db $8D, $85, $06, $03, $03, $AD, $06, $85
.db $03, $03, $F7, $00, $04, $11, $AF, $85
.db $06, $89, $89, $85, $89, $89, $85, $89
.db $85, $89, $89, $85, $89, $0C, $89, $F6
.db $DE, $AE, $85, $09, $03, $A9, $06, $A6
.db $81, $85, $03, $84, $AB, $0C, $85, $06
.db $81, $03, $85, $89, $06, $87, $0C, $85
.db $06, $A9, $85, $85, $06, $85, $A9, $A6
.db $0C, $85, $06, $89, $85, $0C, $F9, $F8
.db $C5, $AF, $85, $89, $85, $06, $85, $89
.db $85, $F8, $C5, $AF, $85, $09, $03, $89
.db $06, $85, $03, $85, $85, $09, $03, $89
.db $06, $85, $03, $85, $F8, $C5, $AF, $85
.db $89, $85, $06, $85, $89, $85, $F8, $C5
.db $AF, $85, $09, $03, $89, $06, $85, $03
.db $85, $85, $06, $03, $03, $89, $06, $85
.db $03, $85, $F8, $D0, $AF, $85, $09, $85
.db $03, $89, $06, $85, $85, $09, $85, $03
.db $89, $06, $85, $89, $06, $85, $89, $85
.db $85, $06, $03, $03, $89, $06, $85, $F8
.db $D0, $AF, $85, $06, $85, $89, $85, $85
.db $85, $89, $85, $85, $85, $89, $85, $AF
.db $0C, $AF, $F6, $57, $AF, $85, $0C, $AD
.db $85, $AD, $F7, $00, $03, $C5, $AF, $F9
.db $85, $09, $85, $03, $89, $06, $85, $85
.db $09, $85, $03, $A9, $0C, $85, $09, $85
.db $03, $89, $06, $85, $85, $09, $85, $03
.db $A9, $06, $85, $F7, $00, $03, $D0, $AF
.db $F9, $F8, $2D, $B0, $8D, $0C, $8D, $F8
.db $2D, $B0, $8D, $06, $84, $03, $84, $8D
.db $06, $84, $03, $84, $F8, $3D, $B0, $89
.db $85, $03, $85, $06, $85, $85, $03, $85
.db $06, $8D, $0C, $8D, $F8, $3D, $B0, $8D
.db $85, $03, $85, $06, $85, $85, $03, $85
.db $06, $85, $03, $89, $89, $89, $85, $85
.db $8D, $8D, $F6, $F1, $AF, $85, $06, $81
.db $03, $81, $AD, $06, $81, $03, $81, $F7
.db $00, $07, $2D, $B0, $F9, $85, $06, $85
.db $89, $85, $81, $85, $89, $85, $85, $85
.db $89, $85, $81, $85, $89, $85, $85, $03
.db $85, $06, $85, $85, $03, $85, $06, $89
.db $0C, $F9, $F8, $A3, $B0, $85, $85, $81
.db $81, $AD, $84, $81, $85, $85, $06, $89
.db $8D, $8D, $F8, $A3, $B0, $85, $85, $81
.db $81, $AD, $84, $85, $85, $89, $04, $89
.db $85, $89, $03, $81, $81, $AF, $F8, $A3
.db $B0, $85, $81, $81, $81, $89, $81, $85
.db $85, $85, $85, $89, $89, $85, $89, $8D
.db $8D, $F8, $A3, $B0, $89, $04, $89, $85
.db $89, $89, $85, $85, $06, $89, $8D, $8D
.db $F6, $5A, $B0, $85, $03, $81, $85, $81
.db $A9, $81, $81, $81, $85, $85, $85, $85
.db $A9, $81, $81, $81, $85, $81, $85, $81
.db $A9, $81, $81, $81, $85, $81, $85, $81
.db $A9, $81, $81, $81, $85, $81, $85, $81
.db $A9, $81, $81, $81, $85, $85, $85, $85
.db $A9, $81, $85, $81, $F9, $85, $03, $81
.db $81, $81, $89, $81, $81, $81, $85, $85
.db $85, $85, $89, $81, $81, $81, $85, $81
.db $81, $81, $A9, $81, $81, $81, $81, $81
.db $85, $85, $89, $81, $81, $81, $85, $03
.db $81, $81, $81, $89, $81, $81, $81, $85
.db $85, $85, $85, $89, $81, $81, $81, $F9

LABEL_B12_B108:
.db $5C, $20, $44, $4F, $44, $47, $45, $53
.db $60, $5B, $40, $53, $20, $82, $2E, $63

LABEL_B12_B118:
.db $5B, $20, $44, $4F, $44, $47, $45, $53
.db $60, $5C, $40, $53, $20, $82, $2E, $63

LABEL_B12_B128:
.db $5B, $20, $53, $50, $45, $41, $4B, $53
.db $2E, $62

LABEL_B12_B132:
.db	$5C, $20, $41, $4E, $53, $57
.db $45, $52, $53, $2E, $63

LABEL_B12_B13D:
.db	$5B, $20, $41
.db $4E, $44, $20, $5C, $60, $88, $20, $55
.db $4E, $44, $45, $52, $53, $54, $41, $4E
.db $44, $61, $45, $41, $43, $48, $20, $4F
.db $54, $48, $45, $52, $2E, $63

LABEL_B12_B15E:
.db	$5C, $20
.db $42, $4C, $4F, $43, $4B, $53, $60, $F6
.db $20, $52, $45, $54, $52, $45, $41, $54
.db $2E, $63

LABEL_B12_B172:
.db	$5B, $40, $53, $20, $84, $49
.db $53, $60, $F8, $83, $2E, $63, $5C, $40
.db $53, $20, $EF, $60, $49, $53, $20, $F8
.db $83, $2E, $63

LABEL_B12_B18B:
.db	$41, $4E, $20, $49, $4E
.db $56, $49, $53, $49, $42, $4C, $45, $20
.db $EF, $85, $20, $41, $52, $49, $53, $45
.db $53, $2E, $63

LABEL_B12_B1A3:
.db	$DE, $84, $85, $60, $87
.db $20, $DE, $61, $5C, $40, $53, $20, $82
.db $2E, $63

LABEL_B12_B1B2:
.db	$DE, $84, $85, $60, $87, $20
.db $DE, $61, $5C, $40, $53, $20, $EF, $2E
.db $63

LABEL_B12_B1C1:
.db	$DE, $84, $85, $60, $44, $49, $53
.db $41, $50, $50, $45, $41, $52, $2E, $63

LABEL_B12_B1D0:
.db $5B, $20, $49, $53, $20, $86, $2E, $63

LABEL_B12_B1D8:
.db $5C, $20, $49, $53, $60, $86, $2E, $63

LABEL_B12_B1E0:
.db $5C, $20, $49, $53, $20, $54, $49, $45
.db $44, $60, $55, $50, $2E, $63

LABEL_B12_B1EE:
.db	$5B, $20
.db $49, $53, $20, $54, $49, $45, $44, $20
.db $55, $50, $2E, $63

LABEL_B12_B1FC:
.db	$5B, $20, $88, $20
.db $F3, $2E, $63

LABEL_B12_B203:
.db	$5C, $20, $88, $60, $F3
.db $2E, $63

LABEL_B12_B20A:
.db	$5B, $20, $52, $45, $F3, $53
.db $20, $DE, $60, $42, $49, $4E, $44, $49
.db $4E, $47, $53, $2E, $63

LABEL_B12_B21D:
.db	$5C, $20, $52
.db $45, $F3, $53, $60, $DE, $42, $49, $4E
.db $44, $49, $4E, $47, $53, $2E, $63

LABEL_B12_B22F:
.db	$5B
.db $20, $49, $53, $20, $42, $55, $52, $53
.db $54, $49, $4E, $47, $60, $57, $49, $54
.db $48, $20, $53, $54, $52, $45, $4E, $47
.db $54, $48, $2E, $63

LABEL_B12_B24C:
.db	$5C, $20, $52, $45
.db $43, $4F, $49, $4C, $53, $60, $49, $4E
.db $20, $46, $45, $41, $52, $2E, $63

LABEL_B12_B25F:
.db	$80
.db $20, $41, $4E, $44, $20, $48, $45, $52
.db $60, $43, $4F, $4D, $50, $F6, $20, $45
.db $53, $43, $41, $50, $45, $61, $51, $55
.db $49, $43, $4B, $4C, $59, $2E, $63

LABEL_B12_B27F:
.db	$D1
.db $20, $57, $41, $53, $20, $4E, $4F, $20
.db $54, $52, $41, $50, $2E, $65

LABEL_B12_B28E:
.db	$5B, $20
.db $53, $50, $4F, $54, $54, $45, $44, $20
.db $41, $4E, $44, $60, $44, $49, $53, $41
.db $52, $4D, $45, $44, $20, $DE, $54, $52
.db $41, $50, $2E, $65

LABEL_B12_B2AC:
.db	$5B, $20, $55, $53
.db $45, $53, $60, $5D, $2E, $63

LABEL_B12_B2B6:
.db	$5B, $20
.db $45, $51, $55, $49, $50, $53, $60, $5D
.db $2E, $62

LABEL_B12_B2C2:
.db	$5B, $20, $44, $52, $4F, $50
.db $53, $60, $5D, $2E, $65

LABEL_B12_B2CD:
.db	$42, $55, $54
.db $20, $49, $54, $20, $48, $41, $53, $20
.db $4E, $4F, $60, $45, $46, $46, $45, $43
.db $54, $2E, $63

LABEL_B12_B2E3:
.db	$55, $53, $49, $4E, $47
.db $20, $5D, $60, $C7, $20, $44, $4F, $20
.db $4E, $4F, $20, $47, $4F, $4F, $44, $61
.db $D2, $2E, $65

LABEL_B12_B2FB:
.db	$88, $20, $44, $49, $53
.db $F5, $60, $D2, $21, $65

LABEL_B12_B305:
.db	$F5, $45, $44
.db $2E, $63

LABEL_B12_B30A:
.db	$44, $49, $53, $F5, $45, $44
.db $2E, $63

LABEL_B12_B312:
.db	$4E, $4F, $F7, $20, $48, $41
.db $50, $50, $45, $4E, $53, $2C, $60, $AE
.db $2E, $63

LABEL_B12_B322:
.db	$5C, $20, $48, $45, $41, $52
.db $53, $20, $54, $48, $45, $60, $46, $4C
.db $55, $54, $45, $20, $41, $4E, $44, $20
.db $46, $41, $4C, $4C, $53, $61, $41, $53
.db $4C, $45, $45, $50, $2E, $63, $5C, $40
.db $53, $20, $45, $59, $45, $53, $60, $4C
.db $4F, $4F, $4B, $20, $56, $41, $43, $41
.db $4E, $54, $2E, $63

LABEL_B12_B35C:
.db	$88, $20, $44, $4F
.db $20, $DC, $60, $D2, $2E, $63

LABEL_B12_B366:
.db	$5B, $20
.db $54, $41, $4B, $45, $53, $20, $4F, $55
.db $54, $60, $5D, $2E, $63

LABEL_B12_B375:
.db	$49, $54, $20
.db $44, $4F, $45, $53, $4E, $40, $54, $20
.db $53, $45, $45, $4D, $20, $54, $4F, $42
.db $45, $20, $42, $52, $4F, $4B, $45, $4E
.db $2E, $65

LABEL_B12_B392:
.db	$88, $20, $47, $4F, $20, $46
.db $4F, $52, $57, $41, $52, $44, $2C, $49
.db $54, $40, $53, $20, $50, $49, $54, $43
.db $48, $20, $42, $4C, $41, $43, $4B, $2E
.db $65

LABEL_B12_B3B1:
.db	$DE, $42, $4F, $54, $54, $4C, $45
.db $43, $41, $50, $60, $4F, $50, $45, $4E
.db $53, $20, $41, $4E, $44, $20, $DE, $61
.db $43, $4F, $4E, $54, $45, $4E, $54, $53
.db $20, $51, $55, $49, $45, $54, $4C, $59
.db $60, $4C, $45, $41, $4B, $20, $4F, $55
.db $54, $2E, $63

LABEL_B12_B3E3:
.db	$42, $55, $54, $20, $81
.db $20, $88, $60, $4F, $50, $45, $4E, $20
.db $DE, $42, $4F, $54, $54, $4C, $45, $2E
.db $65

LABEL_B12_B3F9:
.db	$49, $54, $20, $53, $54, $49, $4E
.db $4B, $53, $21, $65

LABEL_B12_B404:
.db	$5B, $20, $48, $41
.db $53, $20, $41, $20, $54, $45, $52, $52
.db $49, $2D, $60, $42, $4C, $45, $20, $50
.db $52, $45, $4D, $4F, $4E, $49, $54, $49
.db $4F, $4E, $2E, $65

LABEL_B12_B424:
.db	$5B, $20, $46, $45
.db $45, $4C, $53, $60, $4E, $4F, $F7, $2E
.db $65

LABEL_B12_B431:
.db	$5C, $20, $53, $45, $45, $53, $20
.db $DE, $60, $52, $45, $44, $20, $46, $4C
.db $41, $4D, $45, $20, $41, $4E, $44, $61
.db $42, $45, $43, $4F, $4D, $45, $53, $20
.db $41, $46, $52, $41, $49, $44, $2E, $63

LABEL_B12_B458:
.db $5B, $20, $52, $41, $49, $53, $45, $53
.db $60, $5D, $20, $54, $4F, $57, $41, $52
.db $44, $53, $61, $DE, $53, $4B, $59, $2E
.db $63

LABEL_B12_B471:
.db	$5B, $20, $54, $41, $4B, $45, $53
.db $20, $DE, $4E, $55, $54, $60, $4F, $46
.db $20, $D7, $20, $41, $4E, $44, $20, $50
.db $55, $54, $53, $61, $49, $54, $20, $49
.db $4E, $20, $DE, $BC, $4E, $50, $4F, $54
.db $2E, $65

LABEL_B12_B49A:
.db	$5B, $20, $54, $41, $4B, $45
.db $53, $20, $DE, $4E, $55, $54, $60, $4F
.db $46, $20, $D7, $2C, $20, $42, $55, $54
.db $20, $49, $54, $61, $53, $48, $52, $49
.db $56, $45, $4C, $53, $20, $55, $50, $20
.db $41, $46, $54, $45, $52, $60, $41, $20
.db $46, $45, $57, $20, $4D, $4F, $4D, $45
.db $4E, $54, $53, $2E, $65

LABEL_B12_B4D5:
.db	$41, $20, $56
.db $49, $53, $49, $4F, $4E, $20, $4F, $46
.db $20, $41, $60, $43, $45, $4C, $45, $53
.db $54, $49, $41, $4C, $20, $89, $61, $41
.db $50, $50, $45, $41, $52, $20, $49, $4E
.db $20, $DE, $60, $53, $4B, $59, $2E, $65

LABEL_B12_B500:
.db $4D, $59, $41, $55, $20, $49, $53, $4E
.db $40, $54, $20, $48, $55, $4E, $47, $52
.db $59, $2C, $60, $53, $4F, $20, $53, $48
.db $45, $20, $50, $55, $54, $53, $20, $DE
.db $61, $46, $4F, $4F, $44, $20, $42, $41
.db $43, $4B, $2E, $65

LABEL_B12_B52C:
.db	$8A, $20, $53, $48
.db $41, $4B, $45, $53, $20, $48, $49, $53
.db $60, $48, $45, $41, $44, $20, $22, $4E
.db $4F, $22, $2E, $65

LABEL_B12_B544:
.db	$8A, $20, $49, $53
.db $60, $48, $41, $52, $44, $48, $45, $41
.db $44, $45, $44, $2E, $65

LABEL_B12_B555:
.db	$DA, $20, $4E
.db $4F, $20, $4E, $45, $45, $44, $60, $54
.db $4F, $20, $55, $53, $45, $20, $DC, $2E
.db $65

LABEL_B12_B569:
.db	$D1, $20, $44, $4F, $45, $53, $4E
.db $40, $54, $20, $53, $45, $45, $4D, $54
.db $4F, $20, $42, $45, $20, $F6, $F7, $61
.db $53, $50, $45, $43, $49, $41, $4C, $20
.db $41, $42, $4F, $55, $54, $20, $49, $54
.db $2E, $65

LABEL_B12_B592:
.db	$E1, $46, $4F, $55, $4E, $44
.db $60, $5D, $2E, $65

LABEL_B12_B59C:
.db	$5B, $20, $46, $45
.db $45, $4C, $53, $20, $56, $45, $52, $59
.db $60, $4C, $49, $47, $48, $54, $2E, $63

LABEL_B12_B5B0:
.db $5B, $20, $49, $53, $60, $8E, $45, $44
.db $2E, $65

LABEL_B12_B5BA:
.db	$4F, $44, $49, $4E, $20, $88
.db $20, $55, $53, $45, $60, $EF, $2E, $63

LABEL_B12_B5C8:
.db $5B, $20, $48, $41, $53, $20, $F8, $60
.db $4C, $45, $41, $52, $4E, $45, $44, $20
.db $EF, $20, $59, $45, $54, $63

LABEL_B12_B5DE:
.db	$5B, $20
.db $88, $20, $45, $51, $55, $49, $50, $60
.db $DC, $20, $49, $54, $45, $4D, $2E, $65

LABEL_B12_B5F0:
.db $E1, $4E, $45, $45, $44, $20, $F8, $45
.db $51, $55, $49, $50, $DC, $20, $49, $54
.db $45, $4D, $2E, $65

LABEL_B12_B604:
.db	$E1, $47, $41, $49
.db $4E, $45, $44, $20, $5E, $60, $45, $58
.db $50, $45, $52, $49, $45, $4E, $43, $45
.db $20, $50, $4F, $49, $4E, $54, $53, $2E
.db $65

LABEL_B12_B621:
.db	$5B, $20, $41, $44, $56, $41, $4E
.db $43, $45, $44, $60, $41, $20, $4C, $45
.db $56, $45, $4C, $2E, $65

LABEL_B12_B635:
.db	$5B, $20, $4C
.db $45, $41, $52, $4E, $45, $44, $60, $41
.db $20, $53, $50, $45, $4C, $4C, $2E, $65

LABEL_B12_B648:
.db $DB, $20, $5E, $60, $A1, $20, $49, $4E
.db $53, $49, $44, $45, $2E, $65

LABEL_B12_B656:
.db	$C6, $20
.db $F9, $54, $4F, $60, $4F, $50, $45, $4E
.db $20, $49, $54, $3F, $62

LABEL_B12_B665:
.db	$49, $54, $40
.db $53, $20, $45, $4D, $50, $54, $59, $2E
.db $65

LABEL_B12_B671:
.db	$E1, $88, $20, $8D, $60, $F6, $4D
.db $4F, $52, $45, $2E, $61, $C6, $20, $F9
.db $54, $4F, $60, $44, $52, $4F, $50, $20
.db $D5, $F7, $3F, $62

LABEL_B12_B68C:
.db	$57, $48, $41, $54
.db $20, $C6, $20, $F9, $60, $54, $4F, $20
.db $44, $52, $4F, $50, $3F, $62

LABEL_B12_B69E:
.db	$5D, $20
.db $49, $53, $20, $60, $44, $52, $4F, $50
.db $50, $45, $44, $2C, $65

LABEL_B12_B6AD:
.db	$41, $4E, $44
.db $20, $5D, $20, $49, $53, $60, $50, $49
.db $43, $4B, $45, $44, $20, $55, $50, $2E
.db $65

LABEL_B12_B6C1:
.db	$5D, $20, $49, $53, $20, $F8, $60
.db $4E, $45, $45, $44, $45, $44, $3F, $62

LABEL_B12_B6D0:
.db $5D, $20, $49, $53, $60, $41, $42, $41
.db $4E, $44, $FD, $44, $2E, $65

LABEL_B12_B6DE:
.db	$5D, $20
.db $53, $48, $FF, $4E, $40, $54, $60, $42
.db $45, $20, $54, $48, $52, $4F, $57, $4E
.db $20, $41, $57, $41, $59, $2E, $65

LABEL_B12_B6F7:
.db	$F8
.db $45, $4E, $4F, $55, $47, $48, $20, $EF
.db $60, $50, $4F, $49, $4E, $54, $53, $2E
.db $63

LABEL_B12_B709:
.db	$5B, $20, $49, $53, $20, $53, $54
.db $49, $4C, $4C, $60, $41, $4C, $49, $56
.db $45, $2E, $63

LABEL_B12_B71B:
.db	$5C, $60, $49, $53, $20
.db $4B, $49, $4C, $4C, $45, $44, $2E, $65

LABEL_B12_B728:
.db $5B, $20, $44, $49, $45, $44, $2E, $63

LABEL_B12_B730:
.db $5B, $20, $49, $53, $20, $41, $4C, $52
.db $45, $41, $44, $59, $60, $44, $45, $41
.db $44, $2E, $63

LABEL_B12_B743:
.db	$81, $20, $41, $54, $45
.db $20, $DE, $4E, $55, $54, $60, $4F, $46
.db $20, $D7, $2E, $65

LABEL_B12_B754:
.db	$D0, $20, $EC, $57
.db $45, $60, $47, $4F, $49, $4E, $47, $3F
.db $62

LABEL_B12_B761:
.db	$8B, $8C, $53, $4B, $55, $52, $45
.db $20, $4F, $4E, $20, $93, $3F, $62

LABEL_B12_B76F:
.db	$8B
.db $8C, $55, $5A, $4F, $20, $4F, $4E, $20
.db $94, $3F, $62

LABEL_B12_B77B:
.db	$8B, $8C, $95, $20, $4F
.db $4E, $20, $CF, $3F, $62

LABEL_B12_B785:
.db	$8B, $41, $54
.db $20, $53, $4B, $55, $52, $45, $2E, $62

LABEL_B12_B790:
.db $8B, $41, $54, $20, $55, $5A, $4F, $2E
.db $62

LABEL_B12_B799:
.db	$8B, $41, $54, $20, $95, $2E, $62
.db $4C, $45, $54, $40, $53, $20, $47, $4F
.db $21, $63

LABEL_B12_B7AA:
.db	$DE, $50, $41, $54, $48, $20
.db $49, $4E, $20, $DE, $60, $57, $4F, $4F
.db $44, $53, $20, $49, $53, $20, $55, $4E
.db $43, $4C, $45, $41, $52, $2E, $65

LABEL_B12_B7C7:
.db	$E4
.db $49, $53, $20, $41, $4E, $20, $41, $52
.db $4D, $4F, $52, $59, $2E, $C6, $20, $F9
.db $54, $4F, $20, $42, $55, $59, $61, $D5
.db $F7, $3F, $62

LABEL_B12_B7E3:
.db	$57, $45, $4C, $4C, $2C
.db $20, $43, $4F, $4D, $45, $20, $41, $47
.db $41, $49, $4E, $2E, $65

LABEL_B12_B7F5:
.db	$57, $48, $49
.db $43, $48, $20, $C6, $20, $F9, $60, $54
.db $4F, $20, $42, $55, $59, $3F, $62

LABEL_B12_B807:
.db	$B4
.db $2E, $60, $F6, $F7, $20, $45, $4C, $53
.db $45, $3F, $62

LABEL_B12_B813:
.db	$E1, $88, $20, $8D, $60
.db $F6, $20, $4D, $4F, $52, $45, $2E, $61
.db $B4, $20, $41, $4E, $44, $60, $43, $4F
.db $4D, $45, $20, $41, $47, $41, $49, $4E
.db $2E, $65

LABEL_B12_B832:
.db	$E4, $49, $53, $20, $41, $60
.db $46, $49, $52, $53, $54, $20, $46, $4F
.db $4F, $44, $20, $53, $48, $4F, $50, $2E
.db $61, $57, $FF, $20, $E1, $4C, $49, $4B
.db $45, $20, $54, $4F, $60, $42, $55, $59
.db $20, $D5, $F7, $3F, $62

LABEL_B12_B85D:
.db	$E4, $49, $53
.db $20, $41, $60, $53, $45, $43, $4F, $4E
.db $44, $2D, $48, $41, $4E, $44, $20, $53
.db $48, $4F, $50, $2E, $61, $43, $41, $4E
.db $20, $49, $20, $CA, $20, $59, $4F, $55
.db $3F, $62

LABEL_B12_B882:
.db	$57, $48, $41, $54, $20, $57
.db $FF, $20, $E1, $60, $4C, $49, $4B, $45
.db $20, $54, $4F, $20, $53, $45, $4C, $4C
.db $3F, $62

LABEL_B12_B89A:
.db	$5D, $3F, $20, $4C, $45, $54
.db $20, $4D, $45, $60, $53, $45, $45, $2E
.db $2E, $2E, $2E, $2E, $61, $48, $4F, $57
.db $20, $41, $42, $4F, $55, $54, $20, $5E
.db $60, $A1, $3F, $62

LABEL_B12_B8BC:
.db	$B4, $2E, $60, $F6
.db $F7, $20, $45, $4C, $53, $45, $3F, $62

LABEL_B12_B8C8:
.db $E4, $49, $53, $20, $41, $20, $48, $4F
.db $53, $50, $49, $54, $41, $4C, $C6, $20
.db $4E, $45, $45, $44, $20, $CA, $3F, $62

LABEL_B12_B8E0:
.db $DE, $46, $45, $45, $20, $46, $4F, $52
.db $60, $48, $45, $41, $4C, $49, $4E, $47
.db $20, $49, $53, $20, $5E, $61, $A1, $2E
.db $20, $49, $53, $20, $DC, $60, $41, $43
.db $43, $45, $50, $54, $41, $42, $4C, $45
.db $3F, $62

LABEL_B12_B90A:
.db	$44, $4F, $45, $53, $20, $F6
.db $FD, $20, $45, $4C, $53, $45, $60, $4E
.db $45, $45, $44, $20, $54, $4F, $20, $42
.db $45, $20, $86, $3F, $62

LABEL_B12_B925:
.db	$57, $48, $4F
.db $20, $4E, $45, $45, $44, $53, $20, $54
.db $4F, $20, $42, $45, $60, $86, $3F, $62

LABEL_B12_B938:
.db $B4, $20, $46, $4F, $52, $60, $57, $41
.db $49, $54, $49, $4E, $47, $2E, $54, $41
.db $4B, $45, $20, $43, $41, $52, $45, $2E
.db $65

LABEL_B12_B951:
.db	$49, $40, $4D, $20, $53, $4F, $52
.db $52, $59, $20, $49, $20, $43, $FF, $60
.db $F8, $CA, $2E, $61

LABEL_B12_B964:
.db	$C9, $42, $45, $20
.db $ED, $2E, $65

LABEL_B12_B96B:
.db	$5B, $20, $49, $53, $20
.db $F8, $4E, $45, $45, $44, $60, $54, $4F
.db $20, $42, $45, $20, $86, $2E, $65

LABEL_B12_B97F:
.db	$E4
.db $49, $53, $20, $41, $20, $43, $48, $55
.db $52, $43, $48, $2E, $60, $C6, $20, $97
.db $20, $54, $4F, $61, $8E, $20, $D5, $FD
.db $3F, $62, $49, $20, $53, $48, $41, $4C
.db $4C, $20, $50, $52, $41, $59, $20, $46
.db $4F, $52, $60, $59, $4F, $55, $2E, $65

LABEL_B12_B9B0:
.db $CC, $20, $4E, $4F, $57, $20, $43, $41
.db $53, $54, $60, $41, $20, $53, $50, $45
.db $4C, $4C, $2E, $63

LABEL_B12_B9C4:
.db	$F0, $60, $53, $45
.db $42, $52, $55, $53, $20, $42, $41, $53
.db $53, $21, $63

LABEL_B12_B9D3:
.db	$57, $48, $4F, $20, $49
.db $53, $20, $54, $4F, $20, $42, $45, $60
.db $8E, $45, $44, $3F, $62

LABEL_B12_B9E5:
.db	$F6, $FD, $20
.db $45, $4C, $53, $45, $3F, $62

LABEL_B12_B9EE:
.db	$DC, $20
.db $52, $45, $51, $55, $49, $52, $45, $53
.db $60, $5E, $20, $A1, $2E, $20, $4F, $2E
.db $4B, $2E, $3F, $62

LABEL_B12_BA04:
.db	$54, $4F, $20, $41
.db $44, $56, $41, $4E, $43, $45, $20, $54
.db $4F, $60, $DE, $4E, $45, $58, $54, $20
.db $4C, $45, $56, $45, $4C, $2C, $65

LABEL_B12_BA1F:
.db	$5B
.db $20, $4E, $45, $45, $44, $53, $20, $5E
.db $60, $45, $58, $50, $45, $52, $49, $45
.db $4E, $43, $45, $20, $50, $4F, $49, $4E
.db $54, $53, $2E, $65

LABEL_B12_BA3C:
.db	$4D, $41, $59, $20
.db $DE, $47, $4F, $44, $53, $60, $57, $41
.db $54, $43, $48, $20, $4F, $56, $45, $52
.db $20, $59, $4F, $55, $21, $65

LABEL_B12_BA56:
.db	$5B, $20
.db $49, $53, $20, $41, $4C, $49, $56, $45
.db $2E, $62

LABEL_B12_BA62:
.db	$C7, $20, $8F, $20, $DE, $FA
.db $49, $4E, $20, $50, $52, $4F, $47, $52
.db $45, $53, $53, $2E, $61, $C9, $FC, $60
.db $41, $20, $4E, $55, $4D, $42, $45, $52
.db $2E, $62

LABEL_B12_BA82:
.db	$E1, $FC, $45, $44, $20, $5E
.db $60, $49, $53, $20, $DC, $20, $4F, $2E
.db $4B, $2E, $62

LABEL_B12_BA93:
.db	$57, $45, $4C, $4C, $2C
.db $20, $53, $41, $56, $49, $4E, $47, $20
.db $5E, $2E, $63

LABEL_B12_BAA3:
.db	$43, $4F, $4D, $50, $4C
.db $45, $54, $45, $44, $2E, $65

LABEL_B12_BAAE:
.db	$57, $45
.db $20, $F9, $54, $4F, $20, $42, $45, $60
.db $46, $52, $49, $45, $4E, $44, $53, $20
.db $57, $49, $54, $48, $61, $50, $45, $4F
.db $50, $4C, $45, $20, $FE, $CF, $2E, $65

LABEL_B12_BAD0:
.db $49, $20, $F9, $54, $4F, $20, $45, $41
.db $54, $20, $41, $60, $4E, $55, $54, $20
.db $4F, $46, $20, $D7, $2E, $65

LABEL_B12_BAE6:
.db	$44, $4F
.db $20, $F8, $4F, $46, $46, $45, $4E, $44
.db $60, $D4, $2E, $65

LABEL_B12_BAF4:
.db	$E1, $55, $4E, $44
.db $45, $52, $53, $54, $41, $4E, $44, $20
.db $4F, $55, $52, $D9, $3F, $65

LABEL_B12_BB06:
.db	$48, $45
.db $4C, $4C, $4F, $21, $65

LABEL_B12_BB0D:
.db	$42, $45, $20
.db $ED, $20, $4F, $46, $20, $50, $49, $54
.db $53, $49, $4E, $20, $DE, $D8, $2E, $65

LABEL_B12_BB20:
.db $4D, $F6, $20, $4F, $46, $20, $DE, $60
.db $F1, $F2, $53, $20, $49, $4E, $61, $DE
.db $D8, $20, $EC, $60, $54, $52, $41, $50
.db $50, $45, $44, $2E, $65

LABEL_B12_BB3D:
.db	$E1, $54, $48
.db $49, $45, $46, $21, $65

LABEL_B12_BB45:
.db	$8B, $4F, $55
.db $54, $43, $41, $53, $54, $53, $2E, $60
.db $46, $4F, $52, $47, $49, $56, $45, $20
.db $55, $53, $2E, $65

LABEL_B12_BB5C:
.db	$DE, $53, $4F, $55
.db $4E, $44, $20, $4F, $46, $20, $DE, $60
.db $A4, $20, $49, $53, $61, $41, $20, $4A
.db $4F, $59, $20, $54, $4F, $20, $42, $4F
.db $54, $48, $20, $DE, $60, $45, $41, $52
.db $20, $41, $4E, $44, $20, $DE, $48, $45
.db $41, $52, $54, $2E, $65

LABEL_B12_BB8D:
.db	$DE, $56, $45
.db $48, $49, $43, $4C, $45, $20, $BE, $4E
.db $60, $41, $53, $20, $22, $49, $43, $45
.db $20, $44, $49, $47, $47, $45, $52, $22
.db $61, $4C, $49, $56, $45, $53, $20, $55
.db $50, $20, $54, $4F, $20, $49, $54, $53
.db $60, $4E, $41, $4D, $45, $2E, $65

LABEL_B12_BBBF:
.db	$D4
.db $20, $4C, $49, $56, $45, $53, $20, $41
.db $42, $4F, $56, $45, $DE, $53, $4B, $59
.db $2E, $65

LABEL_B12_BBD2:
.db	$DE, $4D, $41, $44, $20, $44
.db $4F, $43, $54, $4F, $52, $60, $49, $4E
.db $20, $41, $42, $49, $4F, $4E, $20, $48
.db $41, $53, $20, $41, $61, $A6, $2E, $65

LABEL_B12_BBF0:
.db $DB, $20, $50, $4C, $41, $43, $45, $53
.db $60, $49, $4E, $20, $DE, $53, $4B, $59
.db $61, $D0, $20, $45, $56, $45, $4E, $20
.db $53, $50, $41, $43, $45, $2D, $60, $53
.db $48, $49, $50, $20, $88, $20, $47, $4F
.db $2E, $65

LABEL_B12_BC1A:
.db	$41, $20, $4E, $55, $54, $20
.db $4F, $46, $20, $D7, $60, $4E, $45, $45
.db $44, $53, $20, $53, $50, $45, $43, $49
.db $41, $4C, $61, $4C, $49, $47, $48, $54
.db $20, $54, $4F, $20, $47, $4C, $4F, $57
.db $2E, $65

LABEL_B12_BC42:
.db	$DB, $20, $A5, $60, $44, $4F
.db $4F, $52, $53, $20, $49, $4E, $20, $54
.db $48, $45, $61, $D8, $20, $4D, $41, $5A
.db $45, $2E, $65

LABEL_B12_BC5B:
.db	$DE, $4D, $49, $52, $41
.db $43, $4C, $45, $20, $4B, $45, $59, $60
.db $43, $41, $4E, $20, $4F, $50, $45, $4E
.db $20, $44, $4F, $4F, $52, $53, $61, $57
.db $48, $49, $43, $48, $20, $EC, $53, $48
.db $55, $54, $60, $42, $59, $20, $EF, $2E
.db $65

LABEL_B12_BC89:
.db	$D5, $20, $F4, $53, $60, $4C, $49
.db $4B, $45, $20, $54, $4F, $20, $54, $45
.db $4C, $4C, $20, $4C, $49, $45, $53, $2C
.db $61, $53, $4F, $20, $42, $45, $20, $ED
.db $2E, $65

LABEL_B12_BCAA:
.db	$E1, $EC, $42, $52, $41, $56
.db $45, $20, $54, $4F, $60, $41, $50, $50
.db $52, $4F, $41, $43, $48, $20, $4D, $45
.db $21, $65

LABEL_B12_BCC2:
.db	$5C, $20, $49, $53, $20, $42
.db $55, $52, $53, $54, $2D, $60, $49, $4E
.db $47, $20, $57, $49, $54, $48, $20, $53
.db $54, $52, $45, $4E, $47, $54, $48, $2E
.db $63

LABEL_B12_BCE1:
.db	$5C, $20, $48, $41, $44, $20, $41
.db $60, $F1, $F2, $2E, $62

LABEL_B12_BCED:
.db	$8B, $90, $60
.db $FB, $45, $41, $53, $54, $2E, $65

LABEL_B12_BCF7:
.db	$8B
.db $90, $60, $FB, $57, $45, $53, $54, $2E
.db $65

LABEL_B12_BD01:
.db	$8B, $90, $60, $FB, $4E, $4F, $52
.db $54, $48, $2E, $65

LABEL_B12_BD0C:
.db	$8B, $90, $60, $FB
.db $53, $4F, $55, $54, $48, $2E, $65

LABEL_B12_BD17:
.db	$E1
.db $EC, $41, $4C, $4C, $20, $44, $45, $41
.db $44, $2E, $65

LABEL_B12_BD23:
.db	$80, $40, $53, $20, $48
.db $4F, $50, $45, $20, $88, $4F, $56, $45
.db $52, $43, $4F, $4D, $45, $20, $DE, $50
.db $4F, $57, $45, $52, $61, $4F, $46, $20
.db $D4, $2E, $60, $DE, $41, $44, $56, $45
.db $4E, $54, $55, $52, $45, $20, $49, $53
.db $61, $4F, $56, $45, $52, $2E, $65

LABEL_B12_BD57:
.db	$E1
.db $44, $4F, $4E, $40, $54, $20, $E3, $60
.db $45, $4E, $4F, $55, $47, $48, $20, $4D
.db $FD, $59, $2E, $61, $43, $4F, $4D, $45
.db $20, $41, $47, $41, $49, $4E, $20, $4C
.db $41, $54, $45, $52, $2E, $65

LABEL_B12_BD7E:
.db	$DC, $20
.db $C7, $20, $43, $4F, $4D, $45, $20, $49
.db $4E, $60, $48, $41, $4E, $44, $59, $20
.db $4C, $41, $54, $45, $52, $2E, $65

LABEL_B12_BD97:
.db	$DA
.db $20, $41, $60, $F1, $F2, $2E, $62

LABEL_B12_BD9F:
.db	$F0
.db $60, $53, $45, $42, $2E, $2E, $42, $2E
.db $2E, $2E, $48, $41, $43, $4B, $2C, $48
.db $41, $43, $4B, $61, $53, $4F, $52, $52
.db $59, $2C, $20, $49, $20, $53, $45, $45
.db $4D, $20, $54, $4F, $60, $E3, $46, $41
.db $49, $4C, $45, $44, $2E, $65

LABEL_B12_BDCE:
.db	$42, $4F
.db $55, $4E, $44, $20, $46, $4F, $52, $20
.db $94, $2E, $47, $45, $54, $54, $49, $4E
.db $47, $20, $4F, $4E, $3F, $62

LABEL_B12_BDE6:
.db	$42, $4F
.db $55, $4E, $44, $20, $46, $4F, $52, $20
.db $CF, $2E, $60, $47, $45, $54, $54, $49
.db $4E, $47, $20, $4F, $4E, $3F, $62

LABEL_B12_BDFF:
.db	$5B
.db $20, $49, $53, $20, $53, $54, $52, $4F
.db $4E, $47, $60, $45, $4E, $4F, $55, $47
.db $48, $20, $41, $4C, $52, $45, $41, $44
.db $59, $2E, $65

LABEL_B12_BE1B:
.db	$43, $4F, $4E, $54, $49
.db $4E, $55, $45, $20, $41, $20, $FA, $2E
.db $60, $FC, $20, $41, $20, $4E, $55, $4D
.db $42, $45, $52, $2E, $62

LABEL_B12_BE35:
.db	$43, $4F, $4E
.db $54, $49, $4E, $55, $49, $4E, $47, $20
.db $FA, $20, $5E, $2E, $63

LABEL_B12_BE45:
.db	$43, $4F, $4E
.db $54, $49, $4E, $55, $45, $20, $FA, $2D
.db $20, $59, $45, $53, $EE, $20, $20, $20
.db $FA, $2D, $20, $4E, $4F, $62

LABEL_B12_BE5E:
.db	$C7, $20
.db $EE, $20, $41, $60, $8F, $44, $20, $FA
.db $20, $4F, $2E, $4B, $2E, $3F, $62

LABEL_B12_BE6F:
.db	$EE
.db $20, $41, $20, $FA, $2E, $60, $FC, $20
.db $41, $20, $4E, $55, $4D, $42, $45, $52
.db $2E, $62

LABEL_B12_BE82:
.db	$FA, $20, $5E, $20, $48, $41
.db $53, $20, $42, $45, $45, $4E, $60, $EE
.db $44, $2E, $65

LABEL_B12_BE93:
.db	$5B, $20, $48, $41, $53
.db $20, $42, $45, $45, $4E, $60, $91, $2E
.db $65

LABEL_B12_BEA1:
.db	$5D, $20, $49, $53, $20, $55, $53
.db $45, $44, $60, $42, $59, $20, $D5, $FD
.db $20, $4E, $4F, $57, $2E, $65

LABEL_B12_BEB6:
.db	$DE, $53
.db $4B, $59, $20, $47, $52, $41, $44, $55
.db $41, $4C, $4C, $59, $60, $43, $4C, $45
.db $41, $52, $53, $20, $41, $4E, $44, $64

LABEL_B12_BED0:
.db $DE, $50, $45, $41, $43, $45, $20, $49
.db $53, $60, $52, $45, $54, $55, $52, $4E
.db $45, $44, $20, $54, $4F, $20, $DE, $64

LABEL_B12_BEE8:
.db $9B, $20, $9C, $2E, $60, $41, $20, $47
.db $45, $4E, $54, $4C, $45, $20, $42, $52
.db $45, $45, $5A, $45, $64

LABEL_B12_BEFD:
.db	$43, $41, $52
.db $45, $53, $53, $45, $53, $60, $C2, $2E
.db $64

LABEL_B12_BF09:
.db	$42, $55, $54, $20, $44, $4F, $45
.db $53, $20, $DE, $60, $42, $52, $45, $45
.db $5A, $45, $20, $BE, $53, $20, $4F, $46
.db $64

LABEL_B12_BF21:
.db	$DE, $48, $41, $52, $44, $53, $48
.db $49, $50, $53, $20, $DC, $54, $48, $45
.db $59, $20, $45, $4E, $44, $55, $52, $45
.db $44, $3F, $64

LABEL_B12_BF3B:
.db	$80, $20, $41, $4E, $44
.db $20, $48, $45, $52, $60, $43, $4F, $4D
.db $50, $F6, $20, $4F, $4E, $20, $81, $2C
.db $61, $EC, $54, $4F, $53, $53, $45, $44
.db $20, $49, $4E, $54, $4F, $60, $DE, $53
.db $4B, $59, $2E, $65

LABEL_B12_BF64:
.db	$80, $20, $48, $45
.db $41, $52, $53, $20, $B2, $40, $53, $60
.db $56, $4F, $49, $43, $45, $20, $49, $4E
.db $20, $DE, $44, $45, $50, $54, $48, $61
.db $4F, $46, $20, $48, $45, $52, $20, $53
.db $4F, $55, $4C, $3B, $60, $22, $59, $4F
.db $55, $40, $4C, $4C, $20, $42, $45, $20
.db $52, $45, $42, $4F, $52, $4E, $61, $54
.db $4F, $20, $46, $49, $47, $48, $54, $20
.db $46, $4F, $52, $60, $50, $45, $41, $43
.db $45, $20, $41, $47, $41, $49, $4E, $2E
.db $22, $61, $80, $20, $49, $53, $60, $8E
.db $45, $44, $2E, $65

LABEL_B12_BFC4:
.db	$DE, $53, $4F, $55
.db $4E, $44, $20, $49, $53, $60, $48, $45
.db $41, $52, $54, $57, $41, $52, $4D, $49
.db $4E, $47, $2E, $65