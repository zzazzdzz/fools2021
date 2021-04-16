SECTION "WRAMPARENT", ROM0[$30C0]
LOAD "WRAM", WRAMX[$DA80], BANK[1]

_EntryPoint:
    call VerifySaveFile
    jp _Start

wTextEngineVarsStart:
wTextEngineCurrentGlyph:
    ds 9
wTextEngineWorkingBlocks:
wTextEngineWorkingBlock1:
    ds 8
wTextEngineWorkingBlock2:
    ds 8
wTextEngineBoldFace:
    ds 1
wTextEngineCurrentXPosition:
    ds 1
wTextEngineCurrentCharIndex:
    ds 1
wTextEngineCurrentTilemapIndex:
    ds 1
wTextEngineCharIndexOffset:
    ds 1
wTextEngineVarsEnd:

wTextBoxBank:
    ds 1
wTextBoxBufferPtr:
    ds 3
wTextBoxBufferListPtr:
    ds 3
wTxNumBuf:
    ds 5

wCurrentBiome:
    ds 1
wMenuCurrentSettings:
    ds 1
wMenuNumOptions:
    ds 1
wDamageDealt:
    ds 1

wCurChunkVars:
wCurChunkX:
    dw $0001
wCurChunkY:
    dw $0002

wMapSeed:
    ds 4
wRNGVars:
wRNGVarX:
    ds 1
wRNGVarA:
    ds 1
wRNGVarB:
    ds 1
wRNGVarC:
    ds 1

; Purposefully place this here, for the 4th hacking challenge.
; This way, after "ld sp, hl" and "dec sp", the stack pointer ends
; up in an easily manipulatable area: first byte is an RNG variable,
; second is the number of minutes XOR'd with some constant.

wPasswordBuffer:
    ds 5

wInventoryPage:
    ds 1
wInventoryChoice:
    ds 1
wCurrentGrassRate:
    db 5 percent
wQuitStartCompletely:
    ds 1
wCurrentOpponentSpecies:
    db 0
wCurrentOpponentLevel:
    ds 1
wCurrentOpponentBoss:
    db 0
wNextOpponentEmpowerment:
    db 0
wAllOpponentsEmpowerment:
    db 0
wAttackEmpowerment:
    db 0

wOpponentsEncountered:
    db 0, 0, 0

wCurrentOpponent:
wCurrentOpponentIGSpecies:
    ds 1
wCurrentOpponentIntroTextPtr:
    ds 2
wCurrentOpponentNamePtr:
    ds 2
wCurrentOpponentExpYield:
    ds 1
wCurrentOpponentBaseHP:
    ds 1
wCurrentOpponentBaseDamage:
    ds 1
wCurrentOpponentDropChance:
    ds 1
wCurrentOpponentDropItem:
    ds 1

wCurrentTurn:
    ds 1
wTextBufPtr:
    ds 2

wPlayerMaxHP:
    db 30
wPlayerCurHP:
    db 30
wPlayerCurLevel:
    db 10
wPlayerCurExpLeft:
    db 4

wLastCoordSum:
    ds 1

wInventoryNumItems:
    db 0
wInventory:
    db $ff,$00
    ds 39*2

wCurrentMapMusic:
    db 0
wSkipSandwichCounter:
    db 0
wShowLoreText:
    db 1
wLoreEventFlags:
    db 0
wSummoningSaltCounter:
    db 0

SwitchToSRA2:
    ; Switch to SRAM bank 2.
    ld a, 2
SwitchToSRAX:
    ; Switch to SRAM bank in A.
    ld [wCurrentSRAMBank], a
SwitchToSRAX_NoPreserve:
    ; Switch to SRAM bank in A, but don't save the current bank.
    ld [$4000], a
    ld a, $0a
    ld [$0000], a
    ret
SwitchToSRA3:
    ; Switch to SRAM bank 3.
    ld a, 3
    jr SwitchToSRAX

wCurrentSRAMBank:
    ds 1

SafeCall:
    ; Call an address (in wSafeCallAddress), but restore the
    ; current SRAM bank once the routine completes.
    db $cd ; call
wSafeCallAddress:
wSafeCallAddressLow:
    ds 1
wSafeCallAddressHigh:
    ds 1
RestoreAndReturn:
    ld a, [wCurrentSRAMBank]
    jr SwitchToSRAX
SafeCallHL:
    call .jp_hl
    jr RestoreAndReturn
.jp_hl
    jp hl

CopyDataFromSRAX:
    ; Self-contained CopyData from SRAM bank in A.
    call SwitchToSRAX_NoPreserve
    call CopyData
    jr RestoreAndReturn

ReadFromSRA3:
    ; Read a byte at HL from SRA3.
    ld a, 3
ReadFromSRAX:
    ; Read a byte at HL from SRAM bank A.
    call SwitchToSRAX_NoPreserve
    ld a, [hl]
    push af
    call RestoreAndReturn
    pop af
    ret

EncodeAndChecksumPassword:
    ; Password encoding and checksumming algorithm. It's here on purpose,
    ; to make sure this can be corrupted with the 99 item stack glitch on
    ; wInventory. This was for the 4th hacking challenge.
    ld hl, wPasswordBuffer
    ; Corrupting byte after 0x04 (REVIVER_SEED)
    ; creates an "ld hl, sp" opcode
    ld c, 4
    ld de, $f9d4
.encode
    ld a, d
    xor e
    xor [hl]
    ld d, e
    ld e, a
    ld [hli], a
    ; Corrupting byte after 0x0D (BRAVERY_POTION)
    ; creates a "dec sp" opcode
    dec c
    jr nz, .encode
    ld a, $3b
    ld hl, wPasswordBuffer
    add [hl]
    inc hl
    xor [hl]
    inc hl
    sub [hl]
    inc hl
    xor [hl]
    inc hl
    ld [hl], a
    ret

VerifySaveFile:
    ; Check if the save file is healthy
    call SwitchToSRA3
    call .calc
    call SwitchToSRA2
    ; Fall through to .calc
.calc
    call CalcSRAMChecksum
    ld a, [$a000]
    cp d
    jr nz, .wrong
    ret
.wrong
    ; Display a message if the checksum is wrong.
    call LoadFontTilePatterns
    xor a
    ldh [$b0], a
    inc a
    ldh [$ba], a
    ld hl, .saveDataCorruptedText
    call PrintText
.forever
    jr .forever
.saveDataCorruptedText
    db $00,$93,$a7,$a4,$7f,$b2,$a0,$b5,$a4,$7f,$a3,$a0,$b3,$a0,$4f
    db $a8,$b2,$7f,$a2,$ae,$b1,$b1,$b4,$af,$b3,$a4,$a3,$e8,$51
    db $8f,$ab,$a4,$a0,$b2,$a4,$7f,$b1,$a4,$a3,$ae,$b6,$ad,$ab,$ae,$a0,$a3,$4f
    db $b3,$a7,$a4,$7f,$b2,$a0,$b5,$a4,$7f,$a5,$a8,$ab,$a4,$e8,$57

CalcSRAMChecksum:
    ; Calculate checksum of SRAM region A001-BFFF with a simple custom
    ; algorithm.
    ld bc, $1fff
    ld hl, $a001
    ld d, $55
.loop
    ld a, [hli]
    xor d
    inc a
    ld d, a
    dec bc
    ld a, b
    or c
    jr nz, .loop
    ret

LoadItemName:
    ; Load an item name to buffer in $CD6D.
    call SwitchToSRA3
    ld a, c
    and a
    jr z, .invalid
    cp MAX_ITEMS
    jr nc, .invalid
    ld hl, ItemNameList
.getEntry
    ld a, [hli]
    and a
    jr nz, .getEntry
    dec c
    jr nz, .getEntry
.got
    ld a, l
    ld [wTextBufPtr], a
    ld a, h
    ld [wTextBufPtr+1], a
    ld de, $cd6d
    ld bc, 18
    call CopyData
    ld hl, $cd6d
.convertCharsets
    ld a, [hl]
    and a
    jr z, .finish
    cp " "
    jr nz, .notSpace
    ld [hl], $7f
    inc hl
    jr .convertCharsets
.notSpace
    add $80 - 1
    ld [hli], a
    jr .convertCharsets
.finish
    ld [hl], $50
    jp SwitchToSRA2
.invalid
    ld hl, InvalidItemName
    jr .got

ItemFlagOperation:
    ; Perform action B on item flag DE.
    ; Set bit if B=0, read bit otherwise.
    push bc
    xor a
    call SwitchToSRAX_NoPreserve
    ld hl, wItemFlags
    ld a, e
    and 7
    ld c, a
    srl d
    rr e
    srl d
    rr e
    srl d
    rr e
    ld b, 0
    inc c
    scf
.bitmask
    rl b
    dec c
    jr nz, .bitmask
    add hl, de
    pop de
    ld a, d
    and a
    jr z, .setBit
.readBit
    ; Set ZF based on bit value
    ld a, [hl]
    and b
    ld b, a
    jp RestoreAndReturn ; ZF set appropriately
.setBit
    ld a, [hl]
    or b
    ld [hl], a
    jp RestoreAndReturn

ClearItemFlags:
    ; Clear the item flag table.
    xor a
    call SwitchToSRAX_NoPreserve
    ld hl, wItemFlags
    ld bc, $0800
    xor a
    call FillMemory
    jp RestoreAndReturn

; Item ball graphics.

PokeBallGfx1:
    db $AB,$00,$45,$00,$8F,$03,$5F,$0C,$BE,$10,$5E,$10,$3F,$20,$7F,$20
    db $AB,$00,$45,$00,$CE,$C0,$FD,$30,$7A,$08,$7B,$08,$FE,$04,$FD,$04
    db $A7,$20,$60,$20,$90,$10,$50,$10,$BC,$0C,$53,$03,$26,$00,$7D,$00
    db $E7,$04,$05,$04,$0E,$08,$0D,$08,$3A,$30,$D3,$C0,$26,$00,$7D,$00
PokeBallGfx2:
    db $00,$00,$50,$00,$57,$03,$0F,$0C,$1E,$10,$3E,$10,$3F,$20,$3F,$20
    db $00,$00,$50,$00,$D5,$C0,$F5,$30,$78,$08,$78,$08,$FC,$04,$FC,$04
    db $27,$20,$60,$20,$50,$10,$10,$10,$0C,$0C,$2B,$03,$28,$00,$00,$00
    db $E4,$04,$04,$04,$0D,$08,$0D,$08,$30,$30,$E8,$C0,$28,$00,$00,$00

; Map exit configurations for the map generator.

MapExitConfigurations:
    db "┌┴┐•"
    db "┤┌┴─"
    db "└┤••"
    db "•│••"
    
    db "•│┌┐"
    db "┐├┘└"
    db "└┴┐•"
    db "•┌┘•"
    
    db "┌┴┐•"
    db "┴┐└┬"
    db "•└┬┘"
    db "•┌┘•"
    
    db "•└┐•"
    db "─┐│┌"
    db "•└┼┘"
    db "•┌┘•"
    
    db "┌┘••"
    db "┼┐┌─"
    db "└┼┘•"
    db "•│••"
    
    db "┌┴─┐"
    db "┤••├"
    db "└┐•│"
    db "•├─┘"
    
    db "•└┐•"
    db "┐┌┘┌"
    db "└┼┐│"
    db "•│└┘"
    
    db "•│••"
    db "─┼┬─"
    db "•├┘•"
    db "•│••"

ENDL