print("Day 2: I Was Told There Would Be No Math")

with open("input.txt", encoding="utf-8") as f:
    presents = [x.replace("\n", "").split("x") for x in list(f)]

totalPaper = 0
totalRibbon = 0
for p in presents:
    [l, w, h] = [int(x) for x in p]
    bow = l * w * h
    paper = 2 * l * w + 2 * w * h + 2 * h * l
    [smallestSide, secondSmallestSide, _] = sorted([l, w, h])
    extraPaper = smallestSide * secondSmallestSide
    ribbon = smallestSide * 2 + secondSmallestSide * 2
    totalPaper += paper + extraPaper
    totalRibbon += ribbon + bow

print("Part 1: ", totalPaper)
print("Part 2: ", totalRibbon)
