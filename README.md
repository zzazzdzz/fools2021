# fools2021

TheZZAZZGlitch's April Fools Event 2021. A procedurally generated adventure, contained in a Pokémon Red save file!

# Building the save file from source

Note: if you just want to play the game, you don't have to build it yourself. Visit the [event site](https://zzazzdzz.github.io/fools2021) for a quick download.

You'll need [RGBDS](https://github.com/rednex/rgbds/releases) v0.4.2 or later, as well as Python 3 to run the save fixing tool.

Compile the code:

```
rgbasm main.asm -o main.o
```

Link and overlay it on top of the base save file. Will also generate the symbol list in `fools2021.sym` as an added bonus!

```
rgblink -n fools2021.sym -O base.sav -o fools.sav -x main.o
```

Pad and fix the save file checksums:

```
python3 tools/savfix.py
```

Your `fools.sav` is ready to be loaded in an emulator.