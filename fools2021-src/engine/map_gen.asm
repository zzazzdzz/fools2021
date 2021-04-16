; *** map_gen.asm
; The procedural map generator.

wMapBufferA equ $d170
wMapBufferB equ (wMapBufferA+8*8)

PRNG:
    ; Generate a random number based on the chunk seed.
    ; Store in A.
    ld a, [wRNGVarX]
    inc a
    ld [wRNGVarX], a
    ld b, a
    ld a, [wRNGVarC]
    xor b
    ld b, a
    ld a, [wRNGVarA]
    xor b
    ld [wRNGVarA], a
    ld b, a
    ld a, [wRNGVarB]
    add b
    ld [wRNGVarB], a
    srl a
    xor b
    ld b, a
    ld a, [wRNGVarC]
    add b
    ld [wRNGVarC], a
    ret

PreparePRNGState:
    ; Seed the RNG with the chunk seed.
    ; Chunk Y in BC. Chunk X in DE.
    ld hl, wMapSeed
    ld a, [hli]
    xor d
    ld d, a
    ld a, [hli]
    xor e
    ld e, a
    ld a, [hli]
    xor b
    ld b, a
    ld a, [hli]
    xor c
    ld [hl], d
    inc hl
    ld [hl], e
    inc hl
    ld [hl], b
    inc hl
    ld [hl], a
    ; Make 16 "warmup" calls to PRNG for better results
    ld c, 16
.warmUp
    call PRNG
    dec c
    jr nz, .warmUp
    ret

GetChunkExitsAndBiome:
    ; Calculate the biome and exit locations for a given chunk.
    ; Seed RNG with chunk coordinates divided by 4 (so each 4x4 chunk area
    ; gets its own biome and layout
    push de
    push hl
    ld a, e
    and $03
    ld b, a
    ld a, l
    and $03
    ld c, a
    push bc
    ld b, h
    ld a, l
    and $fc
    ld c, a
    ld a, e
    and $fc
    ld e, a
    call PreparePRNGState
    call PRNG
    and %00000111
    ld d, 0
    swap a
    ld e, a
    pop bc
    ld a, c
    add a
    add a
    add b
    ld c, a
    ld b, 0
    ld hl, MapExitConfigurations
    add hl, bc
    add hl, de
    call ReadFromSRA3
    ld c, a
    call PRNG
    and $30
    or c
    ldh [hChunkExitsAndBiome], a
    pop hl
    pop de
    ld a, e
    or l
    and $fc
    or d
    or h
    ret nz
    ld a, c
    and $0f
    ldh [hChunkExitsAndBiome], a
    ret

MapGen_ConnectDots:
    ; Connect point at B to point at C with block E, with an intermediate
    ; random point.
    push bc
.genX
    call PRNG
    and $07
    jr z, .genX
    cp $07
    jr z, .genX
    swap a
    ld d, a
.genY
    call PRNG
    and $07
    jr z, .genY
    cp $07
    jr z, .genY
    or d
    ld d, a
    pop hl
    ld b, d
    ld c, l
    push bc
    ld b, h
    ld c, d
    push de
    call MapGen_ConnectDots_Simple
    pop de
    pop bc
    ; Fall through to MapGen_ConnectDots_Simple

MapGen_ConnectDots_Simple:
    ; Connect point at B to point at C with block E, with a direct path.
    ld a, e
    ldh [hChunkWriteTile], a
MapGen_ConnectDots_Simple2:
    ld a, b
    swap a
    and $0f
    ld d, a
    ld a, c
    swap a
    and $0f
    cp d
    ld d, -16
    jr c, .startXNotLess
    ld d, 16
.startXNotLess
    ld a, b
    and $0f
    ld e, a
    ld a, c
    and $0f
    cp e
    ld e, -1
    jr c, .startYNotLess
    ld e, 1
.startYNotLess
    call MapGen_WriteTileAtB
    ld a, b
    swap a
    and $0f
    ld h, a
    ld a, c
    swap a
    and $0f
    cp h
    jr z, .xAlreadyReached
    ld a, b
    add d
    ld b, a
.xAlreadyReached
    call MapGen_WriteTileAtB
    ld a, b
    and $0f
    ld h, a
    ld a, c
    and $0f
    cp h
    jr z, .yAlreadyReached
    ld a, b
    add e
    ld b, a
.yAlreadyReached
    call MapGen_WriteTileAtB
    ld a, b
    cp c
    jr nz, .startYNotLess
    ret

MapGen_WriteTileAtB:
    ; Write tile [hChunkWriteTile] at location B.
    ld hl, wMapBufferA
    ld a, b
    and $0f
    add a
    add a
    add a
    add l
    ld l, a
    ld a, b
    swap a
    and $0f
    add l
    ld l, a
    ldh a, [hChunkWriteTile]
    ld [hl], a
    ret

MapGen_ConnectDots_Preserve:
    ; MapGen_ConnectDots, but preserves BC and DE.
    push bc
    push de
    call MapGen_ConnectDots
    pop de
    pop bc
    ret

MapGen_SetTileHLNorth:
    ; Write tile A north of HL.
    ld a, -8
    add l
    ld l, a
    ldh a, [hChunkWriteTile]
    ld [hl], a
    ld a, 8
    add l
    ld l, a
    ret

MapGen_SetTileHLSouth:
    ; Write tile A south of HL.
    ld a, 8
    add l
    ld l, a
    ldh a, [hChunkWriteTile]
    ld [hl], a
    ld a, -8
    add l
    ld l, a
    ret

MapGen_SetTileHLWest:
    ; Write tile A west of HL.
    dec l
    ldh a, [hChunkWriteTile]
    ld [hl], a
    inc l
    ret

MapGen_SetTileHLEast:
    ; Write tile A east of HL.
    inc l
    ldh a, [hChunkWriteTile]
    ld [hl], a
    dec l
    ret

; [hChunkWriteTile] - which tile
MapGen_Expand:
    ; Loop through each tile on the map. If it is tile [hChunkWriteTile],
    ; it has a 50% chance of spawning a new tile with ID [hChunkWriteTile],
    ; from each cardinal direction (1 tile up, 1 tile down, 1 tile left,
    ; 1 tile right). We call this procedure "expanding".
    ld hl, wMapBufferA + 8
    ld de, wMapBufferB + 8
    ld c, 64 - 16
.makeMapCopy
    ld a, [hli]
    ld [de], a
    inc e
    dec c
    jr nz, .makeMapCopy
    ld hl, wMapBufferA + 8
    ld de, wMapBufferB + 8
    ld c, 64 - 16
.expandDong
    ld a, [de]
    ld b, a
    ldh a, [hChunkWriteTile]
    cp b
    jr nz, .noExpand
    ld a, l
    and $07
    jr z, .noExpand
    cp $07
    jr z, .noExpand
    call PRNG
    ld b, a
    bit 0, b
    call nz, MapGen_SetTileHLWest
    bit 1, b
    call nz, MapGen_SetTileHLEast
    bit 2, b
    call nz, MapGen_SetTileHLNorth
    bit 3, b
    call nz, MapGen_SetTileHLSouth
.noExpand
    inc e
    inc l
    dec c
    jr nz, .expandDong
    ret

MapGen_Seed:
    ; In the map data, replace each tile B with C with a D/256 chance.
    ; We call this procedure "seeding".
    ld a, b
    ldh [hChunkWriteTile], a
    ld hl, wMapBufferA
    ld e, 64
.loop
    ld a, [hli]
    cp b
    jr nz, .continue
    call PRNG
    cp d
    ldh a, [hChunkWriteTile]
    ld b, a
    jr nc, .continue
    ld a, c
    dec hl
    ld [hli], a
.continue
    dec e
    jr nz, .loop
    ret

MapGen_SeedInside:
    ; MapGen_Seed, but does not check tiles on map borders
    ; (X=0,7 or Y=0,7)
    ld a, b
    ldh [hChunkWriteTile], a
    ld hl, wMapBufferA + 8
    ld e, 64 - 16
.loop
    ld a, l
    and $07
    jr z, .continue
    cp $07
    jr z, .continue
    ld a, [hl]
    cp b
    jr nz, .continue
    call PRNG
    cp d
    ldh a, [hChunkWriteTile]
    ld b, a
    jr nc, .continue
    ld a, c
    ld [hl], a
.continue
    inc l
    dec e
    jr nz, .loop
    ret

MapGen_AdvancedSeed:
    ; MapGen_SeedInside, but only changes tiles which are next to other tiles,
    ; based on values in [hChunkSeedTileTop], [hChunkSeedTileBottom],
    ; [hChunkSeedTileLeft], [hChunkSeedTileRight].
    ld a, b
    ldh [hChunkWriteTile], a
    ld hl, wMapBufferA + 8
    ld e, 64 - 16
.loop
    ld a, [hl]
    cp b
    jr nz, .continue
    ld a, l
    and $07
    jr z, .continue
    cp $07
    jr z, .continue
    call PRNG
    cp d
    ldh a, [hChunkWriteTile]
    ld b, a
    jr c, .continue
    ld a, l
    sub 8
    ld l, a
    ldh a, [hChunkSeedTileTop]
    and a
    jr z, .skipTopCheck
    cp [hl]
    jr nz, .noTopTile
.skipTopCheck
    ld a, l
    add 8 + 8
    ld l, a
    ldh a, [hChunkSeedTileBottom]
    and a
    jr z, .skipBotCheck
    cp [hl]
    jr nz, .noBotTile
.skipBotCheck
    ld a, l
    sub 8 + 1
    ld l, a
    ldh a, [hChunkSeedTileLeft]
    and a
    jr z, .skipLeftCheck
    cp [hl]
    jr nz, .noLeftTile
.skipLeftCheck
    inc l
    inc l
    ldh a, [hChunkSeedTileRight]
    and a
    jr z, .skipRightCheck
    cp [hl]
    jr nz, .noRightTile
.skipRightCheck
    dec l
    ld a, c
    ld [hl], a
.continue
    inc l
    dec e
    jr nz, .loop
    ret
.noTopTile
    ld a, l
    add 8 + 1
    ld l, a
    dec e
    jr nz, .loop
    ret
.noBotTile
    ld a, l
    sub 8 - 1
    ld l, a
    dec e
    jr nz, .loop
    ret
.noLeftTile
    inc l
    inc l
.noRightTile
    dec e
    jr nz, .loop
    ret

GenerateChunk:
    ; Generate a chunk.
    ; X in DE, Y in HL.
    push de
    push hl
    call GetChunkExitsAndBiome
    ld hl, wMapBufferA
    ld bc, 64
    ld a, $0f
    call FillMemory
    ldh a, [hChunkExitsAndBiome]
    ld b, a
    bit 0, b
    jr z, .notE
    ld a, $74
    ldh [hChunkStartXY], a
.notE
    bit 1, b
    jr z, .notW
    ld a, $04
    ldh [hChunkStartXY], a
.notW
    bit 2, b
    jr z, .notS
    ld a, $47
    ldh [hChunkStartXY], a
.notS
    bit 3, b
    jr z, .notN
    ld a, $40
    ldh [hChunkStartXY], a
.notN
    pop hl
    pop de
    push de
    push hl
    ld b, h
    ld c, l
    call PreparePRNGState
    ldh a, [hChunkStartXY]
    ld b, a
    ldh a, [hChunkExitsAndBiome]
    ld d, a
    ld e, $0a
    bit 0, d
    ld c, $74
    call nz, MapGen_ConnectDots_Preserve
    bit 1, d
    ld c, $04
    call nz, MapGen_ConnectDots_Preserve
    bit 2, d
    ld c, $47
    call nz, MapGen_ConnectDots_Preserve
    bit 3, d
    ld c, $40
    call nz, MapGen_ConnectDots_Preserve
    ld a, $0a
    ldh [hChunkWriteTile], a
    push de
    call MapGen_Expand
    pop de
    bit 3, d
    ld b, $30
    call nz, MapGen_WriteTileAtB
    ld b, $40
    call nz, MapGen_WriteTileAtB
    bit 2, d
    ld b, $37
    call nz, MapGen_WriteTileAtB
    ld b, $47
    call nz, MapGen_WriteTileAtB
    bit 1, d
    ld b, $03
    call nz, MapGen_WriteTileAtB
    ld b, $04
    call nz, MapGen_WriteTileAtB
    bit 0, d
    ld b, $73
    call nz, MapGen_WriteTileAtB
    ld b, $74
    call nz, MapGen_WriteTileAtB
    ; Select biome
    ld a, d
    swap a
    and $03
    add a
    ld e, a
    ld d, 0
    ld hl, BiomeCallbacks
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    call _hl_
    ld hl, wMapBufferA
    ld de, $0000
.checkItemTiles
    ; Check if any item tiles need to be removed
    ld a, [hli]
    cp $33
    call z, CheckItemTile
    cp $32
    call z, CheckItemTile
    cp $60
    call z, CheckItemTile
    cp $34
    call z, CheckItemTile
    cp $08
    call z, CheckItemTile
    inc e
    ld a, e
    cp $08
    jr nz, .checkItemTiles
    inc d
    ld e, 0
    ld a, d
    cp $08
    jr nz, .checkItemTiles
.leave
    pop hl
    pop de
    ret
BiomeCallbacks:
    dw GenerateChunk_GrasslandsBiome
    dw GenerateChunk_SteppesBiome
    dw GenerateChunk_ConstructBiome
    dw GenerateChunk_CorruptionBiome

FeedDJB2Hash:
    ; Add A to DJB2 hash in HL.
    ld b, h
    ld c, l
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    sla l
    rl h
    add hl, bc
    ld b, 0
    ld c, a
    add hl, bc
    ret

GetItemTileHash:
    ; Hash an item location (chunk X,Y and map X,Y) with DJB2, except
    ; limited to $3FFF. Return in DE.
    ld hl, 5381
    ld a, d
    call FeedDJB2Hash
    ld a, e
    call FeedDJB2Hash
    ld de, wCurChunkVars
    ld a, [de]
    call FeedDJB2Hash
    inc de
    ld a, [de]
    call FeedDJB2Hash
    inc de
    ld a, [de]
    call FeedDJB2Hash
    inc de
    ld a, [de]
    call FeedDJB2Hash
    ld a, h
    and %00111111
    ld d, a
    ld e, l
    ret

CheckItemTile:
    ; Check if an item was already picked up. Change up the corresponding
    ; map tile accordingly.
    push de
    push hl
    call GetItemTileHash
    ld b, 1
    call ItemFlagOperation
    jr z, .didntPickUp
    pop hl
    dec hl
    ld de, ItemPickupBlockSwaps
.test
    ld a, [de]
    inc de
    inc de
    cp [hl]
    jr nz, .test
.swapTile
    dec de
    ld a, [de]
    ld [hli], a
    pop de
    ret
.didntPickUp
    pop hl
    pop de
    ret

GenerateChunk_GrasslandsBiome:
    ; Generate a Grasslands biome.
    ; seed(0x0a, 0x0b, 0x30, prng_state);
    ld bc, $0a0b
    ld d, $30
    call MapGen_Seed
    ; expand(0x0b, 0xff, prng_state);
    ld a, $0b
    ldh [hChunkWriteTile], a
    call MapGen_Expand
    ; advanced_seed(0x0f, 0x0f, 0x0a, 0xff, 0xff, 0x6c, 0x20, prng_state);
    ld a, $0f
    ldh [hChunkSeedTileTop], a
    ld a, $0a
    ldh [hChunkSeedTileBottom], a
    xor a
    ldh [hChunkSeedTileLeft], a
    ldh [hChunkSeedTileRight], a
    ld bc, $0f6c
    ld d, $20
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0f, 0x0a, 0x0f, 0xff, 0xff, 0x6f, 0x20, prng_state);
    ld a, $0a
    ldh [hChunkSeedTileTop], a
    ld a, $0f
    ldh [hChunkSeedTileBottom], a
    ld bc, $0f6f
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0f, 0xff, 0xff, 0x0a, 0x0f, 0x6e, 0x20, prng_state);
    xor a
    ldh [hChunkSeedTileTop], a
    ldh [hChunkSeedTileBottom], a
    ld a, $0a
    ldh [hChunkSeedTileLeft], a
    ld a, $0f
    ldh [hChunkSeedTileRight], a
    ld bc, $0f6e
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0f, 0xff, 0xff, 0x0f, 0x0a, 0x6d, 0x20, prng_state);
    ld a, $0f
    ldh [hChunkSeedTileLeft], a
    ld a, $0a
    ldh [hChunkSeedTileRight], a
    ld bc, $0f6d
    call MapGen_AdvancedSeed
    ; seed(0x0a, 0x74, 0x30, prng_state);
    ld bc, $0a74
    ld d, $30
    call MapGen_Seed
    ; seed(0x0a, 0x7a, 0x30, prng_state);
    ld bc, $0a7a
    ld d, $30
    call MapGen_Seed
    ; seed_inside(0x6c, 0x33, 0x40, prng_state);
    ld bc, $6c33
    ld d, $40
    call MapGen_SeedInside
    ; seed_inside(0x6d, 0x32, 0x40, prng_state);
    ld bc, $6d32
    ld d, $40
    call MapGen_SeedInside
    ; seed_inside(0x6e, 0x60, 0x40, prng_state);
    ld bc, $6e60
    ld d, $40
    call MapGen_SeedInside
    ; seed_inside(0x6f, 0x34, 0x40, prng_state);
    ld bc, $6f34
    ld d, $40
    jp MapGen_SeedInside

GenerateChunk_SteppesBiome:
    ; Generate a Steppes biome.
    ; seed(0x0a, 0x7b, 0x40, prng_state);
    ld bc, $0a7b
    ld d, $40
    call MapGen_Seed
    ; seed(0x0a, 0x7a, 0x30, prng_state);
    ld bc, $0a7a
    ld d, $30
    call MapGen_Seed
    ; seed(0x0a, 0x0b, 0xd0, prng_state);
    ld bc, $0a0b
    ld d, $d0
    call MapGen_Seed
    ; seed_inside(0x0a, 0x08, 0x20, prng_state);
    ld bc, $0a08
    ld d, $20
    jp MapGen_SeedInside

GenerateChunk_ConstructBiome:
    ; Generate a Construct biome.
    ; advanced_seed(0x0f, 0xff, 0xff, 0xff, 0x0a, 0x13, 0xc0, prng_state);
    xor a
    ldh [hChunkSeedTileTop], a
    ldh [hChunkSeedTileBottom], a
    ldh [hChunkSeedTileLeft], a
    ld a, $0a
    ldh [hChunkSeedTileRight], a
    ld bc, $0f13
    ld d, $c0
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0f, 0xff, 0xff, 0x0a, 0xff, 0x13, 0xc0, prng_state);
    ld a, $0a
    ldh [hChunkSeedTileLeft], a
    xor a
    ldh [hChunkSeedTileRight], a
    ld bc, $0f13
    ld d, $c0
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0a, 0xff, 0xff, 0x0f, 0xff, 0x4e, 0x60, prng_state);
    ld a, $0f
    ldh [hChunkSeedTileLeft], a
    ld bc, $0a4e
    ld d, $60
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0a, 0xff, 0xff, 0xff, 0x0f, 0x4d, 0x60, prng_state);
    xor a
    ldh [hChunkSeedTileLeft], a
    ld a, $0f
    ldh [hChunkSeedTileRight], a
    ld bc, $0a4d
    ld d, $60
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0a, 0x0f, 0xff, 0xff, 0xff, 0x51, 0x60, prng_state);
    xor a
    ldh [hChunkSeedTileRight], a
    ld a, $0f
    ldh [hChunkSeedTileTop], a
    ld bc, $0a51
    ld d, $60
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0a, 0xff, 0x0f, 0xff, 0xff, 0x52, 0x60, prng_state);
    xor a
    ldh [hChunkSeedTileTop], a
    ld a, $0f
    ldh [hChunkSeedTileBottom], a
    ld bc, $0a52
    ld d, $60
    call MapGen_AdvancedSeed
    ; if (exits[0]) connect_dots_simple(startxy[0], startxy[1], 4, 0, 0x55, prng_state);
    ld a, $55
    ldh [hChunkWriteTile], a
    ldh a, [hChunkExitsAndBiome]
    ld d, a
    ldh a, [hChunkStartXY]
    ld e, a
    push de
    bit 3, d
    ld b, e
    ld c, $40
    call nz, MapGen_ConnectDots_Simple2
    pop de
    ; if (exits[1]) connect_dots_simple(startxy[0], startxy[1], 4, 7, 0x55, prng_state);
    push de
    bit 2, d
    ld b, e
    ld c, $47
    call nz, MapGen_ConnectDots_Simple2
    pop de
    ; if (exits[2]) connect_dots_simple(startxy[0], startxy[1], 0, 4, 0x55, prng_state);
    push de
    bit 1, d
    ld b, e
    ld c, $04
    call nz, MapGen_ConnectDots_Simple2
    pop de
    ; if (exits[3]) connect_dots_simple(startxy[0], startxy[1], 7, 4, 0x55, prng_state);
    bit 0, d
    ld b, e
    ld c, $74
    call nz, MapGen_ConnectDots_Simple2
    ; seed(0x0a, 0x0b, 0x50, prng_state);
    ld bc, $0a0b
    ld d, $50
    call MapGen_Seed
    ; seed(0x0a, 0x7a, 0xc0, prng_state);
    ld bc, $0a7a
    ld d, $c0
    call MapGen_Seed
    ; seed(0x0a, 0x0b, 0x74, prng_state);
    ld bc, $0a0b
    ld d, $74
    call MapGen_Seed
    ; seed_inside(0x4e, 0x32, 0x18, prng_state);
    ld bc, $4e32
    ld d, $18
    call MapGen_SeedInside
    ; seed_inside(0x4d, 0x60, 0x18, prng_state);
    ld bc, $4d60
    ld d, $18
    jp MapGen_SeedInside

GenerateChunk_CorruptionBiome:
    ; Generate a Corruption biome.
    ; advanced_seed(0x0f, 0xff, 0xff, 0xff, 0x0a, 0xec, 0x40, prng_state);
    xor a
    ldh [hChunkSeedTileTop], a
    ldh [hChunkSeedTileBottom], a
    ldh [hChunkSeedTileRight], a
    ld a, $0a
    ldh [hChunkSeedTileLeft], a
    ld bc, $0fec
    ld d, $40
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0f, 0xff, 0xff, 0x0a, 0xff, 0xec, 0x40, prng_state);
    xor a
    ldh [hChunkSeedTileLeft], a
    ld a, $0a
    ldh [hChunkSeedTileRight], a
    ld bc, $0fec
    ld d, $40
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0f, 0x0a, 0xff, 0xff, 0xff, 0xec, 0x40, prng_state);
    xor a
    ldh [hChunkSeedTileRight], a
    ld a, $0a
    ldh [hChunkSeedTileTop], a
    ld bc, $0fec
    ld d, $40
    call MapGen_AdvancedSeed
    ; advanced_seed(0x0f, 0xff, 0x0a, 0xff, 0xff, 0xec, 0x40, prng_state);  
    xor a
    ldh [hChunkSeedTileTop], a
    ld a, $0a
    ldh [hChunkSeedTileBottom], a
    ld bc, $0fec
    ld d, $40
    call MapGen_AdvancedSeed
    ; seed(0xec, 0xc9, 0x80, prng_state);
    ld bc, $ecc9
    ld d, $80
    call MapGen_Seed
    ; seed(0x0a, 0x0b, 0x80, prng_state);
    ld bc, $0a0b
    ld d, $80
    call MapGen_Seed
    ; randomly place corrupted tiles
    ld hl, wMapBufferA
    ld c, 64
.loop
    ld a, [hl]
    cp $0f
    jr nz, .cont
    call PRNG
    cp $40
    jr nc, .cont
    call PRNG
    and $03
    push hl
    ld hl, CorruptedTilesTable
    ld d, 0
    ld e, a
    add hl, de
    ld a, [hl]
    pop hl
    ld [hl], a
.cont
    inc l
    dec c
    jr nz, .loop
    ; if (exits[0]) connect_dots_simple(startxy[0], startxy[1], 4, 0, 0x31, prng_state);
    ld a, $31
    ldh [hChunkWriteTile], a
    ldh a, [hChunkExitsAndBiome]
    ld d, a
    ldh a, [hChunkStartXY]
    ld e, a
    push de
    bit 3, d
    ld b, e
    ld c, $40
    call nz, MapGen_ConnectDots_Simple2
    pop de
    ; if (exits[1]) connect_dots_simple(startxy[0], startxy[1], 4, 7, 0x31, prng_state);
    push de
    bit 2, d
    ld b, e
    ld c, $47
    call nz, MapGen_ConnectDots_Simple2
    pop de
    ; if (exits[2]) connect_dots_simple(startxy[0], startxy[1], 0, 4, 0x31, prng_state);
    push de
    bit 1, d
    ld b, e
    ld c, $04
    call nz, MapGen_ConnectDots_Simple2
    pop de
    ; if (exits[3]) connect_dots_simple(startxy[0], startxy[1], 7, 4, 0x31, prng_state);
    bit 0, d
    ld b, e
    ld c, $74
    call nz, MapGen_ConnectDots_Simple2
    ; seed(0x31, 0x0b, 0x20, prng_state);
    ld bc, $310b
    ld d, $20
    call MapGen_Seed
    ; seed_inside(0x31, 0x08, 0x10, prng_state);
    ld bc, $3108
    ld d, $10
    jp MapGen_SeedInside
CorruptedTilesTable:
    db $d9, $db, $ca, $cb

CopyWithStride:
    ; Copy wMapBufferA to DE with 24-block stride
    ; (DE is usually wOverworldMap)
    ld hl, wMapBufferA
    ld b, 8
.col
    ld c, 8
.row
    ld a, [hli]
    ld [de], a
    inc de
    dec c
    jr nz, .row
    ld a, e
    add 24 - 8
    ld e, a
    ld a, d
    adc 0
    ld d, a
    dec b
    jr nz, .col
    ret
    
GenerateAndCopySingleChunk:
    ; Generate a chunk, then copy it to wOverworldMap.
    push hl
    push bc
    call StoreChunkVars
    pop bc
    pop hl
    push bc
    call GenerateChunk
    pop bc
    push hl
    push de
    ld d, b
    ld e, c
    call CopyWithStride
    pop de
    pop hl
    ret

LoadChunkVars:
    ; Load chunk X, Y to DE, HL.
    ld hl, wCurChunkVars
    ld e, [hl]
    inc hl
    ld d, [hl]
    inc hl
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ret

StoreChunkVars:
    ; Store chunk X, Y at DE, HL to wCurChunkVars.
    ld b, h
    ld c, l
    ld hl, wCurChunkVars
    ld [hl], e
    inc hl
    ld [hl], d
    inc hl
    ld [hl], c
    inc hl
    ld [hl], b
    ret

RecalculateMapView:
    ; Reload all chunks in player's view
    call LoadChunkVars
    push hl
    push de
    ld bc, wCurMapBlocks + 8*24 + 8
    call GenerateAndCopySingleChunk
    ldh a, [hChunkExitsAndBiome]
    ld [wCurrentBiome], a
    dec de
    ld bc, wCurMapBlocks + 8*24
    call GenerateAndCopySingleChunk
    dec hl
    ld bc, wCurMapBlocks
    call GenerateAndCopySingleChunk
    inc de
    ld bc, wCurMapBlocks + 8
    call GenerateAndCopySingleChunk
    inc de
    ld bc, wCurMapBlocks + 8*2
    call GenerateAndCopySingleChunk
    inc hl
    ld bc, wCurMapBlocks + 8*24 + 8*2
    call GenerateAndCopySingleChunk
    inc hl
    ld bc, wCurMapBlocks + 16*24 + 8*2
    call GenerateAndCopySingleChunk
    dec de
    ld bc, wCurMapBlocks + 16*24 + 8
    call GenerateAndCopySingleChunk
    dec de
    ld bc, wCurMapBlocks + 16*24
    call GenerateAndCopySingleChunk
    pop de
    pop hl
    jp StoreChunkVars