; *** ace.asm
; Fourth hacking challenge.

ForceRGBDSToExportThisSymbol:
    ; Make sure RGBDS exports the YouWin symbol, so it can be found in the
    ; object and SYM files.
    dw YouWin

MakeSlidesImpossible:
    ; An evil "feature" to make sliding to the target function impossible.
    db $ff, $ff, $ff

PlaceholderForV101:
    ; Extra padding, to make sure the address of YouWin is identical in
    ; versions 1.0.0 and 1.0.1 of the save file.
    text "bepis"
    done
    db $ff, $ff, $ff

YouWin:
    ; Target function for the ACE challenge.
    call TextboxEnable
    call ClearScreen
    call UpdateSprites
    coord hl, 1, 8
    ld de, CongratulationsYouGotACE
    call PlaceStringSimple
.forever
    jr .forever

CongratulationsYouGotACE:
    ; "Congratulations! You got ACE!"
    db $7f,$82,$ae,$ad,$a6,$b1,$a0,$b3,$b4,$ab,$a0,$b3,$a8,$ae,$ad,$b2,$e7,$4f
    db $7f,$7f,$7f,$98,$ae,$b4,$7f,$a6,$ae,$b3,$7f,$80,$82,$84,$e7,$50
