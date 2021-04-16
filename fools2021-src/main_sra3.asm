SECTION "SRA3PARENT", ROMX[$6000], BANK[1]
LOAD "SRA3", SRAM[$A000], BANK[3]

_SRA3Checksum:
    ds 1

_SRA3Ident:
    db 3

CharacterSet:
include "include/charset.asm"

LevelUpExp:
    db 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 7, 7, 8, 8, 10, 11, 12, 13, 14, 16, 16, 18, 20, 21, 22, 24, 26, 27, 29, 31, 32, 34, 37, 38, 40, 42, 44, 47, 49, 51, 53, 56, 58, 60, 63, 66, 68, 71, 74, 77, 79, 82, 85, 88, 92, 94, 97, 101, 104, 107, 110, 114, 117, 121, 125, 128, 131, 136, 139, 143, 147, 150, 155, 159, 162, 167, 171, 176, 179, 184, 188, 193, 197, 202, 206, 211, 216, 220, 225, 230, 235, 240, 244, 250, 254

BiomeEncounterTable:
    ; grasslands
    db E_RATTATA, 4
    db E_RATTATA, 5
    db E_RATTATA, 6
    db E_PIDGEY, 4
    db E_PIDGEY, 5
    db E_METAPOD, 5
    db E_METAPOD, 6
    db E_METAPOD, 4
    ; steppes
    db E_RAPIDASH, 6
    db E_RAPIDASH, 7
    db E_FEAROW, 6
    db E_FEAROW, 7
    db E_TAUROS, 6
    db E_TAUROS, 7
    db E_BULBASAUR, 6
    db E_BULBASAUR, 5
    ; construct
    db E_SHYDON, 6
    db E_SHYDON, 7
    db E_SHYDON, 6
    db E_NIDORINO, 6
    db E_NIDORINO, 7
    db E_MACHOP, 6
    db E_MACHOP, 7
    db E_SNORLAX, 6
    ; corruption
    db E_MISSINGLING, 4
    db E_MISSINGLING, 5
    db E_MISSINGLING, 6
    db E_DRAGONITE, 4
    db E_DRAGONITE, 5
    db E_MAGMAR, 5
    db E_MAGMAR, 4
    db E_TMZ4, 4

BiomeItemTable:
    ; grasslands
    db POTION
    db POTION
    db SKIP_SANDWICH
    db SKIP_SANDWICH
    db SKIP_SANDWICH
    db SUMMONING_SALT
    db SUMMONING_SALT
    db HARDENED_SCALE
    ; steppes
    db SUPER_POTION
    db SUPER_POTION
    db HYPER_POTION
    db SKIP_SANDWICH
    db BRAVERY_POTION
    db REVIVER_SEED
    db REVIVER_SEED
    db LIFE_SEED
    ; construct
    db SUPER_POTION
    db SUPER_POTION
    db SUMMONING_SALT
    db SUMMONING_SALT
    db DAREDEVIL_POTION
    db BRAVERY_POTION
    db REVIVER_SEED
    db REVIVER_SEED
    ; corruption
    db SUMMONING_SALT
    db SUMMONING_SALT
    db GLITCH_SHARD
    db GLITCH_SHARD
    db GLITCH_SHARD
    db GLITCH_SHARD
    db REVIVER_SEED
    db LIFE_SEED

OpponentsTable:
OpponentsTable_Shydon:
    db RHYDON
    dw ShydonEncounterText
    dw Opponent1Name
    db 3 ; exp yield
    db 5 ; base hp
    db 4 ; base dmg
    db 50 percent  ; chance to drop item
    db SHYHORN ; item ID to drop
OpponentsTable_Rattata:
    db RATTATA
    dw StandardEncounterText
    dw Opponent2Name
    db 3 ; exp yield
    db 7 ; base hp
    db 3 ; base dmg
    db 3 percent ; chance to drop item
    db POTION ; item ID to drop
OpponentsTable_Pidgey:
    db PIDGEY
    dw StandardEncounterText
    dw Opponent3Name
    db 4 ; exp yield
    db 9 ; base hp
    db 4 ; base dmg
    db 3 percent ; chance to drop item
    db POTION ; item ID to drop
OpponentsTable_Metapod:
    db METAPOD
    dw HookedEncounterText
    dw Opponent4Name
    db 2 ; exp yield
    db 8 ; base hp
    db 1 ; base dmg
    db 5 percent ; chance to drop item
    db HARDENED_SCALE
OpponentsTable_Missingling:
    db $7f
    dw StandardEncounterText
    dw Opponent5Name
    db 6
    db 10
    db 6
    db 5 percent
    db REVIVER_SEED
OpponentsTable_Scyther:
    db SCYTHER
    dw ScytherEncounterText
    dw Opponent6Name
    db 10
    db 11
    db 4
    db 0 percent
    db NO_ITEM
OpponentsTable_Dragonite:
    db DRAGONITE
    dw HookedEncounterText
    dw Opponent7Name
    db 4 ; exp yield
    db 7 ; base hp
    db 7 ; base dmg
    db 5 percent ; chance to drop item
    db LIFE_SEED
OpponentsTable_Magmar:
    db MAGMAR
    dw MagmarEncounterText
    dw Opponent8Name
    db 5 ; exp yield
    db 5 ; base hp
    db 9 ; base dmg
    db 3 percent ; chance to drop item
    db REVIVER_SEED
OpponentsTable_TMZ4:
    db $7a
    dw TMZ4EncounterText
    dw Opponent9Name
    db 8 ; exp yield
    db 10 ; base hp
    db 2 ; base dmg
    db 90 percent ; chance to drop item
    db GLITCH_SHARD
OpponentsTable_Wolf:
    db $5f
    dw WolfEncounterText
    dw Opponent10Name
    db 14 ; exp yield
    db 10 ; base hp
    db 5 ; base dmg
    db $ff
    db DARK_CRYSTAL
OpponentsTable_Fox:
    db NINETALES
    dw FoxEncounterText
    dw Opponent11Name
    db 16 ; exp yield
    db 10 ; base hp
    db 6 ; base dmg
    db $ff
    db AMBER_CRYSTAL
OpponentsTable_Noe:
    db CHANSEY
    dw NoeEncounterText
    dw Opponent12Name
    db 18 ; exp yield
    db 11 ; base hp
    db 6 ; base dmg
    db $ff
    db FLUFFY_CRYSTAL
OpponentsTable_Mewtwo:
    db MEWTWO
    dw MewtwoEncounterText
    dw Opponent13Name
    db 25 ; exp yield
    db 11 ; base hp
    db 8 ; base dmg
    db 0 percent
    db NO_ITEM
OpponentsTable_Rapidash:
    db RAPIDASH
    dw RapidashEncounterText
    dw Opponent14Name
    db 6 ; exp yield
    db 7 ; base hp
    db 7 ; base dmg
    db 5 percent
    db HYPER_POTION
OpponentsTable_Fearow:
    db FEAROW
    dw StandardEncounterText
    dw Opponent15Name
    db 5 ; exp yield
    db 6 ; base hp
    db 5 ; base dmg
    db 10 percent
    db SHARP_BEAK
OpponentsTable_Tauros:
    db TAUROS
    dw StandardEncounterText
    dw Opponent16Name
    db 6 ; exp yield
    db 5 ; base hp
    db 6 ; base dmg
    db 10 percent
    db SHARP_HORN
OpponentsTable_Bulbasaur:
    db BULBASAUR
    dw BulbasaurEncounterText
    dw Opponent17Name
    db 5 ; exp yield
    db 4 ; base hp
    db 5 ; base dmg
    db 10 percent
    db LIFE_SEED
OpponentsTable_Nidorino:
    db NIDORINO
    dw StandardEncounterText
    dw Opponent18Name
    db 6 ; exp yield
    db 3 ; base hp
    db 7 ; base dmg
    db 4 percent
    db SKIP_SANDWICH
OpponentsTable_Snorlax:
    db SNORLAX
    dw SnorlaxEncounterText
    dw Opponent19Name
    db 7 ; exp yield
    db 8 ; base hp
    db 3 ; base dmg
    db 2 percent
    db REVIVER_SEED
OpponentsTable_Machop:
    db MACHOP
    dw MachopEncounterText
    dw Opponent20Name
    db 6
    db 5 ; base hp
    db 6 ; base dmg
    db 3 percent
    db SUPER_POTION
OpponentsTable_Dbg:
    db PORYGON
    dw StandardEncounterText
    dw PlayerMonName
    db 200
    db 1
    db 1
    db 0
    db NO_ITEM

ItemNameList:
    ;    "-----------------"
    done
    text "POTION"
    done
    text "SUPER POTION"
    done
    text "HYPER POTION"
    done
    text "REVIVER SEED"
    done
    text "LIFE SEED"
    done
    text "HARDENED SCALE"
    done
    text "SKIP SANDWICH"
    done
    text "SUMMONING SALT"
    done
    text "TELLTALE ORB"
    done
    text "GLITCH SHARD"
    done
    text "SHYHORN"
    done
    text "DAREDEVIL POTION"
    done
    text "BRAVERY POTION"
    done
    text "DARK CRYSTAL"
    done
    text "AMBER CRYSTAL"
    done
    text "FLUFFY CRYSTAL"
    done
    text "SHARP BEAK"
    done
    text "SHARP HORN"
    done

InvalidItemName:
    db 100,100,100,100,100,0

InaccurateEmulatorText:
    text "You are using an inaccurate"
    next "or unsupported emulator."
    para "For more information visit:"
    next "zzazzdzz.github.io/emu."
    done

WrongROMText:
    text "You are using a modified or"
    next "invalid ROM image."
    para "This save file is compatible"
    next "with Pokémon Red EN only."
    para "Particularly, Pokémon Blue"
    next "cannot be used with this save."
    para "Consult the event site for"
    next "any further information."
    done

IntroText:
    text "Welcome to Fools2021:"
    next "Road to Infinity!"
    wait
    done

RetireQuestionText:
    text "Once you retire, you will"
    next "receive a completion code."
    para "This means your adventure"
    next "will immediately end."
    para "Are you sure you want to"
    next "retire?"
    done

FirstMoveText:
    text "<B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B> gets the"
    next "chance to strike first!"
    tx_wait 30
    done
    
PlayerFaintedText:
    text "Oh no!"
    next "Your <B>Pikachu</B> fainted!"
    tx_wait 60
    done

EnemyFaintedText:
    text "The enemy <B>"
    tx_buf_indirect 3, wTextBufPtr
    next "</B>fainted!"
    tx_wait 60
    done

AttacksText:
    text "<B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B> attacks!"
    done

DamageText:
    text "<B>"
    tx_buf_indirect 3, wTextBufPtr
    next "</B>took <B>"
    tx_num wDamageDealt
    text "</B> damage!"
    tx_wait 30
    done

GainedExpText:
    text "Your <B>Pikachu</B> gained"
    next "<B>"
    tx_num wDamageDealt
    text "</B> experience points!"
    tx_wait 60
    done

PlayerLevelUpText:
    text "Your <B>Pikachu</B> has reached"
    next "level <B>"
    tx_num wDamageDealt
    text "</B>!"
    done

PlayerLostText:
    text "You're out of usable Pokémon!"
    next "Your adventure is over!"
    done

ItemDroppedText:
    text "The opponent dropped a"
    next "<B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B> in panic!"
    tx_wait 110
    done

ItemFoundText:
    text "You picked up"
    next "a <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>!"
    done

RevivedText:
    text "<B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B> was revived!"
    tx_wait 30
    done

GenericUsedText:
    text "You used the"
    next "<B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>!"
    done

HPRestoredText:
    text "Restored <B>"
    tx_num wDamageDealt
    text " HP</B>"
    next "to <B>Pikachu</B>!"
    wait
    done

CannotUseText:
    text "Oak's words echoed..."
    next "There's a time and place for"
    cont "everything... but not now."
    wait
    done

CannotUseTextCorruption:
    text "DAD's advice..."
    next ""
    db $2b,$4e,$4f,$3e
    db $2b,$4e,$4f,$3e
    db $2b,$4e,$4f,$3e
    db $2b,$4e,$4f,$3e
    db $2b,$4e,$4f,$3e
    db $2b,$4e,$4f
    text "..."
    wait
    done

ItsAFeatureText:
    text "It's a feature!"
    next "Press Start to confirm."
    done

IneffectiveText:
    text "It won't have any effect."
    wait
    done

HealthIncreasedText:
    text "<B>Pikachu</B>'s health increased"
    next "by <B>"
    tx_num wDamageDealt
    text "</B> points!"
    wait
    done

SkipSandwichText:
    text "Ate the <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>!"
    next "Movement speed increased!"
    wait
    done

SummoningItemText:
    text "You slowly pull out the"
    next "<B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>."
    para "As you do it, you feel like"
    next "something bad is going to"
    cont "happen..."
    done

SummoningItemUsedText:
    text "Used the <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>,"
    next "hoping to summon something."
    para "A lost soul seems to have"
    next "answered your call..."
    wait
    done

SummoningItemFailedText:
    text "Used <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>,"
    next "but nothing happened."
    para "Are you in the right biome?"
    next "Do you have an offering? "
    wait
    done

SummoningItemFirstFailedText:
    text "Used <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>,"
    next "but nothing happened."
    para "Use it in the <B>Grasslands</B>."
    next "Surely something will happen!"
    wait
    done

LocalBuffText:
    text "The next opponent you"
    next "encounter will be stronger!"
    wait
    done

GlobalBuffText:
    text "The opponents in the area"
    next "got slightly stronger!"
    wait
    done

AttackBuffText:
    text "<B>Pikachu</B>'s attacks got"
    next "a bit stronger!"
    wait
    done

LoreIntroText:
    text "Welcome to Glitchtopia."
    next "The world of infinite choices."
    para "The world corrupted by the"
    next "Glitch Lord's malice..."
    para "It is all left to you to"
    next "restore order and peace."
    para "Begin by looking around and"
    next "finding items to help you"
    cont "survive."
    para "I wish you best of luck."
    next "I'm counting on you..."
    wait
    done

LoreBiomeText:
    text "Well, it looks like you"
    next "just entered a new biome..."
    para "Each biome has different"
    next "items to find and enemies to"
    cont "encounter."
    para "Some items could also have"
    next "different effects in different"
    cont "biomes."
    para "But be careful - the farther"
    next "you travel, the stronger "
    cont "your opponents become..."
    wait
    done

LoreSaltText:
    text "This item gives off a very"
    next "strange aura..."
    para "It's as if it holds the key"
    next "to summoning the guardians"
    cont "of this universe."
    para "Summon and challenge the"
    next "lost souls of our world "
    cont "by using this item."
    para "Make sure you're ready for"
    next "a tough battle though..."
    wait
    done

LoreDefeatedGuardianText:
    text "Looks like this guardian's"
    next "soul can finally rest."
    para "But it's far from over."
    next "You should challenge the "
    cont "guardians of other biomes."
    para "If you're ever lost, this"
    next "item will surely help you."
    cont "Farewell!"
    para "<B>TELLTALE ORB</B> magically"
    next "appeared in your inventory!"
    done

HintText1:
    text "Abracadabra..."
    next "Time to take action..."
    para "Look for <B>GLITCH SHARDS</B>"
    next "in the <B>Corruption</B>..."
    wait
    done

HintText2:
    text "Hocus pocus..."
    next "You'll need three shards to"
    cont "summon the soul in corruption."
    wait
    done

HintText3:
    text "Abracadabra alakazam!"
    next "Follow my lead!"
    para "An opponent in <B>Construct</B>"
    next "should have an item you need!"
    wait
    done

HintText4:
    text "Hocus pocus..."
    next "Two <B>SHYHORNS</B> and two"
    cont "<B>GLITCH SHARDS</B> will wake"
    cont "up the soul of <B>Construct</B>."
    wait
    done

HintText5:
    text "Abracadabra!"
    next "You'll need a <B>GLITCH SHARD</B>"
    cont "to summon the next opponent."
    wait
    done

HintText6:
    text "Hocus pocus!"
    next "Find two items lying next to"
    cont "each other in the <B>Steppes</B>."
    para "But don't pick them up!"
    next "Leave them for the lost soul."
    para "When you find the right place,"
    next "summon the soul there..."
    wait
    done

HintText7:
    text "Abracadabra alakazam!"
    next "Our future is in your hands!"
    para "Summon a special enemy"
    next "in the <B>Grasslands</B>!"
    wait
    done

HintTextEasterEgg:
    text "|o|h |n|o|s |.|.|."
    next "|n|o|t |h|e|r|e |t|h|i|s |y|e|a|r |.|.|."
    para "|b|u|t |n|e|x|t |t|i|m|e|s |.|.|."
    next "|I |C|O|M|E |B|A|C|K |!|!"
    para "|V|E|R|Y|!|!|!"
    next "|V|E|R|Y |C|O|M|E |B|A|C|K|!|!"
    wait
    done

HintTextScare:
    text "I'm sick of being trapped"
    next "inside that orb."
    para "What the hell is Fidei?"
    next "It's where dreams have died."
    para "Since then, I still keep"
    next "making the same mistake."
    para "Relying on a person as my"
    next "sole source of happiness."
    para "I keep trying to change,"
    next "but I just can't help it."
    para "Because all I ever wanted..."
    next "was a friend."
    para "Can you be my friend?"
    next "Please play with me."
    wait
    done
HintTextScare2:
    text "Please just play with m"
    tx_buf_indirect 3, $0650
    done

LoreWolfText:
    text "The lost soul returned to"
    next "the afterlife."
    para "It will spend the rest of"
    next "time wandering alone in the "
    cont "darkness..."
    para "Unless you find another soul"
    next "to keep it company..."
    wait
    done

LoreFoxText:
    text "The lost soul leaves to the"
    next "afterlife, together with the"
    cont "other soul you freed."
    para "Yet they can't be together."
    next "They're separated, imprisoned"
    cont "in their own worlds."
    para "But maybe, if you find an"
    next "opportunity to join these"
    cont "two souls together..."
    para "If fate only considered such"
    next "a possibility..."
    para "Maybe then there could be"
    next "a way to make everyone happy..."
    wait
    done

LoreNoeText:
    text "Another soul, now free, joins"
    next "two of the lost souls in the "
    cont "afterlife."
    para "They're all still separated."
    next "Fate ain't giving them"
    cont "any chances."
    para "But maybe, to achieve eternal"
    next "peace, they don't have to be"
    cont "together."
    para "If the souls recognize who"
    next "they are, then they can rest."
    para "Then, all of them reuniting"
    next "will be the ultimate reward."
    wait
    done

LoreMewtwoText:
    text "The lost souls are separated,"
    next "but standing together, they "
    cont "are truly unstoppable."
    para "Wolf will continue to hunt."
    next "The Fox is the prey."
    para "The Gentle Soul struggles to"
    next "find its place in all of this."
    para "Let the situation develop."
    next "Maybe the chance will come."
    para "All you have to do... is hold"
    next "on to your hopes and dreams."
    wait
    done

LoreCrystal1Text:
    text "This crystal emanates with"
    next "dark energy."
    para "It's no use staring at it."
    next "It will just make you feel "
    cont "very inconvenienced."
    wait
    done

LoreCrystal2Text:
    text "This crystal gives off a"
    next "magnificent amber glow."
    para "With this crystal nearby,"
    next "even the <B>DARK CRYSTAL</B>"
    cont "stops being so dark."
    para "Looking at the glow makes"
    next "you feel warm inside..."
    para "I'd call it my Favorite"
    next "Crystal. FC for short!"
    wait
    done

LoreCrystal3Text:
    text "Weirdly, this crystal isn't"
    next "hard like the others."
    cont "It's soft and fluffy."
    para "Bringing it next to the"
    next "<B>DARK CRYSTAL</B> makes it"
    cont "brighten up slightly."
    para "But the <B>AMBER CRYSTAL</B>"
    next "does not respond at all."
    cont "It holds its amber glow."
    wait
    done

EdgeText:
    text "Congratulations, you reached"
    next "the edge of the world."
    para "Kind of. The world will loop"
    next "back around."
    cont "Glitchtopia isn't flat."
    para "That being said, here's a"
    next "reward for coming this far!"
    cont "<B>ToTheEdgeAndBeyond</B>."
    wait
    done

StandardEncounterText:
    text "A wild <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B> appeared!"
    done
ShydonEncounterText:
    text "A wild <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>"
    next "carefully approaches you!"
    done
HookedEncounterText:
    text "A hooked <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>"
    next "attacked!"
    done
ScytherEncounterText:
    text "You encounter <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>,"
    next "Guardian of the Grasslands!"
    done
MagmarEncounterText:
    text "Wild_____appeared, but"
    next "it turned into a <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>!"
    done
TMZ4EncounterText:
    text "You encounter a wild"
    next "_TMZ4"
    cont "_TMZ4"
    cont "_TMZ4"
    cont "_TMZ4"
    cont "_TMZ4"
    done
WolfEncounterText:
    text "You encounter <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>,"
    next "Soul of the Black Wolf!"
    done
FoxEncounterText:
    text "You encounter <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>,"
    next "Soul of the Mighty Fox!"
    done
NoeEncounterText:
    text "You encounter <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>,"
    next "Gentle Soul of Pleasure!"
    done
MewtwoEncounterText:
    text "You encounter <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>,"
    next "the Ultimate Lifeform!"
    done
RapidashEncounterText:
    text "Listen up! It's my"
    next "favorite <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B>..."
    done
BulbasaurEncounterText:
    text "Look! It's the Pokémon"
    next "no one ever picked!"
    done
SnorlaxEncounterText:
    text "A sleeping <B>"
    tx_buf_indirect 3, wTextBufPtr
    next "</B>blocks the road!"
    done
MachopEncounterText:
    text "A <B>"
    tx_buf_indirect 3, wTextBufPtr
    text "</B> is stomping"
    next "the ground flat!"
    done

Opponent1Name:
    text "Shydon"
    done
Opponent2Name:
    text "Rattata"
    done
Opponent3Name:
    text "Pidgey"
    done
Opponent4Name:
    text "Metapod"
    done
Opponent5Name:
    text "Glitchling"
    done
Opponent6Name:
    text "Scyther"
    done
Opponent7Name:
    text "Dragonite"
    done
Opponent8Name:
    text "Magmar"
    done
Opponent9Name:
    text "TMZ4"
    done
Opponent10Name:
    text "?????"
    done
Opponent11Name:
    text "Ninetales"
    done
Opponent12Name:
    text "Chansey"
    done
Opponent13Name:
    text "Mewtwo"
    done
Opponent14Name:
    text "Rapidash"
    done
Opponent15Name:
    text "Fearow"
    done
Opponent16Name:
    text "Tauros"
    done
Opponent17Name:
    text "Bulbasaur"
    done
Opponent18Name:
    text "Nidorino"
    done
Opponent19Name:
    text "Snorlax"
    done
Opponent20Name:
    text "Machop"
    done

PlayerMonName:
    text "Pikachu"
    done

ENDL