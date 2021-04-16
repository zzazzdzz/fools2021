; *** battle.asm
; The battle system.

FillScreenWithTile:
    ; Fill wTileMap with tile A.
    ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
    ld hl, wTileMap
    jp FillMemory

BeginEncounter:
    ; Begin an encounter.
    call SaveScreenTilesToBuffer2
    call SpriteClearAnimCounters
    ; Flag opponent as encountered
    ld a, [wCurrentOpponentSpecies]
    ld c, a
    ld b, 1
    ld hl, wOpponentsEncountered
    predef FlagActionPredef
    xor a
    ld [wLowHealthAlarmDisabled], a
    ld c, AUDIO_2
    ; Determine the battle music
    ld a, [wCurrentOpponentBoss]
    and a
    ld a, MUSIC_WILD_BATTLE
    jr z, .wild
    ld a, [wCurrentOpponentSpecies]
    cp E_MEWTWO
    ld a, MUSIC_FINAL_BATTLE
    jr z, .wild
    ld a, MUSIC_GYM_LEADER_BATTLE
.wild
    call PlayMusic
    ; Play battle transition
    call TextboxEnable
    farcall LoadBattleTransitionTile
    farcall BattleTransition_DoubleCircle
    ldh a, [$d7]
    ld [wSavedTilesetType], a
    xor a
    ldh [$d7], a
    call UpdateSprites
    call BlackOutPals
    call TextboxEnable
    ; Load current opponent to wCurrentOpponent
    ld hl, OpponentsTable
    ld bc, OPPONENTS_TABLE_SIZE
    ld a, [wCurrentOpponentSpecies]
    dec a
    call AddNTimes
    ld de, wCurrentOpponent
    ld bc, OPPONENTS_TABLE_SIZE
    ld a, 3
    call CopyDataFromSRAX
    ld a, [wCurrentOpponentIGSpecies]
    call LoadMonSprite
    ld a, $7f
    call FillScreenWithTile
    xor a
    ldh [$e1], a
    coord hl, $0c, 0
    ld a, 1
    call Predef
    call Delay3
    call DisableLCD
    farcall LoadHudAndHpBarAndStatusTilePatterns
    ld hl, $9800
    ld bc, $400
    ld a, $7f
    call FillMemory
    ld a, $70
    ldh [rWX], a
    call EnableLCD
    ld b, 1
    call RunPaletteCommand
    call DelayFrame
    call LoadGBPal
    ld a, 7 + $50
.scrollAnimate
    sub 4
    ldh [rWX], a
    ld b, a
    call DelayFrame
    ld a, b
    cp $07
    jr nz, .scrollAnimate
    ld a, [wCurrentOpponentIGSpecies]
    call PlayCry
    xor a
    ldh [hWhoseTurn], a
    call LoadCurrentTurnNameIntoBuffer
    ld hl, wCurrentOpponentIntroTextPtr
    ld a, [hli]
    ld h, [hl]
    ld l, a
    call PrintTextVWF
    ld a, $54
    ld [wBattleMonSpecies], a
    ld [wBattleMonSpecies2], a
    ld [wd0b5], a
    call GetMonHeader
    ld a, $0f
    call BankswitchHome
    safe_call $4ca7
    call CopyPlayerAndOpponentNames
.drawHuds
    ld a, $54
    ld [wBattleMonSpecies], a
    ld a, [wPlayerCurLevel]
    ld [wBattleMonLevel], a
    ld a, [wPlayerCurHP]
    ld [wBattleMonHP+1], a
    ld a, [wPlayerMaxHP]
    ld [wBattleMonMaxHP+1], a
    ld a, [wCurrentOpponentIGSpecies]
    ld [wEnemyMonSpecies], a
    ld a, [wCurrentOpponentLevel]
    ld [wEnemyMonLevel], a
    ld c, a
    ld b, 0
    ld hl, 0
    ld a, [wCurrentOpponentBaseHP]
    call AddNTimes
    srl h
    rr l
    ld a, h
    and a
    jr z, .noOverflow
    ld l, $ff
.noOverflow
    ld a, l
    ld [wEnemyMonHP+1], a
    ld [wEnemyMonMaxHP+1], a
    call DrawPlayerHUDAndHPBar
    call DrawEnemyHUDAndHPBar
    xor a
    ldh [hWhoseTurn], a
    ld a, [wCurrentOpponentLevel]
    ld b, a
    ld a, [wPlayerCurLevel]
    cp b
    jr c, .opponentMovesFirst
.playerMovesFirst
    ld a, 1
    ldh [hWhoseTurn], a
.opponentMovesFirst
    call LoadCurrentTurnNameIntoBuffer
    ld hl, FirstMoveText
    call PrintTextVWF
.battleLoop
    xor a
    ld [wFrequencyModifier], a
    ld [wTempoModifier], a
    call LoadCurrentTurnNameIntoBuffer
    ld hl, AttacksText
    call PrintTextVWF
    ld a, SFX_DAMAGE
    call PlaySound
    call BlinkAttackedMon
    call CalcDamage
    call ApplyDamage
    call LoadCurrentTurnNameIntoBufferReverse
    ld hl, DamageText
    call PrintTextVWF
    ld a, [wEnemyMonHP+1]
    and a
    jr z, .enemyFainted
    ld a, [wBattleMonHP+1]
    and a
    jp z, .playerFainted
    ldh a, [hWhoseTurn]
    and a
    ld a, 1
    jr z, .flipTurns
    xor a
.flipTurns
    ldh [hWhoseTurn], a
    jr .battleLoop
.enemyFainted
    call EndLowHealthAlarm
    call PlayFaintSFX
    coord hl, 12, 5
    coord de, 12, 6
    call SlideDownFaintedMonPic
    coord hl, 0, 0
    lb bc, 5, 11
    call ClearScreenArea
    call LoadCurrentTurnNameIntoBufferReverse
    ld c, AUDIO_2
    ld a, [wCurrentOpponentBoss]
    and a
    ld a, MUSIC_DEFEATED_WILD_MON
    jr z, .wild2
    ld a, MUSIC_DEFEATED_GYM_LEADER
.wild2
    call PlayMusic
    ld a, [wCurrentOpponentBoss]
    and a
    jr z, .noSummoningSaltInc
    ld a, [wSummoningSaltCounter]
    inc a
    ld [wSummoningSaltCounter], a
.noSummoningSaltInc
    ld hl, EnemyFaintedText
    call PrintTextVWF
    ; Calculate level up
    ; Bug: if gaining exp on level 100, the "reached level 100"
    ; message will show every time, even though the level hasn't
    ; changed :)
    ld a, [wCurrentOpponentExpYield]
    ld c, a
    ld b, 0
    ld a, [wCurrentOpponentLevel]
    ld hl, 0
    call AddNTimes
    ; Bug: calculation of exp points can overflow, since none of
    ; the opponents were supposed to reach levels higher than 100.
    ; But because of a different bug, this is possible :)
    srl h
    rr l
    srl h
    rr l
    srl h
    rr l
    ld a, l
    ld [wDamageDealt], a
    ld hl, GainedExpText
    call PrintTextVWF
    ld a, [wDamageDealt]
    ld b, a
    ld a, [wPlayerCurExpLeft]
    cp $ff
    jr z, .noLevelUp
    ld c, a
    ld d, 0
.levelUpLoop
    ld a, [wPlayerCurLevel]
    cp 100 ; Cap level at 100
    jr z, .updateLevels
    ld a, c
    cp b
    jr z, .levelUpExact
    jr nc, .levelUpNoOverflow
.levelUpExact
    ld a, b
    sub c
    ld b, a
    push bc
    inc d ; Gain a level
    ld a, [wPlayerCurLevel]
    inc a
    ld [wPlayerCurLevel], a
    ld c, a
    ld b, 3
    and 1
    jr z, .even
    ld b, 2
.even
    ld a, [wPlayerMaxHP]
    add b
    jr nc, .hpNoOverflow1
    ld a, $ff
.hpNoOverflow1
    ld [wPlayerMaxHP], a
    ld a, [wPlayerCurHP]
    add b
    jr nc, .hpNoOverflow2
    ld a, $ff
.hpNoOverflow2
    ld [wPlayerCurHP], a
    ld b, 0
    ld hl, LevelUpExp
    add hl, bc
    call ReadFromSRA3
    pop bc
    ld c, a
    jr .levelUpLoop
.levelUpNoOverflow
    sub b
    ld c, a
    ld [wPlayerCurExpLeft], a
    ld a, d
    and a
    jr z, .noLevelUp
.updateLevels
    ld a, [wPlayerCurLevel]
    ld [wBattleMonLevel], a
    ld [wDamageDealt], a
    ld a, [wPlayerCurHP]
    ld [wBattleMonHP+1], a
    ld a, [wPlayerMaxHP]
    ld [wBattleMonMaxHP+1], a
    call DrawPlayerHUDAndHPBar
    ld hl, PlayerLevelUpText
    call PrintTextVWF
    ld a, SFX_LEVEL_UP
    call PlaySound
    ld c, 160
    call DelayFrames
.noLevelUp
    ld a, [wCurrentOpponentDropChance]
    cp $ff
    jr nz, .not100
    call GotAnItem
    jr .clearAndReturn
.not100
    ld b, a
    call Random
    sub b
    call c, GotAnItem
.clearAndReturn
    xor a
    ld [wCurrentOpponentSpecies], a
    jp ReturnFromBattleToOverworld
.playerFainted
    ; Try to revive the fainted player
    call PlayFaintSFX
    call RemoveFaintedPlayerMon
    ld hl, PlayerFaintedText
    call PrintTextVWF
    ld b, REVIVER_SEED
    call CheckItemInBag
    jr nz, .blackedOut
    ld hl, wInventoryNumItems
    ld a, c
    ld [wWhichPokemon], a
    ld a, 1
    ld [wItemQuantity], a
    call RemoveItemFromInventory
    ld a, [wPlayerMaxHP]
    ld [wBattleMonHP+1], a
    ld [wPlayerCurHP], a
    ld a, $df
    call PlaySound
    call DrawPlayerHUDAndHPBar
    farcall AnimationShowMonPic
    ld hl, RevivedText
    call PrintTextVWF
    ld a, 1
    ldh [hWhoseTurn], a
    jp .battleLoop
.blackedOut
    ; No reviver seeds in inventory. The player lost
    ld a, 5
    ld [wAudioFadeOutCounterReloadValue], a
    ld a, $ff
    ld [wAudioFadeOutControl], a
    ld hl, PlayerLostText
    call PrintTextVWF
    ld c, 100
    call DelayFrames
    ld a, 1
    ld [wTextBoxID], a
    call DisplayTextBoxID
    call Delay3
    jp GenerateAndShowPassword
GotAnItem:
    ; Opponent dropped an item
    ld a, [wCurrentOpponentDropItem]
    ld c, a
    ld [wcf91], a
    call LoadItemName
    ld a, 1
    ld [wItemQuantity], a
    ld hl, wInventoryNumItems
    call AddItemToInventory
    ld hl, ItemDroppedText
    jp PrintTextVWF

ReturnFromBattleToOverworld:
    ; End the battle and return back to the overworld.
    xor a
    ld [wCurrentMapMusic], a
    ld [wCurrentOpponentBoss], a
    ld a, 5
    ld [wAudioFadeOutCounterReloadValue], a
    ld a, $ff
    ld [wAudioFadeOutControl], a
    ld hl, wd72c
    res 1, [hl]
    ld a, [wSavedTilesetType]
    ldh [$d7], a
    xor a
    call WriteAToPals
    ld [wFontLoaded], a
    ld [wIsInBattle], a
    call DisableLCD
    ; LCD disabled now
    ld a, $98
	ld [wMapViewVRAMPointer + 1],a
	xor a
	ld [wMapViewVRAMPointer], a
    ldh [$af], a
    ldh [$ae], a
    ldh [$42], a
    ldh [$43], a
    call LoadMapViewAndCopyToVRAM
    call LoadTilesetTilePatternData
    call LoadPokeBallGfx
    farcall InitMapSprites
    call EnableLCD
    call LoadWalkingPlayerSpriteGraphics
    call UpdateSprites
	ld b, 9
	call RunPaletteCommand
    call DelayFrame
    call LoadGBPal
    call GBFadeInFromWhite
    ld c, AUDIO_1
    ld a, $ff
    call PlayMusic
    call CheckForBiomeChange
    ld a, 1
    ld [wAudioFadeOutCounterReloadValue], a
    jp ReturnFromTextboxToOverworld

LoadMapViewAndCopyToVRAM:
    ; Load the current map view and copy it to VRAM immediately.
    call LoadCurrentMapView
    coord hl, 0, 0
    ld de, $9800
    ld b, 18
.vramCopyLoop
    ld c, 20
.vramCopyInnerLoop
    ld a, [hli]
    ld [de], a
    inc e
    dec c
    jr nz, .vramCopyInnerLoop
    ld a, 32 - 20
    add e
    ld e, a
    jr nc, .noCarry
    inc d
.noCarry
    dec b
    jr nz, .vramCopyLoop
    ret

BlinkAttackedMon:
    ; Blinking animation for attacks.
    ld c, 4
.loop
    push bc
    farcall AnimationHideMonPic
    ld c, 3
    call DelayFrames
    farcall AnimationShowMonPic
    ld c, 3
    call DelayFrames
    pop bc
    dec c
    jr nz, .loop
    ret

LoadMonSprite:
    ; Load sprite for use in battle.
    ld [wBattleMonSpecies2], a
    ld [wEnemyMonSpecies2], a
    ld [wcf91], a
    ld [wd0b5], a
    ; Check if it's any of the 'glitches'
    cp $7f
    jr z, .glitch1
    cp $7a
    jr z, .glitch2
    cp $5f
    jr z, .glitch3
    ; Otherwise, just load a real sprite
    call GetMonHeader
    ld de, $9000
    safe_call LoadMonFrontSprite
    ret
.glitch1
    call DisableLCD
    ld hl, $9000
    ld bc, $180
    xor a
    call FillMemory
    ld de, $9180
    ld bc, $9310 - $9180
    ld hl, $1234
    call CopyData
    jp EnableLCD
.glitch2
    call DisableLCD
    ld hl, $9000
    ld bc, $310
    xor a
    call FillMemory
    ld de, $90a0
    ld bc, $0040
    push bc
    push bc
    push bc
    ld hl, $2345
    call CopyData
    pop bc
    ld de, $9110
    call CopyData
    pop bc
    ld de, $9180
    call CopyData
    pop bc
    ld de, $91f0
    call CopyData
    jp EnableLCD
.glitch3
    call DisableLCD
    ld de, $9000
    ld hl, $1cf5
    ld bc, $0310
    call CopyData
    jp EnableLCD

PlayFaintSFX:
    ; Play the faint sound effect.
    xor a
    ld [wFrequencyModifier], a
    ld [wTempoModifier], a
    ld a, SFX_FAINT_FALL
    call PlaySoundWaitForCurrent
.sfxwait
    ld a, [wChannelSoundIDs + 4]
    cp SFX_FAINT_FALL
    jr z, .sfxwait
    ld a, SFX_FAINT_THUD
    jp PlaySound

LoadOpponentName_:
    ; Load the opponent's name into the text buffer.
    ld a, [wCurrentOpponentNamePtr]
    ld [wTextBufPtr], a
    ld a, [wCurrentOpponentNamePtr + 1]
    ld [wTextBufPtr + 1], a
    ret

LoadPlayerName_:
    ; Load the player's name into the text buffer.
    ld a, PlayerMonName % 256
    ld [wTextBufPtr], a
    ld a, PlayerMonName / 256
    ld [wTextBufPtr + 1], a
    ret

LoadCurrentTurnNameIntoBuffer:
    ; Load the name of whoever has their turn in battle.
    ldh a, [hWhoseTurn]
    and a
    jr z, LoadOpponentName_
    jr LoadPlayerName_

LoadCurrentTurnNameIntoBufferReverse:
    ; Load the name of whoever hasn't their turn in battle.
    ldh a, [hWhoseTurn]
    and a
    jr z, LoadPlayerName_
    jr LoadOpponentName_

CalcDamage:
    ; Calculate attack damage, result in [wDamageDealt]
    ld a, [wPlayerCurLevel]
    ld b, a
    ; Player's base damage is 6
    ld c, 6
    ldh a, [hWhoseTurn]
    and a
    jr nz, .playerToEnemy
    ld a, [wCurrentOpponentBaseDamage]
    ld c, a
    ld a, [wCurrentOpponentLevel]
    ld b, a
.playerToEnemy
    ld h, 0
    ld l, a
    ld a, b
    ld b, 0
    call AddNTimes
    srl h
    rr l
    srl h
    rr l
    call Random
    and $03
    ld b, 0
    ld c, a
    add hl, bc
    dec hl
    dec hl
    ldh a, [hWhoseTurn]
    and a
    jr z, .skipDamageBonuses
    ld a, [wAttackEmpowerment]
    ld c, a
    ld b, 0
    add hl, bc
.skipDamageBonuses
    ld a, h
    and a
    jr z, .noOverflow
    ld l, $ff
.noOverflow
    ld a, l
    ld [wDamageDealt], a
    ret

ApplyDamage:
    ; Apply the damage value in A, subtracting it from opponent's HP and
    ; updating the health bars.
    ld l, a
    ldh a, [hWhoseTurn]
    and a
    jr nz, .applyToEnemy
.applyToPlayer
    ld a, [wBattleMonHP+1]
    sub l
    jr nc, .noOverflow1
    xor a
.noOverflow1
    ld [wBattleMonHP+1], a
    ld [wPlayerCurHP], a
    jp DrawPlayerHUDAndHPBar
    ret
.applyToEnemy
    ld a, [wEnemyMonHP+1]
    sub l
    jr nc, .noOverflow2
    xor a
.noOverflow2
    ld [wEnemyMonHP+1], a
    jp DrawEnemyHUDAndHPBar
    ret

CopyPlayerAndOpponentNames:
    ; Copy appropriate names to wEnemyMonNick and wBattleMonNick.
    ld hl, wCurrentOpponentNamePtr
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, wEnemyMonNick
    ld bc, 11
    ld a, 3
    call CopyDataFromSRAX
    ld hl, wEnemyMonNick
.convertCharsets
    ld a, [hl]
    and a
    jr z, .finished
    cp "4"
    jr z, .four
    cp "?"
    jr z, .question
    cp $1b
    ld b, $a0 - $1b
    jr nc, .small
    ld b, $80 - 1
.small
    add b
    ld [hli], a
    jr .convertCharsets
.four
    ld [hl], $fa
    inc hl
    jr .convertCharsets
.question
    ld [hl], $e6
    inc hl
    jr .convertCharsets
.finished
    ld [hl], $50
    ld de, wBattleMonNick
    ld hl, .fixedPlayerMonName
    ld bc, 11
    jp CopyData
.fixedPlayerMonName
    db $8f,$a8,$aa,$a0,$a2,$a7,$b4,$50