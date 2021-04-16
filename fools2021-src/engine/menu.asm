; *** menu.asm
; Simple creation of multi-choice menus, ripped straight from fools2020.

MoveLinesUp:
    ld bc, -20
    jr MoveLines
MoveLinesDown:
    ld bc, 20
MoveLines:
    ld a, d
    and %111
    jp AddNTimes

DisplayMenu:
    ld a, [hli]
    ld b, a
    ld a, [hli]
    ld c, a
    ld a, [hli]
    ld [wMenuNumOptions], a
    ld a, [hli]
    ld [wMenuCurrentSettings], a
    bit 7, a
    call z, SaveScreenTilesToBuffer2_SaveAll
.drawTextbox
    push hl
    ld hl, $c48f
    ld de, -20
    inc b
    push bc
    ld a, b
    inc c
.tilemapCalcHeight
    add hl, de
    dec c
    jr nz, .tilemapCalcHeight
    cpl
    ld e, a
    add hl, de
    pop bc
    ld d, c
    ld c, b
    ld b, d
    push hl
    ld a, [wMenuCurrentSettings]
    bit 6, a
    call z, TextBoxBorder
    pop hl
    ld de, 22
    add hl, de
    pop de ; menu data
.writeMenuText
    push hl
    call PlaceStringSimple
    call UpdateSprites
    pop hl
    dec hl
    ld a, [wMenuCurrentSettings]
    ld d, a
    ld e, 0
    ; fall through to ChoiceMenuHandler

ChoiceMenuHandler:
    ld [hl], $ed
.waitNoInput
    ldh a, [$f8]
    and a
    jr nz, .waitNoInput
.waitInput
    ldh a, [$f8]
    and a
    jr z, .waitInput
.testButtons
    add a, a
    jr nc, .noDown
    ld b, a
    ld a, [wMenuNumOptions]
    dec a
    cp e
    ld a, b
    jr z, .noDown
    inc e
    ld [hl], $7f
    call MoveLinesDown
.noDown
    add a, a
    jr nc, .noUp
    ld b, a
    ld a, e
    and a
    ld a, b
    jr z, .noUp
    dec e
    ld [hl], $7f
    call MoveLinesUp 
.noUp
    add a, a
    jr nc, .noLeft
    bit 3, d
    jr z, .noLeft
    ld a, $f0
    jr MenuSFXClickAndExit
.noLeft
    add a, a
    jr nc, .noRight
    bit 4, d
    jr z, .noRight
    ld a, $f1
    jr MenuSFXClickAndExit
.noRight
    add a, a ; START
    add a, a ; SELECT
    add a, a
    jr nc, .noB
    bit 5, d
    jr z, .noB
    ld [hl], $ec
    ld a, $ff
    jr MenuSFXClickAndExit
.noB
    add a, a
    jr nc, .noA
    ld [hl], $ec
    ld a, e
    jr MenuSFXClickAndExit
.noA
    jr ChoiceMenuHandler

MenuSFXClickAndExit:
    push af
    ld a, SFX_PRESS_AB
    call PlaySound
    bit 7, d
    call z, LoadScreenTilesFromBuffer2
    call UpdateSprites
    pop af
    ret