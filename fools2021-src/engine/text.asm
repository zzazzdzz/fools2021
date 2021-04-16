; *** text.asm
; Text engine, ripped straight from unfinished fools2020.

CHAR_DEFINITION_SIZE equ 9
CHAR_TILE_BUFFER_SIZE equ 36

InitTextEngine:
    ld bc, wTextEngineVarsEnd - wTextEngineVarsStart
    ld hl, wTextEngineVarsStart
    xor a
    jp FillMemory

ClearWorkingBlocks:
    ld bc, 16
    ld hl, wTextEngineWorkingBlocks
    xor a
    jp FillMemory

PrintTextVWF:
    ld a, 3
PrintTextVWF_Banked:
    ld [wTextBoxBank], a
    push hl
    call InitTextEngine
    ld a, 1
    ld [wTextBoxID], a
    call DisplayTextBoxID
    pop hl
PrintTextVWFCommandProcessor:
    ld a, [wTextBoxBank]
    call ReadFromSRAX
    inc hl
    and a
    jr z, .done
    cp $f0
    jr nc, .command
    cp $3e
    jr z, .skipOffset
    ld b, a
    ld a, [wTextEngineCharIndexOffset]
    add b
.skipOffset
    call PrintSingleChar
    jr PrintTextVWFCommandProcessor
.done
    ld de, wTextBoxBufferPtr + 2
    ld a, [de]
    and a
    jp z, RotateBlocks
.exitBuffer
    ld h, a
    xor a
    ld [de], a
    dec de
    ld a, [de]
    ld l, a
    dec de
    ld a, [de]
    ld [wTextBoxBank], a
    jr PrintTextVWFCommandProcessor
.command
    sub $f0
    ld c, a
    ld b, 0
    push hl
    ld hl, VWFCommandsJumptable
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld d, [hl]
    ld e, a
    pop hl
    push de
    ret

VWFCommandsJumptable:
    dw PrintTextVWFCommandProcessor
    dw TextCommandF1
    dw TextCommandF2
    dw TextCommandF3
    dw TextCommandF4
    dw TextCommandF5
    dw TextCommandF6
    dw TextCommandF7
    dw TextCommandF8
    dw TextCommandF9
    dw TextCommandFA
    dw TextCommandFB
    dw TextCommandFC
    dw PrintTextVWFCommandProcessor
    dw PrintTextVWFCommandProcessor
    dw PrintTextVWFCommandProcessor
    
TextCommandF1:
    push hl
    call RotateBlocks
    call WaitButtonPress
    call ScrollTextUpOneLine
    call ScrollTextUpOneLine
    ld a, SCREEN_WIDTH * 2
    ld [wTextEngineCurrentTilemapIndex], a
    xor a
    ld [wTextEngineCurrentXPosition], a
    pop hl
    jr PrintTextVWFCommandProcessor

TextCommandF2:
    push hl
    call RotateBlocks
    call ClearWorkingBlocks
    ld a, SCREEN_WIDTH * 2
    ld [wTextEngineCurrentTilemapIndex], a
    xor a
    ld [wTextEngineCurrentXPosition], a
    pop hl
    jp PrintTextVWFCommandProcessor

TextCommandF3:
    push hl
    call RotateBlocks
    call WaitButtonPress
    call ClearWorkingBlocks
    xor a
    ld [wTextEngineCurrentXPosition], a
    ld [wTextEngineCurrentCharIndex], a
    ld [wTextEngineCurrentTilemapIndex], a
    coord hl, 1, 13
    ld bc, $0412
    call ClearScreenArea
    ld c, 16
    call DelayFrames
    pop hl
    jp PrintTextVWFCommandProcessor

TextCommandF4:
    push hl
    call RotateBlocks
    call WaitButtonPress
    pop hl
    jp PrintTextVWFCommandProcessor

TextCommandF5:
    ld a, 1
    ld [wTextEngineBoldFace], a
    jp PrintTextVWFCommandProcessor

TextCommandF6:
    xor a
    ld [wTextEngineBoldFace], a
    jp PrintTextVWFCommandProcessor

SaveCurrentTextboxBuffer:
    ld de, wTextBoxBufferPtr
    ld a, [wTextBoxBank]
    ld [de], a
    ld b, a
    inc de
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    ret

TextCommandF7:
    inc hl
    inc hl
    inc hl
    call SaveCurrentTextboxBuffer
    dec hl
    dec hl
    dec hl ; yeah yeah spare me the notlikethis
    ld a, b
    call ReadFromSRAX
    inc hl
    ld [wTextBoxBank], a
    ld a, b
    call ReadFromSRAX
    inc hl
    ld c, a
    ld a, b
    call ReadFromSRAX
    ld l, c
    ld h, a
    jp PrintTextVWFCommandProcessor

TextCommandF8:
    ; text buffer indirect
    inc hl
    inc hl
    inc hl
    call SaveCurrentTextboxBuffer
    dec hl
    dec hl
    dec hl ; yeah yeah spare me the notlikethis
    ld a, b
    call ReadFromSRAX
    inc hl
    ld [wTextBoxBank], a
    ld a, b
    call ReadFromSRAX
    inc hl
    ld c, a
    ld a, b
    call ReadFromSRAX
    ld l, c
    ld h, a
    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp PrintTextVWFCommandProcessor

TextCommandF9:
    ld a, [wTextBoxBank]
    call ReadFromSRAX
    ld [wTextEngineCharIndexOffset], a
    inc hl
    jp PrintTextVWFCommandProcessor

TextCommandFA:
    ; print 8-bit number from address
    ld a, [wTextBoxBank]
    call ReadFromSRAX
    ld e, a
    inc hl
    ld a, [wTextBoxBank]
    call ReadFromSRAX
    ld d, a
    inc hl
    ld bc, $4103
    push hl
    ld hl, wTxNumBuf+4
    xor a
    ld [hld], a
    ld [hld], a
    ld [hld], a
    ld [hld], a
    ld [hl], a
    call PrintNumber
    pop hl
    call SaveCurrentTextboxBuffer
    ld hl, wTxNumBuf
.convCharsets
    ld a, [hl]
    and a
    jr z, .convCharsetsFinish
    ld c, $f6 - $43
    sub c
    ld [hli], a
    jr .convCharsets
.convCharsetsFinish
    ld hl, wTxNumBuf
    jp PrintTextVWFCommandProcessor

TextCommandFB:
    ; delay frames
    ld a, [wTextBoxBank]
    call ReadFromSRAX
    inc hl
    push af
    push hl
    call RotateBlocks
    pop hl
    pop af
    ld c, a
    call DelayFrames
    jp PrintTextVWFCommandProcessor

WaitButtonPress:
    push hl
    coord hl, 18, 17
    ld b, 0
.loop
    push bc
    call DelayFrame
    call JoypadLowSensitivity
    pop bc
    ldh a, [$b5]
    and 3
    jr nz, .finish
    inc b
    ld a, b
    and $10
    jr z, .arrow
    ld [hl], $7a
    jr .loop
.arrow
    ld [hl], $ee
    jr .loop
.finish
    ld [hl], $7a
    pop hl
    ld a, $90
    jp PlaySound

TextCommandFC:
    ; cls without button press
    push hl
    call RotateBlocks
    call ClearWorkingBlocks
    xor a
    ld [wTextEngineCurrentXPosition], a
    ld [wTextEngineCurrentCharIndex], a
    ld [wTextEngineCurrentTilemapIndex], a
    coord hl, 1, 13
    ld bc, $0412
    call ClearScreenArea
    ld c, 16
    call DelayFrames
    pop hl
    jp PrintTextVWFCommandProcessor

PrintSingleChar:
    push hl
    ld bc, CHAR_DEFINITION_SIZE
    ld hl, CharacterSet
    dec a
    call AddNTimes
    ld de, wTextEngineCurrentGlyph
    ld bc, 9
    ld a, 3
    call CopyDataFromSRAX
    ld hl, wTextEngineCurrentGlyph
    call CopyCharToWorkingBlocks
    pop hl
    ret

CopyCharToWorkingBlocks:
    ld a, [hli]
    push af
    ld a, [wTextEngineBoldFace]
    and a
    jr z, .noBold
    pop af
    inc a
    push af
.noBold
    ld a, 8
    ld de, wTextEngineWorkingBlock1
.eachByte
    call RotateAndCopySingleLine
    inc hl
    inc de
    dec a
    jr nz, .eachByte
    ld a, [wTextEngineCurrentXPosition]
    ld b, a
    pop af
    add b
    inc a
    cp 8
    call nc, RotateBlocks
    and 7
    ld [wTextEngineCurrentXPosition], a
    ret

RotateBlocks:
    push af
    ld hl, $8bb0
    ld bc, $0010
    ld a, [wTextEngineCurrentCharIndex]
    inc a
    cp CHAR_TILE_BUFFER_SIZE
    jr c, .noOverflow
    sub CHAR_TILE_BUFFER_SIZE
.noOverflow
    ld [wTextEngineCurrentCharIndex], a
    call AddNTimes
    ld de, wTextEngineWorkingBlocks
    call UpdateVRAMAndDelayFrame
    ld bc, 8
    ld hl, wTextEngineWorkingBlock2
    ld de, wTextEngineWorkingBlock1
    call CopyData
    ld hl, wTextEngineCurrentTilemapIndex
    inc [hl]
    pop af
    ret

RotateAndCopySingleLine:
    push af
    push de
    push hl
    ld b, [hl]
    ld a, [wTextEngineBoldFace]
    and a
    ld a, b
    jr z, .noBold
    srl b
    or b
.noBold
    ld b, a
    ld c, 0
    ld a, [wTextEngineCurrentXPosition]
.shiftATimes
    and a
    jr z, .isZero
    rr b
    rr c
    dec a
    jr .shiftATimes
.isZero
    ld h, d
    ld l, e
    ld de, 8
    ld a, b
    or [hl]
    ld [hl], a
    add hl, de
    ld [hl], c
    pop hl
    pop de
    pop af
    ret

UpdateVRAMAndDelayFrame:
    di
    ld c, 8
.waitHblank
    ldh a, [rSTAT]
    and %00000011
    jr nz, .waitHblank
    ld a, [de]
    ld [hli], a
    ld [hli], a
    inc de
.waitNoHblank
    ldh a, [rSTAT]
    and %00000011
    jr z, .waitNoHblank
    dec c
    jr nz, .waitHblank
.recalc
    coord hl, 1, 14
    ld a, [wTextEngineCurrentTilemapIndex]
    ld b, 0
    ld c, a
    add hl, bc
    ld a, h
    cp $c5
    jr c, .ok
    xor a
    ld [wTextEngineCurrentTilemapIndex], a
    jr .recalc
.ok
    ld a, [wTextEngineCurrentCharIndex]
    add $bb
    ld [hl], a
    ld a, $7c
    ld [$c4f3], a
    ld [$c4cb], a
    ei
    jp DelayFrame
