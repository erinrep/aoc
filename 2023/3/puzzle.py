import re

print("Day 3: Gear Ratios")

with open("input.txt", encoding="utf-8") as f:
    lines = [list(x.replace("\n", ".")) for x in list(f)]


def isSymbol(c):
    return re.match(r"[^a-zA-Z\d.]", c)


def hasAdjacentSymbol(grid, y, x):
    # right
    if x + 1 < len(grid[y]) and isSymbol(grid[y][x + 1]):
        return True
    # right and down
    if x + 1 < len(grid[y]) and y + 1 < len(grid) and isSymbol(grid[y + 1][x + 1]):
        return True
    # down
    if y + 1 < len(grid) and isSymbol(grid[y + 1][x]):
        return True
    # left and down
    if x - 1 >= 0 and y + 1 < len(grid) and isSymbol(grid[y + 1][x - 1]):
        return True
    # left
    if x - 1 >= 0 and isSymbol(grid[y][x - 1]):
        return True
    # left and up
    if x - 1 >= 0 and y - 1 >= 0 and isSymbol(grid[y - 1][x - 1]):
        return True
    # up
    if y - 1 >= 0 and isSymbol(grid[y - 1][x]):
        return True
    # right and up
    if x + 1 < len(grid[y]) and y - 1 >= 0 and isSymbol(grid[y - 1][x + 1]):
        return True
    return False


total = 0
for y, line in enumerate(lines):
    isNextToSymbol = False
    numStr = ""
    for x, c in enumerate(line):
        if c.isnumeric():
            numStr += c
            if hasAdjacentSymbol(lines, y, x):
                isNextToSymbol = True
        else:
            if isNextToSymbol:
                total += int(numStr)
            isNextToSymbol = False
            numStr = ""


print("Part 1:", total)


numsWithCoords = []

for y, line in enumerate(lines):
    numInfo = {"num": 0, "coords": []}
    numStr = ""
    for x, c in enumerate(line):
        if c.isnumeric():
            numStr += c
            numInfo["coords"].append((y, x))
        else:
            if numStr != "":
                numInfo["num"] = int(numStr)
                numsWithCoords.append(numInfo)
                numInfo = {"num": 0, "coords": []}
                numStr = ""


def isAdjacent(y1, x1, y2, x2):
    # right
    if x1 + 1 == x2 and y1 == y2:
        return True
    # right and down
    if x1 + 1 == x2 and y1 + 1 == y2:
        return True
    # down
    if x1 == x2 and y1 + 1 == y2:
        return True
    # left and down
    if x1 - 1 == x2 and y1 + 1 == y2:
        return True
    # left
    if x1 - 1 == x2 and y1 == y2:
        return True
    # left and up
    if x1 - 1 == x2 and y1 - 1 == y2:
        return True
    # up
    if x1 == x2 and y1 - 1 == y2:
        return True
    # right up
    if x1 + 1 == x2 and y1 - 1 == y2:
        return True
    return False


GEAR = "*"
total = 0
for y, line in enumerate(lines):
    numStr = ""
    for x, c in enumerate(line):
        if c == GEAR:
            nums = set()
            for n in numsWithCoords:
                for c in n["coords"]:
                    if isAdjacent(y, x, c[0], c[1]):
                        nums.add(n["num"])
                        break
            if len(nums) == 2:
                total += nums.pop() * nums.pop()


print("Part 2:", total)
