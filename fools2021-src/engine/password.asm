; *** password.asm
; Password generation routines.

GenerateAndShowPassword:
    ; Generate the password and show it to the player.
    call TextboxEnable
    call ClearScreen
	call LoadTextBoxTilePatterns
    call UpdateSprites
    ld c, 30
    call DelayFrames
    call PasswordGeneration
    call PlayUnusedTheme
    coord hl, 1, 1
    ld de, PasswordScreenTilemap
    call PlaceStringSimple
    coord hl, 4, 14
    ld bc, $010a
    call TextBoxBorder
    coord hl, 5, 15
    ld de, wPasswordBuffer
    ld c, 5
    call PrintHex
.forever
    jr .forever

PasswordGeneration:
    ; Password generation routine.
    ld a, [wPlayTimeHours]
    and a
    jr z, .justMinutes
    ld b, a
    ld c, 60
    ld a, [wPlayTimeMinutes]
.adding
    add c
    jr c, .overflowed
    dec b
    jr nz, .adding
    jr .done
.justMinutes
    ld a, [wPlayTimeMinutes]
    jr .done
.overflowed
    ld a, $ff
.done
    ld e, 0
    ld [wPasswordBuffer], a
    ld hl, wOpponentsEncountered
    ld a, [hli]
    and $fe
    cp $fe
    jr nz, .noAllOpponents
    ld a, [hli]
    cp $ff
    jr nz, .noAllOpponents
    ld a, [hli]
    and $1f
    cp $1f
    jr nz, .noAllOpponents
    set 0, e
.noAllOpponents
    ld a, [wPlayerMaxHP]
    cp 100
    jr c, .noLevel
    set 1, e
.noLevel
    ld hl, wLoreEventFlags
    bit 7, [hl]
    jr z, .noEmpoweredBoss
    set 2, e
.noEmpoweredBoss
    res 3, e
    ld a, e
    ld [wPasswordBuffer+1], a
    ld a, [wSummoningSaltCounter]
    ld [wPasswordBuffer+2], a
    call Random
    ld [wPasswordBuffer+3], a
    call EncodeAndChecksumPassword
    ; NotLikeThis
    ret

PlayUnusedTheme:
    ; Play the R/B/Y unused trade theme.
    ld a, MUSIC_VERMILION
    ld c, AUDIO_1
    call PlayMusic
    xor a
    ld hl, $c006
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], $13
    inc hl
    ld [hl], $69
    inc hl
    ld [hli], a
    ld [hl], a
    ret

PasswordScreenTilemap:
    db $7f,$7f,$82,$8e,$8d,$86,$91,$80,$93,$94,$91,$80,$93,$88,$8e,$8d,$4f,$4f
    db $7f,$7f,$7f,$7f,$93,$87,$88,$92,$7f,$92,$93,$8e,$91,$98,$4f
    db $7f,$7f,$7f,$88,$92,$7f,$87,$80,$8f,$8f,$98,$7f,$84,$8d,$83,$4f,$4f
    db $7f,$7f,$7f,$7f,$93,$87,$80,$8d,$8a,$7f,$98,$8e,$94,$e7,$4f,$4f,$4f
    db $84,$ad,$b3,$a4,$b1,$7f,$b3,$a7,$a4,$7f,$af,$a0,$b2,$b2,$b6,$ae,$b1,$a3,$4f
    db $a0,$b3,$7f,$b3,$a7,$a4,$7f,$a4,$b5,$a4,$ad,$b3,$7f,$b2,$a8,$b3,$a4,$4f
    db $b3,$ae,$7f,$a7,$a0,$b5,$a4,$7f,$b8,$ae,$b4,$b1,$7f,$b2,$a2,$ae,$b1,$a4,$4f
    db $b2,$a0,$b5,$a4,$a3,$7f,$ae,$ad,$ab,$a8,$ad,$a4,$e8,$50
