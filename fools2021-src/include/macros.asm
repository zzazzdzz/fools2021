safe_call: MACRO
    ld a, LOW(\1)
    ld [wSafeCallAddressLow], a
    ld a, HIGH(\1)
    ld [wSafeCallAddressHigh], a
    call SafeCall
ENDM

safe_call_hl: MACRO
    ld hl, \1
    call SafeCallHL
ENDM

coord: MACRO
    IF _NARG >= 4
        ld \1, \4 + SCREEN_WIDTH * \3 + \2
    ELSE
        ld \1, wTileMap + SCREEN_WIDTH * \3 + \2
    ENDC
ENDM

lb: MACRO ; r, hi, lo
	ld \1, (\2) << 8 + ((\3) & $ff)
ENDM

dw_coord: MACRO
    dw wTileMap + SCREEN_WIDTH * \2 + \1
ENDM

farcall: MACRO
    ld b, b_\1
    ld hl, \1
    call Bankswitch
ENDM

safe_farcall: MACRO
    ld b, b_\1
    ld hl, \1
    safe_call Bankswitch
ENDM

text   EQUS "db " ; Start writing text.
next   EQUS "db $F2," ; Move a line down.
para   EQUS "db $F3," ; Start a new paragraph.
cont   EQUS "db $F1," ; Scroll to the next line.
done   EQUS "db $0"  ; End a text box.
wait   EQUS "db $F4,0"

tx_buf: MACRO
    db $f7
    db \1
    dw \2
ENDM

tx_buf_indirect: MACRO
    db $f8
    db \1
    dw \2
ENDM

tx_buf_id_indirect: MACRO
    db $f9
    db \1
ENDM

tx_num: MACRO
    db $fa
    dw \1
ENDM

tx_wait: MACRO
    db $fb
    db \1
ENDM

tx_cls: MACRO
    db $fc
ENDM

tx_deliria equs "db $f9,$4d"

percent EQUS "* $ff / 100"

; Constant enumeration is useful for monsters, items, moves, etc.
const_def: MACRO
const_value = 0
ENDM

const: MACRO
\1 EQU const_value
const_value = const_value + 1
ENDM

predef_id: MACRO
	ld a, (\1Predef - PredefPointers) / 3
	ENDM

predef: MACRO
	predef_id \1
	call Predef
	ENDM