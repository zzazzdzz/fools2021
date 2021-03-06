; *** charset.asm
; Character set definitions.

_Char01:
    db 5 ; char width
    db %01110000
    db %10001000
    db %10001000
    db %11111000
    db %10001000
    db %10001000
    db %10001000
    db %00000000

_Char02:
    db 5 ; char width
    db %11110000
    db %10001000
    db %10001000
    db %11110000
    db %10001000
    db %10001000
    db %11110000
    db %00000000

_Char03:
    db 5 ; char width
    db %01110000
    db %10001000
    db %10000000
    db %10000000
    db %10000000
    db %10001000
    db %01110000
    db %00000000

_Char04:
    db 5 ; char width
    db %11110000
    db %10001000
    db %10001000
    db %10001000
    db %10001000
    db %10001000
    db %11110000
    db %00000000

_Char05:
    db 5 ; char width
    db %11111000
    db %10000000
    db %10000000
    db %11110000
    db %10000000
    db %10000000
    db %11111000
    db %00000000

_Char06:
    db 5 ; char width
    db %11111000
    db %10000000
    db %10000000
    db %11110000
    db %10000000
    db %10000000
    db %10000000
    db %00000000

_Char07:
    db 5 ; char width
    db %01110000
    db %10001000
    db %10000000
    db %10111000
    db %10001000
    db %10001000
    db %01110000
    db %00000000

_Char08:
    db 5 ; char width
    db %10001000
    db %10001000
    db %10001000
    db %11111000
    db %10001000
    db %10001000
    db %10001000
    db %00000000

_Char09:
    db 5 ; char width
    db %11111000
    db %00100000
    db %00100000
    db %00100000
    db %00100000
    db %00100000
    db %11111000
    db %00000000

_Char0A:
    db 5 ; char width
    db %00001000
    db %00001000
    db %00001000
    db %00001000
    db %10001000
    db %10001000
    db %01110000
    db %00000000

_Char0B:
    db 5 ; char width
    db %10001000
    db %10010000
    db %10100000
    db %11000000
    db %10100000
    db %10010000
    db %10001000
    db %00000000

_Char0C:
    db 5 ; char width
    db %10000000
    db %10000000
    db %10000000
    db %10000000
    db %10000000
    db %10000000
    db %11111000
    db %00000000

_Char0D:
    db 5 ; char width
    db %10001000
    db %11011000
    db %10101000
    db %10101000
    db %10001000
    db %10001000
    db %10001000
    db %00000000

_Char0E:
    db 5 ; char width
    db %10001000
    db %11001000
    db %11001000
    db %10101000
    db %10011000
    db %10011000
    db %10001000
    db %00000000

_Char0F:
    db 5 ; char width
    db %01110000
    db %10001000
    db %10001000
    db %10001000
    db %10001000
    db %10001000
    db %01110000
    db %00000000

_Char10:
    db 5 ; char width
    db %11110000
    db %10001000
    db %10001000
    db %11110000
    db %10000000
    db %10000000
    db %10000000
    db %00000000

_Char11:
    db 5 ; char width
    db %01110000
    db %10001000
    db %10001000
    db %10001000
    db %10101000
    db %10010000
    db %01101000
    db %00000000

_Char12:
    db 5 ; char width
    db %11110000
    db %10001000
    db %10001000
    db %11110000
    db %10100000
    db %10010000
    db %10001000
    db %00000000

_Char13:
    db 5 ; char width
    db %01110000
    db %10001000
    db %10000000
    db %01110000
    db %00001000
    db %10001000
    db %01110000
    db %00000000

_Char14:
    db 5 ; char width
    db %11111000
    db %00100000
    db %00100000
    db %00100000
    db %00100000
    db %00100000
    db %00100000
    db %00000000

_Char15:
    db 5 ; char width
    db %10001000
    db %10001000
    db %10001000
    db %10001000
    db %10001000
    db %10001000
    db %01110000
    db %00000000

_Char16:
    db 5 ; char width
    db %10001000
    db %10001000
    db %01010000
    db %01010000
    db %01010000
    db %00100000
    db %00100000
    db %00000000

_Char17:
    db 5 ; char width
    db %10001000
    db %10001000
    db %10101000
    db %10101000
    db %10101000
    db %01010000
    db %01010000
    db %00000000

_Char18:
    db 5 ; char width
    db %10001000
    db %10001000
    db %01010000
    db %00100000
    db %01010000
    db %10001000
    db %10001000
    db %00000000

_Char19:
    db 5 ; char width
    db %10001000
    db %10001000
    db %10001000
    db %01010000
    db %00100000
    db %00100000
    db %00100000
    db %00000000

_Char1A:
    db 5 ; char width
    db %11111000
    db %00001000
    db %00010000
    db %00100000
    db %01000000
    db %10000000
    db %11111000
    db %00000000

_Char1B:
    db 5 ; char width
    db %00000000
    db %00000000
    db %01110000
    db %10010000
    db %10010000
    db %10010000
    db %01101000
    db %00000000

_Char1C:
    db 4 ; char width
    db %10000000
    db %10000000
    db %11100000
    db %10010000
    db %10010000
    db %10010000
    db %11100000
    db %00000000

_Char1D:
    db 4 ; char width
    db %00000000
    db %00000000
    db %01110000
    db %10000000
    db %10000000
    db %10000000
    db %01110000
    db %00000000

_Char1E:
    db 4 ; char width
    db %00010000
    db %00010000
    db %01110000
    db %10010000
    db %10010000
    db %10010000
    db %01110000
    db %00000000

_Char1F:
    db 4 ; char width
    db %00000000
    db %00000000
    db %01100000
    db %10010000
    db %11110000
    db %10000000
    db %01110000
    db %00000000

_Char20:
    db 3 ; char width
    db %00100000
    db %01000000
    db %11100000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %00000000

_Char21:
    db 4 ; char width
    db %00000000
    db %00000000
    db %01100000
    db %10010000
    db %10010000
    db %01110000
    db %00010000
    db %11110000

_Char22:
    db 4 ; char width
    db %10000000
    db %10000000
    db %11100000
    db %10010000
    db %10010000
    db %10010000
    db %10010000
    db %00000000

_Char23:
    db 3 ; char width
    db %01000000
    db %00000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %00000000

_Char24:
    db 3 ; char width
    db %01000000
    db %00000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %10000000

_Char25:
    db 4 ; char width
    db %10000000
    db %10000000
    db %10010000
    db %10100000
    db %11000000
    db %10100000
    db %10010000
    db %00000000

_Char26:
    db 3 ; char width
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %00000000

_Char27:
    db 5 ; char width
    db %00000000
    db %00000000
    db %11010000
    db %10101000
    db %10101000
    db %10101000
    db %10001000
    db %00000000

_Char28:
    db 4 ; char width
    db %00000000
    db %00000000
    db %11100000
    db %10010000
    db %10010000
    db %10010000
    db %10010000
    db %00000000

_Char29:
    db 4 ; char width
    db %00000000
    db %00000000
    db %01100000
    db %10010000
    db %10010000
    db %10010000
    db %01100000
    db %00000000

_Char2A:
    db 4 ; char width
    db %00000000
    db %00000000
    db %11100000
    db %10010000
    db %10010000
    db %11100000
    db %10000000
    db %10000000

_Char2B:
    db 4 ; char width
    db %00000000
    db %00000000
    db %01110000
    db %10010000
    db %10010000
    db %01110000
    db %00010000
    db %00010000

_Char2C:
    db 4 ; char width
    db %00000000
    db %00000000
    db %10110000
    db %11000000
    db %10000000
    db %10000000
    db %10000000
    db %00000000

_Char2D:
    db 4 ; char width
    db %00000000
    db %00000000
    db %01110000
    db %10000000
    db %01100000
    db %00010000
    db %11100000
    db %00000000

_Char2E:
    db 4 ; char width
    db %01000000
    db %01000000
    db %11110000
    db %01000000
    db %01000000
    db %01000000
    db %00110000
    db %00000000

_Char2F:
    db 4 ; char width
    db %00000000
    db %00000000
    db %10010000
    db %10010000
    db %10010000
    db %10010000
    db %01110000
    db %00000000

_Char30:
    db 4 ; char width
    db %00000000
    db %00000000
    db %10010000
    db %10010000
    db %10010000
    db %10100000
    db %01000000
    db %00000000

_Char31:
    db 5 ; char width
    db %00000000
    db %00000000
    db %10001000
    db %10101000
    db %10101000
    db %10101000
    db %01010000
    db %00000000

_Char32:
    db 4 ; char width
    db %00000000
    db %00000000
    db %10010000
    db %01100000
    db %01100000
    db %01100000
    db %10010000
    db %00000000

_Char33:
    db 4 ; char width
    db %00000000
    db %00000000
    db %10010000
    db %10010000
    db %10010000
    db %01110000
    db %00010000
    db %11100000

_Char34:
    db 4 ; char width
    db %00000000
    db %00000000
    db %11110000
    db %00100000
    db %01000000
    db %10000000
    db %11110000
    db %00000000

_Char35:
    db 3 ; char width
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %00000000
    db %01000000
    db %00000000

_Char36:
    db 3 ; char width
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %01000000
    db %01000000
    db %10000000

_Char37:
    db 5 ; char width
    db %01110000
    db %10001000
    db %10001000
    db %00010000
    db %00100000
    db %00000000
    db %00100000
    db %00000000

_Char38:
    db 3 ; char width
    db %10100000
    db %10100000
    db %10100000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000

_Char39:
    db 4 ; char width
    db %00000000
    db %00000000
    db %00000000
    db %11110000
    db %00000000
    db %00000000
    db %00000000
    db %00000000

_Char3A:
    db 2 ; char width
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %10000000
    db %00000000

_Char3B:
    db 3 ; char width
    db %00000000
    db %01000000
    db %00000000
    db %00000000
    db %00000000
    db %01000000
    db %00000000
    db %00000000

_Char3C:
    db 3 ; char width
    db %01000000
    db %10000000
    db %10000000
    db %10000000
    db %10000000
    db %10000000
    db %01000000
    db %00000000

_Char3D:
    db 3 ; char width
    db %10000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %10000000
    db %00000000

_Char3E:
    db 3 ; char width
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000

_Char3F:
    db 8 ; char width
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000

_Char40:
    db 5 ; char width
    db %01110000
    db %10101000
    db %10100000
    db %01110000
    db %00101000
    db %10101000
    db %01110000
    db %00000000

_Char41:
    db 2 ; char width
    db %01000000
    db %01000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000

_Char42:
    db 4 ; char width
    db %00010000
    db %00010000
    db %00100000
    db %00100000
    db %01000000
    db %01000000
    db %10000000
    db %00000000

_Char43:
    db 5 ; char width
    db %01110000
    db %10001000
    db %10011000
    db %10101000
    db %11001000
    db %10001000
    db %01110000
    db %00000000

_Char44:
    db 3 ; char width
    db %01000000
    db %11000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %11100000
    db %00000000

_Char45:
    db 5 ; char width
    db %01110000
    db %10001000
    db %00001000
    db %00010000
    db %00100000
    db %01000000
    db %11111000
    db %00000000

_Char46:
    db 5 ; char width
    db %11111000
    db %00010000
    db %00100000
    db %00010000
    db %00001000
    db %10001000
    db %01110000
    db %00000000

_Char47:
    db 5 ; char width
    db %00010000
    db %00110000
    db %01010000
    db %10010000
    db %11111000
    db %00010000
    db %00010000
    db %00000000

_Char48:
    db 5 ; char width
    db %11111000
    db %10000000
    db %11110000
    db %00001000
    db %00001000
    db %10001000
    db %01110000
    db %00000000

_Char49:
    db 5 ; char width
    db %00110000
    db %01000000
    db %10000000
    db %11110000
    db %10001000
    db %10001000
    db %01110000
    db %00000000

_Char4A:
    db 5 ; char width
    db %11111000
    db %00001000
    db %00010000
    db %00100000
    db %01000000
    db %01000000
    db %01000000
    db %00000000

_Char4B:
    db 5 ; char width
    db %01110000
    db %10001000
    db %10001000
    db %01110000
    db %10001000
    db %10001000
    db %01110000
    db %00000000

_Char4C:
    db 5 ; char width
    db %01110000
    db %10001000
    db %10001000
    db %01111000
    db %00001000
    db %00010000
    db %01100000
    db %00000000

_Char4D:
    db 4 ; char width
    db %00100000
    db %01000000
    db %01100000
    db %10010000
    db %11110000
    db %10000000
    db %01110000
    db %00000000

_Char4E:
    db 5 ; char width
    db %00010000
    db %00100000
    db %01110000
    db %10001000
    db %10001000
    db %11111000
    db %10001000
    db %10001000

_Char4F:
    db 5 ; char width
    db %00000000
    db %11111000
    db %10000000
    db %10000000
    db %11110000
    db %10000000
    db %10000000
    db %10000000

_Char50:
    db 3 ; char width
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %00000000
    db %01100000
    db %01100000
    db %00000000

_Char51:
    db 4 ; char width
    db %00010000
    db %00110000
    db %00100000
    db %00100000
    db %01100000
    db %00000000
    db %11000000
    db %11000000

_Char52:
    db 5 ; char width
    db %00100000
    db %01100000
    db %01000000
    db %11111000
    db %10000000
    db %10000000
    db %10011000
    db %11110000

_Char53:
    db 6 ; char width
    db %00000000
    db %00000000
    db %01110000
    db %11011000
    db %11111000
    db %10000000
    db %10000000
    db %11111100

_Char54:
    db 7 ; char width
    db %00111100
    db %01100110
    db %01000000
    db %01000000
    db %11000000
    db %10000000
    db %11000100
    db %01111100

_Char55:
    db 7 ; char width
    db %01111000
    db %01001110
    db %01000000
    db %01110000
    db %01000000
    db %11000000
    db %10000000
    db %11111000

_Char56:
    db 5 ; char width
    db %00000000
    db %00000000
    db %00000000
    db %11111000
    db %10001000
    db %10001000
    db %11001000
    db %01111000

_Char57:
    db 6 ; char width
    db %01100000
    db %01000000
    db %01000000
    db %01111000
    db %01101000
    db %10001000
    db %10001100
    db %10000100

_Char58:
    db 6 ; char width
    db %00000000
    db %00000000
    db %00000000
    db %01011100
    db %01100100
    db %01000100
    db %10000100
    db %10000100

_Char59:
    db 5 ; char width
    db %00000000
    db %00110000
    db %11100000
    db %10000000
    db %11111000
    db %00001000
    db %11111000
    db %00000000

_Char5A:
    db 6 ; char width
    db %00000000
    db %00000000
    db %01011100
    db %01110000
    db %11000000
    db %10000000
    db %10000000
    db %00000000
	
_Char5B:
    db 3 ; char width
    db %00100000
    db %00100000
    db %00000000
    db %00100000
    db %01100000
    db %11100000
    db %01000000
    db %01000000
	
_Char5C:
    db 7 ; char width
    db %00111000
    db %01100110
    db %11000010
    db %10000010
    db %10000010
    db %10000100
    db %10011100
    db %11110000
	
_Char5D:
    db 7 ; char width
    db %00100010
    db %00110110
    db %00110110
    db %01101110
    db %01000010
    db %01000010
    db %11000010
    db %10000010
	
_Char5E:
    db 7 ; char width
    db %00111000
    db %00101000
    db %01001100
    db %01111100
    db %01011110
    db %11000010
    db %10000110
    db %11111100
	
_Char5F:
    db 7 ; char width
    db %00001000
    db %00011000
    db %00110100
    db %00100100
    db %01111100
    db %01000100
    db %10000110
    db %10000010
	
_Char60:
    db 7 ; char width
    db %00100110
    db %00100100
    db %00111100
    db %01110000
    db %01100000
    db %01111000
    db %11001100
    db %10000110
	
_Char61:
    db 6 ; char width
    db %10000100
    db %10000100
    db %10001100
    db %01001000
    db %01001000
    db %01010000
    db %00110000
    db %00110000
	
_Char62:
    db 6 ; char width
    db %01111000
    db %01001100
    db %01001000
    db %01111000
    db %11110000
    db %10010000
    db %10011000
    db %10001000
	
_Char63:
    db 5 ; char width
    db %10011000
    db %11011000
    db %01110000
    db %01110000
    db %00010000
    db %00010000
    db %00010000
    db %00010000
	
_Char64:
    db 5 ; char width
    db %00000000
    db %10000000
    db %10011000
    db %10110000
    db %11110000
    db %00011000
    db %01001000
    db %01110000
	
_Char65:
    db 7 ; char width
    db %00000000
    db %00000000
    db %00000000
    db %01111100
    db %11001100
    db %10001100
    db %11011100
    db %01110110
	
_Char66:
    db 6 ; char width
    db %00100000
    db %00100000
    db %00100000
    db %01111000
    db %01001100
    db %11000100
    db %10011100
    db %11110000
	
_Char67:
    db 6 ; char width
    db %00000000
    db %00000000
    db %01001000
    db %01001000
    db %11011000
    db %10011000
    db %11111000
    db %00001100
	
_Char68:
    db 6 ; char width
    db %00000000
    db %00000000
    db %11001100
    db %01011000
    db %00110000
    db %01011000
    db %11001000
    db %00000000
	
_Char69:
    db 7 ; char width
    db %00000000
    db %00000000
    db %00000000
    db %11101100
    db %11111100
    db %10011110
    db %10010010
    db %10010010
	
_Char6A:
    db 2 ; char width
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %01000000
    db %11000000
    db %10000000
    db %10000000