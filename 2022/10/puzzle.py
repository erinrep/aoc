print("Day 10: Cathode-Ray Tube")

with open("input.txt", encoding="utf-8") as f:
    instructions = [x.replace("\n", "").split(" ") for x in list(f)]

vals = [1]
strengths = []
i = 0
for cycle in range(1, 240):
    if i >= len(instructions):
        break
    vals.append(0)
    instruction = instructions[i]
    if instruction[0] != "noop":
        vals.append(int(instruction[1]))
    i += 1

for cycle in range(20, 221, 40):
    x = sum(vals[0:cycle])
    strengths.append(x * cycle)

print("Part One: ", sum(strengths))

x = 1
screen = ""
sprite = range(0, 3)
pos = 0
for cycle in range(len(vals)):
    x = sum(vals[0 : cycle + 1])
    sprite = range(x - 1, x + 2)

    if pos in sprite:
        screen += "#"
    else:
        screen += "."

    if (cycle + 1) % 40 == 0:
        pos = 0
    else:
        pos += 1

print("Part Two:")
for i in range(0, 201, 40):
    print(screen[i : i + 40])
