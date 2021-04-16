; *** emulator_tests.asm
; Simple hardware behavior tests, to make sure the game runs on an accurate
; enough emulator to be playable.

EchoRAMTest:
    ; Check support for echo RAM. Return status in CF.
    ld b, 0
.loop
    ld a, b
    ld [$d000], a
    ld a, [$f000]
    cp b
    jr nz, .fail
    dec b
    jr nz, .loop
    and a
    ret
.fail
    scf
    ret

VRAMInaccessibilityTest:
    ; Check VRAM inaccessibility. Return status in CF.
    ld hl, $8111
    ld bc, $ff00
.loop
    ld a, [hl]
    cp $ff
    jr nz, .notFF
    inc c
.notFF
    dec b
    jr nz, .loop
    ld a, c
    and a
    scf
    ret z
    ccf
    ret

CheckEmulationAccuracy:
    ; Perform all of the checks above. Return status in CF.
    call EchoRAMTest
    ret c
    call VRAMInaccessibilityTest
    ret