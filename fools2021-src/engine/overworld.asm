; *** overworld.asm
; Functions related to the overworld map, including the map script,
; map preparation routines, and any interactions with the overworld.

IntoOverworld:
    ; Warp the player to the overworld.
    ld a, $08
    ld [wJoyIgnore], a
    ld a, $1f
    ld [wLastMap], a
    call DisableLCD
    call BlackOutPals
    ; Tileset 0
    ld hl, wCurMapTileset
    ld [hl], $00
    inc hl
    ; Width and height of 24 blocks
    ld [hl], 24
    inc hl
    ld [hl], 24
    inc hl
    ; Set map data pointers accordingly
    ld d, h
    ld e, l
    ld hl, MapDataPointers
    ld bc, 10
    call CopyData
    ; No warps, sprites and signs on the event map
    xor a
    ld [wNumberOfWarps], a
    ld [wNumSprites], a
    ld [wNumSigns], a
    ; Fill map blocks with $54 (mostly a debug feature)
    ld hl, wCurMapBlocks
    ld bc, 24 * 24
.copyBlocks
    ld a, $54
    ld [hli], a
    dec bc
    ld a, c
    or b
    jr nz, .copyBlocks
    ; Load the map data we crafted
    predef LoadTilesetHeader
    call $1206 ; LoadMapHeader.finishUp+?
    ; Generate the actual map
    call RecalculateMapView
    safe_call_hl LoadTileBlockMap
    ; Generating clobbers wGrassRate. Let's restore it
    xor a
    ld [wGrassRate], a
    ; Initialize everything else
    call PlacePlayerAtSpawn
    call PrepareXYPositions
    call LoadTilesetTilePatternData
    call LoadPokeBallGfx
    ld b, b_InitMapSprites
    ld hl, InitMapSprites
    call Bankswitch
    call EnableLCD
    ; Give player control using some hacky code
    ld b, b_UsedCut
    ld hl, $6fec
    call Bankswitch ; UsedCut+?
    ld a, $90
    ldh [$b0], a
    ld hl, .returnAddr
    push hl
    call $29f8
.returnAddr
    call LoadGBPal
    ld sp, $dfff
    ld a, $3c
    ld [$c104], a
    jp OverworldLoop

MapDataPointers:
    dw wCurMapBlocks          ; map blocks
    dw $0000                  ; text pointers
    dw MapScript              ; map script
    dw $0000                  ; object data
    db $00, $ff               ; no connections

PlacePlayerAtSpawn:
    ; Find a suitable spawn point for the player
    ld hl, wCurMapBlocks + 24 * 8 + 8
    ld bc, $0000
.loop
    ; Look through all possible coordinates and search for a ground tile
    ld a, [hli]
    cp $0a
    jr z, .found
    inc c
    ld a, c
    cp $08
    jr nz, .loop
    ld de, 16
    add hl, de
    inc b
    ld c, 0
    ld a, b
    cp $08
    jr nz, .loop
.failsafe
    ; There's no valid ground tile, so let's fall back to X=4, Y=4
    ; I thought this scenario is unlikely, but apparently, it's pretty
    ; common. Oh well.
    ld b, b
    ld bc, $0404
.found
    ; Got it
    ld a, c
    add a
    add 16
    ld [wXCoord], a
    ld a, b
    add a
    add 16
    ld [wYCoord], a
    ret

MapScript:
    ; Main map script.
    xor a
    ld [wGrassRate], a
    ; Check if new chunks need to be loaded
    ld b, 1
    call LoadChunkVars
    ld a, [wXCoord]
    cp $0f
    jr nz, .noWest
    dec de
    add 16
    ld [wXCoord], a
    ld b, a
.noWest
    cp $20
    jr nz, .noEast
    inc de
    sub 16
    ld [wXCoord], a
    ld b, a
.noEast
    ld a, [wYCoord]
    cp $0f
    jr nz, .noNorth
    dec hl
    add 16
    ld [wYCoord], a
    ld b, a
.noNorth
    cp $20
    jr nz, .noSouth
    inc hl
    sub 16
    ld [wYCoord], a
    ld b, a
.noSouth
    dec b
    jr z, .checkStartMenu
    ; Reload the chunks if so
    call StoreChunkVars
    call RecalculateMapView
    call PrepareXYPositions
    safe_call_hl LoadTileBlockMap
    ; Generating clobbers wGrassRate. Let's restore it
    xor a
    ld [wGrassRate], a
.checkStartMenu
    ; Should we display the start menu?
    ldh a, [$f8]
    and $08
    jr z, .noStartMenu
    call CustomStartMenu
.noStartMenu
    call CheckForBiomeChange
    call CheckForWildEncounters
    call CheckForItemPickups
    call CheckForLoreText
    call CheckForFarLands
    ; Begin an encounter if one was requested
    ; Also check for completing the Daredevil Potion achievement
    ld a, [wCurrentOpponentSpecies]
    and a
    jr z, .noEncounter
    ld a, [wCurrentOpponentLevel]
    ld l, a
    ld a, [wNextOpponentEmpowerment]
    add l
    ld [wCurrentOpponentLevel], a
    ld a, [wNextOpponentEmpowerment]
    and a
    jr z, .noAchievement
    ld a, [wCurrentOpponentBoss]
    and a
    jr z, .noAchievement
    ld hl, wLoreEventFlags
    set 7, [hl]
.noAchievement
    xor a
    ld [wNextOpponentEmpowerment], a
    call BeginEncounter
.noEncounter
    ret

CheckForLoreText:
    ; Check if there's a lore textbox to be displayed.
    ld a, [wCurrentOpponentSpecies]
    and a
    ret nz
    ld a, [wShowLoreText]
    and a
    ret z
    ld hl, LoreTexts
    dec a
    add a
    ld c, a
    ld b, 0
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    push hl
    call TextboxEnable
    pop hl
    call PrintTextVWF
    ld a, [wShowLoreText]
    cp 4
    jr nz, .no4
    ; If it's ID 4, give the player a Telltale Orb
    ld a, SFX_GET_ITEM_2
    call PlaySound
    ld c, 180
    call DelayFrames
    ld a, TELLTALE_ORB
    ld [wcf91], a
    ld a, 1
    ld [wItemQuantity], a
    ld hl, wInventoryNumItems
    call AddItemToInventory
.no4
    xor a
    ld [wShowLoreText], a
    ld a, [wLoreEventFlags]
    set 2, a
    ld [wLoreEventFlags], a
    jp ReturnFromTextboxToOverworld
LoreTexts:
    dw LoreIntroText
    dw LoreBiomeText
    dw LoreSaltText
    dw LoreDefeatedGuardianText
    dw LoreWolfText
    dw LoreFoxText
    dw LoreNoeText
    dw LoreMewtwoText
    dw EdgeText

CheckForItemPickups:
    ; Pick up an item if there's one in front of the player
    ldh a, [$f8]
    and $01
    ret z
    predef GetTileAndCoordsInFrontOfPlayer
    ld a, [wTileInFrontOfPlayer]
    cp $3d
    jr z, .foundItem
    cp $56
    jr z, .foundItem
    ret
.foundItem
    sra d
    sra e
    ld a, d
    sub 8
    ld d, a
    ld a, e
    sub 8
    ld e, a
    call GetItemTileHash
    ld b, 0
    call ItemFlagOperation
    ld hl, BiomeItemTable
    ld bc, 8
    ld a, [wCurrentBiome]
    swap a
    and $0f
    call AddNTimes
    call Random
    and $07
    ld c, a
    ld b, 0
    add hl, bc
    call ReadFromSRA3
    ld c, a
    ld [wcf91], a
    ; Summoning Salt gives a lore message if collected first time
    cp SUMMONING_SALT
    jr nz, .noSummoning
    ld a, [wLoreEventFlags]
    bit 1, a
    ld a, c
    jr nz, .noSummoning
    ld a, [wLoreEventFlags]
    set 1, a
    ld [wLoreEventFlags], a
    ld a, 3
    ld [wShowLoreText], a
    ld a, c
.noSummoning
    call LoadItemName
    ld a, 1
    ld [wItemQuantity], a
    ld hl, wInventoryNumItems
    call AddItemToInventory
    call SpriteClearAnimCounters
    call TextboxEnable_NoLoadFont
    ld a, 1
    ld [wTextBoxID], a
    call DisplayTextBoxID
    call Delay3
    ld de, ItemPickupBlockSwaps
    farcall ReplaceTreeTileBlock
    farcall RedrawMapView
    ld hl, ItemFoundText
    call PrintTextVWF
    ld a, SFX_GET_ITEM_1
    call PlaySound
    ld c, 80
    call DelayFrames
    call LoadWalkingPlayerSpriteGraphics
    jp ReturnFromTextboxToOverworld

CheckForWildEncounters:
    ; Check if a wild encounter should be generated.
    ld a, [wXCoord]
    ld b, a
    ld a, [wYCoord]
    add b
    ld b, a
    ; Also ticks down the skip sandwich counter, but the code here is
    ; buggy and doesn't work. Skip sandwiches should last 200 steps, but
    ; last 200 frames instead :)
    ld a, [wLastCoordSum]
    cp b
    ret z
    ld a, [wSkipSandwichCounter]
    and a
    jr z, .noSkip
    dec a
    jr nz, .resetState
    ld [wWalkBikeSurfState], a
.resetState
    ld [wSkipSandwichCounter], a
.noSkip
    ; Check if standing on a grass tile
    ld a, [$c45d]
    cp $52
    ret nz
.checkForEncounter
    xor a
    ld [$c107], a
    ld a, b
    ld [wLastCoordSum], a
    ld a, [wCurrentGrassRate]
    ld b, a
    call Random
    sub b
    ret nc
.encounter
    ld hl, BiomeEncounterTable
    ld bc, 16
    ld a, [wCurrentBiome]
    swap a
    and $0f
    call AddNTimes
    call Random
    and $07
    add a
    ld b, 0
    ld c, a
    add hl, bc
    call ReadFromSRA3
    ld [wCurrentOpponentSpecies], a
    inc hl
    call ReadFromSRA3
    push af
    call LoadChunkVars
    ; Determine the level of the encounter
    ; The farther out the chunk, the higher the level
    ld a, d
    and $80
    jr z, .absDE
    ld a, d
    cpl
    ld d, a
    ld a, e
    cpl
    ld e, a
    inc de
.absDE
    ld a, h
    and $80
    jr z, .absHL
    ld a, h
    cpl
    ld h, a
    ld a, l
    cpl
    ld l, a
    inc hl
.absHL
    add hl, de
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    ld a, h
    and a
    jr z, .noSaturation
    ; Levels were supposed to cap out at +32, but that didn't work either.
    ; They grow infinitely :)
    ld l, 32
.noSaturation
    pop af
    add l
    ld l, a
    ld a, [wAllOpponentsEmpowerment]
    add l
    ld [wCurrentOpponentLevel], a
    ret

CheckForFarLands:
    ; Check for the Far Lands achievement.
    ; The player has to be standing in chunk with either X=$7FFF or Y=$7FFF.
    ld a, [wLoreEventFlags]
    bit 6, a
    ret nz
    call LoadChunkVars
    ld a, d
    cp $7f
    jr nz, .notEdge1
    ld a, e
    cp $ff
    jr nz, .notEdge1
.edgy
    ld a, 9
    ld [wShowLoreText], a
    ld hl, wLoreEventFlags
    set 6, [hl]
    ret
.notEdge1
    ld a, h
    cp $7f
    ret nz
    ld a, l
    cp $ff
    ret nz
    jr .edgy
