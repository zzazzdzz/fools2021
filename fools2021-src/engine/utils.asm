; *** utils.asm
; General utility functions.

TextboxEnable:
    ; Show a textbox in the overworld.
    call SaveScreenTilesToBuffer1
    call SaveScreenTilesToBuffer2
    call SpriteClearAnimCounters
    call LoadFontTilePatterns
TextboxEnable_NoLoadFont:
    ; Show a textbox in the overworld, but skip loading font graphics
    ld b, $9c
    ld hl, CopyScreenTileBufferToVRAM
    call SafeCallHL
    xor a
    ldh [$b0], a
    inc a
    ldh [$ba], a
    ret

ReturnFromTextboxToOverworld:
    ; Return to overworld after showing a textbox.
    ld a, $90
    ldh [$b0], a
    call DelayFrame
    call LoadGBPal
    xor a
    ldh [$ba], a
    call SwitchToMapRomBank
    ldh a, [$f8]
    ld h, a
    ld l, 0
    push hl
    call LoadWalkingPlayerSpriteGraphics
    jp $2a22

SpriteClearAnimCounters:
    ; Clear the player's sprite animation counters.
    xor a
    ld [wPlayerMovingDirection], a
    ld a, [$c102]
    and %11111100
    ld [$c102], a
    ld hl, $c107
    xor a
    ld [hli], a
    ld [hl], a
    jp UpdateSprites

PlayMusicFromRAM:
    ; Given an array of music pointers in HL, play the music there.
    ; Unused. There was plans for some nice custom music, but I ran out
    ; of space.
    ld bc, $0008
    ld de, $C006
    call CopyData
    xor a
    ld bc, $0004
    ld hl, $C016
    call FillMemory
    ld a, $01
    ld bc, $0004
    ld hl, $C0B6
    call FillMemory
    ld a, $e0
    ld bc, $0004
    ld hl, $C026
    jp FillMemory

BlackOutPals:
    ; Set a fully black palette (effectively blacking out the screen).
    ld a, %11111111
WriteAToPals:
	ld [rBGP], a
    ld [rOBP0], a
    ld [rOBP1], a
    ret

CompareBCToDE:
    ; Check if BC == DE.
    ld a, b
    cp d
    jr nz, .nope
    ld a, c
    cp e
.nope
    ret

CheckROM:
    ; A simple checksum test, to see if the loaded ROM is Pokemon Red EN.
    ld hl, $0000
    ld bc, $3fff
    ld de, $0000
.loop
    ld a, [hl]
    xor d
    ld d, a
    ld a, [hli]
    add e
    ld e, a
    dec bc
    ld a, c
    or b
    jr nz, .loop
    ld bc, $4DE1
    jp CompareBCToDE

PlaceStringSimple:
    ; At HL, place the string stored in DE.
    push bc
    push hl
    ld bc, 20
.nextChar
    ld a, [de]
    inc de
    cp $50
    jr z, .finished
    cp $4f
    jr z, .nextLine
    ld [hli], a
    jr .nextChar
.nextLine
    pop hl
    add hl, bc
    push hl
    jr .nextChar
.finished
    pop hl
    pop bc
    ret

SaveScreenTilesToBuffer2_SaveAll:
    ; SaveScreenTilesToBuffer2, but preserves all registers.
    push af
    push bc
    push de
    push hl
    call SaveScreenTilesToBuffer2
    pop hl
    pop de
    pop bc
    pop af
    ret

ClearSpriteData:
    ; Clear the wSpriteStateData array, effectively hiding all sprites.
    push hl
    ld hl, wSpriteStateData1 + $10
	ld de, wSpriteStateData2 + $10
	xor a
	ld c, $f0
.clearSpriteData
	ld [hli], a
	ld [de], a
	inc e
	dec c
	jr nz, .clearSpriteData
    ld hl, wSpriteStateData1 + $12
	ld de, $0010
	ld c, $0f
.disableAllSprites
	ld [hl], $ff
	add hl, de
	dec c
	jr nz, .disableAllSprites
    pop hl
    ret

CopyDataDuringHblank:
    ; Copy C bytes from DE to HL during hBlank periods.
.waitHblank
    ldh a, [rSTAT]
    and %00000011
    jr nz, .waitHblank
    ld a, [de]
    ld [hli], a
    inc de
    ld a, [de]
    ld [hli], a
    inc de
    dec c
    dec c
    jr z, .done
.waitNoHblank
    ldh a, [rSTAT]
    and %00000011
    jr z, .waitNoHblank
    jr .waitHblank
.done
    ret

PrepareXYPositions:
    ; Correctly fill in wCurrentTileBlockMapViewPointer, based on
    ; wXCoord and wYCoord.
    ld hl, wOverworldMap
    ld a, [wXCoord]
    srl a
    ld c, a
    ld b, 0
    add hl, bc
    inc hl
    ld a, [wYCoord]
    srl a
    inc a
    ld d, a
    ld a, [wCurMapWidth]
    add 6
    ld c, a
.yLoop
    add hl, bc
    dec d
    jr nz, .yLoop
.yLoopEnd
    ld de, wCurrentTileBlockMapViewPointer
    ld a, l
    ld [de], a
    inc de
    ld a, h
    ld [de], a
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    ld c, a
    inc de
    ld a, b
    and 1
    ld [de], a
    inc de
    ld a, c
    and 1
    ld [de], a
    ret

WaitAPress:
    ; Wait until A is fully released and then pressed.
    ; An A press actually has three parts to it. When A is pressed, when
    ; A is held, and when A is released. And together, this forms one complete
    ; A press.
    ldh a, [$f8]
    and a
    jr nz, WaitAPress
.waitInput
    ldh a, [$f8]
    and a
    jr z, .waitInput
    ret

PrintHex:
    ; Print a hex string from DE at HL, of length C.
    ld a, [de]
    swap a
    call PrintHexDigit
    ld a, [de]
    call PrintHexDigit
    inc de
    dec c
    jr nz, PrintHex
    ret
PrintHexDigit:
    ; Helper function for PrintHex.
    and $0f
    add $f6
    jr nc, .noAdd
    add $60
.noAdd
    ld [hli], a
    ret

CheckForBiomeChange:
    ; Updates several memory values when biomes are changed.
    ld a, [wCurrentBiome]
    swap a
    and $0f
    ld hl, .biomeThemes
    ld b, 0
    ld c, a
    add hl, bc
    ld b, [hl]
    ld a, [wCurrentMapMusic]
    cp b
    ret z
    ld a, c
    and a
    jr z, .notFirst
    ld a, [wLoreEventFlags]
    bit 0, a
    jr nz, .notFirst
    bit 2, a
    jr z, .notFirst
    ; If the player visits a new biome for the first time, make sure to
    ; display the tutorial message:
    set 0, a
    ld [wLoreEventFlags], a
    ld a, 2
    ld [wShowLoreText], a
.notFirst
    ld a, 5
    ld hl, $cfc9
    ld [hld], a
    ld [hld], a
    ld [hl], b
    ld a, b
    ld [wCurrentMapMusic], a
    ld hl, .biomeLastMapValues
    ld b, 0
    add hl, bc
    ld a, [hl]
    ld [wLastMap], a
    ld [wCurMap], a
	ld b, 9
	jp RunPaletteCommand
.biomeThemes
    db MUSIC_ROUTES1
    db MUSIC_ROUTES2
    db MUSIC_VERMILION
    db MUSIC_LAVENDER
.biomeLastMapValues
    db $1f
    db $02
    db $0a
    db $04

FixInventory:
    ; Pad missing inventory spaces with FF00, to make the inventory data
    ; more friendly to read. Also prevents the 99 item stack glitch.
    ; However, this function is called only when opening the inventory menu,
    ; so if you never open it, the glitch still occurs, leading to potential
    ; memory corruption and ACE. This was intended for the 4th hacking
    ; challenge.
    ld hl, wInventory
    ld c, 40
.findFF
    ld a, [hli]
    inc hl
    dec c
    inc a
    jr nz, .findFF
    dec hl
    ld [hl], 0
    inc hl
.correct
    dec a
    ld [hli], a
    inc a
    ld [hli], a
    dec c
    jr nz, .correct
    ret

CheckItemInBag:
    ; Check if item B is in bag. If it is, HL will point to item quantity,
    ; and ZF will be set.
    ld hl, wInventory
    ld c, 0
.test
    ld a, [hli]
    cp b
    ret z
    inc hl
    inc c
    cp $ff
    jr nz, .test
.nope
    ld a, 1
    ld hl, $0001 ; [$0001] == $00
    and a
    ret

RemoveItemByIndex:
    ; Remove item B, quantity C from player's inventory.
    ld a, c
    ld [wItemQuantity], a
    call CheckItemInBag
    ld a, c
    ld [wWhichPokemon], a
    ld hl, wInventoryNumItems
    call RemoveItemFromInventory
    jp FixInventory

LoadPokeBallGfx:
    ; Loads item ball graphics to appropriate VRAM tiles
    ld hl, PokeBallGfx1
    ld de, $92d0
    ld bc, 32
    ld a, 3
    call CopyDataFromSRAX
    ld de, $93d0
    ld bc, 32
    ld a, 3
    call CopyDataFromSRAX
    ld hl, PokeBallGfx2
    ld de, $9460
    ld bc, 32
    ld a, 3
    call CopyDataFromSRAX
    ld de, $9560
    ld bc, 32
    ld a, 3
    jp CopyDataFromSRAX

ItemPickupBlockSwaps:
    ; Picking up items replaces the tiles they're located on based on
    ; this table.
    db $33, $6C
    db $32, $6D
    db $60, $6E
    db $34, $6F
    db $08, $31
    db $FF ; List terminator
