import itertools
import math

print("Day 8: Haunted Wasteland")

with open("input.txt", encoding="utf-8") as f:
    lines = [x.replace("\n", "") for x in list(f)]

directions = []
for d in list(lines[0]):
    if d == "L":
        directions.append(0)
    else:
        directions.append(1)

nodes = {}
for line in lines[2:]:
    parts = line.split(" = ")
    nodes[parts[0]] = parts[1].strip("()").split(", ")

steps = 0
curr = "AAA"
dirIndex = 0
while curr != "ZZZ":
    curr = nodes[curr][directions[dirIndex]]
    steps += 1
    if dirIndex == len(directions) - 1:
        dirIndex = 0
    else:
        dirIndex += 1

print("Part 1:", steps)


def num_steps(directions, nodes, curr):
    for i, dir in enumerate(itertools.cycle(directions)):
        curr = nodes[curr][dir]
        if curr[-1] == "Z":
            return i + 1


print("Part 1 optimized:", num_steps(directions, nodes, "AAA"))

all_steps = []
starting_nodes = [x for x in nodes.keys() if x[-1] == "A"]
for node in starting_nodes:
    all_steps.append(num_steps(directions, nodes, node))

print("Part 2:", math.lcm(*all_steps))
