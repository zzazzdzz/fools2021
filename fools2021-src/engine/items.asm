; *** items.asm
; Item use handlers.

Inventory_UseItem:
    ; Uses the item with identifier A.
    ldh [hCurrentItem], a
    ld a, [wInventoryPage]
    add a
    add a
    ld c, a
    ld a, [wInventoryChoice]
    add c
    ld [wWhichPokemon], a
    ldh a, [hCurrentItem]
    ld c, a
    call LoadItemName
    ld hl, UseItemJumptable - 2 ; hacky, but why not
    ldh a, [hCurrentItem]
    add a
    ld c, a
    ld b, 0
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    xor a
    ld [wItemQuantity], a
    ld a, [wWhichPokemon]
    push af
    call _hl_
    pop af
    ld [wWhichPokemon], a
    ld hl, wInventoryNumItems
    call RemoveItemFromInventory
    call FixInventory
    ; NotLikeThis
    ret

UseItemJumptable:
    dw UseHPRestoreItem
    dw UseHPRestoreItem
    dw UseHPRestoreItem
    dw CannotUseItem
    dw UseHPIncreaseItem
    dw UseHPIncreaseItem
    dw UseSkipSandwich
    dw UseSummoningSalt
    dw UseTelltaleOrb
    dw CannotUseItem
    dw CannotUseItem
    dw UseDaredevilPotion
    dw UseBraveryPotion
    dw UseCrystal
    dw UseCrystal
    dw UseCrystal
    dw UseSharpObject
    dw UseSharpObject

UseHPRestoreItem:
    ; Use one of the generic HP restoration potions.
    ld hl, GenericUsedText
    call PrintTextVWF
    ld a, SFX_HEAL_AILMENT
    call PlaySound
    ld c, 60
    call DelayFrames
    ldh a, [hCurrentItem]
    dec a
    jr z, .heal20
    dec a
    jr z, .heal50
.heal200:
    ld d, 200
.heal
    ld a, [wPlayerMaxHP]
    ld c, a
    ld a, [wPlayerCurHP]
    ld b, a
    cp c
    jr z, .noHeal
    ld a, b
    add d
    jr nc, .noOverflow
    ld a, $ff
.noOverflow
    cp c
    jr c, .noOverflow2
    ld a, c
.noOverflow2
    ld [wPlayerCurHP], a
    sub b
    ld [wDamageDealt], a
    ld hl, HPRestoredText
    call PrintTextVWF
    ld a, 1
    ld [wItemQuantity], a
    ret
.heal20
    ld d, 20
    jr .heal
.heal50
    ld d, 50
    jr .heal
.noHeal
    ld hl, IneffectiveText
    jp PrintTextVWF

UseHPIncreaseItem:
    ; Use one of the permanent HP increase items.
    ld hl, GenericUsedText
    call PrintTextVWF
    ld a, SFX_HEAL_AILMENT
    call PlaySound
    ld c, 60
    call DelayFrames
    ldh a, [hCurrentItem]
    cp LIFE_SEED
    ld b, 3
    jr z, .add3
    ld b, 1
.add3
    ld a, [wPlayerMaxHP]
    cp $ff
    jr z, .cannotIncrease
    add b
    jr nc, .noOverflow
    ld a, 255
.noOverflow
    ld [wPlayerMaxHP], a
    ld a, [wPlayerCurHP]
    add b
    jr nc, .noOverflow2
    ld a, 255
.noOverflow2
    ld [wPlayerCurHP], a
    ld a, b
    ld [wDamageDealt], a
    ld hl, HealthIncreasedText
    call PrintTextVWF
    ld a, 1
    ld [wItemQuantity], a
    ret
.cannotIncrease
    ld hl, IneffectiveText
    jp PrintTextVWF

CannotUseItem:
    ; Item cannot be used.
    ld a, [wCurrentBiome]
    swap a
    and $0f
    ; If the current biome is Corruption, show a special message.
    cp 3
    ld hl, CannotUseText
    jr nz, .notCorrupted
    ld hl, CannotUseTextCorruption
.notCorrupted
    call PrintTextVWF
    ret

UseSkipSandwich:
    ; Use Skip Sandwich.
    ld a, 200
    ld [wSkipSandwichCounter], a
    ld a, 1
    ld [wWalkBikeSurfState], a
    ld [wItemQuantity], a
    ld a, SFX_HEAL_AILMENT
    call PlaySound
    ld hl, SkipSandwichText
    jp PrintTextVWF

UseSummoningSalt:
    ; Use Summoning Salt.
    ld a, 5
    ld [wAudioFadeOutCounterReloadValue], a
    ld a, $ff
    ld [wAudioFadeOutControl], a
    ld [wCurrentMapMusic], a
    ld hl, SummoningItemText
    call PrintTextVWF
    ld hl, .summonMenu
    call DisplayMenu
    cp $01
    jp nz, .leave
    ld a, [wCurrentBiome]
    swap a
    and $0f
    ld b, a
    ld a, [wSummoningSaltCounter]
    and a
    jr z, .firstSummon
    dec a
    jr z, .secondSummon
    dec a
    jr z, .thirdSummon
    dec a
    jp z, .fourthSummon
    dec a
    jp z, .finalSummon
    jp .summonFailed
.firstSummon
    ld a, b
    and a
    jp nz, .summonFailed
    ld a, 4
    ld [wShowLoreText], a
    ld b, E_SCYTHER
    ld c, 12
.standardSummonProc
    ld a, 1
    ld [wItemQuantity], a
    ld [wQuitStartCompletely], a
    ld hl, wCurrentOpponentSpecies
    ld [hl], b
    inc hl
    ld [hl], c
    inc hl
    ld [hl], 1
    ld hl, SummoningItemUsedText
    call PrintTextVWF
    ret
.thirdSummon
    ld a, b
    cp 2
    jp nz, .summonFailed
    ld b, SHYHORN
    call CheckItemInBag
    ld a, [hl]
    cp 2
    jp c, .summonFailed
    ld b, GLITCH_SHARD
    call CheckItemInBag
    ld a, [hl]
    cp 2
    jp c, .summonFailed
    ld a, 6
    ld [wShowLoreText], a
    ld bc, GLITCH_SHARD*256 + 2
    call RemoveItemByIndex
    ld bc, SHYHORN*256 + 2
    call RemoveItemByIndex
    ld b, E_FOX
    ld c, 25
    jr .standardSummonProc
.secondSummon
    ld a, b
    cp 3
    jr nz, .summonFailed
    ld b, GLITCH_SHARD
    call CheckItemInBag
    ld a, [hl]
    cp 3
    jr c, .summonFailed
    ld a, 5
    ld [wShowLoreText], a
    ld bc, GLITCH_SHARD*256 + 3
    call RemoveItemByIndex
    ld b, E_WOLF
    ld c, 18
    jr .standardSummonProc
.fourthSummon
    ld a, b
    cp 1
    jr nz, .summonFailed
    ld b, GLITCH_SHARD
    call CheckItemInBag
    ld a, [hl]
    and a
    jr z, .summonFailed
    ld hl, wTileMapBackup
    ld e, 0
    ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.countTiles
    ld a, [hli]
    cp $3d
    call z, .incE
    cp $56
    call z, .incE
    dec bc
    ld a, c
    or b
    jr nz, .countTiles
    ld a, e
    cp 2
    jr c, .summonFailed
    ld bc, GLITCH_SHARD*256 + 1
    call RemoveItemByIndex
    ld a, 7
    ld [wShowLoreText], a
    ld b, E_NOE
    ld c, 35
    jp .standardSummonProc
.finalSummon
    ld a, b
    and a
    jp nz, .summonFailed
    ld a, 8
    ld [wShowLoreText], a
    ld b, E_MEWTWO
    ld c, 40
    jp .standardSummonProc
.summonFailed
    ld a, [wSummoningSaltCounter]
    and a
    ld hl, SummoningItemFailedText
    jr nz, .notFirstSummon
    ld hl, SummoningItemFirstFailedText
.notFirstSummon
    call PrintTextVWF
.leave
    call CheckForBiomeChange
    ret
.incE
    inc e
    ret
.summonMenu
    db 11, 2 ; w, h
    db 2
    db %10100001 ; [disable screen save][draw textbox][B allowed][R allowed][L allowed][item size][item size][item size]
    db $8f,$b4,$b3,$7f,$a8,$b3,$7f,$a3,$ae,$b6,$ad,$4f
    db $8a,$a4,$a4,$af,$7f,$a6,$ae,$a8,$ad,$a6,$50

UseTelltaleOrb:
    ; Use Telltale Orb.
    ld hl, GenericUsedText
    call PrintTextVWF
    ld a, SFX_TELEPORT_EXIT_1
    call PlaySound
    ld c, 80
    call DelayFrames
    ; In corruption, 1/256 chance for a special something
    ld a, [wCurrentBiome]
    swap a
    and $0f
    cp 3
    jr nz, .cont
    call Random
    cp $69
    jr z, .scare
.cont
    ; Which hint to tell?
    ld a, [wSummoningSaltCounter]
    dec a
    jr z, .hintsForSecondBoss
    dec a
    jr z, .hintsForThirdBoss
    dec a
    jr z, .hintsForFourthBoss
    dec a
    jr z, .hintsForFinalBoss
    ; If there's nothing to tell, channel a Delirian.
    ld hl, HintTextEasterEgg
    call PrintTextVWF
    ; NotLikeThis
    ret
.hintsForSecondBoss
    ld b, GLITCH_SHARD
    call CheckItemInBag
    ld hl, HintText1
    jr nz, .secondBossNoShards
    ld hl, HintText2
.secondBossNoShards
    jp PrintTextVWF
.hintsForThirdBoss
    ld b, SHYHORN
    call CheckItemInBag
    ld hl, HintText3
    jr nz, .secondBossNoShards ; PrintTextVWF
    ld hl, HintText4
    jr .secondBossNoShards ; PrintTextVWF
.hintsForFourthBoss
    ld b, GLITCH_SHARD
    call CheckItemInBag
    ld hl, HintText5
    jr nz, .secondBossNoShards ; PrintTextVWF
    ld hl, HintText6
    jr .secondBossNoShards ; PrintTextVWF
.hintsForFinalBoss
    ld hl, HintText7
    jr .secondBossNoShards ; PrintTextVWF
.scare
    ; Special something
    ld a, $33
    ld [wAudioFadeOutControl], a
    ld hl, HintTextScare
    call PrintTextVWF
    di
    ld c, AUDIO_2
    ld a, MUSIC_GYM_LEADER_BATTLE
    call PlayMusic
    ld de, $c006
    ld hl, .glitchyCommandPtrs
    ld bc, 16
    call CopyData
    ei 
    ld hl, HintTextScare2
    call PrintTextVWF
    xor a
    ld [wLowHealthAlarmDisabled], a
    ld a, $80
    ld [wLowHealthAlarm], a
    ldh a, [$d7]
    ld [wSavedTilesetType], a
    xor a
    ldh [$d7], a
    ld hl, $8800
    ld bc, $1400
    ld de, $1234
.xorVRAMWithGarbage
    ldh a, [rSTAT]
    and %00000011
    jr nz, .xorVRAMWithGarbage ; wait for hBlank
    ld a, [de]
    xor [hl]
    ld [hli], a
    inc de
    dec bc
    call .delayLoop
    ld a, c
    or b
    jr nz, .xorVRAMWithGarbage
    call EndLowHealthAlarm
    ld c, 100
    call DelayFrames
    call ReturnFromBattleToOverworld
    ld a, 1
    ld [wQuitStartCompletely], a
    ret
.delayLoop
    push bc
    ld bc, 200
.decBc
    dec bc
    ld a, c
    or b
    jr nz, .decBc
    pop bc
    ret
.glitchyCommandPtrs
    dw $1ce0
    dw $2c5e
    dw $1109
    dw $2e5c
    dw $1105
    dw $095c
    dw $3dde
    dw $2fc0

UseCrystal:
    ; Use a crystal.
    ld hl, .crystalTexts
    ldh a, [hCurrentItem]
    sub DARK_CRYSTAL
    add a
    ld c, a
    ld b, 0
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    jp PrintTextVWF
.crystalTexts
    dw LoreCrystal1Text
    dw LoreCrystal2Text
    dw LoreCrystal3Text

UseDaredevilPotion:
    ; Use Daredevil Potion.
    ld hl, GenericUsedText
    call PrintTextVWF
    ld a, SFX_HEAL_AILMENT
    call PlaySound
    ld c, 60
    call DelayFrames
    ld a, [wNextOpponentEmpowerment]
    cp 5 * 4
    jr z, .stahp
    add 5
    ld [wNextOpponentEmpowerment], a
    ld a, 1
    ld [wItemQuantity], a
    ld hl, LocalBuffText
    jp PrintTextVWF
.stahp
    ld hl, IneffectiveText
    jp PrintTextVWF

UseBraveryPotion:
    ; Use Bravery Potion.
    ld hl, GenericUsedText
    call PrintTextVWF
    ld a, SFX_HEAL_AILMENT
    call PlaySound
    ld c, 60
    call DelayFrames
    ld a, [wAllOpponentsEmpowerment]
    cp 2 * 10
    jr z, .stahp
    add 2
    ld [wAllOpponentsEmpowerment], a
    ld a, 1
    ld [wItemQuantity], a
    ld hl, GlobalBuffText
    jp PrintTextVWF
.stahp
    ld hl, IneffectiveText
    jp PrintTextVWF

UseSharpObject:
    ; Use Sharp Beak or Sharp Horn.
    ld hl, GenericUsedText
    call PrintTextVWF
    ld a, SFX_HEAL_AILMENT
    call PlaySound
    ld c, 60
    call DelayFrames
    ld a, [wAttackEmpowerment]
    cp 3 * 10
    jr z, .stahp
    add 3
    ld [wAttackEmpowerment], a
    ld a, 1
    ld [wItemQuantity], a
    ld hl, AttackBuffText
    jp PrintTextVWF
.stahp
    ld hl, IneffectiveText
    jp PrintTextVWF