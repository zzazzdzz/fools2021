SCREEN_WIDTH equ 20
SCREEN_HEIGHT equ 18

; Music constants.

AUDIO_1 EQUS "$02"
AUDIO_2 EQUS "$08"
AUDIO_3 EQUS "$1f"

; AUDIO_1
MUSIC_PALLET_TOWN EQUS "((Music_PalletTown - SFX_Headers_1) / 3)"
MUSIC_POKECENTER EQUS "((Music_Pokecenter - SFX_Headers_1) / 3)"
MUSIC_GYM EQUS "((Music_Gym - SFX_Headers_1) / 3)"
MUSIC_CITIES1 EQUS "((Music_Cities1 - SFX_Headers_1) / 3)"
MUSIC_CITIES2 EQUS "((Music_Cities2 - SFX_Headers_1) / 3)"
MUSIC_CELADON EQUS "((Music_Celadon - SFX_Headers_1) / 3)"
MUSIC_CINNABAR EQUS "((Music_Cinnabar - SFX_Headers_1) / 3)"
MUSIC_VERMILION EQUS "((Music_Vermilion - SFX_Headers_1) / 3)"
MUSIC_LAVENDER EQUS "((Music_Lavender - SFX_Headers_1) / 3)"
MUSIC_SS_ANNE EQUS "((Music_SSAnne - SFX_Headers_1) / 3)"
MUSIC_MEET_PROF_OAK EQUS "((Music_MeetProfOak - SFX_Headers_1) / 3)"
MUSIC_MEET_RIVAL EQUS "((Music_MeetRival - SFX_Headers_1) / 3)"
MUSIC_MUSEUM_GUY EQUS "((Music_MuseumGuy - SFX_Headers_1) / 3)"
MUSIC_SAFARI_ZONE EQUS "((Music_SafariZone - SFX_Headers_1) / 3)"
MUSIC_PKMN_HEALED EQUS "((Music_PkmnHealed - SFX_Headers_1) / 3)"
MUSIC_ROUTES1 EQUS "((Music_Routes1 - SFX_Headers_1) / 3)"
MUSIC_ROUTES2 EQUS "((Music_Routes2 - SFX_Headers_1) / 3)"
MUSIC_ROUTES3 EQUS "((Music_Routes3 - SFX_Headers_1) / 3)"
MUSIC_ROUTES4 EQUS "((Music_Routes4 - SFX_Headers_1) / 3)"
MUSIC_INDIGO_PLATEAU EQUS "((Music_IndigoPlateau - SFX_Headers_1) / 3)"

; AUDIO_2
MUSIC_GYM_LEADER_BATTLE EQUS "((Music_GymLeaderBattle - SFX_Headers_1) / 3)"
MUSIC_TRAINER_BATTLE EQUS "((Music_TrainerBattle - SFX_Headers_1) / 3)"
MUSIC_WILD_BATTLE EQUS "((Music_WildBattle - SFX_Headers_1) / 3)"
MUSIC_FINAL_BATTLE EQUS "((Music_FinalBattle - SFX_Headers_1) / 3)"
MUSIC_DEFEATED_TRAINER EQUS "((Music_DefeatedTrainer - SFX_Headers_1) / 3)"
MUSIC_DEFEATED_WILD_MON EQUS "((Music_DefeatedWildMon - SFX_Headers_1) / 3)"
MUSIC_DEFEATED_GYM_LEADER EQUS "((Music_DefeatedGymLeader - SFX_Headers_1) / 3)"

; AUDIO_3 $1f
MUSIC_TITLE_SCREEN EQUS "((Music_TitleScreen - SFX_Headers_1) / 3)"
MUSIC_CREDITS EQUS "((Music_Credits - SFX_Headers_1) / 3)"
MUSIC_HALL_OF_FAME EQUS "((Music_HallOfFame - SFX_Headers_1) / 3)"
MUSIC_OAKS_LAB EQUS "((Music_OaksLab - SFX_Headers_1) / 3)"
MUSIC_JIGGLYPUFF_SONG EQUS "((Music_JigglypuffSong - SFX_Headers_1) / 3)"
MUSIC_BIKE_RIDING EQUS "((Music_BikeRiding - SFX_Headers_1) / 3)"
MUSIC_SURFING EQUS "((Music_Surfing - SFX_Headers_1) / 3)"
MUSIC_GAME_CORNER EQUS "((Music_GameCorner - SFX_Headers_1) / 3)"
MUSIC_INTRO_BATTLE EQUS "((Music_IntroBattle - SFX_Headers_1) / 3)"
MUSIC_DUNGEON1 EQUS "((Music_Dungeon1 - SFX_Headers_1) / 3)"
MUSIC_DUNGEON2 EQUS "((Music_Dungeon2 - SFX_Headers_1) / 3)"
MUSIC_DUNGEON3 EQUS "((Music_Dungeon3 - SFX_Headers_1) / 3)"
MUSIC_CINNABAR_MANSION EQUS "((Music_CinnabarMansion - SFX_Headers_1) / 3)"
MUSIC_POKEMON_TOWER EQUS "((Music_PokemonTower - SFX_Headers_1) / 3)"
MUSIC_SILPH_CO EQUS "((Music_SilphCo - SFX_Headers_1) / 3)"
MUSIC_MEET_EVIL_TRAINER EQUS "((Music_MeetEvilTrainer - SFX_Headers_1) / 3)"
MUSIC_MEET_FEMALE_TRAINER EQUS "((Music_MeetFemaleTrainer - SFX_Headers_1) / 3)"
MUSIC_MEET_MALE_TRAINER EQUS "((Music_MeetMaleTrainer - SFX_Headers_1) / 3)"

; AUDIO_1 AUDIO_2 AUDIO_3
SFX_SNARE_1 EQUS "((SFX_Snare1_1 - SFX_Headers_1) / 3)"
SFX_SNARE_2 EQUS "((SFX_Snare2_1 - SFX_Headers_1) / 3)"
SFX_SNARE_3 EQUS "((SFX_Snare3_1 - SFX_Headers_1) / 3)"
SFX_SNARE_4 EQUS "((SFX_Snare4_1 - SFX_Headers_1) / 3)"
SFX_SNARE_5 EQUS "((SFX_Snare5_1 - SFX_Headers_1) / 3)"
SFX_TRIANGLE_1 EQUS "((SFX_Triangle1_1 - SFX_Headers_1) / 3)"
SFX_TRIANGLE_2 EQUS "((SFX_Triangle2_1 - SFX_Headers_1) / 3)"
SFX_SNARE_6 EQUS "((SFX_Snare6_1 - SFX_Headers_1) / 3)"
SFX_SNARE_7 EQUS "((SFX_Snare7_1 - SFX_Headers_1) / 3)"
SFX_SNARE_8 EQUS "((SFX_Snare8_1 - SFX_Headers_1) / 3)"
SFX_SNARE_9 EQUS "((SFX_Snare9_1 - SFX_Headers_1) / 3)"
SFX_CYMBAL_1 EQUS "((SFX_Cymbal1_1 - SFX_Headers_1) / 3)"
SFX_CYMBAL_2 EQUS "((SFX_Cymbal2_1 - SFX_Headers_1) / 3)"
SFX_CYMBAL_3 EQUS "((SFX_Cymbal3_1 - SFX_Headers_1) / 3)"
SFX_MUTED_SNARE_1 EQUS "((SFX_Muted_Snare1_1 - SFX_Headers_1) / 3)"
SFX_TRIANGLE_3 EQUS "((SFX_Triangle3_1 - SFX_Headers_1) / 3)"
SFX_MUTED_SNARE_2 EQUS "((SFX_Muted_Snare2_1 - SFX_Headers_1) / 3)"
SFX_MUTED_SNARE_3 EQUS "((SFX_Muted_Snare3_1 - SFX_Headers_1) / 3)"
SFX_MUTED_SNARE_4 EQUS "((SFX_Muted_Snare4_1 - SFX_Headers_1) / 3)"
SFX_CRY_00 EQUS "((SFX_Cry00_1 - SFX_Headers_1) / 3)"
SFX_CRY_01 EQUS "((SFX_Cry01_1 - SFX_Headers_1) / 3)"
SFX_CRY_02 EQUS "((SFX_Cry02_1 - SFX_Headers_1) / 3)"
SFX_CRY_03 EQUS "((SFX_Cry03_1 - SFX_Headers_1) / 3)"
SFX_CRY_04 EQUS "((SFX_Cry04_1 - SFX_Headers_1) / 3)"
SFX_CRY_05 EQUS "((SFX_Cry05_1 - SFX_Headers_1) / 3)"
SFX_CRY_06 EQUS "((SFX_Cry06_1 - SFX_Headers_1) / 3)"
SFX_CRY_07 EQUS "((SFX_Cry07_1 - SFX_Headers_1) / 3)"
SFX_CRY_08 EQUS "((SFX_Cry08_1 - SFX_Headers_1) / 3)"
SFX_CRY_09 EQUS "((SFX_Cry09_1 - SFX_Headers_1) / 3)"
SFX_CRY_0A EQUS "((SFX_Cry0A_1 - SFX_Headers_1) / 3)"
SFX_CRY_0B EQUS "((SFX_Cry0B_1 - SFX_Headers_1) / 3)"
SFX_CRY_0C EQUS "((SFX_Cry0C_1 - SFX_Headers_1) / 3)"
SFX_CRY_0D EQUS "((SFX_Cry0D_1 - SFX_Headers_1) / 3)"
SFX_CRY_0E EQUS "((SFX_Cry0E_1 - SFX_Headers_1) / 3)"
SFX_CRY_0F EQUS "((SFX_Cry0F_1 - SFX_Headers_1) / 3)"
SFX_CRY_10 EQUS "((SFX_Cry10_1 - SFX_Headers_1) / 3)"
SFX_CRY_11 EQUS "((SFX_Cry11_1 - SFX_Headers_1) / 3)"
SFX_CRY_12 EQUS "((SFX_Cry12_1 - SFX_Headers_1) / 3)"
SFX_CRY_13 EQUS "((SFX_Cry13_1 - SFX_Headers_1) / 3)"
SFX_CRY_14 EQUS "((SFX_Cry14_1 - SFX_Headers_1) / 3)"
SFX_CRY_15 EQUS "((SFX_Cry15_1 - SFX_Headers_1) / 3)"
SFX_CRY_16 EQUS "((SFX_Cry16_1 - SFX_Headers_1) / 3)"
SFX_CRY_17 EQUS "((SFX_Cry17_1 - SFX_Headers_1) / 3)"
SFX_CRY_18 EQUS "((SFX_Cry18_1 - SFX_Headers_1) / 3)"
SFX_CRY_19 EQUS "((SFX_Cry19_1 - SFX_Headers_1) / 3)"
SFX_CRY_1A EQUS "((SFX_Cry1A_1 - SFX_Headers_1) / 3)"
SFX_CRY_1B EQUS "((SFX_Cry1B_1 - SFX_Headers_1) / 3)"
SFX_CRY_1C EQUS "((SFX_Cry1C_1 - SFX_Headers_1) / 3)"
SFX_CRY_1D EQUS "((SFX_Cry1D_1 - SFX_Headers_1) / 3)"
SFX_CRY_1E EQUS "((SFX_Cry1E_1 - SFX_Headers_1) / 3)"
SFX_CRY_1F EQUS "((SFX_Cry1F_1 - SFX_Headers_1) / 3)"
SFX_CRY_20 EQUS "((SFX_Cry20_1 - SFX_Headers_1) / 3)"
SFX_CRY_21 EQUS "((SFX_Cry21_1 - SFX_Headers_1) / 3)"
SFX_CRY_22 EQUS "((SFX_Cry22_1 - SFX_Headers_1) / 3)"
SFX_CRY_23 EQUS "((SFX_Cry23_1 - SFX_Headers_1) / 3)"
SFX_CRY_24 EQUS "((SFX_Cry24_1 - SFX_Headers_1) / 3)"
SFX_CRY_25 EQUS "((SFX_Cry25_1 - SFX_Headers_1) / 3)"

SFX_LEVEL_UP EQUS "((SFX_Level_Up - SFX_Headers_1) / 3)"
SFX_BALL_TOSS EQUS "((SFX_Ball_Toss - SFX_Headers_1) / 3)"
SFX_BALL_POOF EQUS "((SFX_Ball_Poof - SFX_Headers_1) / 3)"
SFX_FAINT_THUD EQUS "((SFX_Faint_Thud - SFX_Headers_1) / 3)"
SFX_RUN EQUS "((SFX_Run - SFX_Headers_1) / 3)"
SFX_DEX_PAGE_ADDED EQUS "((SFX_Dex_Page_Added - SFX_Headers_1) / 3)"
SFX_CAUGHT_MON EQUS "((SFX_Caught_Mon - SFX_Headers_1) / 3)"
SFX_PECK EQUS "((SFX_Peck - SFX_Headers_1) / 3)"
SFX_FAINT_FALL EQUS "((SFX_Faint_Fall - SFX_Headers_1) / 3)"
SFX_BATTLE_09 EQUS "((SFX_Battle_09 - SFX_Headers_1) / 3)"
SFX_POUND EQUS "((SFX_Pound - SFX_Headers_1) / 3)"
SFX_BATTLE_0B EQUS "((SFX_Battle_0B - SFX_Headers_1) / 3)"
SFX_BATTLE_0C EQUS "((SFX_Battle_0C - SFX_Headers_1) / 3)"
SFX_BATTLE_0D EQUS "((SFX_Battle_0D - SFX_Headers_1) / 3)"
SFX_BATTLE_0E EQUS "((SFX_Battle_0E - SFX_Headers_1) / 3)"
SFX_BATTLE_0F EQUS "((SFX_Battle_0F - SFX_Headers_1) / 3)"
SFX_DAMAGE EQUS "((SFX_Damage - SFX_Headers_1) / 3)"
SFX_NOT_VERY_EFFECTIVE EQUS "((SFX_Not_Very_Effective - SFX_Headers_1) / 3)"
SFX_BATTLE_12 EQUS "((SFX_Battle_12 - SFX_Headers_1) / 3)"
SFX_BATTLE_13 EQUS "((SFX_Battle_13 - SFX_Headers_1) / 3)"
SFX_BATTLE_14 EQUS "((SFX_Battle_14 - SFX_Headers_1) / 3)"
SFX_VINE_WHIP EQUS "((SFX_Vine_Whip - SFX_Headers_1) / 3)"
SFX_BATTLE_16 EQUS "((SFX_Battle_16 ; unused? - SFX_Headers_1) / 3)"
SFX_BATTLE_17 EQUS "((SFX_Battle_17 - SFX_Headers_1) / 3)"
SFX_BATTLE_18 EQUS "((SFX_Battle_18 - SFX_Headers_1) / 3)"
SFX_BATTLE_19 EQUS "((SFX_Battle_19 - SFX_Headers_1) / 3)"
SFX_SUPER_EFFECTIVE EQUS "((SFX_Super_Effective - SFX_Headers_1) / 3)"
SFX_BATTLE_1B EQUS "((SFX_Battle_1B - SFX_Headers_1) / 3)"
SFX_BATTLE_1C EQUS "((SFX_Battle_1C - SFX_Headers_1) / 3)"
SFX_DOUBLESLAP EQUS "((SFX_Doubleslap - SFX_Headers_1) / 3)"
SFX_BATTLE_1E EQUS "((SFX_Battle_1E - SFX_Headers_1) / 3)"
SFX_HORN_DRILL EQUS "((SFX_Horn_Drill - SFX_Headers_1) / 3)"
SFX_BATTLE_20 EQUS "((SFX_Battle_20 - SFX_Headers_1) / 3)"
SFX_BATTLE_21 EQUS "((SFX_Battle_21 - SFX_Headers_1) / 3)"
SFX_BATTLE_22 EQUS "((SFX_Battle_22 - SFX_Headers_1) / 3)"
SFX_BATTLE_23 EQUS "((SFX_Battle_23 - SFX_Headers_1) / 3)"
SFX_BATTLE_24 EQUS "((SFX_Battle_24 - SFX_Headers_1) / 3)"
SFX_BATTLE_25 EQUS "((SFX_Battle_25 - SFX_Headers_1) / 3)"
SFX_BATTLE_26 EQUS "((SFX_Battle_26 - SFX_Headers_1) / 3)"
SFX_BATTLE_27 EQUS "((SFX_Battle_27 - SFX_Headers_1) / 3)"
SFX_BATTLE_28 EQUS "((SFX_Battle_28 - SFX_Headers_1) / 3)"
SFX_BATTLE_29 EQUS "((SFX_Battle_29 - SFX_Headers_1) / 3)"
SFX_BATTLE_2A EQUS "((SFX_Battle_2A - SFX_Headers_1) / 3)"
SFX_BATTLE_2B EQUS "((SFX_Battle_2B - SFX_Headers_1) / 3)"
SFX_BATTLE_2C EQUS "((SFX_Battle_2C - SFX_Headers_1) / 3)"
SFX_PSYBEAM EQUS "((SFX_Psybeam - SFX_Headers_1) / 3)"
SFX_BATTLE_2E EQUS "((SFX_Battle_2E - SFX_Headers_1) / 3)"
SFX_BATTLE_2F EQUS "((SFX_Battle_2F - SFX_Headers_1) / 3)"
SFX_PSYCHIC_M EQUS "((SFX_Psychic_M - SFX_Headers_1) / 3)"
SFX_BATTLE_31 EQUS "((SFX_Battle_31 - SFX_Headers_1) / 3)"
SFX_BATTLE_32 EQUS "((SFX_Battle_32 - SFX_Headers_1) / 3)"
SFX_BATTLE_33 EQUS "((SFX_Battle_33 - SFX_Headers_1) / 3)"
SFX_BATTLE_34 EQUS "((SFX_Battle_34 - SFX_Headers_1) / 3)"
SFX_BATTLE_35 EQUS "((SFX_Battle_35 - SFX_Headers_1) / 3)"
SFX_BATTLE_36 EQUS "((SFX_Battle_36 - SFX_Headers_1) / 3)"
SFX_SILPH_SCOPE EQUS "((SFX_Silph_Scope - SFX_Headers_1) / 3)"

SFX_GET_ITEM_2 EQUS "((SFX_Get_Item2_1 - SFX_Headers_1) / 3)"
SFX_TINK EQUS "((SFX_Tink_1 - SFX_Headers_1) / 3)"
SFX_HEAL_HP EQUS "((SFX_Heal_HP_1 - SFX_Headers_1) / 3)"
SFX_HEAL_AILMENT EQUS "((SFX_Heal_Ailment_1 - SFX_Headers_1) / 3)"
SFX_START_MENU EQUS "((SFX_Start_Menu_1 - SFX_Headers_1) / 3)"
SFX_PRESS_AB EQUS "((SFX_Press_AB_1 - SFX_Headers_1) / 3)"

; AUDIO_1 AUDIO_3
SFX_GET_ITEM_1 EQUS "((SFX_Get_Item1_1 - SFX_Headers_1) / 3)"

SFX_POKEDEX_RATING EQUS "((SFX_Pokedex_Rating_1 - SFX_Headers_1) / 3)"
SFX_GET_KEY_ITEM EQUS "((SFX_Get_Key_Item_1 - SFX_Headers_1) / 3)"
SFX_POISONED EQUS "((SFX_Poisoned_1 - SFX_Headers_1) / 3)"
SFX_TRADE_MACHINE EQUS "((SFX_Trade_Machine_1 - SFX_Headers_1) / 3)"
SFX_TURN_ON_PC EQUS "((SFX_Turn_On_PC_1 - SFX_Headers_1) / 3)"
SFX_TURN_OFF_PC EQUS "((SFX_Turn_Off_PC_1 - SFX_Headers_1) / 3)"
SFX_ENTER_PC EQUS "((SFX_Enter_PC_1 - SFX_Headers_1) / 3)"
SFX_SHRINK EQUS "((SFX_Shrink_1 - SFX_Headers_1) / 3)"
SFX_SWITCH EQUS "((SFX_Switch_1 - SFX_Headers_1) / 3)"
SFX_HEALING_MACHINE EQUS "((SFX_Healing_Machine_1 - SFX_Headers_1) / 3)"
SFX_TELEPORT_EXIT_1 EQUS "((SFX_Teleport_Exit1_1 - SFX_Headers_1) / 3)"
SFX_TELEPORT_ENTER_1 EQUS "((SFX_Teleport_Enter1_1 - SFX_Headers_1) / 3)"
SFX_TELEPORT_EXIT_2 EQUS "((SFX_Teleport_Exit2_1 - SFX_Headers_1) / 3)"
SFX_LEDGE EQUS "((SFX_Ledge_1 - SFX_Headers_1) / 3)"
SFX_TELEPORT_ENTER_2 EQUS "((SFX_Teleport_Enter2_1 - SFX_Headers_1) / 3)"
SFX_FLY EQUS "((SFX_Fly_1 - SFX_Headers_1) / 3)"
SFX_DENIED EQUS "((SFX_Denied_1 - SFX_Headers_1) / 3)"
SFX_ARROW_TILES EQUS "((SFX_Arrow_Tiles_1 - SFX_Headers_1) / 3)"
SFX_PUSH_BOULDER EQUS "((SFX_Push_Boulder_1 - SFX_Headers_1) / 3)"
SFX_SS_ANNE_HORN EQUS "((SFX_SS_Anne_Horn_1 - SFX_Headers_1) / 3)"
SFX_WITHDRAW_DEPOSIT EQUS "((SFX_Withdraw_Deposit_1 - SFX_Headers_1) / 3)"
SFX_CUT EQUS "((SFX_Cut_1 - SFX_Headers_1) / 3)"
SFX_GO_INSIDE EQUS "((SFX_Go_Inside_1 - SFX_Headers_1) / 3)"
SFX_SWAP EQUS "((SFX_Swap_1 - SFX_Headers_1) / 3)"
SFX_PURCHASE EQUS "((SFX_Purchase_1 - SFX_Headers_1) / 3)"
SFX_COLLISION EQUS "((SFX_Collision_1 - SFX_Headers_1) / 3)"
SFX_GO_OUTSIDE EQUS "((SFX_Go_Outside_1 - SFX_Headers_1) / 3)"
SFX_SAVE EQUS "((SFX_Save_1 - SFX_Headers_1) / 3)"

; AUDIO_1
SFX_POKEFLUE EQUS "((SFX_Pokeflute - SFX_Headers_1) / 3)"
SFX_SAFARI_ZONE_PA EQUS "((SFX_Safari_Zone_PA - SFX_Headers_1) / 3)"

; AUDIO_3
SFX_INTRO_LUNGE EQUS "((SFX_Intro_Lunge - SFX_Headers_1) / 3)"
SFX_INTRO_HIP EQUS "((SFX_Intro_Hip - SFX_Headers_1) / 3)"
SFX_INTRO_HOP EQUS "((SFX_Intro_Hop - SFX_Headers_1) / 3)"
SFX_INTRO_RAISE EQUS "((SFX_Intro_Raise - SFX_Headers_1) / 3)"
SFX_INTRO_CRASH EQUS "((SFX_Intro_Crash - SFX_Headers_1) / 3)"
SFX_INTRO_WHOOSH EQUS "((SFX_Intro_Whoosh - SFX_Headers_1) / 3)"
SFX_SLOTS_STOP_WHEEL EQUS "((SFX_Slots_Stop_Wheel - SFX_Headers_1) / 3)"
SFX_SLOTS_REWARD EQUS "((SFX_Slots_Reward - SFX_Headers_1) / 3)"
SFX_SLOTS_NEW_SPIN EQUS "((SFX_Slots_New_Spin - SFX_Headers_1) / 3)"
SFX_SHOOTING_STAR EQUS "((SFX_Shooting_Star - SFX_Headers_1) / 3)"

JustRet equ $008c

wCurTextPtrs equ $d5d0
wCurObjectPtrs equ $d620 
wWarpCoords equ $d628
wCurTextIDs equ $d670
wMapConnectionMeta equ $d3f0

hSCX equ $ae
hChunkExitsAndBiome equ $95
hChunkStartXY equ $96
hChunkWriteTile equ $97

hChunkSeedTileTop equ $98
hChunkSeedTileBottom equ $99
hChunkSeedTileLeft equ $9A
hChunkSeedTileRight equ $9B

hWhoseTurn equ $f3

hInventoryItemsLeft equ $95
hCurrentItem equ $96

wCurMapBlocks equ $d800
wInventoryTextBuffer equ $d808

wItemFlags equ $b700

_hl_ equ $35e3

OPPONENTS_TABLE_SIZE equ 10

    const_def
    const E_NOMON
    const E_SHYDON
    const E_RATTATA
    const E_PIDGEY
    const E_METAPOD
	const E_MISSINGLING
	const E_SCYTHER
	const E_DRAGONITE
	const E_MAGMAR
	const E_TMZ4
	const E_WOLF
	const E_FOX
	const E_NOE
	const E_MEWTWO
	const E_RAPIDASH
	const E_FEAROW
	const E_TAUROS
	const E_BULBASAUR
	const E_NIDORINO
	const E_SNORLAX
	const E_MACHOP

MAX_ITEMS equ 19

    const_def
    const NO_ITEM
    const POTION
    const SUPER_POTION
    const HYPER_POTION
    const REVIVER_SEED
    const LIFE_SEED
    const HARDENED_SCALE
    const SKIP_SANDWICH
	const SUMMONING_SALT
	const TELLTALE_ORB
	const GLITCH_SHARD
	const SHYHORN
	const DAREDEVIL_POTION
	const BRAVERY_POTION
	const DARK_CRYSTAL
	const AMBER_CRYSTAL
	const FLUFFY_CRYSTAL
	const SHARP_BEAK
	const SHARP_HORN

    const_def
    const NO_MON       ; $00
	const RHYDON       ; $01
	const KANGASKHAN   ; $02
	const NIDORAN_M    ; $03
	const CLEFAIRY     ; $04
	const SPEAROW      ; $05
	const VOLTORB      ; $06
	const NIDOKING     ; $07
	const SLOWBRO      ; $08
	const IVYSAUR      ; $09
	const EXEGGUTOR    ; $0A
	const LICKITUNG    ; $0B
	const EXEGGCUTE    ; $0C
	const GRIMER       ; $0D
	const GENGAR       ; $0E
	const NIDORAN_F    ; $0F
	const NIDOQUEEN    ; $10
	const CUBONE       ; $11
	const RHYHORN      ; $12
	const LAPRAS       ; $13
	const ARCANINE     ; $14
	const MEW          ; $15
	const GYARADOS     ; $16
	const SHELLDER     ; $17
	const TENTACOOL    ; $18
	const GASTLY       ; $19
	const SCYTHER      ; $1A
	const STARYU       ; $1B
	const BLASTOISE    ; $1C
	const PINSIR       ; $1D
	const TANGELA      ; $1E
	const MISSINGNO_1F ; $1F
	const MISSINGNO_20 ; $20
	const GROWLITHE    ; $21
	const ONIX         ; $22
	const FEAROW       ; $23
	const PIDGEY       ; $24
	const SLOWPOKE     ; $25
	const KADABRA      ; $26
	const GRAVELER     ; $27
	const CHANSEY      ; $28
	const MACHOKE      ; $29
	const MR_MIME      ; $2A
	const HITMONLEE    ; $2B
	const HITMONCHAN   ; $2C
	const ARBOK        ; $2D
	const PARASECT     ; $2E
	const PSYDUCK      ; $2F
	const DROWZEE      ; $30
	const GOLEM        ; $31
	const MISSINGNO_32 ; $32
	const MAGMAR       ; $33
	const MISSINGNO_34 ; $34
	const ELECTABUZZ   ; $35
	const MAGNETON     ; $36
	const KOFFING      ; $37
	const MISSINGNO_38 ; $38
	const MANKEY       ; $39
	const SEEL         ; $3A
	const DIGLETT      ; $3B
	const TAUROS       ; $3C
	const MISSINGNO_3D ; $3D
	const MISSINGNO_3E ; $3E
	const MISSINGNO_3F ; $3F
	const FARFETCHD    ; $40
	const VENONAT      ; $41
	const DRAGONITE    ; $42
	const MISSINGNO_43 ; $43
	const MISSINGNO_44 ; $44
	const MISSINGNO_45 ; $45
	const DODUO        ; $46
	const POLIWAG      ; $47
	const JYNX         ; $48
	const MOLTRES      ; $49
	const ARTICUNO     ; $4A
	const ZAPDOS       ; $4B
	const DITTO        ; $4C
	const MEOWTH       ; $4D
	const KRABBY       ; $4E
	const MISSINGNO_4F ; $4F
	const MISSINGNO_50 ; $50
	const MISSINGNO_51 ; $51
	const VULPIX       ; $52
	const NINETALES    ; $53
	const PIKACHU      ; $54
	const RAICHU       ; $55
	const MISSINGNO_56 ; $56
	const MISSINGNO_57 ; $57
	const DRATINI      ; $58
	const DRAGONAIR    ; $59
	const KABUTO       ; $5A
	const KABUTOPS     ; $5B
	const HORSEA       ; $5C
	const SEADRA       ; $5D
	const MISSINGNO_5E ; $5E
	const MISSINGNO_5F ; $5F
	const SANDSHREW    ; $60
	const SANDSLASH    ; $61
	const OMANYTE      ; $62
	const OMASTAR      ; $63
	const JIGGLYPUFF   ; $64
	const WIGGLYTUFF   ; $65
	const EEVEE        ; $66
	const FLAREON      ; $67
	const JOLTEON      ; $68
	const VAPOREON     ; $69
	const MACHOP       ; $6A
	const ZUBAT        ; $6B
	const EKANS        ; $6C
	const PARAS        ; $6D
	const POLIWHIRL    ; $6E
	const POLIWRATH    ; $6F
	const WEEDLE       ; $70
	const KAKUNA       ; $71
	const BEEDRILL     ; $72
	const MISSINGNO_73 ; $73
	const DODRIO       ; $74
	const PRIMEAPE     ; $75
	const DUGTRIO      ; $76
	const VENOMOTH     ; $77
	const DEWGONG      ; $78
	const MISSINGNO_79 ; $79
	const MISSINGNO_7A ; $7A
	const CATERPIE     ; $7B
	const METAPOD      ; $7C
	const BUTTERFREE   ; $7D
	const MACHAMP      ; $7E
	const MISSINGNO_7F ; $7F
	const GOLDUCK      ; $80
	const HYPNO        ; $81
	const GOLBAT       ; $82
	const MEWTWO       ; $83
	const SNORLAX      ; $84
	const MAGIKARP     ; $85
	const MISSINGNO_86 ; $86
	const MISSINGNO_87 ; $87
	const MUK          ; $88
	const MISSINGNO_8A ; $8A
	const KINGLER      ; $8A
	const CLOYSTER     ; $8B
	const MISSINGNO_8C ; $8C
	const ELECTRODE    ; $8D
	const CLEFABLE     ; $8E
	const WEEZING      ; $8F
	const PERSIAN      ; $90
	const MAROWAK      ; $91
	const MISSINGNO_92 ; $92
	const HAUNTER      ; $93
	const ABRA         ; $94
	const ALAKAZAM     ; $95
	const PIDGEOTTO    ; $96
	const PIDGEOT      ; $97
	const STARMIE      ; $98
	const BULBASAUR    ; $99
	const VENUSAUR     ; $9A
	const TENTACRUEL   ; $9B
	const MISSINGNO_9C ; $9C
	const GOLDEEN      ; $9D
	const SEAKING      ; $9E
	const MISSINGNO_9F ; $9F
	const MISSINGNO_A0 ; $A0
	const MISSINGNO_A1 ; $A1
	const MISSINGNO_A2 ; $A2
	const PONYTA       ; $A3
	const RAPIDASH     ; $A4
	const RATTATA      ; $A5
	const RATICATE     ; $A6
	const NIDORINO     ; $A7
	const NIDORINA     ; $A8
	const GEODUDE      ; $A9
	const PORYGON      ; $AA
	const AERODACTYL   ; $AB
	const MISSINGNO_AC ; $AC
	const MAGNEMITE    ; $AD
	const MISSINGNO_AE ; $AE
	const MISSINGNO_AF ; $AF
	const CHARMANDER   ; $B0
	const SQUIRTLE     ; $B1
	const CHARMELEON   ; $B2
	const WARTORTLE    ; $B3
	const CHARIZARD    ; $B4
	const MISSINGNO_B5 ; $B5
	const FOSSIL_KABUTOPS   ; $B6
	const FOSSIL_AERODACTYL ; $B7
	const MON_GHOST    ; $B8
	const ODDISH       ; $B9
	const GLOOM        ; $BA
	const VILEPLUME    ; $BB
	const BELLSPROUT   ; $BC
	const WEEPINBELL   ; $BD
	const VICTREEBEL   ; $BE