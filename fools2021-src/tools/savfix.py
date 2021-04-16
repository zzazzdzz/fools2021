
with open("fools.sav", "rb") as fp:
    save = bytearray(fp.read())

# pad to 32 KB
if len(save) < 32*1024:
    save += bytes([0xff] * (32*1024 - len(save)))

checksum = 0
for i in range(0x2598, 0x3523):
    checksum += save[i]
checksum %= 256
checksum ^= 0xff
save[0x3523] = checksum

checksum = 0x55
for i in range(0x4001, 0x6000):
    checksum ^= save[i]
    checksum += 1
    checksum %= 256
save[0x4000] = checksum

checksum = 0x55
for i in range(0x6001, 0x8000):
    checksum ^= save[i]
    checksum += 1
    checksum %= 256
save[0x6000] = checksum

with open('fools.sav', 'wb') as fp:
    fp.write(save)