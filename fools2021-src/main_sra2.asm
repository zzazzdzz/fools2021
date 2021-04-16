SECTION "SRA2PARENT", ROMX[$4000], BANK[1]
LOAD "SRA2", SRAM[$A000], BANK[2]

; SRAM bank 2. Contains mostly code

_SRA2Checksum:
    ds 1
_SRA2Ident:
    db 2
    
include "engine/utils.asm"
include "engine/text.asm"
include "engine/emulator_tests.asm"
include "engine/overworld.asm"
include "engine/map_gen.asm"
include "engine/menu.asm"
include "engine/start_menu.asm"
include "engine/battle.asm"
include "engine/password.asm"
include "engine/ace.asm"
include "engine/items.asm"

_Start:
    ; Entry point.
    call ClearItemFlags
    ld a, $c0
    ld [wSpritePlayerStateData1YPixels], a
    ld a, $ff
    ld [wAudioFadeOutControl], a
    ld a, 3
    ld [wAudioFadeOutCounterReloadValue], a
    call TextboxEnable
    ld c, 30
    call DelayFrames
    call CheckEmulationAccuracy
    call c, InaccurateEmulator
    call CheckROM
    call nz, WrongROM
    ld hl, IntroText
    call PrintTextVWF
    ld hl, wMapSeed
    call Random
    ld [hli], a
    call Random
    ld [hli], a
    call Random
    ld [hli], a
    call Random
    ld [hl], a
    ldh a, [$f8]
    and $04
    call nz, SeedSetFeature
    ld c, 30
    call DelayFrames
    jp IntoOverworld

InaccurateEmulator:
    ld hl, InaccurateEmulatorText
    call PrintTextVWF
.forever
    jr .forever
    ret

WrongROM:
    ld hl, WrongROMText
    call PrintTextVWF
.forever
    jr .forever
    ret

SeedSetFeature:
    ; A cool hidden feature. Hold Select while starting the game to set the
    ; seed. This was mostly to make ACE TASes easier for those who found it.
    ld hl, ItsAFeatureText
    call PrintTextVWF
    xor a
    ld [wInventoryPage], a
.inputLoop
    coord hl, 10, 8
    ld bc, $0208
    call TextBoxBorder
    coord hl, 11, 10
    ld de, wMapSeed
    ld c, 4
    call PrintHex
    coord hl, 11, 9
    ld bc, 8
    ld a, $7f
    call FillMemory
    ld a, [wInventoryPage]
    ld c, a
    ld b, 0
    coord hl, 11, 9
    add hl, bc
    ld [hl], $ee
.waitNoInput
    ldh a, [$f8]
    and a
    jr nz, .waitNoInput
.waitInput
    ldh a, [$f8]
    and a
    jr z, .waitInput
    bit 5, a
    jr nz, .left
    bit 4, a
    jr nz, .right
    bit 6, a
    jr nz, .up
    bit 7, a
    jr nz, .down
    bit 3, a
    jr nz, .start
    jr .inputLoop
.left
    ld a, [wInventoryPage]
    and a
    jr z, .inputLoop
    dec a
    ld [wInventoryPage], a
    jr .inputLoop
.right
    ld a, [wInventoryPage]
    cp 7
    jr z, .inputLoop
    inc a
    ld [wInventoryPage], a
    jr .inputLoop
.start
    ld a, SFX_PURCHASE
    call PlaySound
    jp WaitForSoundToFinish
.down
    ld de, $f0ff
    jr .common
.up
    ld de, $1001
.common
    ld a, [wInventoryPage]
    ld b, 0
    ld c, a
    srl c
    ld hl, wMapSeed
    add hl, bc
    ld a, [wInventoryPage]
    and 1
    jr z, .upper
.lower
    ld a, [hl]
    add e
    ld [hl], a
    jp .inputLoop
.upper
    ld a, [hl]
    add d
    ld [hl], a
    jp .inputLoop

ENDL