print("Day 2: Cube Conundrum")

with open("input.txt", encoding="utf-8") as f:
    lines = [x.replace("\n", "") for x in list(f)]

total = 0
for line in lines:
    parts = line.split(": ")
    id = parts[0].split(" ")[-1]
    grabs = parts[1].split("; ")
    totalCubes = {"red": 12, "green": 13, "blue": 14}
    possible = True
    for g in grabs:
        grab = g.split(", ")
        for c in grab:
            cube = c.split(" ")
            if int(cube[0]) > totalCubes[cube[1]]:
                possible = False
                break
    if possible:
        total += int(id)

print("Part 1: ", total)

total = 0
for line in lines:
    parts = line.split(": ")
    grabs = parts[1].split("; ")
    totalCubes = {"red": 0, "green": 0, "blue": 0}
    for g in grabs:
        grab = g.split(", ")
        for c in grab:
            cube = c.split(" ")
            if int(cube[0]) > totalCubes[cube[1]]:
                totalCubes[cube[1]] = int(cube[0])
    total += totalCubes["red"] * totalCubes["green"] * totalCubes["blue"]

print("Part 2: ", total)
