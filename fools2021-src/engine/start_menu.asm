; *** start_menu.asm
; Implementation of the Start Menu.

CustomStartMenu:
    ; Display Start Menu.
    xor a
    ld [wQuitStartCompletely], a
    call SaveScreenTilesToBuffer1
	call LoadTextBoxTilePatterns
    call TextboxEnable
    ld a, SFX_START_MENU
    call PlaySound
RedisplayCustomStartMenu_RedrawBottom:
    ; Display Start Menu, but skip enabling textboxes and loading the font
    ld a, 1
    ld [wTextBoxID], a
    call DisplayTextBoxID
    coord hl, 1, 13
    ld de, BiomeInfo
    call PlaceStringSimple
    ld hl, BiomeNames
    ld bc, 11
    ld a, [wCurrentBiome]
    swap a
    and $0f
    call AddNTimes
    ld d, h
    ld e, l
    coord hl, 9, 14
    call PlaceStringSimple
    coord hl, 11, 16
    ld de, wMapSeed
    ld c, 4
    call PrintHex
RedisplayCustomStartMenu:
    ; Display Start Menu, but skip displaying the bottom textbox
    ld hl, StartMenuStruct
    call DisplayMenu
    cp $ff
    jp z, QuitStartMenu
    and a
    jr z, StartMenu_ViewMon
    dec a
    jr z, StartMenu_Inventory
    jp StartMenu_Retire

QuitStartMenu:
    ; Quit Start Menu.
    call LoadScreenTilesFromBuffer1
    ld c, 3
    call DelayFrames
    jp ReturnFromTextboxToOverworld

StartMenu_ViewMon:
    ; "Pokémon" option in Start Menu.
    call SaveScreenTilesToBuffer2
    call StartMenu_Mon
    call WaitAPress
    call LoadScreenTilesFromBuffer2
    call Delay3
    call LoadFontTilePatterns
    jr RedisplayCustomStartMenu

StartMenu_Inventory:
    ; "Item" option in Start Menu.
    xor a
    ld [wInventoryPage], a
    ld bc, $0101
    ld de, .leftArrowTile
    ld hl, $8eb0
    call CopyVideoDataDouble
    call FixInventory
    call SaveScreenTilesToBuffer2
.reloadInventory
    ld a, [wQuitStartCompletely]
    and a
    jp nz, QuitStartMenu
    coord hl, 0, 2
    ld bc, $0812
    call TextBoxBorder
    ld a, [wInventoryPage]
    and a
    jr z, .noRightArrow
    coord hl, 0, 10
    ld [hl], $eb
.noRightArrow
    ld a, [wInventoryPage]
    cp 9
    jr z, .noLeftArrow
    coord hl, 19, 10
    ld [hl], $ed
.noLeftArrow
    call UpdateSprites
    call GetInventoryText
    ld hl, wInventoryTextBuffer - 4
    ld [hl], 17
    inc hl
    ld [hl], 8
    inc hl
    ld [hl], 4
    inc hl
    ld [hl], %11111010
    ld hl, wInventoryTextBuffer - 4
    call DisplayMenu
    ld [wInventoryChoice], a
    cp $f0
    jr nz, .noLeft
    ld a, [wInventoryPage]
    and a
    jr z, .reloadInventory
    dec a
    ld [wInventoryPage], a
    jr .reloadInventory
.noLeft
    cp $f1
    jr nz, .noRight
    ld a, [wInventoryPage]
    cp 9
    jr z, .reloadInventory
    inc a
    ld [wInventoryPage], a
    jr .reloadInventory
.noRight
    cp $ff
    jr z, .exit
    ld b, a
    ld a, [wInventoryPage]
    add a
    add a
    add b
    add a
    ld c, a
    ld b, 0
    ld hl, wInventory
    add hl, bc
    ld a, [hl]
    cp $ff
    call nz, Inventory_UseItem
    jr .reloadInventory
.exit
    call LoadScreenTilesFromBuffer2
    ld a, [wQuitStartCompletely]
    and a
    jp nz, QuitStartMenu
    jp RedisplayCustomStartMenu
.leftArrowTile
    db %00000000
    db %00000110
    db %00001110
    db %00011110
    db %00111110
    db %00011110
    db %00001110
    db %00000110

StartMenu_Retire:
    ; "Retire" option in Start Menu.
    ld hl, RetireQuestionText
    call PrintTextVWF
    ld hl, .retireMenu
    call DisplayMenu
    cp $01
    jp nz, RedisplayCustomStartMenu_RedrawBottom
    ld a, 5
    ld [wAudioFadeOutCounterReloadValue], a
    ld a, $ff
    ld [wAudioFadeOutControl], a
    ld c, 80
    call DelayFrames
    call LoadScreenTilesFromBuffer1
    call Delay3
    jp GenerateAndShowPassword
.retireMenu
    db $03,$02 ; w, h
    db $02
    db %00100001 ; [disable screen save][draw textbox][B allowed][R allowed][L allowed][item size][item size][item size]
    db $8d,$ae,$4f,$98,$a4,$b2,$50

StartMenu_Mon:
    ; Draw the stat screen in "Pokémon" option.
    coord hl, 0, 3
    ld bc, $0712
    call TextBoxBorder
    call UpdateSprites
    ld a, $54
    ld [wBattleMonSpecies2], a
    ld [wEnemyMonSpecies2], a
    ld [wcf91], a
    ld [wd0b5], a
    call GetMonHeader
    ld de, $8c00
    safe_call LoadMonFrontSprite
	ld a, $c0 - ($f1 - $c0)
	ldh [$e1], a
	coord hl, 4, 10
	predef AnimateSendingOutMon
    call Predef
    coord hl, 8, 4
    ld de, MonStatsText
    call PlaceStringSimple
    ld bc, $0103
    coord hl, 12, 5
    ld de, wPlayerCurHP
    call PrintNumber
    ld bc, $0103
    coord hl, 16, 5
    ld de, wPlayerMaxHP
    call PrintNumber
    ld bc, $4103
    coord hl, 12, 8
    ld de, wPlayerCurLevel
    call PrintNumber
    ld bc, $4103
    coord hl, 8, 9
    ld de, wPlayerCurExpLeft
    call PrintNumber
    ld bc, $0103
    ld hl, wPlayerCurLevel
    push hl
    inc [hl]
    coord hl, 14, 10
    ld de, wPlayerCurLevel
    call PrintNumber
    pop hl
    dec [hl]
    coord hl, 15, 5
    ld [hl], $f3
    ld a, $54
    jp PlayCry

MonStatsText:
    db $8f,$a8,$aa,$a0,$a2,$a7,$b4,$4f,$4f,$4f
    db $84,$b7,$af,$a4,$b1,$a8,$a4,$ad,$a2,$a4,$9c,$4f
    db $8b,$b5,$f2,$4f,$4f
    db $b3,$ae,$7f,$8b,$b5,$f2,$50

StartMenuStruct:
    db $07,$05 ; w, h
    db $03 ; num options
    db %00100010 ; [disable screen save][draw textbox][B allowed][R allowed][L allowed][item size][item size][item size]
    db $8f,$8e,$8a,$ba,$8c,$8e,$8d,$4f,$4f
    db $88,$93,$84,$8c,$4f,$4f
    db $91,$84,$93,$88,$91,$84,$50

BiomeInfo:
    db $81,$a8,$ae,$ac,$a4,$9c,$4f,$4f
    db $92,$a4,$a4,$a3,$9c,$50

BiomeNames:
    db $86,$91,$80,$92,$92,$8b,$80,$8d,$83,$92,$50
    db $7f,$7f,$7f,$92,$93,$84,$8f,$8f,$84,$92,$50
    db $7f,$82,$8e,$8d,$92,$93,$91,$94,$82,$93,$50
    db $82,$8e,$91,$91,$94,$8f,$93,$88,$8e,$8d,$50

GetInventoryText:
    ; Get inventory string for the Item menu.
    ld hl, wInventory
    ld a, [wInventoryPage]
    ld bc, 8
    call AddNTimes
    ld d, h
    ld e, l
    ld hl, wInventoryTextBuffer
    call .getItem
    call .getItem
    call .getItem
    call .getItem
    ld [hl], $50
    ret
.getItem
    ld a, [de]
    ld c, a
    inc de
    ld a, [de]
    ld [wItemQuantity], a
    inc de
    push de
    push hl
    call LoadItemName
    pop hl
    ld de, $cd6d
.copyName
    ld a, [de]
    cp $50
    jr z, .nameEnded
    ld [hli], a
    inc de
    jr .copyName
.nameEnded
    ld [hl], $4f
    inc hl
    ld c, 13
    ld a, $7f
.fillWithSpace
    ld [hli], a
    dec c
    jr nz, .fillWithSpace
    ld [hl], $f1
    inc hl
    ld [hli], a
    ld [hli], a
    push hl
    dec hl
    dec hl
    ld de, wItemQuantity
	ld bc, $0102
	call PrintNumber
    pop hl
    ld [hl], $4f
    inc hl
    pop de
    ret